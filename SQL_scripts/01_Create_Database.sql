-- ============================================================================
-- SCRIPT: 01_Create_Database.sql
-- Proyecto: Sistema de Gestión Comercial - Atlántico Tech Galicia S.L.
-- Descripción: crea la base de datos del Sistema de Gestión Comercial.
-- Autor: Cristiane G. Martins

--  Motor de Base de Datos:
 -- MySQL 8.0

-- ============================================================================


-- ============================================================================
-- Eliminar la base de datos si ya existe
-- ============================================================================

DROP DATABASE IF EXISTS SistemaGestionComercial;

-- ============================================================================
-- Crear la base de datos
-- ============================================================================

CREATE DATABASE SistemaGestionComercial
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- ============================================================================
-- Seleccionar la base de datos
-- ============================================================================

USE SistemaGestionComercial;
