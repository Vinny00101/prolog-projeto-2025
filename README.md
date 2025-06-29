# Sistema de Recomendação de Filmes em Prolog

## Objetivo

Este projeto foi desenvolvido como parte de uma atividade em dupla, com o objetivo de construir um sistema de recomendação de filmes utilizando a linguagem **Prolog**.

## Funcionalidades

O sistema permite que o usuário forneça um **filme já assistido** e **informações adicionais de interesse**, como:

- Gênero preferido

A partir desses dados, o sistema **recomenda filmes similares**, com base em critérios compartilhados entre os filmes, e retorna um **score de similaridade** para cada um deles.

---
## Critérios e Pesos da Recomendação

A lógica do sistema de recomendação atribui **pesos diferentes** a cada critério utilizado na comparação entre filmes. Esses pesos influenciam diretamente no cálculo do **ScoreFinal**, que define a relevância da recomendação.

```prolog
% Fatos que definem os pesos atribuídos a cada critério:

p_genero(2).            % Peso para coincidência de gênero
p_ator_preferido(1).    % Peso se o ator preferido estiver no elenco
p_nota_imdb(1).         % Peso se o filme tiver nota acima do mínimo desejado
p_pais(1).              % Peso se o país de origem for o mesmo
```
## Regra principal

  ```prolog
    marcar_assistido(Usuario, Filme, AtorPreferido, ListaFinal) :-
      assertz(assistido(Usuario, Filme)),
      recomendacao_com_explicacao(Filme, AtorPreferido, Usuario, ListaFinal).
  ```

Essa regra serve para marcar um filme como assistido pelo usuário, e imediatamente gerar recomendações com base nele.

## Exclusão de Filmes Inadequados

O sistema verifica automaticamente se o filme já foi assistido pelo usuário usando o fato:
  ```prolog
  assistido(usuario, filme).
  ```

## Regras de Recomendação

```prolog
  recomendacao_com_explicacao(FilmeBase, AtorPreferido, Usuario, ListaFinal).
```

Essa é a regra principal do sistema de recomendação. A partir de um filme que o usuário já assistiu **(FilmeBase)** e um    ator preferido **(AtorPreferido)**, ela gera uma lista de recomendações ListaFinal com base na similaridade com outros filmes da base.

-Etapas realizadas internamente:

-Percorre todos os filmes cadastrados.

-Ignora o próprio FilmeBase.

-Elimina qualquer filme já assistido pelo Usuario.

-Calcula o ScoreFinal de similaridade com a regra **calcular_score/4**.

-Filtra apenas os filmes com score igual 4 e 3.

-Gera explicações para a recomendação com a regra **explicacao_recomendacao/3**.

-Ordena os resultados do maior para o menor score.

## calcular_score/4

Essa regra compara dois filmes **(Filme1 e Filme2)** e atribui uma pontuação de similaridade com base nos critérios definidos **(gênero, ator, nota IMDb e país)**.

Para cada critério compatível:

-Soma-se o respectivo peso.

-O total determina o ScoreFinal.

## explicacao_recomendacao/3

Essa regra analisa por que um filme está sendo recomendado, comparando os atributos entre **Filme1** e **Filme2**, e retornando uma lista com explicações textuais.

Exemplo de explicações possíveis:

-Gênero semelhante.

-Nota IMDb igual ou maior.

-Mesmo país de origem.

-Ator preferido no elenco.

Essas informações ajudam o usuário a entender por que aquele filme foi sugerido.