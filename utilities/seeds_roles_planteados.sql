-- ROLES DEL SISTEMA 
INSERT INTO dbo_user_roles (role_name, description, is_system_role) 
VALUES 
('SUPER_ADMIN', 'Acceso completo al sistema', TRUE), 
('ADMIN', 'Administrador del sistema', TRUE), 
('TRADER_OPERATOR', 'Operador de trading', TRUE), 
('CASHIER_MANAGER', 'Gestor de cajas', TRUE), 
('CLIENT_USER', 'Usuario cliente', TRUE), 
('AUDITOR', 'Solo visualización para auditoría', TRUE); 

-- PERMISOS BÁSICOS (Módulo: TRANSACTION) 
INSERT INTO dbo_permissions (permission_code, permission_name, module) 
VALUES 
('transaction.trade.create', 'Crear transacciones de trading', 'transaction'), 
('transaction.trade.read', 'Ver transacciones de trading', 'transaction'), 
('transaction.trade.update', 'Actualizar transacciones', 'transaction'), 
('transaction.trade.delete', 'Eliminar transacciones', 'transaction'), 
('transaction.transfer.create', 'Crear transferencias', 'transaction'), 
('transaction.loan.create', 'Crear préstamos', 'transaction'), 
('transaction.loan.pay', 'Pagar préstamos', 'transaction'); 

-- PERMISOS BÁSICOS (Módulo: BALANCE) 
INSERT INTO dbo_permissions (permission_code, permission_name, module) 
VALUES 
('balance.daily.open', 'Abrir balance diario', 'balance'), 
('balance.daily.close', 'Cerrar balance diario', 'balance'), 
('balance.daily.read', 'Ver balances diarios', 'balance'), 
('balance.company.view', 'Ver balances de compañía', 'balance'); 

-- PERMISOS BÁSICOS (Módulo: ASSET) 
INSERT INTO dbo_permissions (permission_code, permission_name, module) 
VALUES 
('asset.usd_cash.transact', 'Operar con USD Efectivo', 'asset'), 
('asset.usdt.transact', 'Operar con USDT', 'asset'), 
('asset.usd_panama.transact', 'Operar con USD Panama', 'asset'), 
('asset.gold.transact', 'Operar con Oro', 'asset'), 
('asset.bs.transact', 'Operar con Bolívares', 'asset'); 

-- PERMISOS BÁSICOS (Módulo: USER_MANAGEMENT) 
INSERT INTO dbo_permissions (permission_code, permission_name, module) 
VALUES 
('user.create', 'Crear usuarios', 'user_management'), 
('user.read', 'Ver usuarios', 'user_management'), 
('user.update', 'Actualizar usuarios', 'user_management'), 
('user.delete', 'Eliminar usuarios', 'user_management'), 
('role.manage', 'Gestionar roles', 'user_management'), 
('permission.manage', 'Gestionar permisos', 'user_management');