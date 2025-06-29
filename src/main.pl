:- ensure_loaded('data/database.pl').
:- dynamic assistido/2.

/*
listing -> exibir o fato dinamico.
assert -> adiciona ao fato dinamico.
retract -> remove fato dinamico.
member -> verificar se um determinado elemento pertence a uma lista.
findall -> Cria uma lista com todos os valores possíveis da variável Var que satisfazem a Condicao.
sort -> Ordena os elementos da lista em ordem crescente e remove duplicatas.
*/

/*Peso para cada criterio da recomendacao*/
p_genero(2).
p_ator_preferido(1).
p_nota_imdb(1).
p_pais(1).

/*
 teste: marcar_assistido('Vinicius', 'Interestelar', 'Christopher Nolan', ListaFinal).
*/

marcar_assistido(Usuario, Filme, AtorPreferido, ListaFinal) :-
    assertz(assistido(Usuario, Filme)),
    recomendacao_com_explicacao(Filme, AtorPreferido, Usuario, ListaFinal).

desmarcar_assistido(Usuario, Filme) :-
    retractall(assistido(Usuario, Filme)).

calcular_score(F1, F2, AtorPreferido, ScoreFinal):-
    p_genero(PG),
    p_ator_preferido(PA),
    p_nota_imdb(PN),
    p_pais(PP),

    filme(F1, G1, _, _, _, _, _, P1, IMDb1, _),
    filme(F2, G2, _, Elenco2, _, _, _, P2, IMDb2, _),

    (G1 == G2 -> S1 = PG ; S1 = 0),
    (member(AtorPreferido, Elenco2) -> S2 = PA ; S2 = 0),
    (IMDb2 >= IMDb1 -> S3 = PN ; S3 = 0),
    (P1 == P2 -> S4 = PP ; S4 = 0),

    ScoreFinal is S1 + S2 + S3 + S4.


explicacao_recomendacao(F1, F2, Explicacoes) :-
    filme(F1, G1, _, _, _, _, _, P1, IMDb1, _),
    filme(F2, G2, _, _, _, _, _, P2, IMDb2, _),

    findall(Exp, (
        (G1 == G2 -> Exp = 'Genero semelhante' ; fail);
        (IMDb1 >= IMDb2 -> Exp = 'Nota IMDb igual ou maior' ; fail);
        (P1 == P2 -> Exp = 'Mesmo pais de origem' ; fail)
    ), Explicacoes).

recomendacao_com_explicacao(FilmeBase, AtorPreferido, Usuario, ListaFinal) :-
    findall(
        Score-Titulo-Explicacoes,
        (
            filme(Titulo, _, _, _, _, _, _, _, _, _),
            Titulo \= FilmeBase,
            \+ assistido(Usuario, Titulo),
            calcular_score(FilmeBase, Titulo, AtorPreferido, Score),
            (Score =:= 4 ; Score =:= 3),
            explicacao_recomendacao(FilmeBase, Titulo, Explicacoes)

        ),
        ListaPontuada
    ),
    sort(0, @>=, ListaPontuada, ListaFinal).