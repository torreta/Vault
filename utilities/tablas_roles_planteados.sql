
-- =============================================
-- TABLAS DE GESTIÓN DE USUARIOS Y PERMISOS
-- =============================================

-- 1. TABLA DE ROLES
CREATE TABLE dbo_user_roles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
    is_system_role BOOLEAN DEFAULT FALSE,
    created_by_user_id INT,
    `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by_user_id) REFERENCES dbo_users(id)
);

-- 2. TABLA DE PERMISOS
CREATE TABLE dbo_permissions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    permission_code VARCHAR(100) UNIQUE NOT NULL,  -- Ej: 'transaction.trade.create'
    permission_name VARCHAR(100) NOT NULL,
    module VARCHAR(50) NOT NULL,                   -- Ej: 'transaction', 'balance', 'client'
    description TEXT,
    auto_discovered BOOLEAN DEFAULT FALSE,         -- Para descubrimiento automático
    `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. ROLES ↔ PERMISOS (Many-to-Many)
CREATE TABLE dbo_role_permissions (
    role_id INT,
    permission_id INT,
    granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    granted_by_user_id INT,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES dbo_user_roles(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES dbo_permissions(id) ON DELETE CASCADE,
    FOREIGN KEY (granted_by_user_id) REFERENCES dbo_users(id)
);

-- 4. USUARIOS ↔ ROLES (Many-to-Many)
CREATE TABLE dbo_user_roles_assignment (
    user_id INT,
    role_id INT,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    assigned_by_user_id INT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES dbo_users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES dbo_user_roles(id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_by_user_id) REFERENCES dbo_users(id)
);

-- 5. PERMISOS DIRECTOS DE USUARIO (Para overrides)
CREATE TABLE dbo_user_direct_permissions (
    user_id INT,
    permission_id INT,
    granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    granted_by_user_id INT,
    expires_at TIMESTAMP NULL,
    PRIMARY KEY (user_id, permission_id),
    FOREIGN KEY (user_id) REFERENCES dbo_users(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES dbo_permissions(id) ON DELETE CASCADE,
    FOREIGN KEY (granted_by_user_id) REFERENCES dbo_users(id)
);

-- 6. PERMISOS CON ALCANCE (SCOPED)
CREATE TABLE dbo_user_scope_permissions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    permission_id INT NOT NULL,
    scope_type ENUM('COMPANY', 'ASSET', 'DRAWER', 'LOCATION') NOT NULL,
    scope_id INT NOT NULL,  -- ID de la entidad (company, asset, drawer, location)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by_user_id INT,
    FOREIGN KEY (user_id) REFERENCES dbo_users(id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES dbo_permissions(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by_user_id) REFERENCES dbo_users(id),
    UNIQUE KEY unique_scope_permission (user_id, permission_id, scope_type, scope_id)
);

-- 7. HISTORIAL DE CAMBIOS DE PERMISOS (AUDITORÍA)
CREATE TABLE dbo_permission_audit_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    target_user_id INT,  -- Usuario afectado
    action_type ENUM('GRANT', 'REVOKE', 'UPDATE', 'EXPIRE') NOT NULL,
    permission_code VARCHAR(100),
    role_name VARCHAR(50),
    scope_type VARCHAR(20),
    scope_id INT,
    old_value TEXT,
    new_value TEXT,
    ip_address VARCHAR(45),
    user_agent TEXT,
    performed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES dbo_users(id)
);
            