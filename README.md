
<!-- README.md se genera a partir de README.Rmd. Por favor, editá este archivo. -->

# metzara <img src="man/figures/logo.png" align="right" width="120"/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/EzequielPiseri/metzara/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/EzequielPiseri/metzara/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/EzequielPiseri/metzara/graph/badge.svg)](https://app.codecov.io/gh/EzequielPiseri/metzara)

<!-- badges: end -->

El objetivo de metzara es proporcionar un conjunto de funciones para
leer, procesar y analizar datos meteorológicos de estaciones, de manera
práctica y reproducible. El paquete está diseñado como una herramienta
didáctica y de análisis para proyectos de ciencia de datos y
programación en R.

\#Instalación

Podés instalar la versión de desarrollo de metzara desde
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("EzequielPiseri/metzara")
```

## Ejemplo de uso

A continuación se muestra un ejemplo básico que ilustra cómo utilizar
las funciones del paquete:

``` r
library(metzara)
## basic example code
```

\##Ejemplo práctico Podés usar las funciones incluidas para generar
resúmenes o visualizar los datos. Por ejemplo, si el paquete incluye una
función tabla_resumen_temperatura():

``` r
##tabla_resumen_temperatura(meteo_estaciones)
```

Todavía vas a necesitar renderizar (knit) el archivo README.Rmd
regularmente para mantener el README.md actualizado. La función
devtools::build_readme() es muy útil para esto.

También podés incrustar gráficos, por ejemplo:

<img src="man/figures/README-pressure-1.png" width="100%" />

En ese caso, no te olvides de hacer commit y push de los archivos de las
figuras generadas, para que se muestren correctamente en GitHub y en
CRAN.
