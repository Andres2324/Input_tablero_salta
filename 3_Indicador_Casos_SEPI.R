


# INDICADOR 1: Casos de IRAG e IRAG extendida por semana epidemiológica ----------------


# PASO 1
UCIRAG_HSM_Filtrado <- UCIRAG_HSM %>%
  # Convertimos la fecha si viene como texto
  mutate(FECHA_MINIMA = as.Date(FECHA_MINIMA)) %>%
  # Excluimos los casos invalidados CHEQUEAR
  filter(CLASIFICACION_MANUAL != "Caso invalidado por epidemiología") %>%
  # Agregamos columnas de año y semana epidemiológica
  mutate(
    anio = isoyear(FECHA_MINIMA),
    semana = isoweek(FECHA_MINIMA) #si bien hay una columna SEPI_FECHA_MINIMA
  )


# PASO 2
tabla_resumen <- UCIRAG_HSM_Filtrado %>%
  group_by(anio, semana, CLASIFICACION_MANUAL) %>%
  summarise(casos = n(), .groups = "drop")


# PASO 3  Rango completo de semanas para visualización
semanas_completas <- expand_grid(
  anio = 2024:2025,
  semana = 1:53,
  CLASIFICACION_MANUAL = c("IRAG extendida", "Infección respiratoria aguda grave (IRAG)")
)

# PASO 4 Unimos para que las semanas sin casos queden con 0 - REVISAR SEMANAS CREADAS- INCLUYE AÑOS COMPLETOS 2024 Y 2025

tabla_resumen_completa <- semanas_completas %>%
  left_join(tabla_resumen, by = c("anio", "semana", "CLASIFICACION_MANUAL")) %>%
  mutate(casos = replace_na(casos, 0))

tabla_resumen_completa <- tabla_resumen_completa %>%
  arrange(anio, semana) %>%
  mutate(semana_label = factor(paste0(anio, "-", sprintf("%02d", semana)),
                               levels = unique(paste0(anio, "-", sprintf("%02d", semana)))))


#PASO 5 Visualizacion REVISAR con el SCRIP del otro repo

ggplot(tabla_resumen_completa, aes(x = semana_label, y = casos, fill = CLASIFICACION_MANUAL)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Casos IRAG por Semana Epidemiológica (2024–2025)",
    x = "Semana Epidemiológica",
    y = "Número de casos",
    fill = "Clasificación"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5)) +
  scale_x_discrete(breaks = function(x) x[seq(1, length(x), by = 4)])  # cada 4 semanas









                              