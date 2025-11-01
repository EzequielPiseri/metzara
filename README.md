
<!-- README.md se genera a partir de README.Rmd. Por favor, editá este archivo. -->

# metzara <img src="man/figures/logo.png" align="right" width="130"/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/EzequielPiseri/metzara/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/EzequielPiseri/metzara/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/EzequielPiseri/metzara/branch/main/graph/badge.svg)](https://app.codecov.io/gh/EzequielPiseri/metzara)

<!-- badges: end -->

# Objetivo

El paquete **metzara** tiene como objetivo facilitar el análisis, la
lectura y la visualización de datos meteorológicos provenientes de
estaciones.  
A través de sus funciones principales, permite automatizar la descarga,
estandarización, resumen y graficación de datos de temperatura, de
manera práctica y reproducible.

Este paquete fue desarrollado como herramienta didáctica y de análisis
dentro de proyectos de ciencia de datos y programación en R.

------------------------------------------------------------------------

## Instalación

Podés instalar la versión de desarrollo del paquete desde
[GitHub](https://github.com/) con:

``` r
# install.packages("pak")
pak::pak("EzequielPiseri/metzara")
```

------------------------------------------------------------------------

## Descarga de datos

Para obtener los datos de estaciones meteorológicas, se implementó la
siguiente función:

### **`leer_estacion()`**

Esta función descarga (si no existe previamente) y lee un archivo CSV
con los datos meteorológicos correspondientes a una estación específica,
usando un identificador predefinido.  
Si el archivo no existe en la ruta indicada, crea el directorio y
descarga automáticamente el dataset desde una fuente remota.

**Ejemplo de uso:**

``` r
datos_ejemplo <- leer_estacion("estacion_NH0472", "datos/NH0472.csv")
head(datos_ejemplo)
```

------------------------------------------------------------------------

## Funciones principales

1.  **`tabla_resumen_temperatura()`**  
    Calcula medidas significativas por estación (media, desviación
    estándar, máximo y mínimo) a partir de los datos descargados.  
    Devuelve una tabla en formato largo, útil para comparar las
    temperaturas entre distintas estaciones.

    **Ejemplo:**

    ``` r
    resumen <- tabla_resumen_temperatura(c("estacion_NH0472"))
    head(resumen)
    ```

2.  **`grafico_temperatura_mensual()`**  
    Genera un gráfico de tendencia mensual de temperatura media por
    estación.  
    Agrupa los datos por mes y calcula el promedio de temperatura,
    mostrando visualmente las variaciones a lo largo del año.

    **Ejemplo:**

    ``` r
    grafico <- grafico_temperatura_mensual(datos_ejemplo, titulo = "Temperatura mensual promedio")
    grafico
    ```

------------------------------------------------------------------------

## Ejemplo completo

Este es un flujo de trabajo básico con **metzara**:

``` r
library(metzara)

# Descargar datos de una estación
datos <- leer_estacion("estacion_NH0472", "datos/NH0472.csv")

# Generar tabla resumen
resumen <- tabla_resumen_temperatura(c("estacion_NH0472"))

# Crear gráfico mensual
grafico_temperatura_mensual(datos, titulo = "Promedio mensual de temperatura - Estación NH0472")
```

------------------------------------------------------------------------

## Autores del paquete

- **Ezequiel Piseri**  
  [GitHub: EzequielPiseri](https://github.com/EzequielPiseri)  
  Estudiante de Ciencia de Datos – Universidad Austral

- **Kiara Manacasa**  
  [GitHub: Kiaramanacasa](https://github.com/Kiaramanacasa)  
  Estudiante de Ciencia de Datos – Universidad Austral

------------------------------------------------------------------------

## Contribuciones al paquete

Si deseás realizar contribuciones al paquete, ya sea para agregar
mejoras, corregir errores o proponer nuevas funciones, seguí estos
pasos:

1.  **Fork y clona el repositorio**  
    Hacé un *fork* del repositorio en tu cuenta de GitHub y clonalo en
    tu máquina local.

2.  **Realizá tus cambios y creá un pull request**  
    Una vez hechos los cambios, abrí un *pull request* a la rama
    principal del proyecto con una descripción clara del propósito de la
    contribución.

Para dudas o sugerencias, podés contactarnos a los siguientes correos:

- **Ezequiel Piseri**: <ezequielpiseri@gmail.com>  
- **Kiara Manacasa**: <kmanacasa@gmail.com>

------------------------------------------------------------------------

### Código de contribución

[Guía de
contribución](https://github.com/EzequielPiseri/metzara/blob/main/.github/CONTRIBUTING.md)

------------------------------------------------------------------------
