-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-01-2024 a las 10:05:58
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `processar_web`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ctascte`
--

CREATE TABLE `ctascte` (
  `id` int(11) NOT NULL,
  `entidad_id` int(11) DEFAULT NULL,
  `fecha` int(255) DEFAULT NULL,
  `comprobante` varchar(50) DEFAULT NULL,
  `numero` varchar(20) DEFAULT NULL,
  `importe` double(13,2) DEFAULT NULL,
  `debe` double(13,2) DEFAULT NULL,
  `haber` double(13,2) DEFAULT NULL,
  `saldo` double(13,2) DEFAULT NULL,
  `saldocomp` double(13,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id` int(255) NOT NULL,
  `localidad_id` int(255) NOT NULL,
  `empresa` varchar(100) NOT NULL,
  `cuit` varchar(13) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entidades`
--

CREATE TABLE `entidades` (
  `id` int(255) NOT NULL,
  `empresa_id` int(255) NOT NULL,
  `entidad` int(255) NOT NULL,
  `servicio` int(255) NOT NULL,
  `cuenta` int(255) NOT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `compania` varchar(100) DEFAULT NULL,
  `cuit` varchar(13) NOT NULL,
  `dni` int(255) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `condfiscal` varchar(100) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fechanac` datetime DEFAULT NULL,
  `sexo` char(1) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados`
--

CREATE TABLE `estados` (
  `id` int(255) NOT NULL,
  `estado` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `id` int(255) NOT NULL,
  `entidad_id` int(255) NOT NULL,
  `idfactura` int(255) DEFAULT NULL,
  `comprobante` varchar(50) NOT NULL,
  `numero` varchar(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `localidad` varchar(255) DEFAULT NULL,
  `cuit` varchar(13) NOT NULL,
  `tipodoc` varchar(10) NOT NULL,
  `dni` int(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `neto` double(13,2) NOT NULL,
  `subtotal` double(13,2) NOT NULL,
  `descuento` double(13,2) DEFAULT NULL,
  `recargo` double(13,2) DEFAULT NULL,
  `total` double(13,2) NOT NULL,
  `totalimpu` double(13,2) NOT NULL,
  `saldo` double(13,2) NOT NULL,
  `observa1` varchar(255) DEFAULT NULL,
  `observa2` varchar(255) DEFAULT NULL,
  `observa3` varchar(255) DEFAULT NULL,
  `observa4` varchar(255) DEFAULT NULL,
  `fecha` datetime NOT NULL,
  `estado` varchar(100) NOT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidades`
--

CREATE TABLE `localidades` (
  `id` int(255) NOT NULL,
  `provincia_id` int(255) NOT NULL,
  `localidad` varchar(100) NOT NULL,
  `cp` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises`
--

CREATE TABLE `paises` (
  `id` int(255) NOT NULL,
  `pais` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincias`
--

CREATE TABLE `provincias` (
  `id` int(255) NOT NULL,
  `pais_id` int(255) NOT NULL,
  `provincia` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(255) NOT NULL,
  `localidad_id` int(255) NOT NULL,
  `estado_id` int(255) NOT NULL,
  `role` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `surname` varchar(200) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_empresas`
--

CREATE TABLE `users_empresas` (
  `id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `empresa_id` int(255) NOT NULL,
  `usuario` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL,
  `update_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users_entidades`
--

CREATE TABLE `users_entidades` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `entidad_id` int(11) DEFAULT NULL,
  `create_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ctascte`
--
ALTER TABLE `ctascte`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ctascte_entidades` (`entidad_id`);

--
-- Indices de la tabla `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_empresas_localidades` (`localidad_id`);

--
-- Indices de la tabla `entidades`
--
ALTER TABLE `entidades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_entidades_empresas` (`empresa_id`);

--
-- Indices de la tabla `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_facturas_entidades` (`entidad_id`);

--
-- Indices de la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_localidades_provincias` (`provincia_id`);

--
-- Indices de la tabla `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `provincias`
--
ALTER TABLE `provincias`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_provincias_paises` (`pais_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_users_localidades` (`localidad_id`),
  ADD KEY `fk_users_estados` (`estado_id`);

--
-- Indices de la tabla `users_empresas`
--
ALTER TABLE `users_empresas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_users_empresas_user` (`user_id`),
  ADD KEY `fk_users_empresas_empr` (`empresa_id`);

--
-- Indices de la tabla `users_entidades`
--
ALTER TABLE `users_entidades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_users_entidades_user` (`user_id`),
  ADD KEY `fk_users_entidades_ent` (`entidad_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ctascte`
--
ALTER TABLE `ctascte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estados`
--
ALTER TABLE `estados`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `localidades`
--
ALTER TABLE `localidades`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `provincias`
--
ALTER TABLE `provincias`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users_entidades`
--
ALTER TABLE `users_entidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ctascte`
--
ALTER TABLE `ctascte`
  ADD CONSTRAINT `fk_ctascte_entidades` FOREIGN KEY (`entidad_id`) REFERENCES `entidades` (`id`);

--
-- Filtros para la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD CONSTRAINT `fk_empresas_localidades` FOREIGN KEY (`localidad_id`) REFERENCES `localidades` (`id`);

--
-- Filtros para la tabla `entidades`
--
ALTER TABLE `entidades`
  ADD CONSTRAINT `fk_entidades_empresas` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `fk_facturas_entidades` FOREIGN KEY (`entidad_id`) REFERENCES `entidades` (`id`);

--
-- Filtros para la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD CONSTRAINT `fk_localidades_provincias` FOREIGN KEY (`provincia_id`) REFERENCES `provincias` (`id`);

--
-- Filtros para la tabla `provincias`
--
ALTER TABLE `provincias`
  ADD CONSTRAINT `fk_provincias_paises` FOREIGN KEY (`pais_id`) REFERENCES `paises` (`id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_estados` FOREIGN KEY (`estado_id`) REFERENCES `estados` (`id`),
  ADD CONSTRAINT `fk_users_localidades` FOREIGN KEY (`localidad_id`) REFERENCES `localidades` (`id`);

--
-- Filtros para la tabla `users_empresas`
--
ALTER TABLE `users_empresas`
  ADD CONSTRAINT `fk_users_empresas_empr` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `fk_users_empresas_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `users_entidades`
--
ALTER TABLE `users_entidades`
  ADD CONSTRAINT `FK_154D2FF46CA204EF` FOREIGN KEY (`entidad_id`) REFERENCES `entidades` (`id`),
  ADD CONSTRAINT `FK_154D2FF4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
