<!-- README.md se genera a partir de README.Rmd. Por favor, editá este archivo. -->

<!-- 🔵 Encabezado con color de fondo -->
<div align="center" style="
  background: linear-gradient(135deg, #0077cc, #00aaff);
  padding: 30px 10px;
  border-radius: 10px;
  color: white;
  font-family: 'Segoe UI', sans-serif;
  box-shadow: 0 4px 10px rgba(0,0,0,0.2);
">
  <h1 style="margin-bottom: 10px; font-size: 2.8em;">🌦️ metzara</h1>
  <h3 style="margin-top: 0; font-weight: 400;">Análisis y procesamiento de datos meteorológicos en R</h3>
</div>

<p align="center">
  <a href="https://lifecycle.r-lib.org/articles/stages.html#experimental">
    <img src="https://img.shields.io/badge/lifecycle-experimental-orange.svg" alt="lifecycle"/>
  </a>
  <a href="https://github.com/EzequielPiseri/metzara/actions">
    <img src="https://github.com/EzequielPiseri/metzara/actions/workflows/R-CMD-check.yaml/badge.svg" alt="R CMD Check"/>
  </a>
  <a href="https://codecov.io/gh/EzequielPiseri/metzara">
    <img src="https://codecov.io/gh/EzequielPiseri/metzara/branch/main/graph/badge.svg" alt="Coverage"/>
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="MIT License"/>
  </a>
</p>

---

<!-- badges: start -->
<p align="center">
  <a href="https://lifecycle.r-lib.org/articles/stages.html#experimental">
    <img src="https://img.shields.io/badge/lifecycle-experimental-orange.svg" alt="lifecycle-badge"/>
  </a>
  <a href="https://github.com/EzequielPiseri/metzara/actions">
    <img src="https://github.com/EzequielPiseri/metzara/actions/workflows/R-CMD-check.yaml/badge.svg" alt="R CMD Check"/>
  </a>
  <a href="https://codecov.io/gh/EzequielPiseri/metzara">
    <img src="https://codecov.io/gh/EzequielPiseri/metzara/branch/main/graph/badge.svg" alt="Coverage"/>
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="MIT License"/>
  </a>
</p>
<!-- badges: end -->

---

## ☀️ Descripción general

**metzara** es un paquete desarrollado en R para facilitar el **análisis, limpieza y visualización de datos meteorológicos** de distintas estaciones.  
Su propósito es ofrecer una herramienta **didáctica, reproducible y práctica** para proyectos de ciencia de datos, programación y estudios climáticos.

🌬️ Este paquete permite:
- Descargar y leer datos meteorológicos desde archivos o URLs.  
- Calcular estadísticas descriptivas de temperatura, humedad y precipitación.  
- Generar gráficos y reportes reproducibles.  
- Trabajar con datasets de ejemplo para aprender y experimentar.

---

## 🌧️ Instalación

Instalá la versión de desarrollo directamente desde GitHub:

```r
# install.packages("pak")
pak::pak("EzequielPiseri/metzara")
## 🌡️ Funciones principales
Función	Descripción
leer_estacion()	Descarga o lee datos crudos de una estación específica.
tabla_resumen_temperatura()	Calcula media, mínimo, máximo y desvío estándar de temperatura.
grafico_temperatura_mensual()	Promedia la temperatura mensual y genera un gráfico de tendencia.
descargar_datos()	Automatiza la descarga de datasets meteorológicos.

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
