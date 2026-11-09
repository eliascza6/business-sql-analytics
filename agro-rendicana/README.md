# 🌾 RendiCaña: Agroindustrial Financial Intelligence & Zafra Audit
**Project Status:** `COMPLETED & ARCHIVED (Proof of Concept / Technical Case Study)`  
**Architect & Analytics Translator:** Elías Cruz Álvarez  
**Core Stack:** Google Cloud Platform (BigQuery Sandbox), Looker Studio, Connected Sheets, Python  
**Cost to Operate:** $0.00 USD (FinOps Cloud-Native Design)

---

## 📌 Executive Summary
RendiCaña is an agroindustrial analytics engine designed to audit financial margins, harvest logistics, and scale deductions (*mermas de báscula*) for sugarcane production across the Veracruz agro-basin (Cordoba, Alvarado, and Papaloapan regions). 

This repository consolidates the dimensional data model, SQL analytical views, and executive dashboard architecture built to reconcile field expenditures against mill (*ingenio*) liquidation statements.

---

## 🏗️ Architecture & Framework E.V.A.
The solution follows the **E.V.A. Operational Framework** (Structure, Value, Automation) under a strict **$0 USD FinOps** constraint:

1. **E (Structure & Hygiene):** 
   - Normalized dimensional model separating dimensions (`03_REGISTRO_PARCELAS`, `02_COSTOS_ESTANDAR`) from transactional facts (`04_REGISTRO_COSTOS`, `05_KARBE_CALIDAD`).
   - Integrated fiscal classification engine for Mexican agricultural regimes (RESICO PF Exento/Gravado, PFAE, and AGAPE).
2. **V (Value & Translation):**
   - Direct translation of agronomic metrics into monetary P&L impact: Cost per Ton, Net Margin per Hectare, and Budget Burn Ratios.
   - High Data-Ink Ratio executive dashboard designed for decision-makers and non-technical stakeholders.
3. **A (Automation & Hybrid Pipeline):**
   - **Data Warehouse:** Google BigQuery Sandbox executing CTEs and aggregation views.
   - **Resilience Layer:** Connected Google Sheets for rapid operational entry without federated IAM friction.
   - **Executive BI:** Looker Studio Gold Master single-page audit interface.

---

## 📊 Key Deliverables & Artifacts
- **Data Dictionary:** Normalized relacional schema covering 9 parcels (65.5 Ha) and agronomic cost baselines ($16,810/Ha for socas; $34,690/Ha for plantillas).
- **Analytical Views:** Precompiled GoogleSQL logic determining financial semaphores (`CONTROLADO` vs. `SOBRECOSTO`).
- **Executive Audit Board:** 1-Page automated dashboard showing Real Incurred Cost vs. Mill Bank Reach liquidation.

---

## 🔍 Market Validation & Strategic Post-Mortem
Following prototype validation in Google AI Studio and field workflow testing with regional producers:
* **The Agronomic & Financial Math:** Validated 100% accurate. The model successfully detects over-budget lots and uncredited VAT deductions.
* **Adoption Friction:** Traditional sugarcane producers exhibit severe behavioral friction for daily manual logging. Manual concierge distribution models yield unsustainable operational overhead.
* **Strategic Verdict:** The operational engine and visual dashboard are deemed **Complete and Validated as an Architectural Case Study**. Further active feature development is frozen; future expansions would strictly require automated document intake (OCR via Vision APIs) rather than daily operational capture.

---
*Maintained as part of the BizOps & AI Operations strategic portfolio.*
