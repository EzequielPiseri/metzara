test_that("tabla_resumen_temperatura retorna formato largo correcto", {
  ids <- c("estacion_NH0472", "estacion_NH0437")

  res <- tabla_resumen_temperatura(ids)

  expect_s3_class(res, "data.frame")
  expect_true(all(c("id", "Tipo", "Temperatura") %in% names(res)))
  expect_gt(nrow(res), 0)

  expect_setequal(unique(res$id), ids)
  expect_true(all(res$Tipo %in% c("Maxima","Minima")))
  expect_type(res$Temperatura, "double")
})

test_that("tabla_resumen_temperatura informa por consola y propaga error en id inválido", {
  expect_message(
    tabla_resumen_temperatura(c("estacion_NH0472")),
    regexp = "(?i)Tabla resumen de temperatura generada para 1 estación"
  )


  expect_error(
    tabla_resumen_temperatura(c("estacion_INEXISTENTE")),
    regexp = "(?i)no es válido"
  )
})
