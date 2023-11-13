-- 1. Crie um novo login de servidor
USE master;
CREATE LOGIN atividade_usuario WITH PASSWORD = '******';

-- 2. Crie um usuário de banco de dados associado ao login
USE localidades;
CREATE USER atividade_usuario FOR LOGIN atividade_usuario;

-- 3. Conceda permissões de SELECT nas colunas específicas da tabela 'paises'
GRANT SELECT ON OBJECT::paises(nome, sigla) TO atividade_usuario;

-- 4. Conceda permissões de SELECT nas colunas específicas da tabela 'estados'
GRANT SELECT ON OBJECT::estados(nome, uf) TO atividade_usuario;

-- 5. Script para revogar as permissões na tabela 'estados'
REVOKE SELECT ON OBJECT::estados(nome, uf) FROM atividade_usuario;

-- 6. Script para remover o usuário
USE localidades;
DROP USER atividade_usuario;

-- 7. Script para remover o login de servidor (use com cautela, pois removerá o usuário e suas permissões)
USE master;

SELECT session_id
FROM sys.dm_exec_sessions
WHERE login_name = 'atividade_usuario'

KILL 61

DROP LOGIN atividade_usuario;