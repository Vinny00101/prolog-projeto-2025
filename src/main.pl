:- dynamic filme/6.
:- dynamic assistido/2.

/*
listing -> exibir o fato.
assert -> adiciona ao fato dinamico.
retract -> remove.
*/
adicionar_filme(Nome, Genero, Atores, NotaIMDb, Classificacao, Pais) :-
    assertz(filme(Nome, Genero, Atores, NotaIMDb, Classificacao, Pais)).

% Remove um filme existente
remover_filme(Nome) :-
    retractall(filme(Nome, _, _, _, _, _)).

marcar_assistido(Usuario, Filme) :-
    assertz(assistido(Usuario, Filme)).

desmarcar_assistido(Usuario, Filme) :-
    retractall(assistido(Usuario, Filme)).


explicacao_recomendacao(FilmeBase, FilmeComparado, Explicacao) :-
    filme(FilmeBase, Genero, Atores, NotaIMDb, Classificacao, Pais),
    filme(FilmeComparado, Genero2, Atores2, NotaIMDb2, Classificacao2, Pais2),

    findall(Item,(

        (Genero == Genero2 -> Item = 'Gênero semelhante'; fail);
        /*Colocar uma recomendação por autor específico, fazer uma regra separada para isso e passa aqui na condição*/
        (NotaIMDb >= NotaIMDb2 -> 'Nota IMDb igual ou maior'; fail);
        (Pais == Pais2 -> 'Mesmo país de origem'; fail)

    ), Explicacao).