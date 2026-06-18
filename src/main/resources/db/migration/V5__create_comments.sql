CREATE TABLE comments (
                          id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                          content    TEXT      NOT NULL,
                          user_id    UUID      NOT NULL REFERENCES users(id)  ON DELETE CASCADE,
                          post_id    UUID      NOT NULL REFERENCES posts(id)  ON DELETE CASCADE,
                          created_at TIMESTAMP NOT NULL DEFAULT now(),
                          updated_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE INDEX idx_comments_post ON comments(post_id);
CREATE INDEX idx_comments_user ON comments(user_id);