# 1. Baixe as posicoes pelo endpoint /Posicao

u_sptrans_busca <- paste0(u_sptrans, "/Posicao")
r_sptrans_busca <- GET(u_sptrans_busca)
tab_sptrans <- content(r_sptrans_busca, simplifyDataFrame = TRUE)

# 2. Rode tibble::glimpse(tab_sptrans$l, 50)
## e cole o resultado abaixo. Deixe o resultado como um comentário
## Dica: Selecione as linhas que deseja comentar e aplique Ctrl+Shift+C




# 3. Quantas/quais linhas de ônibus temos com o nome LAPA?
## Dica: descubra o endpoint e use um parâmetro de busca!




# 4. [extra] Escolha uma linha e obtenha a posição de todos os ônibus dessa linha.
# Obtenha uma tabela com as coordenadas de latitude e longitude.




# 5. [extra] use o pacote leaflet para montar um mapa contendo a posição de todos 
# os ônibus da linha.
