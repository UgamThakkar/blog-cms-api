CREATE TABLE tags (
                      id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                      name       VARCHAR(50) NOT NULL UNIQUE,
                      slug       VARCHAR(50) NOT NULL UNIQUE,
                      created_at TIMESTAMP   NOT NULL DEFAULT now()
);

CREATE TABLE post_tags (
                           post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
                           tag_id  UUID NOT NULL REFERENCES tags(id)  ON DELETE CASCADE,
                           PRIMARY KEY (post_id, tag_id)
);