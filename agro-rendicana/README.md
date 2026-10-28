# 🌾 RendiCaña (El Agro-Valuador)
### Modelo Canónico de Costos, Control de Mermas y Rendimiento Operativo de Zafra

Sistema de inteligencia operativa y valuación de costos agrícolas para productores de caña de azúcar en la región de las Altas Montañas y Cuenca del Papaloapan (Córdoba, Cuitláhuac, Alvarado, Veracruz).

---

## 🎯 El Problema de Negocio (The Problem)
En el sector cañero tradicional, los costos de cultivo (socas y resocas), corte, alce y acarreo hacia el ingenio se administran de forma empírica y agrupada. Esto provoca:
1. **Falta de granularidad:** Mermas invisibles por hectárea y descontrol en la mano de obra.
2. **Incertidumbre en la liquidación:** Imposibilidad de proyectar el margen neto real frente a la fluctuación del KARBE (Kilos de Azúcar Recuperable Base Estándar).
3. **Decisiones a ciegas:** Pérdida de rentabilidad por compras desfasadas de fertilizantes y control tardío de plagas/malezas.

---

## 🏗️ Marco Metodológico: Framework E.V.A.
El proyecto se rige bajo la arquitectura de datos **E.V.A.**:

### 1. Estructura (E) — Higiene y Normalización de Datos
Desagregación atómica de costos en tres entidades operativas independientes:
* `INSUMO`: Químicos, biológicos, fertilizantes y semilla tasados a precio de mercado regional.
* `MANO_DE_OBRA`: Jornales de campo parametrizados globalmente (limpiezas, siembra, abono manual).
* `MAQUINARIA_MAQUILA`: Servicios mecanizados (pasos de tractor) y aspersión de precisión mediante dron agrícola UBV.

### 2. Valor (V) — Métricas Críticas (KPIs)
* **Costo Operativo por Hectárea (MXN/Ha)** desglosado por fases fenológicas (Arranque, Desarrollo, Cierre y Cosecha).
* **Margen Neto Estimado al Bolsillo** (Ingreso por liquidación estimada en ingenio menos costos acumulados).
* **Ratio Insumo vs. Maquila** para evaluar el ahorro por tecnificación aérea frente a aplicaciones terrestres.

### 3. Automatización (A) — Arquitectura Cloud-Native ($0 USD)
* **Captura:** Google Sheets con validaciones en origen para evitar datos corruptos.
* **Procesamiento y Almacén:** Google BigQuery Sandbox para consultas SQL analíticas de rendimientos históricos y proyecciones.
* **Capa Ejecutiva:** Dashboards en Looker Studio para visualización rápida del estado financiero de cada parcela.

---

## 📊 Ciclo Operativo Modelado (Base 20 Hectáreas)
El modelo cubre las 4 fases productivas de socas y resocas:

| Fase Operativa | Días / Ventana | Acciones Clave | Entidades Involucradas |
| :--- | :--- | :--- | :--- |
| **Fase 1: Arranque y Sello** | Días 0 – 20 post-corte | Encalle, resiembra, drench enraizador, sello preemergente dual y abono de fondo. | Mano de obra, Semilla, Químico, Dron |
| **Fase 2: Desarrollo y Cultivo** | Días 30 – 60 | Desazolve de drenajes, postemergencia modular, urea y aporque mecánico. | Mano de obra, Químico, Tractor, Dron |
| **Fase 3: Cierre y Cóctel Foliar** | Meses 2.5 – 4 | Control de bejuco, protocolo MIP condicional contra mosca pinta y bioestimulación. | Químico foliar, Dron UBV |
| **Fase 4: Preparación de Cosecha** | Meses 9 – 12 | Chapeo de cabeceras, guardarrayas transitables y logística de frentes de zafra. | Maquinaria |

---

## 🛠️ Stack Tecnológico
* **Data Ingestion & Prototyping:** Google Sheets (Connected Sheets)
* **Cloud Data Warehouse:** Google BigQuery (SQL Analytics: CTEs, Window Functions)
* **BI & Reporting:** Looker Studio
* **Version Control:** Git / GitHub Desktop

---

## 👤 Autor & Contacto
**Elías Cruz Álvarez**  
*Analytics Translator & Solopreneur Agro-Fintech*  
Córdoba, Veracruz, México  
[LinkedIn](https://www.linkedin.com/in/eliascza6) | `eliascza6@gmail.com`