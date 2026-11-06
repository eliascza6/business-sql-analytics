/* ==============================================================================
   PROYECTO: RendiCaña Analytics Engine
   SCRIPT: 05_auditoria_metricas.sql
   PROPÓSITO: Validación rápida de KPIs consolidados, superficie total (65.5 Ha)
              y absorción del costo en LOTE-004 ($260,918.43 MXN)
   ============================================================================== */

SELECT 
  Lote_ID,
  Superficie_Ha,
  Costo_Total_Invertido_MXN,
  Semaforo_Financiero
FROM 
  `rendicana_analytics_v4.vw_resumen_lotes_financiero`
ORDER BY 
  Lote_ID ASC;
