DICCIONARIO DE DATOS Y ESQUEMA RELACIONAL: RENDICAÑA v4.2
Motor Lógico: Gestion_Inteligente_Cana_v4.2
Arquitectura: Google Sheets (Captura) -> Google BigQuery Sandbox (Analítica) -> Looker Studio (Visualización)
Autor: Elías Cruz Álvarez (Analytics Translator & Senior SaaS Architect)
Versión: 4.2 Calibrada y Multi-Régimen Fiscal (2026)
---
1. MODELADO DIMENSIONAL (FRAMEWORK E.V.A.)
TABLAS DE DIMENSIONES (Catálogos y Contexto)
#### 1. `03_REGISTRO_PARCELAS` (Dimensión Predio - Multi-tenant y Fiscal)
*Rango Federado en BigQuery Sandbox:* `03_REGISTRO_PARCELAS!A:J` (10 Columnas)

- `Lote_ID` (STRING, PK): Identificador único del predio (Col A).
- `Nombre_Predio` (STRING): Nombre común o toponímico de la parcela (Col B).
- `Superficie_Ha` (NUMERIC): Extensión territorial cultivable en hectáreas (Col C).
- `Variedad` (STRING): Variedad agronómica establecida, ej. MEX 69-290 (Col D).
- `Tipo_Suelo` (STRING): Textura edafológica, ej. Franco Arcilloso (Col E).
- `Contrato_Ingenio` (STRING): Factoría o ingenio receptor, ej. Ingenio El Modelo (Col F).
- `Ubicacion_Municipio` (STRING): Demarcación geográfica, ej. Alvarado (Col G).
- `Estatus_Escrituracion` (STRING): 'Propiedad Privada' | 'En Trámite' | 'Certificado Parcelario' (Col H).
- `Folio_Notarial_Tramite` (STRING): Número de expediente agrario o notarial (Col I).
- `Apoyo_Gubernamental_MXN` (NUMERIC): Subsidio recibido por ciclo productivo (Col J).
---
2. `02\_COSTOS\_ESTANDAR` (Dimensión Referencial de Precios - Calibrada)
Propósito: Proveer la línea base de costos unitarios y dosificaciones recomendadas según los planes agronómicos optimizados.
`ID\_Insumo` (STRING, PK): Código alfanumérico del insumo o servicio (rango `INS-010` al `INS-037`).
`Categoria` (ENUM): `'Labores'` | `'Semilla'` | `'Bioestimulante'` | `'Herbicida'` | `'Servicio Dron'` | `'Fertilizante'` | `'Maquinaria'` | `'Fitosanitario'` | `'Coadyuvante'` | `'Enmienda'`.
`Concepto\_Insumo` (STRING): Denominación comercial o técnica de la labor, producto o maquila.
`Unidad\_Medida` (STRING): Unidad operativa de cuantificación (`Jornal`, `Tonelada`, `Paquete Ha`, `Vuelo / Ha`, `Bulto 50kg`, `Paso / Ha`, `Litro`).
`Costo\_Unitario\_MXN` (NUMERIC): Precio unitario de referencia regional en la cuenca de Veracruz.
`Detalle\_Aplicacion` (STRING): Dosificación agronómica y ventana de intervención en el ciclo vegetativo.
`Zona\_Referencia` (STRING): Zona cañera de muestreo de precios (Alvarado / Veracruz Central).
Líneas Base del Catálogo Maestro:
Línea Base Soca / Resoca: $$16,810.00\text{ MXN / Ha}$
Fase 1 (Arranque, Sello y Enraizamiento): $$7,895.00\text{ MXN / Ha}$ (`INS-010` a `INS-015`)
Fase 2 (Desarrollo, Macollamiento y Cultivo): $$5,555.00\text{ MXN / Ha}$ (`INS-016` a `INS-019`)
Fase 3 (Cierre de Cañal, Foliar y Elongación): $$2,705.00\text{ MXN / Ha}$ (`INS-020` a `INS-022`)
Fase 4 (Preparación de Cosecha y Bordes): $$655.00\text{ MXN / Ha}$ (`INS-023` a `INS-024`)
Línea Base Plantilla (Nueva Siembra): $$34,690.00\text{ MXN / Ha}$
Fase 1 (Preparación Mecanizada del Suelo): $$8,300.00\text{ MXN / Ha}$ (`INS-030` a `INS-034`)
Fase 2 (Siembra, Desinfección y Sello): $$16,445.00\text{ MXN / Ha}$ (`INS-035`, `INS-036`, `INS-013`, `INS-014`, `INS-015`)
Fase 3 (Desarrollo y Segunda Nutrición): $$6,585.00\text{ MXN / Ha}$ (`INS-037`, `INS-017`, `INS-014`, `INS-018`, `INS-019`)
Fase 4 (Cierre de Cañal y Foliar): $$2,705.00\text{ MXN / Ha}$ (`INS-020` a `INS-022`)
Fase 5 (Preparación Cosecha y Bordes): $$655.00\text{ MXN / Ha}$ (`INS-023` a `INS-024`)
---
3. `12\_CONFIG\_TIERS` (Dimensión de Monetización SaaS)
Propósito: Configuración de derechos de acceso, límites de consumo de IA y tarifas por ciclo de zafra.
`Tier\_ID` (STRING, PK): Identificador del escalafón comercial (`TIER-1`, `TIER-2A`, `TIER-2B`, `TIER-2C`, `TIER-3`).
`Nombre\_Plan` (STRING): `'Freemium'` | `'Pro Básico'` | `'Pro Mediano'` | `'Pro Multipredio'` | `'Enterprise'`.
`Rango\_Hectareas` (STRING): Segmento de escala atendido (`1 - 5 Ha`, `6 - 15 Ha`, `16 - 50 Ha`, `50+ Ha`).
`Precio\_Zafra\_MXN` (NUMERIC): Inversión por ciclo agrícola ($$0.00$, $$399.00$, $$699.00$, $$1,499.00\text{ MXN / Zafra}$; $$2,500.00+\text{ MXN / Mes}$).
`Limite\_Consultas\_IA` (INTEGER): Cuota mensual asignada para llamadas agénticas de voz/texto.
`Modulos\_Incluidos` (STRING): Catálogo de módulos funcionales y reportes accesibles.
---
TABLAS DE HECHOS (Transacciones Operativas, Financieras y de Molienda)
4. `04\_REGISTRO\_COSTOS` (Hechos de Gastos y Operaciones de Campo)
Propósito: Bitácora transaccional de cada erogación realizada en las parcelas, con trazabilidad fiscal.
`ID\_Registro` (STRING, PK): Folio único de transacción (ej. `REC-001`).
`Fecha` (DATE): Fecha de ejecución del gasto o adquisición (formato `YYYY-MM-DD`).
`Productor\_ID` (STRING, FK -> `03\_REGISTRO\_PARCELAS.Productor\_ID`): Titular responsable del egreso.
`Lote\_ID` (STRING, FK -> `03\_REGISTRO\_PARCELAS.Lote\_ID`): Predio específico al que se imputa el costo.
`Tipo\_Ciclo` (ENUM): `'Plantilla'` | `'Soca'` | `'Resoca'`.
`Fase\_Operativa` (ENUM):
`'Fase 1: Preparación / Arranque'`
`'Fase 2: Siembra / Desarrollo'`
`'Fase 3: Macollamiento / Nutrición Foliar'`
`'Fase 4: Cierre / Elongación'`
`'Fase 5: Mantenimiento y Bordes'`
`Actividad\_Insumo` (STRING): Descripción específica de la labor o agroquímico adquirido.
`Cantidad` (NUMERIC): Volumen, superficie o número de unidades aplicadas.
`Unidad` (STRING): Magnitud física (`Ha`, `Bulto`, `Litro`, `Jornal`, `Paso`, `Vuelo`).
`Costo\_Total\_MXN` (NUMERIC): Importe monetario total erogado en la operación.
`Forma\_Pago` (ENUM): `'Efectivo'` | `'Tarjeta Débito'` | `'Transferencia'` | `'Crédito de Avío'`.
`Cuenta\_Origen` (ENUM): `'Santander'` | `'Mercado Pago'` | `'Klar'` | `'Caja Chica / Efectivo'`.
`Estatus\_CFDI\_Deducible` (ENUM): Respaldo comprobatorio emitido por el proveedor:
`'CON\_FACTURA\_SAT'`: Comprobante Fiscal Digital por Internet (CFDI) válido con archivo XML/PDF.
`'NOTA\_SIMPLE\_REMISION'`: Nota de venta, recibo de mostrador o ticket sin timbrado fiscal.
`'MANO\_OBRA\_SIN\_CFDI'`: Pago en efectivo a jornaleros, cuadrillas de corte o acarreo informal.
`Impacto\_Fiscal\_Acreditamiento` (STRING): Diagnóstico fiscal automatizado asignado por el motor/IA:
`'Acredita\_IVA\_Solamente'`: Recuperación del $16%$ de IVA acreditable (típico en RESICO Exento/Gravado).
`'Deduce\_ISR\_y\_Acredita\_IVA'`: Deduce base gravable de ISR y acredita IVA (típico en PFAE General y Personas Morales AGAPE).
`'Solo\_Gasto\_Interno'`: Gasto operativo real que resta margen contable pero no tiene efecto tributario deducible.
---
5. `05\_KARBE\_CALIDAD` (Hechos de Molienda y Auditoría de Báscula)
Propósito: Registrar los boletos de pesaje emitidos por el ingenio y auditar las penalizaciones de calidad y mermas.
`Remision\_ID` (STRING, PK): Folio de boleta o ticket de báscula en batey (ej. `T-45910`).
`Productor\_ID` (STRING, FK -> `03\_REGISTRO\_PARCELAS.Productor\_ID`).
`Lote\_ID` (STRING, FK -> `03\_REGISTRO\_PARCELAS.Lote\_ID`).
`Fecha\_Corte` (DATE): Fecha de derribo y pesaje de la caña.
`Toneladas\_Brutas` (NUMERIC): Peso total del camión descontando tara del vehículo.
`Porcentaje\_Castigo\_Materia\_Extrana` (NUMERIC): Porcentaje de deducción aplicado en laboratorio por hojas, lodo y paja.
`Toneladas\_Netas` (NUMERIC): Toneladas reconocidas por el ingenio tras descontar materia extraña:
$$\text{Toneladas_Netas} = \text{Toneladas_Brutas} \times \left(1 - \frac{\text{Porcentaje_Castigo}}{100}\right)$$
`Pol\_Cana` (NUMERIC): Concentración aparente de sacarosa determinada en el jugo.
`Pureza\_Jugo` (NUMERIC): Proporción de sacarosa en los sólidos disueltos totales.
`KARBE\_Obtenido` (NUMERIC): Kilogramos de Azúcar Recuperable Base Estándar certificados por tonelada de caña.
`Precio\_Base\_Ton\_MXN` (NUMERIC): Cotización de la caña fijada para el ciclo según el precio de referencia del azúcar.
`Precio\_Ajustado\_Ton\_MXN` (NUMERIC): Precio neto resultante tras penalización de calidad y castigos de báscula.
`Valor\_Bruto\_Liquidacion\_MXN` (NUMERIC): Importe devengado por el viaje:
$$\text{Valor_Bruto} = \text{Toneladas_Netas} \times \text{Precio_Ajustado_Ton_MXN}$$
---
TABLAS DE AGREGACIÓN Y MOTORES FINANCIEROS
6. `06\_DATOS\_MAESTROS` (Consolidado por Lote y Control de Desviación Presupuestal)
Propósito: Vista agregada a nivel predio para la simulación de margen neto y auditoría en tiempo real.
`Lote\_ID` (STRING, PK): Identificador único del predio.
`Superficie\_Ha` (NUMERIC): Superficie en hectáreas extraída de `03\_REGISTRO\_PARCELAS`.
`Ciclo` (ENUM): `'Plantilla'` | `'Soca'` | `'Resoca'`.
`Rendimiento\_Est\_Ton\_Ha` (NUMERIC): Estimación de campo de productividad agronómica (Ton/Ha).
`Ton\_Totales\_Est` (NUMERIC): Producción esperada acumulada:
$$\text{Ton_Totales_Est} = \text{Superficie_Ha} \times \text{Rendimiento_Est_Ton_Ha}$$
`Costo\_Total\_Invertido\_MXN` (NUMERIC): Suma agregada de egresos reales desde `04\_REGISTRO\_COSTOS`:
$$\text{Costo_Total_Invertido_MXN} = \sum \text{Costo_Total_MXN}$$
`Costo\_Por\_Ton\_MXN` (NUMERIC): Costo real devengado por tonelada estimada:
$$\text{Costo_Por_Ton_MXN} = \frac{\text{Costo_Total_Invertido_MXN}}{\text{Ton_Totales_Est}}$$
`Ingreso\_Bruto\_Est\_MXN` (NUMERIC): Expectativa de liquidación bruta basada en el KARBE ponderado:
$$\text{Ingreso_Bruto_Est_MXN} = \text{Ton_Totales_Est} \times \text{Precio_Ajustado_Ton_MXN}$$
`Margen\_Neto\_Est\_MXN` (NUMERIC): Utilidad neta de campo proyectada:
$$\text{Margen_Neto_Est_MXN} = \text{Ingreso_Bruto_Est_MXN} - \text{Costo_Total_Invertido_MXN}$$
`Presupuesto\_Meta\_Ha\_MXN` (NUMERIC): Límite presupuestal técnico establecido por la calibración agronómica:
$$\text{Presupuesto_Meta_Ha} = \begin{cases} $16,810.00 & \text{si Ciclo} \in {\text{'Soca'}, \text{'Resoca'}} \ $34,690.00 & \text{si Ciclo} = \text{'Plantilla'} \end{cases}$$
`Presupuesto\_Total\_Lote\_MXN` (NUMERIC): Techo de gasto autorizado para la superficie completa del predio:
$$\text{Presupuesto_Total_Lote_MXN} = \text{Superficie_Ha} \times \text{Presupuesto_Meta_Ha_MXN}$$
`Porcentaje\_Consumo\_Presupuesto` (NUMERIC): Ratio de absorción de la bolsa de inversión autorizada:
$$\text{Ratio} = \frac{\text{Costo_Total_Invertido_MXN}}{\text{Presupuesto_Total_Lote_MXN}}$$
`Semaforo\_Financiero` (STRING): Alerta directiva visual para el productor:
`'🔴 SOBRECOSTO'`: Cuando $\text{Ratio} > 1.00$ (Se superó el techo agronómico).
`'🟡 ALERTA'`: Cuando $0.85 \le \text{Ratio} \le 1.00$ (Consumo superior al $85%$; riesgo de sobrecosto).
`'🟢 CONTROLADO'`: Cuando $\text{Ratio} < 0.85$ (Inversión en rango seguro).
---
7. `08\_MODULO\_LEASING` (Evaluación de Maquinaria y Activos de Transporte)
Propósito: Calcular el costo horario operativo y el escudo fiscal derivado del financiamiento de vehículos de trabajo (ej. camioneta pick-up de supervisión) o tractores.
`ID\_Activo` (STRING, PK): Código del vehículo o apero (ej. `ACT-001`).
`Descripcion\_Activo` (STRING): Detalle del equipo (ej. Camioneta Pick-Up Doble Cabina 4x4).
`Costo\_Mensual\_Arrendamiento\_MXN` (NUMERIC): Pago de renta mensual (leasing financiero o puro).
`Horas\_Uso\_Promedio\_Mes` (NUMERIC): Horas efectivas reportadas en campo.
`Costo\_Por\_Hora\_Operativa\_MXN` (NUMERIC):
$$\text{Costo_Hora} = \frac{\text{Costo_Mensual_Arrendamiento_MXN}}{\text{Horas_Uso_Promedio_Mes}}$$
`Recuperacion\_IVA\_Mensual\_MXN` (NUMERIC): IVA acreditable deducido mensualmente por la factura de arrendamiento ($16%$).
`Escudo\_ISR\_Mensual\_MXN` (NUMERIC): Deducción autorizada del pago de renta (aplica en PFAE General y Personas Morales AGAPE; en RESICO protege el flujo vía acreditamiento de IVA).
---
8. `09\_MODULO\_FISCAL` (Matriz de Cumplimiento Tributario y Liquidación)
Propósito: Desacoplar la retención del ingenio de la ganancia operativa neta, modelando los escenarios fiscales de la caña.
`Productor\_ID` (STRING, PK/FK).
`Regimen\_Fiscal\_Activo` (STRING): Tipo tributario asignado en `03\_REGISTRO\_PARCELAS`.
`Ingresos\_Brutos\_Acumulados\_MXN` (NUMERIC): Suma acumulada de liquidaciones cobradas en el ejercicio fiscal.
`Monto\_Exento\_ISR\_MXN` (NUMERIC):
RESICO PF: Hasta $$900,000.00\text{ MXN}$ anuales exentos.
PFAE General: $$0.00\text{ MXN}$ (Tributación sobre utilidad neta total).
Persona Moral AGAPE: 20 UMA anuales por socio (con tope de 200 UMA por sociedad).
`Base\_Gravable\_ISR\_MXN` (NUMERIC): Importe sujeto a determinación de impuesto.
`Retencion\_Ingenio\_ISR\_MXN` (NUMERIC): Monto retenido por la factoría en la boleta de liquidación final ($1.25%$ en RESICO Gravado).
`Bolsa\_IVA\_Acreditable\_MXN` (NUMERIC): Monto total de IVA trasladado en facturas de insumos (`04\_REGISTRO\_COSTOS`), disponible para compensar contra IVA por venta o solicitar devolución en cuenta bancaria.
---
2. RELACIONES E INTEGRIDAD REFERENCIAL (SCHEMA MAP)
```
\[ 03\_REGISTRO\_PARCELAS ] (1) 
   │
   ├── (1:N) ──> \[ 04\_REGISTRO\_COSTOS ]  (FK: Productor\_ID, Lote\_ID)
   ├── (1:N) ──> \[ 05\_KARBE\_CALIDAD ]    (FK: Productor\_ID, Lote\_ID)
   ├── (1:1) ──> \[ 06\_DATOS\_MAESTROS ]   (FK: Lote\_ID)
   └── (1:1) ──> \[ 09\_MODULO\_FISCAL ]    (FK: Productor\_ID)

\[ 02\_COSTOS\_ESTANDAR ] (1)
   │
   └── (Referencia Paramétrica) ──> \[ 04\_REGISTRO\_COSTOS ] (Por Concepto / Actividad)
   └── (Regla Paramétrica $16,810 / $34,690) ──> \[ 06\_DATOS\_MAESTROS ]

\[ 12\_CONFIG\_TIERS ] (1)
   │
   └── (Regla de Acceso y Límites IA) ──> \[ System Prompt de Gemini 1.5 Pro ]
```
