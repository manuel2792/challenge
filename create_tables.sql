-- El script DDL es suponiendo que utilizan BigQuery

-- Crear tabla Customers
CREATE TABLE `project_id.ecommerce.Customers` (
  customer_id INT64,
  email STRING,
  nombre STRING,
  apellido STRING,
  sexo STRING,
  direccion STRING,
  fecha_nacimiento DATE,
  telefono STRING,
  PRIMARY KEY (customer_id)
);

-- Crear tabla Category
CREATE TABLE `project_id.ecommerce.Category` (
  categoria_id INT64,
  nombre STRING,
  descripcion STRING,
  ruta STRING,
  PRIMARY KEY (categoria_id)
);

-- Crear tabla Item
CREATE TABLE `project_id.ecommerce.Item` (
  item_id INT64,
  categoria_id INT64,
  producto STRING,
  descripcion STRING,
  PRIMARY KEY (item_id)
);

-- Crear tabla Orders
CREATE TABLE `project_id.ecommerce.Orders` (
  order_id INT64,
  customer_id INT64,
  order_date DATE,
  vendedor_id INT64,
  item_id INT64,
  precio FLOAT64,
  PRIMARY KEY (order_id),
);

-- Crear tabla OrderItem
CREATE TABLE `project_id.ecommerce.OrderItem` (
  order_id INT64,
  item_id INT64,
  cantidad INT64,
  precio_unitario FLOAT64,
  PRIMARY KEY (order_id, item_id)
);
