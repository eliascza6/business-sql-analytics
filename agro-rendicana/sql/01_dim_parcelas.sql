-- =============================================================================
-- PROYECTO: RendiCaña v4.2
-- TABLA: dim_parcelas (Dimensión Predios y Régimen Fiscal)
-- MOTOR: Google BigQuery Sandbox ($0 USD)
-- AUTOR: Elías Cruz Álvarez (Analytics Translator & Senior SaaS Architect)
-- =============================================================================

CREATE OR REPLACE TABLE `rendicana-analytics.rendicana_dw.dim_parcelas` (
  Productor_ID STRING OPTIONS(description="Identificador del productor (Multi-tenant)"),
  Lote_ID STRING OPTIONS(description="Clave primaria del predio"),
  Nombre_Predio STRING OPTIONS(description="Toponímico de la parcela"),
  Superficie_Cosechada_Real_Ha NUMERIC OPTIONS(description="Superficie cultivable física en Ha"),
  Variedad STRING OPTIONS(description="Variedad agronómica de caña"),
  Tipo_Suelo STRING OPTIONS(description="Clasificación edafológica"),
  Contrato_Ingenio STRING OPTIONS(description="Factoría receptora del contrato"),
  Ubicacion_Municipio STRING OPTIONS(description="Municipio de ubicación del predio"),
  Regimen_Fiscal_SAT STRING OPTIONS(description="Tratamiento fiscal del productor (RESICO, PFAE, AGAPE)")
);

INSERT INTO `rendicana-analytics.rendicana_dw.dim_parcelas` 
VALUES 
  ('PROD-4843', 'LOTE-004', '207 El Mosquitero (Tabla 4)', 9.0, 'CP 72-2086', 'Franco Arcilloso', 'Ingenio El Modelo', 'Alvarado', 'RESICO_PF_EXENTO'),
  ('PROD-4846', 'LOTE-005', '207 El Mosquitero (Tabla 5)', 14.0, 'MEX 69-290', 'Arcilloso Pesado', 'Ingenio El Modelo', 'Alvarado', 'RESICO_PF_EXENTO'),
  ('PROD-4194', 'LOTE-006', '207 El Mosquitero (Tabla 6)', 1.0, 'ITV 92-1424', 'Franco Arenoso', 'Ingenio El Modelo', 'Alvarado', 'SIN_REGISTRO_FORMAL'),
  ('PROD-4196', 'LOTE-007', '207 El Mosquitero (Tabla 7)', 4.0, 'CP 72-2086', 'Franco Arcilloso', 'Ingenio El Modelo', 'Alvarado', 'RESICO_PF_GRAVADO'),
  ('PROD-4195', 'LOTE-008', '207 El Mosquitero (Tabla 8)', 12.0, 'MEX 69-290', 'Vegas de Río', 'Ingenio El Modelo', 'Alvarado', 'RESICO_PF_EXENTO'),
  ('PROD-5774', 'LOTE-009', 'Mandinga y Cardonal', 10.0, 'CP 72-2086', 'Franco Limoso', 'Ingenio La Gloria', 'Cardonal', 'PFAE_GENERAL');
