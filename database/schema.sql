--
-- PostgreSQL database dump
--

\restrict UnpQ9Mf1p83BlVmMN032lpbbcVPPjDOfJNte7QmzoFJ0eskfKSDbJojehdbA4XT

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-07-03 18:06:02

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 869 (class 1247 OID 17954)
-- Name: Estado; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Estado" AS ENUM (
    'pendiente',
    'confirmada',
    'cancelada'
);


ALTER TYPE public."Estado" OWNER TO postgres;

--
-- TOC entry 866 (class 1247 OID 17949)
-- Name: Rol; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Rol" AS ENUM (
    'cliente',
    'admin'
);


ALTER TYPE public."Rol" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 17865)
-- Name: mesas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mesas (
    id integer NOT NULL,
    numero integer NOT NULL,
    capacidad integer NOT NULL,
    disponible boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.mesas OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17864)
-- Name: mesas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mesas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mesas_id_seq OWNER TO postgres;

--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 221
-- Name: mesas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mesas_id_seq OWNED BY public.mesas.id;


--
-- TOC entry 224 (class 1259 OID 17879)
-- Name: reservaciones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservaciones (
    id integer NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    personas integer NOT NULL,
    estado public."Estado" DEFAULT 'pendiente'::public."Estado" NOT NULL,
    usuario_id integer NOT NULL,
    mesa_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT reservaciones_estado_check CHECK (((estado)::text = ANY (ARRAY[('pendiente'::character varying)::text, ('confirmada'::character varying)::text, ('cancelada'::character varying)::text])))
);


ALTER TABLE public.reservaciones OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17878)
-- Name: reservaciones_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservaciones_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservaciones_id_seq OWNER TO postgres;

--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 223
-- Name: reservaciones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservaciones_id_seq OWNED BY public.reservaciones.id;


--
-- TOC entry 220 (class 1259 OID 17848)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    correo character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    rol public."Rol" DEFAULT 'cliente'::public."Rol" NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    CONSTRAINT usuarios_rol_check CHECK (((rol)::text = ANY (ARRAY[('cliente'::character varying)::text, ('admin'::character varying)::text])))
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17847)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- TOC entry 4875 (class 2604 OID 17868)
-- Name: mesas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesas ALTER COLUMN id SET DEFAULT nextval('public.mesas_id_seq'::regclass);


--
-- TOC entry 4878 (class 2604 OID 17882)
-- Name: reservaciones id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservaciones ALTER COLUMN id SET DEFAULT nextval('public.reservaciones_id_seq'::regclass);


--
-- TOC entry 4872 (class 2604 OID 17851)
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- TOC entry 5045 (class 0 OID 17865)
-- Dependencies: 222
-- Data for Name: mesas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mesas (id, numero, capacidad, disponible, created_at) FROM stdin;
3	3	6	f	2026-06-24 18:45:26.738028
4	18	6	t	2026-06-30 00:49:09.219
2	2	10	t	2026-06-24 18:45:26.738028
1	1	2	f	2026-06-24 18:45:26.738028
\.


--
-- TOC entry 5047 (class 0 OID 17879)
-- Dependencies: 224
-- Data for Name: reservaciones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservaciones (id, fecha, hora, personas, estado, usuario_id, mesa_id, created_at) FROM stdin;
1	2026-06-25	12:00:00	2	confirmada	2	1	2026-06-24 18:45:26.738028
2	2026-06-25	14:00:00	4	pendiente	3	2	2026-06-24 18:45:26.738028
3	2026-06-26	19:00:00	5	pendiente	2	3	2026-06-24 18:45:26.738028
\.


--
-- TOC entry 5043 (class 0 OID 17848)
-- Dependencies: 220
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nombre, correo, password, rol, created_at) FROM stdin;
1	Carlos Mendoza	carlos@email.com	123456	admin	2026-06-24 18:45:26.738028
2	Ana García	ana@email.com	123456	cliente	2026-06-24 18:45:26.738028
3	Luis Pérez	luis@email.com	123456	cliente	2026-06-24 18:45:26.738028
4	Kenia Paiz	kenia.paiz@gmail.com	$2b$10$Ipt/gY7CB3dgP.q3dfbQ8OKmlnDvIqCLX/zHf.V5i35GWEUowUGgS	cliente	2026-06-30 01:42:53.333
5	David Barahona	david.barahona@gmail.com	$2b$10$HAOC59JOxjOQIYViL69i/uPoIqVEDIIq4WYcYgYbiY4gGqmc3eSgu	cliente	2026-07-02 00:50:42.914
\.


--
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 221
-- Name: mesas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mesas_id_seq', 4, true);


--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 223
-- Name: reservaciones_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservaciones_id_seq', 3, true);


--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 5, true);


--
-- TOC entry 4888 (class 2606 OID 17877)
-- Name: mesas mesas_numero_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesas
    ADD CONSTRAINT mesas_numero_key UNIQUE (numero);


--
-- TOC entry 4890 (class 2606 OID 17875)
-- Name: mesas mesas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mesas
    ADD CONSTRAINT mesas_pkey PRIMARY KEY (id);


--
-- TOC entry 4892 (class 2606 OID 17894)
-- Name: reservaciones reservaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservaciones
    ADD CONSTRAINT reservaciones_pkey PRIMARY KEY (id);


--
-- TOC entry 4884 (class 2606 OID 17863)
-- Name: usuarios usuarios_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_correo_key UNIQUE (correo);


--
-- TOC entry 4886 (class 2606 OID 17861)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4893 (class 2606 OID 17900)
-- Name: reservaciones reservaciones_mesa_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservaciones
    ADD CONSTRAINT reservaciones_mesa_id_fkey FOREIGN KEY (mesa_id) REFERENCES public.mesas(id);


--
-- TOC entry 4894 (class 2606 OID 17895)
-- Name: reservaciones reservaciones_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservaciones
    ADD CONSTRAINT reservaciones_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


-- Completed on 2026-07-03 18:06:02

--
-- PostgreSQL database dump complete
--

\unrestrict UnpQ9Mf1p83BlVmMN032lpbbcVPPjDOfJNte7QmzoFJ0eskfKSDbJojehdbA4XT

