# RetailPro — Análisis de Ventas

## Descripción

**RetailPro** es un proyecto de análisis de datos orientado a comprender el comportamiento de las ventas y obtener **insights de negocio** que permitan identificar oportunidades y posibles causas detrás de la evolución de las ventas.

El análisis busca responder preguntas como:

* ¿Cómo evolucionan las ventas a lo largo del tiempo?
* ¿Qué productos y categorías generan mayor facturación?
* ¿En qué regiones se concentran las ventas?
* ¿Cómo se comporta el ticket promedio?
* ¿Qué factores pueden explicar cambios en el desempeño comercial?

Los resultados del análisis se utilizan como base para la elaboración de un **dashboard en Power BI**, orientado a facilitar la interpretación de la información y la toma de decisiones.

---

## Herramientas utilizadas

* **SQL Server Management Studio 22:** utilizado para la creación, carga, validación y análisis de la base de datos mediante SQL.
* **Power BI:** utilizado para la visualización de datos y construcción del dashboard.

---

## Estructura del proyecto

```text
RetailPro/
├── ventas_tech_db.sql
├── m4_consultas_negocio.sql
├── m5_consultas_joins.sql
├── Ozan_Fabiola_Checkpoint2.pbix
└── README.md
```

### Archivos principales

| Archivo                         | Descripción                                                                                                    |
| ------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| `ventas_tech_db.sql`            | Script de creación y carga de la base de datos. Contiene `DROP`, `CREATE`, `INSERT` y consultas de validación. |
| `m4_consultas_negocio.sql`      | Consultas SQL utilizadas para responder las principales preguntas de negocio.                                  |
| `m5_consultas_joins.sql`        | Consultas SQL que utilizan `JOIN` para combinar información de las diferentes tablas.                          |
| `Ozan_Fabiola_Checkpoint2.pbix` | Dashboard desarrollado en Power BI a partir del análisis realizado.                                            |
| `README.md`                     | Documentación del proyecto y guía para su ejecución.                                                           |

---

## Estructura de la base de datos

La base de datos de RetailPro está compuesta por **4 tablas principales**:

| Tabla        | Descripción                                               |
| ------------ | --------------------------------------------------------- |
| `Ventas`     | Contiene la información de las transacciones realizadas.  |
| `Clientes`   | Contiene información asociada a los clientes.             |
| `Productos`  | Contiene información sobre los productos comercializados. |
| `Categorias` | Contiene la clasificación de los productos.               |

Las tablas se relacionan mediante sus respectivas claves, permitiendo integrar la información para realizar un análisis comercial completo.

---

## Cómo ejecutar el proyecto

Para reproducir el análisis, seguí estos pasos en orden:

### 1. Crear y cargar la base de datos

Abrí **SQL Server Management Studio 22**, conectate a tu instancia de SQL Server y ejecutá:

```text
ventas_tech_db.sql
```

Este script se encarga de:

* Eliminar objetos existentes mediante `DROP`.
* Crear las tablas mediante `CREATE`.
* Cargar los datos mediante `INSERT`.
* Ejecutar consultas de **validación** para comprobar que la carga se realizó correctamente.

### 2. Ejecutar las consultas de negocio

Una vez creada y cargada la base de datos, ejecutá:

```text
m4_consultas_negocio.sql
```

Este archivo contiene las consultas utilizadas para analizar las ventas y responder las principales preguntas de negocio.

### 3. Ejecutar las consultas con JOIN

Luego ejecutá:

```text
m5_consultas_joins.sql
```

Este archivo contiene consultas que utilizan **JOIN** para combinar información de las distintas tablas y realizar un análisis integrado de los datos.

### 4. Abrir el dashboard

Finalmente, abrí:

```text
Ozan_Fabiola_Checkpoint2.pbix
```

El archivo debe abrirse utilizando **Power BI Desktop** para visualizar el dashboard y explorar los resultados del análisis.

---

## Flujo del proyecto

```text
Base de datos
     ↓
Carga y validación de datos
     ↓
Análisis de negocio con SQL
     ↓
Consultas con JOIN
     ↓
Visualización en Power BI
```
