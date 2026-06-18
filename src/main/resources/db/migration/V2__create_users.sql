CREATE TABLE users (
                       id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                       email         VARCHAR(255) NOT NULL UNIQUE,
                       username      VARCHAR(100) NOT NULL UNIQUE,
                       password_hash VARCHAR(255) NOT NULL,
                       role          VARCHAR(20)  NOT NULL DEFAULT 'AUTHOR',
                       created_at    TIMESTAMP    NOT NULL DEFAULT now(),
                       updated_at    TIMESTAMP    NOT NULL DEFAULT now()
);