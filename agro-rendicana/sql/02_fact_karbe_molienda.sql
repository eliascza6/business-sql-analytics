-- =============================================================================
-- PROYECTO: RendiCaña v4.2
-- TABLA: fact_karbe_molienda (Hechos de Molienda, Báscula y Retenciones)
-- MOTOR: Google BigQuery Sandbox (Ingesta Atómica DDL sin costos de facturación)
-- =============================================================================

CREATE OR REPLACE TABLE `rendicana-analytics.rendicana_dw.fact_karbe_molienda` AS
SELECT 'LIQ-4192' AS Remision_ID, DATE '2026-07-29' AS Fecha_Corte, 'PROD-4843' AS Productor_ID, 'LOTE-004' AS Lote_ID, 'Ingenio El Modelo' AS Contrato_Ingenio, 469.310 AS Toneladas_Brutas, 8.50 AS Porcentaje_Castigo_Materia_Extrana, 429.418 AS Toneladas_Netas, 13.20 AS Pol_Cana, 84.50 AS Pureza_Jugo, 111.264 AS KARBE_Obtenido, 913.25 AS Precio_Base_Ton_MXN, 913.25 AS Precio_Ajustado_Ton_MXN, 441253.15 AS Valor_Bruto_Liquidacion_MXN, 84475.80 AS Deduccion_Corte_Mecanizado_MXN, 110392.96 AS Deduccion_Acarreo_Flete_MXN, 15665.62 AS Deduccion_Cortadores_Manual_MXN, 36434.05 AS Deduccion_Cuotas_IMSS_Otros_MXN, 68447.51 AS Amortizacion_Preliquidaciones_MXN, 246968.43 AS Total_Deducciones_Zafra_MXN, 927.83 AS Retenciones_Institucionales_MXN, 125836.21 AS Alcance_Neto_Final_MXN
UNION ALL
SELECT 'LIQ-4193', DATE '2026-07-29', 'PROD-4846', 'LOTE-005', 'Ingenio El Modelo', 837.515, 7.50, 774.694, 13.20, 84.50, 111.264, 913.25, 913.25, 800892.18, 116800.20, 216348.81, 69167.31, 103303.08, 81374.91, 505619.40, 4703.66, 209194.21
UNION ALL
SELECT 'LIQ-4194', DATE '2026-07-29', 'PROD-4194', 'LOTE-006', 'Ingenio El Modelo', 80.540, 8.50, 73.694, 13.20, 84.50, 111.264, 913.25, 913.25, 75749.59, 14497.20, 19028.70, 4907.40, 5476.73, 9902.18, 43910.03, 822.11, 21017.43
UNION ALL
SELECT 'LIQ-4196', DATE '2026-07-29', 'PROD-4196', 'LOTE-007', 'Ingenio El Modelo', 138.120, 10.50, 123.617, 13.20, 84.50, 111.264, 913.25, 913.25, 129484.28, 24803.60, 39637.45, 6412.48, 12434.68, 10022.49, 83288.21, 1441.99, 34731.59
UNION ALL
SELECT 'LIQ-4195', DATE '2026-07-29', 'PROD-4195', 'LOTE-008', 'Ingenio El Modelo', 486.770, 8.50, 445.393, 13.20, 84.50, 111.264, 913.25, 913.25, 457668.53, 87818.80, 114499.98, 15528.12, 33161.01, 75873.20, 251007.91, 933.62, 129873.80
UNION ALL
SELECT 'LIQ-05774', DATE '2026-08-19', 'PROD-5774', 'LOTE-009', 'Ingenio La Gloria', 572.160, 10.00, 514.944, 12.80, 82.10, 105.491, 865.87, 865.87, 445874.50, 111571.20, 132626.69, 13447.59, 20306.47, 65134.08, 277951.95, 3093.02, 78419.01;
