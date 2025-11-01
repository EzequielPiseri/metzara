
#' Lee y descarga datos meteorologicos de una estacion
#'
#' Esta funcion descarga (si no existe previamente) y lee un archivo CSV con datos
#' meteorologicos correspondientes a una estacion especifica, usando un identificador
#' predefinido. Si el archivo no existe en la ruta indicada, se crea el directorio
#' y se descarga automaticamente desde una fuente remota.
#'
#' @param id_estacion Cadena de texto con el identificador de la estacion.
#' Los valores validos son: "estacion_NH0472", "estacion_NH0910",
#' "estacion_NH0046", "estacion_NH0098" y "estacion_NH0437".
#'
#' @param ruta Cadena de texto con la ruta local donde se guardara o leera el archivo CSV.
#' Por ejemplo, "datos/NH0472.csv".
#'
#' @return Un data frame (tibble) con los datos meteorologicos de la estacion especificada.
#'
#' @details
#' La funcion valida el identificador de estacion, crea la carpeta de destino si no existe,
#' descarga el archivo en caso necesario y luego lee el contenido en formato CSV.
#' Utiliza los paquetes `readr` para la lectura de datos y `cli` para mostrar mensajes informativos.
#'
#' @examples
#' \dontrun{
#' # Descargar y leer los datos de la estacion NH0472
#' datos_ejemplo <- leer_estacion("estacion_NH0472", "datos/NH0472.csv")
#'
#' # Mostrar las primeras filas
#' head(datos_ejemplo)
#' }
#'
#' @export
#' @importFrom utils download.file
#' @importFrom cli cli_abort cli_inform
#' @importFrom readr read_csv
leer_estacion <- function(id_estacion, ruta) {

  urls <- list(
    estacion_NH0472 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0472.csv",
    estacion_NH0910 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0910.csv",
    estacion_NH0046 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0046.csv",
    estacion_NH0098 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0098.csv",
    estacion_NH0437 = "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/NH0437.csv"
  )

  if (!id_estacion %in% names(urls)) {
    cli::cli_abort("El id de estacion '{id_estacion}' no es valido. Usa uno de: {toString(names(urls))}")
  }

  url <- urls[[id_estacion]]
  directorio <- dirname(ruta)

  if (!dir.exists(directorio)) {
    cli::cli_inform("La carpeta '{directorio}' no existe. Creandola...")
    dir.create(directorio, recursive = TRUE)
    cli::cli_inform("Carpeta '{directorio}' creada.")
  }

  if (!file.exists(ruta)) {
    cli::cli_inform("El archivo no existe en la ruta indicada. Descargando datos de la estacion {id_estacion}...")
    utils::download.file(url, ruta, mode = "wb")
    cli::cli_inform("Descarga completada en '{ruta}'.")
  } else {
    cli::cli_inform("El archivo ya existe en la ruta indicada. Leyendo archivo '{ruta}'...")
  }

  datos <- suppressWarnings(
    suppressMessages(
      readr::read_csv(
        ruta,
        show_col_types = FALSE,
        progress = FALSE
      )
    )
  )

  cli::cli_inform("Lectura completada. El dataset de la estacion {id_estacion} tiene {nrow(datos)} filas y {ncol(datos)} columnas.")
  return(datos)
}



# datos_ejemplo <- leer_estacion("estacion_NH0472", "datos/NH0472.csv")
