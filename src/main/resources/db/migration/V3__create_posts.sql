CREATE TABLE posts (
                       id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                       title      VARCHAR(255) NOT NULL,
                       slug       VARCHAR(255) NOT NULL UNIQUE,
                       content    TEXT         NOT NULL,
                       status     VARCHAR(20)  NOT NULL DEFAULT 'DRAFT',
                       user_id    UUID         NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                       created_at TIMESTAMP    NOT NULL DEFAULT now(),
                       updated_at TIMESTAMP    NOT NULL DEFAULT now()
);

CREATE INDEX idx_posts_slug   ON posts(slug);
CREATE INDEX idx_posts_status ON posts(status);
CREATE INDEX idx_posts_user   ON posts(user_id);