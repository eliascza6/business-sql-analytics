# RendiCaña v4.2: Arquitectura Cloud-Native de Inteligencia Financiera y Auditoría de Zafra ($0 USD)

> **Autor:** Elías Cruz Álvarez  
> **Rol:** Analytics Translator & Senior SaaS Architect  
> **Enfoque:** Optimización Agroindustrial, Modelado Dimensional y Gobernanza de Datos  
> **Stack:** Google Cloud Platform (BigQuery Sandbox) | Looker Studio | Git / GitHub  

---

## 1. El Problema de Negocio (Wicked Environment)
En la cuenca cañera de Veracruz (abastecedora de ingenios como *El Modelo* y *La Gloria*), los productores enfrentan una **ceguera financiera estructural**:
* **Desconocimiento del Margen Real:** El productor recibe la liquidación final del ingenio y asume que el alcance depositado es su "ganancia", sin conciliar los egresos de efectivo realizados durante los 12 meses de cultivo (fertilización, combustible, maquila y jornales).
* **Opacidad en Deducciones de Báscula:** Los descuentos por corte mecanizado, fletes de acarreo, cuotas IMSS y castigos por materia extraña absorben entre el 50% y el 65% del valor bruto devengado, sin auditoría predio por predio.

---

## 2. Arquitectura de Datos (Framework E.V.A.)

Operando bajo la **regla estricta de $0 USD de costo de infraestructura**, el sistema se diseñó desacoplando el almacenamiento de la capa lógica y de visualización:
[ Captura Normalizada ]  -->  [ BigQuery Sandbox (Data Warehouse) ]  -->  [ Looker Studio ]
(Hojas de Trabajo v4.2)    
• dim_parcelas (Catastro/Fiscal)            • KPIs Ejecutivos
• fact_karbe_molienda (Báscula)             • Tabla Maestra
• fact_registro_costos (Campo)              • Semáforo de Riesgo
│ (Vía CTEs)
▼
vw_datos_maestros (Capa Lógica)

### Modelo Dimensional Estrella
1. **`dim_parcelas`:** Dimensión conformada que registra superficie, variedad, factoría y régimen fiscal del productor (RESICO, PFAE, AGAPE).
2. **`fact_karbe_molienda`:** Hechos transaccionales de báscula en batey (toneladas netas, castigos de materia extraña, KARBE certificado y liquidación bruta).
3. **`fact_registro_costos`:** Hechos operacionales de campo particionados por `Fecha` y agrupados por `(Productor_ID, Lote_ID)`, controlando trazabilidad de CFDI.
4. **`vw_datos_maestros`:** Vista federada compilada con CTEs que pre-agrega costos para erradicar multiplicaciones cartesianas (*fan-out effect*) y evalúa las reglas de negocio en tiempo real.

---

## 3. Hallazgos Financieros y Retorno de Inversión (ROI)

Auditando un ciclo real de **50.0 Hectáreas** y **2,361.76 Toneladas Netas** distribuidas en 6 predios clave:

| Indicador Financiero Clave | Valor Auditado (MXN) | Interpretación de Negocio |
| :--- | :---: | :--- |
| **Valor Bruto Devengado en Zafra** | **$2,350,922.23** | Monto liquidado por la caña entregada en báscula. |
| **Deducciones Totales de Zafra** | **$1,408,745.93** | Retenciones por corte, alce, flete, IMSS y amortizaciones. |
| **Tasa de Absorción Logística Promedio** | **59.92%** | El transporte y cosecha absorben más de la mitad del ingreso bruto. |
| **Alcance Neto Depositado por Ingenio** | **$599,072.25** | Efectivo aparente recibido por los productores. |
| **Inversión Agronómica Real de Campo** | **$822,400.00** | Egresos reales de cultivo ($16,000–$17,000 MXN/Ha). |
| **Margen Neto de Bolsillo Real** | **-$223,327.75** | **Déficit operativo consolidado oculto para el productor.** |

### Diagnóstico de Semáforo Logístico:
* **`🔴 SOBRECOSTO_LOGISTICO` (>55% de absorción):** Predios donde el flete y corte castigaron desproporcionadamente la rentabilidad.
* **`🟢 CONTROLADO` (<50% de absorción):** Predios optimizados en logística donde el margen neto se mantuvo positivo (ej. `LOTE-006` con +$5,017.43 MXN netos).

---

## 4. Estructura de este Módulo en el Repositorio

* **`sql/`**: Scripts DDL de tablas particionadas, ingesta atómica y vista maestra `vw_datos_maestros`.
* **`docs/`**: Diccionario de datos oficial v4.2 con reglas de negocio y calibración de costos estándar de soca ($16,810/Ha) y plantilla ($34,690/Ha).
* **`img/`**: Capturas del reporte ejecutivo interactivo desplegado en Looker Studio.
