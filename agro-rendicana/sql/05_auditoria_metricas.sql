-- =============================================================================
-- PROYECTO: RendiCaña v4.2
-- QUERY: Auditoría Ejecutiva de Control de Totales de Zafra
-- OBJETIVO: Validación matemática previa a la renderización en Looker Studio
-- =============================================================================

SELECT 
  COUNT(DISTINCT Lote_ID) AS Total_Lotes_Auditados,
  SUM(Superficie_Ha) AS Superficie_Total_Ha,
  ROUND(SUM(Toneladas_Netas), 2) AS Total_Toneladas_Netas,
  ROUND(AVG(Costo_Logistico_Por_Ton_MXN), 2) AS Costo_Logistico_Promedio_Ton,
  ROUND(SUM(Ingreso_Bruto_MXN), 2) AS Valor_Bruto_Zafra_MXN,
  ROUND(SUM(Deducciones_Zafra_MXN), 2) AS Total_Deducciones_Zafra_MXN,
  ROUND(SUM(Costo_Cultivo_Invertido_MXN), 2) AS Inversion_Agronomica_Campo_MXN,
  ROUND(SUM(Margen_Neto_Bolsillo_MXN), 2) AS Margen_Neto_Real_Bolsillo_MXN
FROM `rendicana-analytics.rendicana_dw.vw_datos_maestros`;
