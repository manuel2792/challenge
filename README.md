# Proyecto de Prueba Técnica

## Consideraciones

**Deadline:**  
Entendemos cada situación en particular y preferimos que trabajes a tu ritmo. Sin embargo, la solución debe ser entregada en no más de una semana desde que recibiste la consigna. Asegúrate de que la solución lleve tu propio sello.

**Puntos a evaluar:**
- **Interpretación de la consigna**
- **Orden y comentarios del código**
- **Queries simples y efectivas**
- **Calidad del entregable**
- Si consideras algún otro punto que pueda sumar, siéntete libre de agregarlo y comentarnos cuál es y por qué lo sumaste.

## Primera Parte - SQL

### Objetivo
A partir de la necesidad presentada, se requiere diseñar un DER (Diagrama Entidad-Relación) que responda al modelo del negocio. Luego, se deben responder mediante SQL las diferentes preguntas planteadas.

### Descripción de la necesidad
Basado en el modelo de ecommerce manejado, queremos representar las siguientes entidades básicas: **Customer, Order, Item y Category**.

- **Customer:** Entidad donde se encuentran todos nuestros usuarios, ya sean Buyers o Sellers del sitio. Los principales atributos son email, nombre, apellido, sexo, dirección, fecha de nacimiento, teléfono, entre otros.
- **Item:** Entidad donde se encuentran los productos publicados en nuestro marketplace. El volumen es muy grande debido a que se encuentran todos los productos que en algún momento fueron publicados. Mediante el estado del ítem o fecha de baja se pueden detectar los ítems activos del marketplace.
- **Category:** Entidad donde se encuentra la descripción de cada categoría con su respectivo path. Cada ítem tiene asociada una categoría.
- **Order:** Entidad que refleja las transacciones generadas dentro del sitio (cada compra es una order). En este caso, no contaremos con un flujo de carrito de compras; por lo tanto, cada ítem que se venda será reflejado en una order, independientemente de la cantidad que se haya comprado.

### Flujo de Compras
Un usuario ingresa al sitio de Mercado Libre para comprar dos dispositivos móviles iguales. Realiza la búsqueda navegando por las categorías **Tecnología > Celulares y Teléfonos > Celulares y Smartphones**, y finalmente encuentra el producto que necesita comprar. Procede con la compra del mismo seleccionando dos unidades, lo cual genera una orden de compra.

### A resolver
1. **Listar los usuarios que cumplen años el día de hoy cuya cantidad de ventas realizadas en enero 2020 sea superior a 1500.**
2. **Para cada mes del 2020, se solicita el top 5 de usuarios que más vendieron ($) en la categoría Celulares. Se requiere el mes y año de análisis, nombre y apellido del vendedor, cantidad de ventas realizadas, cantidad de productos vendidos y el monto total transaccionado.**
3. **Poblar una nueva tabla con el precio y estado de los Ítems a fin del día. Tener en cuenta que debe ser reprocesable. Vale resaltar que en la tabla Item, solo se tendrá el último estado informado por la PK definida. (Se puede resolver a través de Stored Procedure.)**

### Backlog de Tareas
1. Diseñar un DER del modelo de datos que logre responder cada una de las preguntas mencionadas anteriormente.
2. Generar el script DDL para la creación de cada una de las tablas representadas en el DER. Enviarlo con el nombre `create_tables.sql`.
3. Generar el código SQL para responder cada una de las situaciones mencionadas anteriormente sobre el modelo diseñado. Nombre solicitado: `respuestas_negocio.sql`.
