--
-- PostgreSQL database dump
--

\restrict B7XcYvV43ns4lrqFlSrHnMjvWcjqgm6KPYljhDp7wNpFezQd5ATUG3ZFuhGavah

-- Dumped from database version 18.6 (Debian 18.6-1.pgdg13+2)
-- Dumped by pg_dump version 18.6 (Debian 18.6-1.pgdg12+2)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: personas; Type: TABLE; Schema: public; Owner: ashley
--

CREATE TABLE public.personas (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    edad integer
);


ALTER TABLE public.personas OWNER TO ashley;

--
-- Name: personas_id_seq; Type: SEQUENCE; Schema: public; Owner: ashley
--

ALTER TABLE public.personas ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.personas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: personas; Type: TABLE DATA; Schema: public; Owner: ashley
--

COPY public.personas (id, nombre, edad) FROM stdin;
1	Juan Pérez	30
2	María López	25
3	Carlos Gómez	40
\.


--
-- Name: personas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ashley
--

SELECT pg_catalog.setval('public.personas_id_seq', 3, true);


--
-- Name: personas personas_pkey; Type: CONSTRAINT; Schema: public; Owner: ashley
--

ALTER TABLE ONLY public.personas
    ADD CONSTRAINT personas_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

\unrestrict B7XcYvV43ns4lrqFlSrHnMjvWcjqgm6KPYljhDp7wNpFezQd5ATUG3ZFuhGavah

