\i nanoid.sql
-- Inspiration come from https://github.com/turbo/pg-shortkey/blob/master/pg-shortkey.sql

-- can't query pg_type because type might exist in other schemas
-- no IF NOT EXISTS for CREATE DOMAIN, need to catch exception
DO $$ BEGIN
    CREATE DOMAIN NANOID as VARCHAR(40);
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

CREATE OR REPLACE FUNCTION nanoid_generate()
RETURNS TRIGGER AS $$
DECLARE
    qry TEXT;
    found TEXT;
BEGIN
    IF NEW.id IS NULL THEN
        qry := 'SELECT id FROM ' || quote_ident(TG_TABLE_NAME) || ' WHERE id=';

        LOOP
            NEW.id = nanoid();
            EXECUTE qry || quote_literal(NEW.id) INTO found;

            IF found IS NULL THEN
                EXIT;
            END IF;
        END LOOP;
    END IF;

    RETURN NEW;
END
$$ language 'plpgsql';
