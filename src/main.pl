:- ensure_loaded('data/database.pl').
:- dynamic assistido/2.
:- set_prolog_flag(encoding, utf8).

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

marcar_assistido(Usuario, Filme, AtorPreferido, ListaFinal) :-
    assertz(assistido(Usuario, Filme)),
    recomendacao_com_explicacao(Filme, AtorPreferido, Usuario, ListaFinal).

desmarcar_assistido(Usuario, Filme) :-
    retractall(assistido(Usuario, Filme)).

calcular_score(F1, F2, AtorPreferido, ScoreFinal):-
    filme(F1, G1, _, _, _, _, _, P1, IMDb1, _),
    filme(F2, G2, _, Elenco2, _, _, _, P2, IMDb2, _),


    /*( condicao -> processo 1 ; processo 2)*/
    S1 = 1, S2 = 2, S3 = 0, S4 = 1,
    ScoreFinal is S1 + S2 + S3 + S4.
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