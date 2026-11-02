-- =============================================================================
-- PROYECTO: RendiCaña v4.2
-- OBJETO: vw_datos_maestros (Vista Lógica de Consolidación y Semáforos)
-- MOTOR: Google BigQuery Sandbox ($0 USD Cómputo On-Demand)
-- =============================================================================

CREATE OR REPLACE VIEW `rendicana-analytics.rendicana_dw.vw_datos_maestros` AS
WITH resumen_costos AS (
  SELECT 
    Lote_ID, 
    COALESCE(SUM(Costo_Total_MXN), 0) AS Costo_Cultivo_Invertido_MXN
  FROM `rendicana-analytics.rendicana_dw.fact_registro_costos` 
  GROUP BY Lote_ID
),
resumen_molienda AS (
  SELECT 
    Lote_ID, 
    ANY_VALUE(Contrato_Ingenio) AS Contrato_Ingenio,
    SUM(Toneladas_Netas) AS Toneladas_Netas_Total,
    SUM(Deduccion_Corte_Mecanizado_MXN + Deduccion_Acarreo_Flete_MXN) AS Gasto_Logistico_Total_MXN,
    SUM(Total_Deducciones_Zafra_MXN) AS Total_Deducciones_Zafra_MXN,
    SUM(Valor_Bruto_Liquidacion_MXN) AS Ingreso_Bruto_Total_MXN,
    SUM(Alcance_Neto_Final_MXN) AS Alcance_Neto_Final_MXN
  FROM `rendicana-analytics.rendicana_dw.fact_karbe_molienda` 
  GROUP BY Lote_ID
)
SELECT 
  p.Productor_ID,
  p.Lote_ID, 
  p.Nombre_Predio, 
  COALESCE(m.Contrato_Ingenio, p.Contrato_Ingenio) AS Contrato_Ingenio,
  p.Superficie_Cosechada_Real_Ha AS Superficie_Ha,
  COALESCE(m.Toneladas_Netas_Total, 0) AS Toneladas_Netas,
  ROUND(SAFE_DIVIDE(m.Toneladas_Netas_Total, p.Superficie_Cosechada_Real_Ha), 2) AS Rendimiento_Ton_Ha,
  ROUND(SAFE_DIVIDE(m.Gasto_Logistico_Total_MXN, m.Toneladas_Netas_Total), 2) AS Costo_Logistico_Por_Ton_MXN,
  ROUND(SAFE_DIVIDE(m.Gasto_Logistico_Total_MXN, m.Ingreso_Bruto_Total_MXN) * 100, 2) AS Pct_Absorcion_Logistica,
  COALESCE(m.Ingreso_Bruto_Total_MXN, 0) AS Ingreso_Bruto_MXN,
  COALESCE(m.Total_Deducciones_Zafra_MXN, 0) AS Deducciones_Zafra_MXN,
  COALESCE(c.Costo_Cultivo_Invertido_MXN, 0) AS Costo_Cultivo_Invertido_MXN,
  ROUND(COALESCE(m.Alcance_Neto_Final_MXN, 0) - COALESCE(c.Costo_Cultivo_Invertido_MXN, 0), 2) AS Margen_Neto_Bolsillo_MXN,
  CASE 
    WHEN SAFE_DIVIDE(m.Gasto_Logistico_Total_MXN, m.Ingreso_Bruto_Total_MXN) > 0.55 THEN '🔴 SOBRECOSTO_LOGISTICO'
    WHEN SAFE_DIVIDE(m.Gasto_Logistico_Total_MXN, m.Ingreso_Bruto_Total_MXN) >= 0.50 THEN '🟡 ALERTA_LOGISTICA'
    ELSE '🟢 CONTROLADO'
  END AS Semaforo_Logistico
FROM `rendicana-analytics.rendicana_dw.dim_parcelas` p
LEFT JOIN resumen_costos c ON p.Lote_ID = c.Lote_ID
LEFT JOIN resumen_molienda m ON p.Lote_ID = m.Lote_ID;
