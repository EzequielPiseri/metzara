
#' Genera un resumen estadistico de temperatura para una o mas estaciones
#'
#' Esta funcion lee los datos meteorologicos de una o mas estaciones, combinando la informacion
#' descargada mediante `leer_estacion()`. Calcula estadisticas basicas de temperatura para cada
#' estacion (media, desviacion estandar, valores maximos y minimos) y devuelve los resultados
#' en formato largo.
#'
#' @param ids_estaciones Vector de texto con los identificadores de las estaciones cuyas
#' temperaturas se desean resumir. Por ejemplo:
#' `c("estacion_NH0098", "estacion_NH0437", "estacion_NH0472")`.
#'
#' @return Un data frame (tibble) con el resumen de temperatura por estacion,
#' con las siguientes columnas:
#' \itemize{
#'   \item `id`: Identificador de la estacion.
#'   \item `Tipo`: Tipo de valor ("Maxima" o "Minima").
#'   \item `Temperatura`: Valor correspondiente de temperatura.
#' }
#'
#' @details
#' La funcion recorre las estaciones indicadas, leyendo los archivos CSV locales (o descargandolos
#' si no existen) mediante `leer_estacion()`. Luego, combina todos los datos en un unico conjunto
#' y calcula, para cada estacion, las temperaturas media, desviacion estandar, maxima y minima.
#' Finalmente, reestructura la tabla a formato largo para facilitar la visualizacion o el analisis.
#'
#' Utiliza los paquetes `dplyr`, `tidyr` y `cli` para el manejo y procesamiento de los datos.
#'
#' @examples
#' \dontrun{
#' # Generar un resumen de temperatura para tres estaciones
#' resumen <- tabla_resumen_temperatura(
#'   ids_estaciones = c("estacion_NH0098", "estacion_NH0437", "estacion_NH0472")
#' )
#'
#' # Ver las primeras filas del resumen
#' head(resumen)
#' }
#'
#' @export
#' @importFrom dplyr group_by summarise bind_rows
#' @importFrom tidyr pivot_longer
#' @importFrom cli cli_inform
#' @importFrom stats sd
tabla_resumen_temperatura <- function(ids_estaciones) {

  lista_datos <- list()

  for (id in ids_estaciones) {
    ruta <- paste0("datos/", id, ".csv")
    datos <- leer_estacion(id, ruta)
    datos$id <- id
    lista_datos[[id]] <- datos
  }

  todas_las_estaciones <- dplyr::bind_rows(lista_datos)

  resumen <- todas_las_estaciones |>
    dplyr::group_by(.data$id) |>
    dplyr::summarise(
      Media               = mean(.data$temperatura_abrigo_150cm, na.rm = TRUE),
      Desviacion_Estandar = stats::sd(.data$temperatura_abrigo_150cm, na.rm = TRUE),
      Maxima              = max(.data$temperatura_abrigo_150cm, na.rm = TRUE),
      Minima              = min(.data$temperatura_abrigo_150cm, na.rm = TRUE),
      .groups = "drop"
    )

  resumen_largo <- tidyr::pivot_longer(
    resumen,
    cols = c("Maxima", "Minima"),
    names_to = "Tipo",
    values_to = "Temperatura"
  )

  cli::cli_inform("Tabla resumen de temperatura generada para {length(ids_estaciones)} estacion(es).")
  return(resumen_largo)
}


# Ejemplo:

#tabla_resumen_temperatura(c("estacion_NH0437", "estacion_NH0472", "estacion_NH0098"))
