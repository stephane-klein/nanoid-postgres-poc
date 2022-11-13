\i generate_nanoid.sql

DROP TABLE IF EXISTS public.users;
CREATE TABLE IF NOT EXISTS public.users (
    id                 NANOID PRIMARY KEY DEFAULT NULL,
    username           VARCHAR DEFAULT NULL UNIQUE,
    email              VARCHAR DEFAULT NULL,
    password_hash      VARCHAR DEFAULT NULL,

    created_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at         TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT id_unique UNIQUE (id)
);

DROP TRIGGER IF EXISTS trigger_users_genid ON public.users;
CREATE TRIGGER trigger_users_genid
    BEFORE INSERT ON public.users
    FOR EACH ROW EXECUTE PROCEDURE nanoid_generate();
