/* ==============================================================================
   PROYECTO: RendiCaña Core Engine v4.2
   VISTA: vw_resumen_lotes_financiero (Consolidado P&L, Semáforos y Absorción)
   ARQUITECTURA: Federated External Tables sobre Google Sheets ($0.00 USD)
   AUTOR: Elías Cruz Álvarez (Analytics Translator & Senior SaaS Architect)
   ============================================================================== */

CREATE OR REPLACE VIEW `rendicana_analytics_v4.vw_resumen_lotes_financiero` AS
WITH 
-- 1. Dimensión Predios: Atributos físicos, agronómicos y de escala
dim_parcelas AS (
  SELECT 
    Lote_ID,
    'PROD-001' AS Productor_ID,
    Nombre_Predio,
    Superficie_Ha,
    Variedad,
    Tipo_Suelo,
    Contrato_Ingenio,
    Ubicacion_Municipio,
    -- Estimación paramétrica agronómica por ciclo regional
    CASE 
      WHEN Lote_ID IN ('LOTE-001', 'LOTE-003') THEN 'Plantilla'
      ELSE 'Soca'
    END AS Ciclo_Agronomico,
    CASE 
      WHEN Lote_ID IN ('LOTE-001', 'LOTE-003') THEN 34690.00
      ELSE 16810.00
    END AS Presupuesto_Meta_Ha_MXN
  FROM 
    `rendicana_analytics_v4.ext_registro_parcelas`
),

-- 2. Hechos de Costos: Agregación atómica sin duplicidad cartesiana
agg_costos AS (
  SELECT 
    Lote_ID,
    COUNT(DISTINCT ID_Registro) AS Total_Eventos_Registrados,
    SUM(Costo_Total_MXN) AS Costo_Total_Invertido_MXN,
    SUM(CASE WHEN Estatus_Deducibilidad_RESICO = 'SÍ' THEN Costo_Total_MXN ELSE 0 END) AS Costo_Soportado_Fiscal_MXN,
    SUM(CASE WHEN Estatus_Deducibilidad_RESICO = 'NO' THEN Costo_Total_MXN ELSE 0 END) AS Costo_Operativo_Sin_CFDI_MXN
  FROM 
    `rendicana_analytics_v4.ext_registro_costos`
  GROUP BY 
    Lote_ID
),

-- 3. Métricas Agronómicas y Rendimientos Estimados
metricas_consolidadas AS (
  SELECT 
    p.Lote_ID,
    p.Productor_ID,
    p.Nombre_Predio,
    p.Superficie_Ha,
    p.Ciclo_Agronomico,
    p.Presupuesto_Meta_Ha_MXN,
    (p.Superficie_Ha * p.Presupuesto_Meta_Ha_MXN) AS Presupuesto_Total_Lote_MXN,
    -- Rendimiento regional estimado de zafra (Ton/Ha)
    CASE 
      WHEN p.Lote_ID = 'LOTE-001' THEN 75.00
      WHEN p.Lote_ID = 'LOTE-002' THEN 65.00
      WHEN p.Lote_ID = 'LOTE-003' THEN 70.00
      WHEN p.Lote_ID = 'LOTE-004' THEN 47.71
      WHEN p.Lote_ID = 'LOTE-005' THEN 55.34
      WHEN p.Lote_ID = 'LOTE-006' THEN 73.69
      WHEN p.Lote_ID = 'LOTE-007' THEN 30.90
      WHEN p.Lote_ID = 'LOTE-008' THEN 37.12
      WHEN p.Lote_ID = 'LOTE-009' THEN 51.49
      ELSE 60.00
    END AS Rendimiento_Est_Ton_Ha,
    915.00 AS Precio_Liquidacion_Est_Ton_MXN,
    COALESCE(c.Total_Eventos_Registrados, 0) AS Total_Eventos_Registrados,
    COALESCE(c.Costo_Total_Invertido_MXN, 0.0) AS Costo_Total_Invertido_MXN,
    COALESCE(c.Costo_Soportado_Fiscal_MXN, 0.0) AS Costo_Soportado_Fiscal_MXN,
    COALESCE(c.Costo_Operativo_Sin_CFDI_MXN, 0.0) AS Costo_Operativo_Sin_CFDI_MXN
  FROM 
    dim_parcelas p
  LEFT JOIN 
    agg_costos c ON p.Lote_ID = c.Lote_ID
)

-- 4. Capa Ejecutiva Final: Rentabilidad, Absorción y Semáforo Directivo
SELECT 
  Lote_ID,
  Productor_ID,
  Nombre_Predio,
  Superficie_Ha,
  Ciclo_Agronomico,
  Rendimiento_Est_Ton_Ha,
  ROUND(Superficie_Ha * Rendimiento_Est_Ton_Ha, 2) AS Ton_Totales_Est,
  Costo_Total_Invertido_MXN,
  ROUND(Costo_Total_Invertido_MXN / NULLIF(Superficie_Ha * Rendimiento_Est_Ton_Ha, 0), 2) AS Costo_Por_Ton_MXN,
  ROUND((Superficie_Ha * Rendimiento_Est_Ton_Ha) * Precio_Liquidacion_Est_Ton_MXN, 2) AS Ingreso_Bruto_Est_MXN,
  ROUND(((Superficie_Ha * Rendimiento_Est_Ton_Ha) * Precio_Liquidacion_Est_Ton_MXN) - Costo_Total_Invertido_MXN, 2) AS Margen_Neto_Est_MXN,
  Presupuesto_Total_Lote_MXN,
  ROUND(Costo_Total_Invertido_MXN / NULLIF(Presupuesto_Total_Lote_MXN, 0), 4) AS Ratio_Consumo_Presupuesto,
  -- Semáforo Financiero de Decisión Agronómica
  CASE 
    WHEN (Costo_Total_Invertido_MXN / NULLIF(Presupuesto_Total_Lote_MXN, 0)) > 1.00 THEN '🔴 SOBRECOSTO'
    WHEN (Costo_Total_Invertido_MXN / NULLIF(Presupuesto_Total_Lote_MXN, 0)) >= 0.85 THEN '🟡 ALERTA'
    ELSE '🟢 CONTROLADO'
  END AS Semaforo_Financiero,
  Costo_Soportado_Fiscal_MXN,
  Costo_Operativo_Sin_CFDI_MXN
FROM 
  metricas_consolidadas
ORDER BY 
  Lote_ID ASC;
