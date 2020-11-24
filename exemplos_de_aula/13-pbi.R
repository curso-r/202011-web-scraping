library(RSelenium)
library(magrittr)

driver <- RSelenium::rsDriver(browser = "firefox")
u <- "https://app.powerbi.com/view?r=eyJrIjoiMjcxNDIyNjAtOGM0Yi00ZWJhLWJkNmEtNjFiOTI0MWVlYjNiIiwidCI6IjI1NmNiNTA1LTAzOWYtNGZiMi04NWE2LWEzZTgzMzI4NTU3OCIsImMiOjh9"
driver$client$navigate(u)

## exemplo google
# stocks <- c("PETR4", "BOVA11", "ITSA4", "IBOV")
# for(i in stocks) {
#   driver$client$navigate("https://google.com")
#   el <- driver$client$findElement("xpath", "//input[@name='q']")
#   el$sendKeysToElement(list(i))
#   Sys.sleep(2)
#   el$sendKeysToElement(list(key = "enter"))
#   Sys.sleep(2)
# }

## Exemplo com captcha
# driver$client$navigate("http://leismunicipa.is/mxhuw")

# obter os valores que estão nos retângulos iniciais


html <- driver$client$getPageSource()
readr::write_file(html[[1]], "pbi.html")

httr::BROWSE("pbi.html")

elems <- driver$client$findElements("xpath", "//*[@class='value']")
elems[[1]]$getElementText()
purrr::map_chr(elems, ~.x$getElementText()[[1]])

# clicar no brasil
el <- driver$client$findElement("xpath", "//*[@class='slicer-dropdown-menu']")
el$clickElement()

scroll <- driver$client$findElement("xpath", "//*[contains(@class, 'scroll-scrolly_visible')]")
capturar_erro <- function(cl) {
  cl$findElement("xpath", "//*[@title='Brazil']")
}
safe_capturar_erro <- purrr::safely(capturar_erro)
erro <- TRUE
while(erro) {
  Sys.sleep(5)
  scroll$executeScript("arguments[0].scrollBy(0,100);", args = list(scroll))
  checkbox <- safe_capturar_erro(driver$client)
  erro <- is.null(checkbox$result)
}



checkbox$clickElement()

# obter os valores novamente

elems <- driver$client$findElements("xpath", "//*[@class='value']")
elems[[1]]$getElementText()
purrr::map_chr(elems, ~.x$getElementText()[[1]])

# outros testes

