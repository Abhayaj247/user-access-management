-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role VARCHAR(20) NOT NULL DEFAULT 'EMPLOYEE',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_role CHECK (role IN ('EMPLOYEE', 'MANAGER', 'ADMIN'))
);

-- Create software table
CREATE TABLE IF NOT EXISTS software (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    access_levels TEXT[] NOT NULL,
    created_by INTEGER REFERENCES users(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create requests table
DROP TABLE IF EXISTS requests CASCADE;
CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id),
    software_id INTEGER NOT NULL REFERENCES software(id),
    access_type VARCHAR(50) NOT NULL,
    reason TEXT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    approved_by INTEGER REFERENCES users(id),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_status CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED'))
);

-- Create index for common queries
CREATE INDEX IF NOT EXISTS idx_requests_user_id ON requests(user_id);
CREATE INDEX IF NOT EXISTS idx_requests_software_id ON requests(software_id);
CREATE INDEX IF NOT EXISTS idx_requests_status ON requests(status);

-- Insert default admin user (password: admin123)
INSERT INTO users (username, password, email, role)
VALUES ('admin', '$2a$10$.4QW7VSlvU0wbySDq4RMZeKMwmh1adFQN2aeLIG5tvmbNyvzdMlhO', 'admin@example.com', 'ADMIN')
ON CONFLICT (username) DO UPDATE 
SET password = EXCLUDED.password,
    email = EXCLUDED.email,
    role = EXCLUDED.role;

-- Insert default software entries
INSERT INTO software (name, description, access_levels, created_by)
SELECT 'Project Management System', 'Enterprise project management and collaboration tool', ARRAY['Read', 'Write', 'Admin'], id
FROM users WHERE username = 'admin'
ON CONFLICT (name) DO NOTHING;

INSERT INTO software (name, description, access_levels, created_by)
SELECT 'Financial Analytics Suite', 'Advanced financial reporting and analysis software', ARRAY['Read', 'Write', 'Admin'], id
FROM users WHERE username = 'admin'
ON CONFLICT (name) DO NOTHING;

INSERT INTO software (name, description, access_levels, created_by)
SELECT 'HR Management System', 'Employee management and payroll processing system', ARRAY['Read', 'Write', 'Admin'], id
FROM users WHERE username = 'admin'
ON CONFLICT (name) DO NOTHING;

INSERT INTO software (name, description, access_levels, created_by)
SELECT 'Customer Support Portal', 'Ticketing and customer service management system', ARRAY['Read', 'Write', 'Admin'], id
FROM users WHERE username = 'admin'
ON CONFLICT (name) DO NOTHING;

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
DROP TRIGGER IF EXISTS update_users_updated_at ON users;
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_software_updated_at ON software;
CREATE TRIGGER update_software_updated_at
    BEFORE UPDATE ON software
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_requests_updated_at ON requests;
CREATE TRIGGER update_requests_updated_at
    BEFORE UPDATE ON requests
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
