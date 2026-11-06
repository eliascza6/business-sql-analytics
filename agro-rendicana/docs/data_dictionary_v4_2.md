# DICCIONARIO DE DATOS Y ESQUEMA RELACIONAL: RENDICAÑA v4.2

**Motor Lógico:** `Gestion_Inteligente_Cana_v4.2`  
**Arquitectura:** Google Sheets (Captura) ➔ Google BigQuery Sandbox (Analítica) ➔ Looker Studio (Visualización)  
**Autor:** Elías Cruz Álvarez (Analytics Translator & Senior SaaS Architect)  
**Versión:** 4.2 Calibrada y Multi-Régimen Fiscal (2026)  
**Infraestructura:** Google Cloud Platform Sandbox ($0.00 USD)

---

## 1. MODELADO DIMENSIONAL (FRAMEWORK E.V.A.)

### TABLAS DE DIMENSIONES (Catálogos y Contexto)

#### 1. `03_REGISTRO_PARCELAS` (Dimensión Predio - Multi-tenant y Fiscal)
*Rango Federado en BigQuery Sandbox:* `03_REGISTRO_PARCELAS!A:J` (10 Columnas)  
*Propósito:* Almacenar las características físicas, edafológicas, contractuales y el estatus legal de cada predio cañero.

- `Lote_ID` (STRING, PK): Identificador único del predio o tabla cañera (Col A, ej. `LOTE-001`).
- `Nombre_Predio` (STRING): Nombre común o toponímico de la parcela (Col B, ej. *Rancho El Nanchal - Tabla 1*).
- `Superficie_Ha` (NUMERIC): Extensión territorial cultivable expresada en hectáreas (Col C).
- `Variedad` (STRING): Variedad agronómica de caña establecida (Col D, ej. `CP 72-2086`, `MEX 69-290`, `ITV 92-1424`).
- `Tipo_Suelo` (STRING): Clasificación edafológica (Col E, ej. *Franco Arcilloso*, *Arcilloso Pesado*, *Vegas de Río*).
- `Contrato_Ingenio` (STRING): Factoría receptora de la caña (Col F, ej. *Ingenio El Modelo*, *Ingenio El Potrero*, *Ingenio San Cristóbal*).
- `Ubicacion_Municipio` (STRING): Demarcación municipal del predio (Col G, ej. *Alvarado*, *Córdoba*, *Atoyac*).
- `Estatus_Escrituracion` (ENUM): Regularización legal de la tierra (Col H: `'Propiedad Privada'` | `'En Trámite'` | `'Certificado Parcelario'`).
- `Folio_Notarial_Tramite` (STRING): Número de escritura pública, folio notarial o título agrario (Col I, ej. `EXP-2026-882`).
- `Apoyo_Gubernamental_MXN` (NUMERIC): Subsidio recibido por ciclo productivo (Col J, ej. *Producción para el Bienestar*).

---

#### 2. `02_COSTOS_ESTANDAR` (Dimensión Referencial de Precios - Calibrada)
*Propósito:* Proveer la línea base de costos unitarios y dosificaciones recomendadas según los planes agronómicos optimizados.

- `ID_Insumo` (STRING, PK): Código alfanumérico del insumo o labor (rango `INS-010` al `INS-037`).
- `Categoria` (ENUM): `'Labores'` | `'Semilla'` | `'Bioestimulante'` | `'Herbicida'` | `'Servicio Dron'` | `'Fertilizante'` | `'Maquinaria'` | `'Fitosanitario'` | `'Coadyuvante'` | `'Enmienda'`.
- `Concepto_Insumo` (STRING): Denominación comercial o técnica de la labor, producto o servicio.
- `Unidad_Medida` (STRING): Unidad operativa de cuantificación (`Jornal`, `Tonelada`, `Paquete Ha`, `Vuelo / Ha`, `Bulto 50kg`, `Paso / Ha`, `Litro`).
- `Costo_Unitario_MXN` (NUMERIC): Precio unitario de referencia regional en la cuenca de Veracruz.
- `Detalle_Aplicacion` (STRING): Dosificación agronómica y ventana de intervención vegetativa.
- `Zona_Referencia` (STRING): Región de muestreo de precios (*Alvarado / Veracruz Central*).

**Líneas Base del Catálogo Maestro:**
* **Línea Base Soca / Resoca:** $16,810.00 MXN / Ha
  * *Fase 1 (Arranque, Sello y Enraizamiento):* $7,895.00 MXN / Ha (`INS-010` a `INS-015`)
  * *Fase 2 (Desarrollo, Macollamiento y Cultivo):* $5,555.00 MXN / Ha (`INS-016` a `INS-019`)
  * *Fase 3 (Cierre de Cañal, Foliar y Elongación):* $2,705.00 MXN / Ha (`INS-020` a `INS-022`)
  * *Fase 4 (Preparación de Cosecha y Bordes):* $655.00 MXN / Ha (`INS-023` a `INS-024`)
* **Línea Base Plantilla (Nueva Siembra):** $34,690.00 MXN / Ha
  * *Fase 1 (Preparación Mecanizada del Suelo):* $8,300.00 MXN / Ha (`INS-030` a `INS-034`)
  * *Fase 2 (Siembra, Desinfección y Sello):* $16,445.00 MXN / Ha (`INS-035` a `INS-036`, `INS-013` a `INS-015`)
  * *Fase 3 (Desarrollo y Segunda Nutrición):* $6,585.00 MXN / Ha (`INS-037`, `INS-017`, `INS-014`, `INS-018`, `INS-019`)
  * *Fase 4 (Cierre de Cañal y Foliar):* $2,705.00 MXN / Ha (`INS-020` a `INS-022`)
  * *Fase 5 (Preparación Cosecha y Bordes):* $655.00 MXN / Ha (`INS-023` a `INS-024`)

---

#### 3. `12_CONFIG_TIERS` (Dimensión de Monetización SaaS)
*Propósito:* Configuración de derechos de acceso, límites de consumo de IA y tarifas por ciclo de zafra.

- `Tier_ID` (STRING, PK): Identificador del escalafón comercial (`TIER-1`, `TIER-2A`, `TIER-2B`, `TIER-2C`, `TIER-3`).
- `Nombre_Plan` (STRING): `'Freemium'` | `'Pro Básico'` | `'Pro Mediano'` | `'Pro Multipredio'` | `'Enterprise'`.
- `Rango_Hectareas` (STRING): Segmento de escala atendido (`1 - 5 Ha`, `6 - 15 Ha`, `16 - 50 Ha`, `50+ Ha`).
- `Precio_Zafra_MXN` (NUMERIC): Inversión por ciclo agrícola ($0.00, $399.00, $699.00, $1,499.00 MXN / Zafra; $2,500.00+ MXN / Mes).
- `Limite_Consultas_IA` (INTEGER): Cuota mensual asignada para transacciones y consultas agénticas.
- `Modulos_Incluidos` (STRING): Catálogo de módulos funcionales y reportes ejecutivos autorizados.

---

### TABLAS DE HECHOS (Transacciones Operativas, Financieras y de Molienda)

#### 4. `04_REGISTRO_COSTOS` (Hechos de Gastos y Operaciones de Campo)
*Rango Federado en BigQuery Sandbox:* `04_REGISTRO_COSTOS!A:L` (12 Columnas)  
*Propósito:* Bitácora transaccional de cada erogación realizada en campo con trazabilidad fiscal RESICO.

- `ID_Registro` (STRING, PK): Folio único de transacción (Col A, ej. `REC-001`, `REC-030`).
- `Fecha` (DATE): Fecha de ejecución del gasto o adquisición (Col B, formato `YYYY-MM-DD`).
- `Lote_ID` (STRING, FK -> `03_REGISTRO_PARCELAS.Lote_ID`): Predio específico al que se imputa el costo (Col C).
- `Tipo_Ciclo` (ENUM): `'Plantilla'` | `'Soca'` | `'Resoca'` (Col D).
- `Fase_Operativa` (STRING): Fase del cultivo vinculada al costo (Col E).
- `Actividad_Insumo` (STRING): Descripción específica de la labor o agroquímico adquirido (Col F).
- `Cantidad` (NUMERIC): Volumen, superficie o número de unidades aplicadas (Col G).
- `Unidad` (STRING): Magnitud física (`Ha`, `Bulto`, `Litro`, `Jornal`, `Paso`, `Vuelo`) (Col H).
- `Costo_Total_MXN` (NUMERIC): Importe monetario total erogado en la operación (Col I).
- `Forma_Pago` (ENUM): `'Efectivo'` | `'Tarjeta Débito'` | `'Transferencia'` | `'Crédito de Avío'` (Col J).
- `Cuenta_Origen` (ENUM): `'Santander'` | `'Mercado Pago'` | `'Klar'` | `'Caja Chica / Efectivo'` (Col K).
- `Estatus_Deducibilidad_RESICO` (ENUM): Respaldo comprobatorio y estatus tributario (Col L: `'SÍ'` | `'NO'`).

---

#### 5. `05_KARBE_CALIDAD` (Hechos de Molienda y Auditoría de Báscula)
*Propósito:* Registrar las remisiones de báscula emitidas por el ingenio y auditar las penalizaciones de calidad y mermas.

- `Remision_ID` (STRING, PK): Folio de boleta o ticket de báscula en batey (ej. `T-45910`).
- `Productor_ID` (STRING): Identificador del titular ante el ingenio.
- `Lote_ID` (STRING, FK -> `03_REGISTRO_PARCELAS.Lote_ID`): Predio de origen del corte.
- `Fecha_Corte` (DATE): Fecha de derribo y pesaje de la caña.
- `Toneladas_Brutas` (NUMERIC): Peso total del transporte descontando tara del camión.
- `Porcentaje_Castigo_Materia_Extrana` (NUMERIC): Deducción aplicada en laboratorio por impurezas (hojas, tierra, paja).
- `Toneladas_Netas` (NUMERIC): Toneladas liquidadas por el ingenio tras descontar castigos:
  $$\text{Toneladas Netas} = \text{Toneladas Brutas} \times \left(1 - \frac{\text{Porcentaje Castigo}}{100}\right)$$
- `Pol_Cana` (NUMERIC): Concentración aparente de sacarosa en el jugo.
- `Pureza_Jugo` (NUMERIC): Proporción de sacarosa en los sólidos disueltos totales.
- `KARBE_Obtenido` (NUMERIC): Kilogramos de Azúcar Recuperable Base Estándar certificados por tonelada de caña.
- `Precio_Base_Ton_MXN` (NUMERIC): Cotización de la caña fijada para el ciclo según precio de referencia nacional.
- `Precio_Ajustado_Ton_MXN` (NUMERIC): Precio neto resultante tras ajustes de calidad y deducciones de molienda.
- `Valor_Bruto_Liquidacion_MXN` (NUMERIC): Importe devengado por el viaje:
  $$\text{Valor Bruto} = \text{Toneladas Netas} \times \text{Precio Ajustado Ton MXN}$$

---

### TABLAS DE AGREGACIÓN Y MOTORES FINANCIEROS

#### 6. `06_DATOS_MAESTROS` (Consolidado por Lote y Control Presupuestal)
*Propósito:* Vista agregada a nivel predio para la simulación de margen neto y auditoría financiera en tiempo real.

- `Lote_ID` (STRING, PK): Identificador único del predio (Col A).
- `Superficie_Ha` (NUMERIC): Superficie arable vinculada desde `03_REGISTRO_PARCELAS` (Col B).
- `Ciclo` (ENUM): `'Plantilla'` | `'Soca'` | `'Resoca'` (Col C).
- `Rendimiento_Est_Ton_Ha` (NUMERIC): Meta agronómica regional estimada en Ton/Ha (Col D).
- `Ton_Totales_Est` (NUMERIC): Volumen total esperado de cosecha (Col E):
  $$E2 = B2 \times D2$$
- `Costo_Total_Invertido_MXN` (NUMERIC): Suma agregada dinámica desde `04_REGISTRO_COSTOS` (Col F):
  $$F2 = \text{SUMAR.SI.CONJUNTO}('04\_REGISTRO\_COSTOS'!I:I, '04\_REGISTRO\_COSTOS'!C:C, A2)$$
- `Costo_Por_Ton_MXN` (NUMERIC): Costo real devengado por tonelada estimada (Col G):
  $$G2 = \frac{F2}{E2}$$
- `Ingreso_Bruto_Est_MXN` (NUMERIC): Facturación bruta esperada según precio liquidado y volumen proyectado (Col H).
- `Margen_Neto_Est_MXN` (NUMERIC): Utilidad neta real proyectada de campo (Col I):
  $$I2 = H2 - F2$$
- `Presupuesto_Meta_Ha_MXN` (NUMERIC): Límite agronómico técnico autorizado (Col J):
  $$J2 = \text{SI}(C2 = \text{"Plantilla"}, 34690, 16810)$$
- `Presupuesto_Total_Lote_MXN` (NUMERIC): Techo de inversión autorizado para la parcela completa (Col K):
  $$K2 = B2 \times J2$$
- `Porcentaje_Consumo_Presupuesto` (NUMERIC): Ratio de absorción presupuestal devengada (Col L):
  $$L2 = \frac{F2}{K2}$$
- `Semaforo_Financiero` (STRING): Indicador directivo visual de gobernanza financiera (Col M):
  * `'🔴 SOBRECOSTO'`: Cuando $L2 > 1.00$ (Inversión supera el techo agronómico).
  * `'🟡 ALERTA'`: Cuando $0.85 \le L2 \le 1.00$ (Consumo superior al $85\%$; riesgo de sobrecosto).
  * `'🟢 CONTROLADO'`: Cuando $L2 < 0.85$ (Inversión en rango seguro).

---

#### 7. `08_MODULO_LEASING` (Evaluación de Maquinaria y Activos de Transporte)
*Propósito:* Calcular el costo horario operativo y el escudo fiscal por arrendamiento de vehículos o maquinaria agrícola.

- `ID_Activo` (STRING, PK): Código del activo (Col A, ej. `ACT-001`).
- `Descripcion_Activo` (STRING): Detalle del equipo (Col B, ej. *Camioneta Pick-Up Doble Cabina 4x4*).
- `Costo_Mensual_Arrendamiento_MXN` (NUMERIC): Pago de renta mensual antes de impuestos (Col D).
- `Horas_Uso_Promedio_Mes` (NUMERIC): Horas efectivas reportadas en campo al mes (Col E).
- `Costo_Por_Hora_Operativa_MXN` (NUMERIC): Costo unitario por hora de trabajo (Col F):
  $$F2 = \frac{D2}{E2}$$
- `Recuperacion_IVA_Mensual_MXN` (NUMERIC): Acreditamiento directo del $16\%$ de IVA mensual por factura de arrendamiento (Col G):
  $$G2 = D2 \times 0.16$$
- `Escudo_ISR_Mensual_MXN` (NUMERIC): Deducción autorizada de renta (según régimen fiscal aplicable).

---

#### 8. `09_MODULO_FISCAL` (Matriz de Cumplimiento Tributario y Liquidación)
*Propósito:* Desacoplar la retención del ingenio de la ganancia operativa neta bajo el marco fiscal RESICO / AGAPE.

- `Productor_ID` (STRING, PK/FK): Identificador del titular fiscal ante el SAT.
- `Regimen_Fiscal_Activo` (STRING): Régimen tributario asignado en `03_REGISTRO_PARCELAS`.
- `Ingresos_Brutos_Acumulados_MXN` (NUMERIC): Suma acumulada de liquidaciones cobradas en el ejercicio fiscal.
- `Monto_Exento_ISR_MXN` (NUMERIC):
  * RESICO PF: Hasta $900,000.00 MXN anuales exentos del sector primario.
  * PFAE General: $0.00 MXN (Tributación sobre utilidad neta total).
  * Persona Moral AGAPE: 20 UMA anuales por socio (tope 200 UMA por sociedad).
- `Base_Gravable_ISR_MXN` (NUMERIC): Importe sujeto a determinación de impuesto.
- `Retencion_Ingenio_ISR_MXN` (NUMERIC): Monto retenido por el ingenio en la boleta de liquidación final ($1.25\%$ en RESICO Gravado).
- `Bolsa_IVA_Acreditable_MXN` (NUMERIC): Monto total de IVA trasladado en facturas de insumos (`04_REGISTRO_COSTOS`), disponible para compensar contra IVA a cargo o solicitar devolución.

---

## 2. RELACIONES E INTEGRIDAD REFERENCIAL (SCHEMA MAP)

```text
[ 03_REGISTRO_PARCELAS ] (1) 
   │
   ├── (1:N) ──> [ 04_REGISTRO_COSTOS ]  (FK: Lote_ID)
   ├── (1:N) ──> [ 05_KARBE_CALIDAD ]    (FK: Lote_ID)
   ├── (1:1) ──> [ 06_DATOS_MAESTROS ]   (FK: Lote_ID)
   └── (1:1) ──> [ 09_MODULO_FISCAL ]    (FK: Productor_ID)

[ 02_COSTOS_ESTANDAR ] (1)
   │
   ├── (Referencia Paramétrica) ──> [ 04_REGISTRO_COSTOS ] (Por Concepto / Actividad)
   └── (Regla Paramétrica $16,810 / $34,690) ──> [ 06_DATOS_MAESTROS ]

[ 12_CONFIG_TIERS ] (1)
   │
   └── (Límites de Consumo y Tiers) ──> [ Motor Agéntico Gemini API / Apps Script ]
