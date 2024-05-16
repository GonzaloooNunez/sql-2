/* Relación tipo 1:1 */
-- PASO 1
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido  VARCHAR(50) NOT NULL,
    email  VARCHAR(50) NOT NULL,
    edad INT
);

INSERT INTO usuarios (nombre, apellido, email, edad) VALUES
('Juan', 'Gomez', 'juan.gomez@example.com', 28),
('Maria', 'Lopez', 'maria.lopez@example.com', 32),
('Carlos', 'Rodriguez', 'carlos.rodriguez@example.com', 25),
('Laura', 'Fernandez', 'laura.fernandez@example.com', 30),
('Pedro', 'Martinez', 'pedro.martinez@example.com', 22),
('Ana', 'Hernandez', 'ana.hernandez@example.com', 35),
('Miguel', 'Perez', 'miguel.perez@example.com', 28),
('Sofia', 'Garcia', 'sofia.garcia@example.com', 26),
('Javier', 'Diaz', 'javier.diaz@example.com', 31),
('Luis', 'Sanchez', 'luis.sanchez@example.com', 27),
('Elena', 'Moreno', 'elena.moreno@example.com', 29),
('Daniel', 'Romero', 'daniel.romero@example.com', 33),
('Paula', 'Torres', 'paula.torres@example.com', 24),
('Alejandro', 'Ruiz', 'alejandro.ruiz@example.com', 28),
('Carmen', 'Vega', 'carmen.vega@example.com', 29),
('Adrian', 'Molina', 'adrian.molina@example.com', 34),
('Isabel', 'Gutierrez', 'isabel.gutierrez@example.com', 26),
('Hector', 'Ortega', 'hector.ortega@example.com', 30),
('Raquel', 'Serrano', 'raquel.serrano@example.com', 32),
('Alberto', 'Reyes', 'alberto.reyes@example.com', 28);


-- PASO 2
CREATE TABLE roles (
id_rol INT AUTO_INCREMENT PRIMARY KEY,
nombre_rol VARCHAR(50) NOT NULL,
);

INSERT INTO roles (nombre_rol) VALUES
('Bronce'),
('Plata'),
('Oro'),
('Platino');

-- PASO 3
-- añado  la columna id_rol a usuarios
ALTER TABLE usuarios ADD COLUMN id_rol INT; 

-- creo clave foranea
ALTER TABLE usuarios ADD FOREIGN KEY (id_rol) REFERENCES roles(id_rol);

-- asigno roles a los usuarios
UPDATE usuarios SET id_rol = 1 WHERE id_usuario IN (12, 5, 6, 13, 20);
UPDATE usuarios SET id_rol = 2 WHERE id_usuario IN (2, 9, 17, 19, 18);
UPDATE usuarios SET id_rol = 3 WHERE id_usuario IN (4, 7, 11, 15, 14);
UPDATE usuarios SET id_rol = 4 WHERE id_usuario IN (3, 8, 1, 16, 10);

-- PASO 4
-- JOIN que saque usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol de las dos tablas
SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol FROM usuarios 
JOIN roles ON usuarios.id_rol = roles.id_rol;




/* Relación tipo 1:N */
-- PASO 1

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

INSERT INTO categorias (nombre_categoria) VALUES
('Electrónicos'),
('Ropa y Accesorios'),
('Libros'),
('Hogar y Cocina'),
('Deportes y aire libre'),
('Salud y cuidado personal'),
('Herramientas y mejoras para el hogar'),
('Juguetes y juegos'),
('Automotriz'),
('Música y Películas');

-- PASO 2
-- añado la columna id_categoría a usuarios
ALTER TABLE usuarios ADD COLUMN id_categoria INT;

-- PASO 3
-- añado categorías a usuarios
UPDATE usuarios SET id_categoria = 1 WHERE id_usuario IN (1, 11);  -- Electrónicos
UPDATE usuarios SET id_categoria = 2 WHERE id_usuario IN (14, 17);  -- Ropa y Accesorios
UPDATE usuarios SET id_categoria = 3 WHERE id_usuario IN (18, 6);  -- Libros
UPDATE usuarios SET id_categoria = 4 WHERE id_usuario IN (10, 8);  -- Hogar y Cocina
UPDATE usuarios SET id_categoria = 5 WHERE id_usuario IN (9, 7); -- Deportes y aire libre
UPDATE usuarios SET id_categoria = 6 WHERE id_usuario IN (2, 12); -- Salud y cuidado personal
UPDATE usuarios SET id_categoria = 7 WHERE id_usuario IN (13, 3); -- Herramientas y mejoras para el hogar
UPDATE usuarios SET id_categoria = 8 WHERE id_usuario IN (20, 16); -- Juguetes y juegos
UPDATE usuarios SET id_categoria = 9 WHERE id_usuario IN (4, 5); -- Automotriz
UPDATE usuarios SET id_categoria = 10 WHERE id_usuario IN (19, 15); -- Música y Películas


-- PASO 4
-- JOIN que combina las tres tablas basándose en las claves foráneas id_rol y id_categoria, esto nos permite que los numeros de id_categoria y rol se vuelvan su nombre
SELECT usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol, categorias.nombre_categoria FROM usuarios
JOIN roles ON usuarios.id_rol = roles.id_rol
JOIN categorias ON usuarios.id_categoria = categorias.id_categoria;



/* Relación tipo N:M */
-- PASO 1
-- Crea una tabla intermedia llamada usuarios_categorias y Añadimos dentro de la creación de la tabla intermedia dos claves foráneas.
CREATE TABLE usuarios_categorias (
    id_usuario_categoria INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_categoria INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- PASO 2
--  Asocia usuarios a categorías
INSERT INTO usuarios_categorias (id_usuario, id_categoria) VALUES
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 5),
(3, 6), (3, 7),
(4, 8), (4, 9), (4, 10);


-- PASO 3
-- un JOIN que saque usuarios.id_usuario, usuarios.nombre, usuarios.apellido, usuarios.email, usuarios.edad, roles.nombre_rol, categorias.nombre_categoria
SELECT * FROM usuarios JOIN categorias ON usuarios.id_usuario = categorias.id_categoria;
SELECT * FROM usuarios JOIN roles ON usuarios.id_rol = roles.id_rol;