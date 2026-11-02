# RendiCaña v4.2: Arquitectura Cloud-Native de Inteligencia Financiera y Auditoría de Zafra ($0 USD)

> **Titular:** Elías Cruz Álvarez  
> **Rol:** Analytics Translator & Senior SaaS Architect  
> **Especialidad:** Optimización Agroindustrial, Modelado Dimensional y Gobernanza de Datos  
> **Stack:** Google Cloud Platform (BigQuery Sandbox) | Looker Studio | Git / GitHub  

---

## 1. El Problema de Negocio (Wicked Environment)
En la cuenca cañera de Veracruz (zona de abastecimiento de factorías como *Ingenio El Modelo* e *Ingenio La Gloria*), los productores tradicionales enfrentan una **ceguera financiera estructural**:
* **Desconocimiento del Margen Real de Bolsillo:** El productor recibe la liquidación final del ingenio y asume que el alcance depositado representa su utilidad, sin auditar ni conciliar los egresos de efectivo acumulados durante los 12 meses de cultivo (fertilización, combustible, labores mecánicas y jornales).
* **Opacidad en Deducciones de Báscula:** Los descuentos por corte mecanizado, flete de acarreo, cuotas IMSS y castigos por materia extraña absorben más del 50% del valor bruto liquidable, sin un control granular por predio.

---

## 2. Arquitectura de Datos (Framework E.V.A.)

Operando bajo la **regla estricta de $0 USD de costo de infraestructura**, el sistema se diseñó desacoplando el almacenamiento de la capa lógica y de visualización:

```text
┌──────────────────────────────────────┐
│  Captura Normalizada de Zafra (v4.2) │
└──────────────────┬───────────────────┘
                   │
                   ▼
┌────────────────────────────────────────────────────────────────────────┐
│             Google BigQuery Sandbox (Almacén Dimensional)             │
│  • dim_parcelas: Catastro, tenencia y régimen fiscal SAT (Multi-tenant)│
│  • fact_karbe_molienda: Liquidaciones de báscula, KARBE y retenciones   │
│  • fact_registro_costos: Transacciones de campo (Partición diaria)     │
└──────────────────┬─────────────────────────────────────────────────────┘
                   │
                   ▼ (Vía CTEs deterministas sin mutación física)
┌────────────────────────────────────────────────────────────────────────┐
│              vw_datos_maestros (Capa Semántica y Lógica)               │
│  • Pre-agregación de costos (eliminación de producto cartesiano / fan) │
│  • Cálculo de Margen Neto de Bolsillo y Semáforo de Riesgo Logístico   │
└──────────────────┬─────────────────────────────────────────────────────┘
                   │
                   ▼ (DirectQuery a $0 USD de cómputo)
┌────────────────────────────────────────────────────────────────────────┐
│                   Looker Studio (Dashboard Ejecutivo)                  │
│  • KPIs de Superficie, Molienda y Costo Unitario de Acarreo            │
│  • Matriz de Rentabilidad Predial y Auditoría de Deducciones           │
└────────────────────────────────────────────────────────────────────────┘
