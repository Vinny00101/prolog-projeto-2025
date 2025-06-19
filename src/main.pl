:- dynamic filme/4.

/*
listing -> exibir o fato.
assert -> adiciona ao fato dinamico.
retract -> remove.
*/

add(Title,Genero,IMDb,FaixaEtaria):-
    assertz(filme(Title, Genero, IMDb, FaixaEtaria)).

mostra:-
    listing(filme).