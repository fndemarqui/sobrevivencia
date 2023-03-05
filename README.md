
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sobrevivencia

<!-- badges: start -->
<!-- badges: end -->

Funções e bancos de dados para a disciplina de Análise de Sobrevivência.

## Instalação

O pacote pode ser instalado a partir do [GitHub](https://github.com/)
com os seguintes comandos:

``` r
# install.packages("devtools")
devtools::install_github("fndemarqui/sobrevivencia")
```

## Exemplo

Carregando o banco de dados *camundongos* do livro Colosimo and Giolo
(2006).

``` r
library(sobrevivencia)
library(tidyverse)

data(camundongos)
glimpse(camundongos)
#> Rows: 93
#> Columns: 4
#> $ grupo  <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, …
#> $ peso   <dbl> 19.9, 19.7, 16.4, 17.0, 21.6, 24.6, 22.7, 15.9, 18.9, 15.7, 20.…
#> $ tempo  <int> 7, 7, 5, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 9, 10, 12, 12, 14,…
#> $ evento <int> 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, …
```

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-bookEnrico" class="csl-entry">

Colosimo, E. A., and S. R. Giolo. 2006. *Análise de Sobrevivência
Aplicada*. Blucher.

</div>

</div>
