-- =============================================================================
-- PROYECTO: RendiCaña v4.2
-- TABLA: fact_registro_costos (Bitácora de Gastos de Cultivo e Insumos)
-- MOTOR: Google BigQuery (Particionada por Fecha, Clustered por Productor y Lote)
-- =============================================================================

CREATE OR REPLACE TABLE `rendicana-analytics.rendicana_dw.fact_registro_costos`
PARTITION BY Fecha
CLUSTER BY Productor_ID, Lote_ID
AS
-- LOTE-004 (9.0 Ha - El Mosquitero / PROD-4843)
SELECT 'REC-001' AS ID_Registro, DATE '2025-10-15' AS Fecha, 'PROD-4843' AS Productor_ID, 'LOTE-004' AS Lote_ID, 'Soca' AS Tipo_Ciclo, 'Fase 1: Preparación / Arranque' AS Fase_Operativa, 'Cultivo mecanizado y fertilizacion fondo' AS Actividad_Insumo, 9.0 AS Cantidad, 'Ha' AS Unidad, 68000.00 AS Costo_Total_MXN, 'Transferencia' AS Forma_Pago, 'Santander' AS Cuenta_Origen, 'CON_FACTURA_SAT' AS Estatus_CFDI_Deducible, 'Deduce_ISR_y_Acredita_IVA' AS Impacto_Fiscal_Acreditamiento
UNION ALL
SELECT 'REC-002', DATE '2025-12-10', 'PROD-4843', 'LOTE-004', 'Soca', 'Fase 2: Siembra / Desarrollo', 'Segunda fertilizacion Urea + herbicida', 9.0, 'Ha', 48500.00, 'Transferencia', 'Santander', 'CON_FACTURA_SAT', 'Deduce_ISR_y_Acredita_IVA'
UNION ALL
SELECT 'REC-003', DATE '2026-03-05', 'PROD-4843', 'LOTE-004', 'Soca', 'Fase 3: Macollamiento / Nutrición Foliar', 'Aplicacion foliar con dron', 9.0, 'Ha', 22500.00, 'Transferencia', 'Santander', 'CON_FACTURA_SAT', 'Acredita_IVA_Solamente'
UNION ALL
SELECT 'REC-004', DATE '2026-06-20', 'PROD-4843', 'LOTE-004', 'Soca', 'Fase 5: Mantenimiento y Bordes', 'Chapeo de guardarrayas y bordos', 9.0, 'Ha', 5400.00, 'Efectivo', 'Caja Chica / Efectivo', 'MANO_OBRA_SIN_CFDI', 'Solo_Gasto_Interno'

-- LOTE-005 (14.0 Ha - El Mosquitero / PROD-4846)
UNION ALL
SELECT 'REC-005', DATE '2025-10-18', 'PROD-4846', 'LOTE-005', 'Soca', 'Fase 1: Preparación / Arranque', 'Cultivo y fertilizacion fondo', 14.0, 'Ha', 112000.00, 'Transferencia', 'Santander', 'CON_FACTURA_SAT', 'Deduce_ISR_y_Acredita_IVA'
UNION ALL
SELECT 'REC-006', DATE '2025-12-15', 'PROD-4846', 'LOTE-005', 'Soca', 'Fase 2: Siembra / Desarrollo', 'Segunda fertilizacion + control malezas', 14.0, 'Ha', 79800.00, 'Transferencia', 'Santander', 'CON_FACTURA_SAT', 'Deduce_ISR_y_Acredita_IVA'
UNION ALL
SELECT 'REC-007', DATE '2026-03-12', 'PROD-4846', 'LOTE-005', 'Soca', 'Fase 3: Macollamiento / Nutrición Foliar', 'Nutricion foliar con dron', 14.0, 'Ha', 36400.00, 'Transferencia', 'Santander', 'CON_FACTURA_SAT', 'Acredita_IVA_Solamente'
UNION ALL
SELECT 'REC-008', DATE '2026-06-22', 'PROD-4846', 'LOTE-005', 'Soca', 'Fase 5: Mantenimiento y Bordes', 'Limpia perimetral y guardarrayas', 14.0, 'Ha', 8400.00, 'Efectivo', 'Caja Chica / Efectivo', 'MANO_OBRA_SIN_CFDI', 'Solo_Gasto_Interno'

-- LOTE-006 (1.0 Ha - El Mosquitero / PROD-4194)
UNION ALL
SELECT 'REC-009', DATE '2025-10-20', 'PROD-4194', 'LOTE-006', 'Soca', 'Fase 1: Preparación / Arranque', 'Cultivo de cepa y abono inicial', 1.0, 'Ha', 7900.00, 'Efectivo', 'Caja Chica / Efectivo', 'NOTA_SIMPLE_REMISION', 'Solo_Gasto_Interno'
UNION ALL
SELECT 'REC-010', DATE '2025-12-18', 'PROD-4194', 'LOTE-006', 'Soca', 'Fase 2: Siembra / Desarrollo', 'Abono Urea y deshierbe manual', 1.0, 'Ha', 5600.00, 'Efectivo', 'Caja Chica / Efectivo', 'NOTA_SIMPLE_REMISION', 'Solo_Gasto_Interno'
UNION ALL
SELECT 'REC-011', DATE '2026-03-15', 'PROD-4194', 'LOTE-006', 'Soca', 'Fase 3: Macollamiento / Nutrición Foliar', 'Foliar de bomba de mochila', 1.0, 'Ha', 2500.00, 'Efectivo', 'Caja Chica / Efectivo', 'NOTA_SIMPLE_REMISION', 'Solo_Gasto_Interno'

-- LOTE-007 (4.0 Ha - El Mosquitero / PROD-4196)
UNION ALL
SELECT 'REC-012', DATE '2025-10-22', 'PROD-4196', 'LOTE-007', 'Soca', 'Fase 1: Preparación / Arranque', 'Cultivo mecanico y fertilizacion', 4.0, 'Ha', 32000.00, 'Transferencia', 'Klar', 'CON_FACTURA_SAT', 'Deduce_ISR_y_Acredita_IVA'
UNION ALL
SELECT 'REC-013', DATE '2025-12-20', 'PROD-4196', 'LOTE-007', 'Soca', 'Fase 2: Siembra / Desarrollo', 'Segunda fertilizacion y sello', 4.0, 'Ha', 23000.00, 'Transferencia', 'Klar', 'CON_FACTURA_SAT', 'Deduce_ISR_y_Acredita_IVA'
UNION ALL
SELECT 'REC-014', DATE '2026-03-18', 'PROD-4196', 'LOTE-007', 'Soca', 'Fase 3: Macollamiento / Nutrición Foliar', 'Aplicacion foliar', 4.0, 'Ha', 10400.00, 'Transferencia', 'Klar', 'CON_FACTURA_SAT', 'Acredita_IVA_Solamente'
UNION ALL
SELECT 'REC-015', DATE '2026-06-25', 'PROD-4196', 'LOTE-007', 'Soca', 'Fase 5: Mantenimiento y Bordes', 'Limpieza manual de bordos', 4.0, 'Ha', 2600.00, 'Efectivo', 'Caja Chica / Efectivo', 'MANO_OBRA_SIN_CFDI', 'Solo_Gasto_Interno'

-- LOTE-008 (12.0 Ha - El Mosquitero / PROD-4195)
UNION ALL
SELECT 'REC-016', DATE '2025-10-25', 'PROD-4195', 'LOTE-008', 'Soca', 'Fase 1: Preparación / Arranque', 'Cultivo mecanizado y fertilizacion fondo', 12.0, 'Ha', 92000.00, 'Transferencia', 'Santander', 'CON_FACTURA_SAT', 'Deduce_ISR_y_Acredita_IVA'
UNION ALL
SELECT 'REC-017', DATE '2025-12-22', 'PROD-4195', 'LOTE-008', 'Soca', 'Fase 2: Siembra / Desarrollo', 'Segunda dosis nitrogenada y deshierbe', 12.0, 'Ha', 66000.00, 'Transferencia', 'Santander', 'CON_FACTURA_SAT', 'Deduce_ISR_y_Acredita_IVA'
UNION ALL
SELECT 'REC-018', DATE '2026-03-20', 'PROD-4195', 'LOTE-008', 'Soca', 'Fase 3: Macollamiento / Nutrición Foliar', 'Nutricion foliar con dron', 12.0, 'Ha', 31200.00, 'Transferencia', 'Santander', 'CON_FACTURA_SAT', 'Acredita_IVA_Solamente'
UNION ALL
SELECT 'REC-019', DATE '2026-06-28', 'PROD-4195', 'LOTE-008', 'Soca', 'Fase 5: Mantenimiento y Bordes', 'Guardarrayas y callejones', 12.0, 'Ha', 7200.00, 'Efectivo', 'Caja Chica / Efectivo', 'MANO_OBRA_SIN_CFDI', 'Solo_Gasto_Interno'

-- LOTE-009 (10.0 Ha - Mandinga y Cardonal / PROD-5774 / Ingenio La Gloria)
UNION ALL
SELECT 'REC-020', DATE '2025-10-28', 'PROD-5774', 'LOTE-009', 'Soca', 'Fase 1: Preparación / Arranque', 'Cultivo y desinfeccion de cepa', 10.0, 'Ha', 75000.00, 'Transferencia', 'Mercado Pago', 'CON_FACTURA_SAT', 'Deduce_ISR_y_Acredita_IVA'
UNION ALL
SELECT 'REC-021', DATE '2025-12-28', 'PROD-5774', 'LOTE-009', 'Soca', 'Fase 2: Siembra / Desarrollo', 'Nutricion nitrogenada y control malezas', 10.0, 'Ha', 54000.00, 'Transferencia', 'Mercado Pago', 'CON_FACTURA_SAT', 'Deduce_ISR_y_Acredita_IVA'
UNION ALL
SELECT 'REC-022', DATE '2026-03-25', 'PROD-5774', 'LOTE-009', 'Soca', 'Fase 3: Macollamiento / Nutrición Foliar', 'Aplicacion dron foliar', 10.0, 'Ha', 26000.00, 'Transferencia', 'Mercado Pago', 'CON_FACTURA_SAT', 'Acredita_IVA_Solamente'
UNION ALL
SELECT 'REC-023', DATE '2026-07-02', 'PROD-5774', 'LOTE-009', 'Soca', 'Fase 5: Mantenimiento y Bordes', 'Mantenimiento de rondas contra fuego', 10.0, 'Ha', 6000.00, 'Efectivo', 'Caja Chica / Efectivo', 'MANO_OBRA_SIN_CFDI', 'Solo_Gasto_Interno';
