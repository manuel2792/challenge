--Consulta 1: Listar los usuarios que cumplen años hoy y realizaron más de 1500 ventas en enero de 2020

--Subquery ventas_enero: Calcula el número de ventas realizadas por cada cliente en enero de 2020 y se filtra aquellos que tienen más de 1500 ventas.
--También se hace un join con Customer: Une los resultados de la subquery ventas_enero con la tabla Customer para obtener los nombres y apellidos de los clientes que cumplen años hoy.

SELECT c.*
FROM Customers c
JOIN (
    SELECT o.customer_id, COUNT(*) AS cantidad_ventas
    FROM Orders o
    JOIN OrderItem oi 
    ON o.order_id = oi.order_id
    WHERE EXTRACT(YEAR FROM o.fecha) = 2020
    AND EXTRACT(MONTH FROM o.fecha) = 1
    GROUP BY o.customer_id
    HAVING COUNT(*) > 1500
) AS ventas_enero 
ON c.customer_id = ventas_enero.customer_id
WHERE EXTRACT(MONTH FROM c.fecha_nacimiento) = EXTRACT(MONTH FROM CURRENT_DATE())
AND EXTRACT(DAY FROM c.fecha_nacimiento) = EXTRACT(DAY FROM CURRENT_DATE());

-- Consulta 2: Top 5 usuarios que más vendieron en la categoría Celulares por mes en 2020

-- ventas_por_mes: Calcula las ventas por cada mes del 2020, incluyendo el vendedor, la cantidad de ventas realizadas, y el monto total transaccionado.
WITH ventas_por_mes AS (
  SELECT
    EXTRACT(YEAR FROM o.fecha) AS year,
    EXTRACT(MONTH FROM o.fecha) AS month,
    c.customer_id AS vendedor_id,
    COUNT(oi.item_id) AS total_ventas,
    SUM(oi.precio_unitario * oi.cantidad) AS total_precio
  FROM orders o
  JOIN orderitem oi ON o.order_id = oi.order_id
  JOIN itemsi ON oi.item_id = i.item_id
  JOIN category cat ON i.category_id = cat.category_id
  JOIN customers c ON o.customer_id = c.customer_id
  WHERE
    cat.nombre = 'Celulares'
    AND EXTRACT(YEAR FROM o.fecha) = 2020
  GROUP BY
    year, month, vendedor_id
),
-- top_5_vendedores: Asigna un número de fila a cada vendedor basado en el monto total transaccionado para cada mes y año, en orden descendente.
top_5_vendedores AS (
  SELECT
    year,
    month,
    vendedor_id,
    total_ventas,
    total_precio,
    ROW_NUMBER() OVER (PARTITION BY year, month ORDER BY total_precio DESC) AS row_num
  FROM
    ventas_por_mes
)
-- SELECT final: Selecciona los datos relevantes de los top 5 vendedores para cada mes y año, uniendo con la tabla Customers para obtener el nombre y apellido del vendedor.  
SELECT
  t.month,
  t.year,
  c.nombre,
  c.apellido,
  t.total_ventas,
  t.total_precio
FROM top_5_vendedores t
JOIN customers c 
ON t.vendedor_id = c.customer_id
WHERE t.row_num <= 5
ORDER BY
  t.year,
  t.month,
  t.total_precio DESC;

--Consulta 3: Se solicita poblar una nueva tabla con el precio y estado de los Ítems a fin del día. Tener en cuenta que debe ser reprocesable. Vale resaltar que en la tabla Item, 
--vamos a tener únicamente el último estado informado por la PK definida. (Se puede resolver a través de StoredProcedure)

-- Primero, definimos la fecha específica para la cual queremos actualizar los estados
DECLARE DIA DATE;
SET DIA = current_date(); 

-- Luego, realizamos la actualización en la tabla item_status
INSERT INTO `cohesive-point-428518-q8.ecommerce.item_status` (item_id, producto, fecha, precio, estado,fecha_actualizacion)
SELECT 
    i.item_id,
    i.nombre AS PRODUCTO,
    o.fecha,
    cast(i.precio as numeric) AS PRECIO,
    CASE 
        WHEN o.order_id IS NOT NULL THEN 'CERRADO'
        ELSE 'ABIERTO'
    END AS ESTADO,
    CURRENT_DATE() AS fecha_actualizacion
FROM `cohesive-point-428518-q8.ecommerce.items` i
LEFT JOIN `cohesive-point-428518-q8.ecommerce.orderitem` oi ON oi.item_id = i.item_id
LEFT JOIN `cohesive-point-428518-q8.ecommerce.orders` o ON o.order_id = oi.order_id
WHERE  o.fecha <= DIA OR o.fecha IS NULL -- Selecciona todas las órdenes antes o hasta el día específico
AND (o.fecha IS NULL OR DATE(o.fecha) < DIA); -- Esta consulta insertará un estado 'ABIERTO' para los ítems sin órdenes asociadas hasta el día especificado






