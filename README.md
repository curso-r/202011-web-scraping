
<!-- README.md is generated from README.Rmd. Please edit that file -->

## Configuração inicial

#### Passo 1: Instalar pacotes

``` r
install.packages("remotes")

# instalar pacote da Curso-R
remotes::install_github("curso-r/CursoR")
```

#### Passo 2: Criar um projeto do RStudio

Faça um projeto do RStudio para usar durante todo o curso e em seguida
abra-o.

``` r
install.packages("usethis")
usethis::create_project("caminho_ate_o_projeto/nome_do_projeto")
```

#### Passo 3: Baixar o material

Certifique que você está dentro do projeto criado no passo 2 e rode o
código abaixo.

**Observação**: Assim que rodar o código abaixo, o programa vai pedir
uma escolha de opções. Escolha o número correspondente ao curso de Web
Scraping!

``` r
# Baixar ou atualizar material do curso
CursoR::atualizar_material()
```

## Slides

| Slide                              | Link                                                                             | Link em PDF                                                                                       |
|:-----------------------------------|:---------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------|
| slides/01-introducao-ao-curso.html | <https://curso-r.github.io/main-web-scraping/slides/01-introducao-ao-curso.html> | <a href='https://curso-r.github.io/main-web-scraping/slides/01-introducao-ao-curso.pdf'> PDF </a> |
| slides/02-introducao-ao-ws.html    | <https://curso-r.github.io/main-web-scraping/slides/02-introducao-ao-ws.html>    | <a href='https://curso-r.github.io/main-web-scraping/slides/02-introducao-ao-ws.pdf'> PDF </a>    |
| slides/03-navegador.html           | <https://curso-r.github.io/main-web-scraping/slides/03-navegador.html>           | <a href='https://curso-r.github.io/main-web-scraping/slides/03-navegador.pdf'> PDF </a>           |
| slides/04-auth.html                | <https://curso-r.github.io/main-web-scraping/slides/04-auth.html>                | <a href='https://curso-r.github.io/main-web-scraping/slides/04-auth.pdf'> PDF </a>                |
| slides/05-html.html                | <https://curso-r.github.io/main-web-scraping/slides/05-html.html>                | <a href='https://curso-r.github.io/main-web-scraping/slides/05-html.pdf'> PDF </a>                |
| slides/06-path.html                | <https://curso-r.github.io/main-web-scraping/slides/06-path.html>                | <a href='https://curso-r.github.io/main-web-scraping/slides/06-path.pdf'> PDF </a>                |
| slides/07-iteracao.html            | <https://curso-r.github.io/main-web-scraping/slides/07-iteracao.html>            | <a href='https://curso-r.github.io/main-web-scraping/slides/07-iteracao.pdf'> PDF </a>            |
| slides/08-webdriver.html           | <https://curso-r.github.io/main-web-scraping/slides/08-webdriver.html>           | <a href='https://curso-r.github.io/main-web-scraping/slides/08-webdriver.pdf'> PDF </a>           |

## Scripts usados em aula

| script           | link                                                                              |
|:-----------------|:----------------------------------------------------------------------------------|
| 01-pokemon.R     | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/01-pokemon.R>     |
| 02-sabesp.R      | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/02-sabesp.R>      |
| 03-sptrans.R     | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/03-sptrans.R>     |
| 04-twitter.R     | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/04-twitter.R>     |
| 05-covid.R       | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/05-covid.R>       |
| 06-html.R        | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/06-html.R>        |
| 07-chancedegol.R | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/07-chancedegol.R> |
| 08-tjsp.R        | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/08-tjsp.R>        |
| 09-ssp.R         | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/09-ssp.R>         |
| 10-wiki.R        | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/10-wiki.R>        |
| 11-ws-example.R  | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/11-ws-example.R>  |
| 12-pesqele.R     | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/12-pesqele.R>     |
| 13-pbi.R         | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/13-pbi.R>         |
| 14-captcha.R     | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/14-captcha.R>     |
| 15-log.R         | <https://curso-r.github.io/202011-web-scraping/exemplos_de_aula/15-log.R>         |
