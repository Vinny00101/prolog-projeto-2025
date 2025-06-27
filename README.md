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

## Exclusão de Filmes Inadequados

- O sistema verifica automaticamente se o filme já foi assistido pelo usuário usando o fato:
  ```prolog
  assistido(usuario, filme).
  ```
