:- ensure_loaded('data/database.pl').
:- dynamic assistido/2.

/*
listing -> exibir o fato.q
assert -> adiciona ao fato dinamico.
retract -> remove.
*/

/*Peso para cada criterio da recomendacao*/
p_genero(2).
p_ator_preferido(1).
p_nota_imdb(1).
p_pais(1).

marcar_assistido(Usuario, Filme) :-
    assertz(assistido(Usuario, Filme)).

desmarcar_assistido(Usuario, Filme) :-
    retractall(assistido(Usuario, Filme)).

calcular_score(F1, F2, AtorPreferido, ScoreFinal).
    filme(F1, G1, _, _, _, _, _, P1, IMDb1, _),
    filme(F2, G2, _, Elenco2, _, _, _, P2, IMDb2, _),
    /* continua o resto da regra*/


explicacao_recomendacao(F1, F2, Explicacoes) :-
    filme(F1, G1, _, _, _, _, _, P1, N1, _),
    filme(F2, G2, _, _, _, _, _, P2, N2, _),

    findall(Exp, (
        (G1 == G2         -> Exp = 'Gênero semelhante'           ; fail);
        (N2 >= N1         -> Exp = 'Nota IMDb igual ou maior'    ; fail);
        (P1 == P2         -> Exp = 'Mesmo país de origem'        ; fail)
    ), Explicacoes).

recomendacao_com_explicacao(FilmeBase, AtorPreferido, Usuario, ListaFinal) :-
    findall(
        Score-Titulo-Explicacoes,
        (
            filme(FilmeComparado, _, _, _, _, _, _, _, _, _),
            FilmeComparado \= FilmeBase,
            \+ assistido(Usuario, FilmeComparado),
            calcular_score(FilmeBase, FilmeComparado, AtorPreferido, Score),
            (Score =:= 4 ; Score =:= 3),
            explicacao_recomendacao(FilmeBase, FilmeComparado, Explicacoes)

        ),
        ListaPontuada
    ),
    sort(0, @>=, ListaPontuada, ListaFinal).