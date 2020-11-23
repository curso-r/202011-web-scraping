library(RSelenium)
library(magrittr)

driver <- RSelenium::rsDriver()
u <- "https://app.powerbi.com/view?r=eyJrIjoiMjcxNDIyNjAtOGM0Yi00ZWJhLWJkNmEtNjFiOTI0MWVlYjNiIiwidCI6IjI1NmNiNTA1LTAzOWYtNGZiMi04NWE2LWEzZTgzMzI4NTU3OCIsImMiOjh9"
driver$client$navigate(u)

# obter os valores que estão nos retângulos iniciais


# clicar no brasil
el <- driver$client$findElement("xpath", "//*[@class='slicer-dropdown-menu']")
el$clickElement()

scroll <- driver$client$findElement("xpath", "//*[contains(@class, 'scroll-scrolly_visible')]")
scroll$executeScript("arguments[0].scrollBy(0,100);", args = list(scroll))

checkbox <- driver$client$findElement("xpath", "//*[@title='Brazil']")
checkbox$clickElement()

# obter os valores novamente

# outros testes