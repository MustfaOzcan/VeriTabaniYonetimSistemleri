--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: kalori_toplam(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kalori_toplam() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
toplam INTEGER;
BEGIN 
toplam:=(SELECT SUM("yemek_kalori")FROM "tbl_yemek");
RETURN toplam;
END;
$$;


ALTER FUNCTION public.kalori_toplam() OWNER TO postgres;

--
-- Name: makskalori(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.makskalori() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
MAKS INTEGER;
BEGIN 
MAKS:=(SELECT MAX("yemek_kalori")FROM "tbl_yemek");
RETURN MAKS;
END;
$$;


ALTER FUNCTION public.makskalori() OWNER TO postgres;

--
-- Name: silinenyemek(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.silinenyemek() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
INSERT INTO tbl_silinenyemek (yemek_id_s,yemek_ad_s)
VALUES(OLD.yemek_id,OLD.yemek_ad);
RETURN NEW;
END;
$$;


ALTER FUNCTION public.silinenyemek() OWNER TO postgres;

--
-- Name: toplamyemek(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplamyemek() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE tbl_toplam_yemek set sayi=sayi+1;
return new;
end;
$$;


ALTER FUNCTION public.toplamyemek() OWNER TO postgres;

--
-- Name: toplamyemek2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toplamyemek2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
UPDATE tbl_toplam_yemek set sayi=sayi-1;
return new;
end;
$$;


ALTER FUNCTION public.toplamyemek2() OWNER TO postgres;

--
-- Name: yemek_sayisi(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yemek_sayisi() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
total INTEGER;
BEGIN 
SELECT COUNT(*) INTO total FROM "tbl_yemek";
RETURN total;
END;
$$;


ALTER FUNCTION public.yemek_sayisi() OWNER TO postgres;

--
-- Name: yemekbul(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yemekbul(yemekid integer) RETURNS TABLE(id integer, adi character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY SELECT "yemek_id", "yemek_ad" FROM tbl_yemek
    WHERE "yemek_id" = yemekid;
END;
$$;


ALTER FUNCTION public.yemekbul(yemekid integer) OWNER TO postgres;

--
-- Name: yemekguncel(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yemekguncel() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."yemek_fiyat" <> OLD."yemek_fiyat" THEN
        INSERT INTO "tbl_urunson"("urunNo", "eskifiyat", "yenifiyat")
        VALUES(OLD."yemek_id", OLD."yemek_fiyat", NEW."yemek_fiyat");
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.yemekguncel() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: kurye_tbl; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kurye_tbl (
    "Insan_id" integer NOT NULL,
    siparis_id integer NOT NULL,
    musteri_id integer NOT NULL,
    yemek_id integer NOT NULL,
    temsilci_id integer NOT NULL
);


ALTER TABLE public.kurye_tbl OWNER TO postgres;

--
-- Name: kurye_tbl_Insan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."kurye_tbl_Insan_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."kurye_tbl_Insan_id_seq" OWNER TO postgres;

--
-- Name: kurye_tbl_Insan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."kurye_tbl_Insan_id_seq" OWNED BY public.kurye_tbl."Insan_id";


--
-- Name: tbl_insan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_insan (
    insan_id integer NOT NULL,
    insan_ad character varying NOT NULL,
    insan_soyad character varying NOT NULL,
    insan_tel character varying NOT NULL,
    insan_tur character varying NOT NULL
);


ALTER TABLE public.tbl_insan OWNER TO postgres;

--
-- Name: tbl_Insan_Insan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."tbl_Insan_Insan_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."tbl_Insan_Insan_id_seq" OWNER TO postgres;

--
-- Name: tbl_Insan_Insan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."tbl_Insan_Insan_id_seq" OWNED BY public.tbl_insan.insan_id;


--
-- Name: tbl_MalzemeYemek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tbl_MalzemeYemek" (
    malzeme_id integer NOT NULL,
    yemek_id integer NOT NULL
);


ALTER TABLE public."tbl_MalzemeYemek" OWNER TO postgres;

--
-- Name: tbl_YemekSiparis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."tbl_YemekSiparis" (
    siparis_id integer NOT NULL,
    yemek_id integer NOT NULL
);


ALTER TABLE public."tbl_YemekSiparis" OWNER TO postgres;

--
-- Name: tbl_YemekSiparis_siparis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."tbl_YemekSiparis_siparis_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."tbl_YemekSiparis_siparis_id_seq" OWNER TO postgres;

--
-- Name: tbl_YemekSiparis_siparis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."tbl_YemekSiparis_siparis_id_seq" OWNED BY public."tbl_YemekSiparis".siparis_id;


--
-- Name: tbl_YemekSiparis_yemek_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."tbl_YemekSiparis_yemek_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."tbl_YemekSiparis_yemek_id_seq" OWNER TO postgres;

--
-- Name: tbl_YemekSiparis_yemek_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."tbl_YemekSiparis_yemek_id_seq" OWNED BY public."tbl_YemekSiparis".yemek_id;


--
-- Name: tbl_fatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_fatura (
    fatura_id integer NOT NULL,
    fatura_tutar money NOT NULL,
    fatura_tarihi date NOT NULL
);


ALTER TABLE public.tbl_fatura OWNER TO postgres;

--
-- Name: tbl_fatura_fatura_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_fatura_fatura_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_fatura_fatura_id_seq OWNER TO postgres;

--
-- Name: tbl_fatura_fatura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_fatura_fatura_id_seq OWNED BY public.tbl_fatura.fatura_id;


--
-- Name: tbl_lokanta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_lokanta (
    lokanta_id integer NOT NULL,
    lokanta_ad character varying NOT NULL,
    lokanta_adres character varying NOT NULL,
    lokanta_tel character varying NOT NULL
);


ALTER TABLE public.tbl_lokanta OWNER TO postgres;

--
-- Name: tbl_lokanta_lokanta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_lokanta_lokanta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_lokanta_lokanta_id_seq OWNER TO postgres;

--
-- Name: tbl_lokanta_lokanta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_lokanta_lokanta_id_seq OWNED BY public.tbl_lokanta.lokanta_id;


--
-- Name: tbl_malzeme; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_malzeme (
    malzeme_id integer NOT NULL,
    tedarik_id integer NOT NULL,
    malzeme_adi integer NOT NULL,
    malzeme_stok integer NOT NULL,
    malzeme_fiyat money NOT NULL
);


ALTER TABLE public.tbl_malzeme OWNER TO postgres;

--
-- Name: tbl_malzeme_kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_malzeme_kategori (
    mal_kategori_id integer NOT NULL,
    malzeme_id integer NOT NULL,
    mal_kategori_ad character varying NOT NULL
);


ALTER TABLE public.tbl_malzeme_kategori OWNER TO postgres;

--
-- Name: tbl_malzeme_kategori_mal_kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_malzeme_kategori_mal_kategori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_malzeme_kategori_mal_kategori_id_seq OWNER TO postgres;

--
-- Name: tbl_malzeme_kategori_mal_kategori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_malzeme_kategori_mal_kategori_id_seq OWNED BY public.tbl_malzeme_kategori.mal_kategori_id;


--
-- Name: tbl_malzeme_malzeme_adi_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_malzeme_malzeme_adi_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_malzeme_malzeme_adi_seq OWNER TO postgres;

--
-- Name: tbl_malzeme_malzeme_adi_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_malzeme_malzeme_adi_seq OWNED BY public.tbl_malzeme.malzeme_adi;


--
-- Name: tbl_malzeme_malzeme_fiyat_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_malzeme_malzeme_fiyat_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_malzeme_malzeme_fiyat_seq OWNER TO postgres;

--
-- Name: tbl_malzeme_malzeme_fiyat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_malzeme_malzeme_fiyat_seq OWNED BY public.tbl_malzeme.malzeme_fiyat;


--
-- Name: tbl_malzeme_malzeme_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_malzeme_malzeme_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_malzeme_malzeme_id_seq OWNER TO postgres;

--
-- Name: tbl_malzeme_malzeme_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_malzeme_malzeme_id_seq OWNED BY public.tbl_malzeme.malzeme_id;


--
-- Name: tbl_malzeme_malzeme_stok_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_malzeme_malzeme_stok_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_malzeme_malzeme_stok_seq OWNER TO postgres;

--
-- Name: tbl_malzeme_malzeme_stok_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_malzeme_malzeme_stok_seq OWNED BY public.tbl_malzeme.malzeme_stok;


--
-- Name: tbl_malzeme_tedarik_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_malzeme_tedarik_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_malzeme_tedarik_id_seq OWNER TO postgres;

--
-- Name: tbl_malzeme_tedarik_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_malzeme_tedarik_id_seq OWNED BY public.tbl_malzeme.tedarik_id;


--
-- Name: tbl_musteri; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_musteri (
    "Insan_id" integer NOT NULL,
    temsilci_id integer NOT NULL,
    musteri_adres character varying NOT NULL
);


ALTER TABLE public.tbl_musteri OWNER TO postgres;

--
-- Name: tbl_musteri_Insan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."tbl_musteri_Insan_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."tbl_musteri_Insan_id_seq" OWNER TO postgres;

--
-- Name: tbl_musteri_Insan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."tbl_musteri_Insan_id_seq" OWNED BY public.tbl_musteri."Insan_id";


--
-- Name: tbl_musteri_temsilcisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_musteri_temsilcisi (
    "Insan_id" integer NOT NULL
);


ALTER TABLE public.tbl_musteri_temsilcisi OWNER TO postgres;

--
-- Name: tbl_musteri_temsilcisi_Insan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."tbl_musteri_temsilcisi_Insan_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."tbl_musteri_temsilcisi_Insan_id_seq" OWNER TO postgres;

--
-- Name: tbl_musteri_temsilcisi_Insan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."tbl_musteri_temsilcisi_Insan_id_seq" OWNED BY public.tbl_musteri_temsilcisi."Insan_id";


--
-- Name: tbl_personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_personel (
    "Insan_id" integer NOT NULL,
    lokanta_id integer NOT NULL
);


ALTER TABLE public.tbl_personel OWNER TO postgres;

--
-- Name: tbl_personel_Insan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."tbl_personel_Insan_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."tbl_personel_Insan_id_seq" OWNER TO postgres;

--
-- Name: tbl_personel_Insan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."tbl_personel_Insan_id_seq" OWNED BY public.tbl_personel."Insan_id";


--
-- Name: tbl_silinenyemek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_silinenyemek (
    kayit integer NOT NULL,
    yemek_id_s integer NOT NULL,
    yemek_ad_s text NOT NULL
);


ALTER TABLE public.tbl_silinenyemek OWNER TO postgres;

--
-- Name: tbl_silinenyemek_kayit_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_silinenyemek_kayit_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_silinenyemek_kayit_seq OWNER TO postgres;

--
-- Name: tbl_silinenyemek_kayit_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_silinenyemek_kayit_seq OWNED BY public.tbl_silinenyemek.kayit;


--
-- Name: tbl_siparis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_siparis (
    siparis_id integer NOT NULL,
    siparis_tarih date DEFAULT '2020-08-14'::date,
    musteri_id integer NOT NULL,
    fatura_id integer NOT NULL
);


ALTER TABLE public.tbl_siparis OWNER TO postgres;

--
-- Name: tbl_siparis_siparis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_siparis_siparis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_siparis_siparis_id_seq OWNER TO postgres;

--
-- Name: tbl_siparis_siparis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_siparis_siparis_id_seq OWNED BY public.tbl_siparis.siparis_id;


--
-- Name: tbl_tedarik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_tedarik (
    tedarik_id integer NOT NULL,
    tedarik_adi character varying NOT NULL,
    tedarikci_ad character varying NOT NULL,
    tedarikci_soyad character varying NOT NULL,
    tedarik_tarih date NOT NULL
);


ALTER TABLE public.tbl_tedarik OWNER TO postgres;

--
-- Name: tbl_tedarik_tedarik_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_tedarik_tedarik_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_tedarik_tedarik_id_seq OWNER TO postgres;

--
-- Name: tbl_tedarik_tedarik_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_tedarik_tedarik_id_seq OWNED BY public.tbl_tedarik.tedarik_id;


--
-- Name: tbl_toplam_yemek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_toplam_yemek (
    sayi integer NOT NULL
);


ALTER TABLE public.tbl_toplam_yemek OWNER TO postgres;

--
-- Name: tbl_urunson; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_urunson (
    "kayitNo" integer NOT NULL,
    "urunNo" smallint NOT NULL,
    eskifiyat money NOT NULL,
    yenifiyat money NOT NULL
);


ALTER TABLE public.tbl_urunson OWNER TO postgres;

--
-- Name: tbl_urunson_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."tbl_urunson_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."tbl_urunson_kayitNo_seq" OWNER TO postgres;

--
-- Name: tbl_urunson_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."tbl_urunson_kayitNo_seq" OWNED BY public.tbl_urunson."kayitNo";


--
-- Name: tbl_yemek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_yemek (
    yemek_id integer NOT NULL,
    lokanta_id integer NOT NULL,
    personel_id integer NOT NULL,
    yemek_ad character varying NOT NULL,
    yemek_fiyat money NOT NULL,
    yemek_stok integer NOT NULL,
    yemek_kalori integer
);


ALTER TABLE public.tbl_yemek OWNER TO postgres;

--
-- Name: tbl_yemek_kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_yemek_kategori (
    kategori_id integer NOT NULL,
    yemek_id integer NOT NULL,
    kategori_adi character varying NOT NULL
);


ALTER TABLE public.tbl_yemek_kategori OWNER TO postgres;

--
-- Name: tbl_yemek_kategori_kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_yemek_kategori_kategori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_yemek_kategori_kategori_id_seq OWNER TO postgres;

--
-- Name: tbl_yemek_kategori_kategori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_yemek_kategori_kategori_id_seq OWNED BY public.tbl_yemek_kategori.kategori_id;


--
-- Name: tbl_yemek_yemek_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tbl_yemek_yemek_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tbl_yemek_yemek_id_seq OWNER TO postgres;

--
-- Name: tbl_yemek_yemek_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tbl_yemek_yemek_id_seq OWNED BY public.tbl_yemek.yemek_id;


--
-- Name: kurye_tbl Insan_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurye_tbl ALTER COLUMN "Insan_id" SET DEFAULT nextval('public."kurye_tbl_Insan_id_seq"'::regclass);


--
-- Name: tbl_YemekSiparis siparis_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tbl_YemekSiparis" ALTER COLUMN siparis_id SET DEFAULT nextval('public."tbl_YemekSiparis_siparis_id_seq"'::regclass);


--
-- Name: tbl_YemekSiparis yemek_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tbl_YemekSiparis" ALTER COLUMN yemek_id SET DEFAULT nextval('public."tbl_YemekSiparis_yemek_id_seq"'::regclass);


--
-- Name: tbl_fatura fatura_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_fatura ALTER COLUMN fatura_id SET DEFAULT nextval('public.tbl_fatura_fatura_id_seq'::regclass);


--
-- Name: tbl_insan insan_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_insan ALTER COLUMN insan_id SET DEFAULT nextval('public."tbl_Insan_Insan_id_seq"'::regclass);


--
-- Name: tbl_lokanta lokanta_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_lokanta ALTER COLUMN lokanta_id SET DEFAULT nextval('public.tbl_lokanta_lokanta_id_seq'::regclass);


--
-- Name: tbl_malzeme malzeme_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_malzeme ALTER COLUMN malzeme_id SET DEFAULT nextval('public.tbl_malzeme_malzeme_id_seq'::regclass);


--
-- Name: tbl_malzeme tedarik_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_malzeme ALTER COLUMN tedarik_id SET DEFAULT nextval('public.tbl_malzeme_tedarik_id_seq'::regclass);


--
-- Name: tbl_malzeme malzeme_adi; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_malzeme ALTER COLUMN malzeme_adi SET DEFAULT nextval('public.tbl_malzeme_malzeme_adi_seq'::regclass);


--
-- Name: tbl_malzeme malzeme_stok; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_malzeme ALTER COLUMN malzeme_stok SET DEFAULT nextval('public.tbl_malzeme_malzeme_stok_seq'::regclass);


--
-- Name: tbl_malzeme malzeme_fiyat; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_malzeme ALTER COLUMN malzeme_fiyat SET DEFAULT nextval('public.tbl_malzeme_malzeme_fiyat_seq'::regclass);


--
-- Name: tbl_malzeme_kategori mal_kategori_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_malzeme_kategori ALTER COLUMN mal_kategori_id SET DEFAULT nextval('public.tbl_malzeme_kategori_mal_kategori_id_seq'::regclass);


--
-- Name: tbl_musteri Insan_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_musteri ALTER COLUMN "Insan_id" SET DEFAULT nextval('public."tbl_musteri_Insan_id_seq"'::regclass);


--
-- Name: tbl_musteri_temsilcisi Insan_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_musteri_temsilcisi ALTER COLUMN "Insan_id" SET DEFAULT nextval('public."tbl_musteri_temsilcisi_Insan_id_seq"'::regclass);


--
-- Name: tbl_personel Insan_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_personel ALTER COLUMN "Insan_id" SET DEFAULT nextval('public."tbl_personel_Insan_id_seq"'::regclass);


--
-- Name: tbl_silinenyemek kayit; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_silinenyemek ALTER COLUMN kayit SET DEFAULT nextval('public.tbl_silinenyemek_kayit_seq'::regclass);


--
-- Name: tbl_siparis siparis_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_siparis ALTER COLUMN siparis_id SET DEFAULT nextval('public.tbl_siparis_siparis_id_seq'::regclass);


--
-- Name: tbl_tedarik tedarik_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_tedarik ALTER COLUMN tedarik_id SET DEFAULT nextval('public.tbl_tedarik_tedarik_id_seq'::regclass);


--
-- Name: tbl_urunson kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_urunson ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."tbl_urunson_kayitNo_seq"'::regclass);


--
-- Name: tbl_yemek yemek_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_yemek ALTER COLUMN yemek_id SET DEFAULT nextval('public.tbl_yemek_yemek_id_seq'::regclass);


--
-- Name: tbl_yemek_kategori kategori_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_yemek_kategori ALTER COLUMN kategori_id SET DEFAULT nextval('public.tbl_yemek_kategori_kategori_id_seq'::regclass);


--
-- Data for Name: kurye_tbl; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.kurye_tbl VALUES
	(4, 1, 2, 7, 3),
	(4, 2, 2, 6, 3);


--
-- Data for Name: tbl_MalzemeYemek; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tbl_YemekSiparis; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tbl_fatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_fatura VALUES
	(1, '?70,00', '2022-07-10'),
	(2, '?104,00', '2022-07-11'),
	(3, '?40,00', '2022-07-12'),
	(4, '?60,00', '2022-07-13'),
	(5, '?69,00', '2022-07-14');


--
-- Data for Name: tbl_insan; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_insan VALUES
	(1, 'mustafa', 'ozcan', '05452546839', 'Personel'),
	(2, 'yahya', 'haliloglu', '05156565123', 'Müşteri'),
	(3, 'hatice', 'turan', '21565165131', 'Müşteri Temsilci'),
	(4, 'yunus ', 'emre', '51256161561', 'Kurye'),
	(5, 'hayriye', 'ozcan', '05465513131', 'Personel'),
	(6, 'alperen', 'cetinkaya', '05651321456', 'Personel');


--
-- Data for Name: tbl_lokanta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_lokanta VALUES
	(1, 'ozcanlar', 'merkez/osmaniye', '3283232'),
	(2, 'cetinkaya', 'adana/merkez', '3565487');


--
-- Data for Name: tbl_malzeme; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tbl_malzeme_kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tbl_musteri; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_musteri VALUES
	(2, 3, 'sakarya');


--
-- Data for Name: tbl_musteri_temsilcisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_musteri_temsilcisi VALUES
	(3);


--
-- Data for Name: tbl_personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_personel VALUES
	(1, 1),
	(5, 1),
	(6, 2);


--
-- Data for Name: tbl_silinenyemek; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_silinenyemek VALUES
	(1, 11, 'künefe'),
	(2, 11, 'cezerye'),
	(3, 11, 'CİKKOLATA'),
	(4, 10, 'DONDURMA'),
	(5, 11, 'KAVUN');


--
-- Data for Name: tbl_siparis; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_siparis VALUES
	(1, '2022-07-10', 2, 1),
	(2, '2022-07-11', 2, 2),
	(3, '2022-07-12', 2, 3),
	(4, '2022-07-13', 2, 4),
	(5, '2022-07-14', 2, 5);


--
-- Data for Name: tbl_tedarik; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tbl_toplam_yemek; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_toplam_yemek VALUES
	(10);


--
-- Data for Name: tbl_urunson; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_urunson VALUES
	(1, 10, '?550,00', '?330,00'),
	(2, 10, '?330,00', '?60,00'),
	(3, 10, '?60,00', '?150,00'),
	(4, 11, '?300,00', '?500,00'),
	(5, 11, '?500,00', '?250,00'),
	(8, 11, '?150,00', '?300,00'),
	(9, 10, '?150,00', '?300,00');


--
-- Data for Name: tbl_yemek; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_yemek VALUES
	(1, 1, 1, 'hamburger', '?120,00', 65, 300),
	(2, 1, 1, 'pizza', '?78,00', 45, 700),
	(4, 1, 1, 'ayran', '?36,00', 89, 250),
	(6, 1, 1, 'köfte', '?80,00', 72, 360),
	(3, 1, 5, 'şalgam', '?34,00', 36, 400),
	(5, 1, 5, 'pide', '?75,00', 58, 630),
	(7, 2, 6, 'pasta', '?90,00', 54, 740),
	(8, 2, 6, 'milkshake', '?60,00', 40, 750),
	(9, 2, 6, 'meyveli yoğurt', '?50,00', 60, 64),
	(10, 1, 1, 'DONDURMA', '?300,00', 36, 300);


--
-- Data for Name: tbl_yemek_kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: kurye_tbl_Insan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."kurye_tbl_Insan_id_seq"', 2, true);


--
-- Name: tbl_Insan_Insan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."tbl_Insan_Insan_id_seq"', 4, true);


--
-- Name: tbl_YemekSiparis_siparis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."tbl_YemekSiparis_siparis_id_seq"', 1, false);


--
-- Name: tbl_YemekSiparis_yemek_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."tbl_YemekSiparis_yemek_id_seq"', 1, false);


--
-- Name: tbl_fatura_fatura_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_fatura_fatura_id_seq', 7, true);


--
-- Name: tbl_lokanta_lokanta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_lokanta_lokanta_id_seq', 17, true);


--
-- Name: tbl_malzeme_kategori_mal_kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_malzeme_kategori_mal_kategori_id_seq', 1, false);


--
-- Name: tbl_malzeme_malzeme_adi_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_malzeme_malzeme_adi_seq', 1, false);


--
-- Name: tbl_malzeme_malzeme_fiyat_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_malzeme_malzeme_fiyat_seq', 1, false);


--
-- Name: tbl_malzeme_malzeme_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_malzeme_malzeme_id_seq', 1, false);


--
-- Name: tbl_malzeme_malzeme_stok_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_malzeme_malzeme_stok_seq', 1, false);


--
-- Name: tbl_malzeme_tedarik_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_malzeme_tedarik_id_seq', 1, false);


--
-- Name: tbl_musteri_Insan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."tbl_musteri_Insan_id_seq"', 2, true);


--
-- Name: tbl_musteri_temsilcisi_Insan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."tbl_musteri_temsilcisi_Insan_id_seq"', 1, false);


--
-- Name: tbl_personel_Insan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."tbl_personel_Insan_id_seq"', 8, true);


--
-- Name: tbl_silinenyemek_kayit_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_silinenyemek_kayit_seq', 5, true);


--
-- Name: tbl_siparis_siparis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_siparis_siparis_id_seq', 9, true);


--
-- Name: tbl_tedarik_tedarik_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_tedarik_tedarik_id_seq', 1, false);


--
-- Name: tbl_urunson_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."tbl_urunson_kayitNo_seq"', 9, true);


--
-- Name: tbl_yemek_kategori_kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_yemek_kategori_kategori_id_seq', 1, false);


--
-- Name: tbl_yemek_yemek_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tbl_yemek_yemek_id_seq', 13, true);


--
-- Name: tbl_urunson PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_urunson
    ADD CONSTRAINT "PK" PRIMARY KEY ("kayitNo");


--
-- Name: tbl_silinenyemek PKayit; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_silinenyemek
    ADD CONSTRAINT "PKayit" PRIMARY KEY (kayit);


--
-- Name: tbl_insan tbl_Insan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_insan
    ADD CONSTRAINT "tbl_Insan_pkey" PRIMARY KEY (insan_id);


--
-- Name: tbl_MalzemeYemek tbl_MalzemeYemek_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tbl_MalzemeYemek"
    ADD CONSTRAINT "tbl_MalzemeYemek_pkey" PRIMARY KEY (malzeme_id, yemek_id);


--
-- Name: tbl_YemekSiparis tbl_YemekSiparis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tbl_YemekSiparis"
    ADD CONSTRAINT "tbl_YemekSiparis_pkey" PRIMARY KEY (yemek_id, siparis_id);


--
-- Name: tbl_fatura tbl_fatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_fatura
    ADD CONSTRAINT tbl_fatura_pkey PRIMARY KEY (fatura_id);


--
-- Name: tbl_lokanta tbl_lokanta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_lokanta
    ADD CONSTRAINT tbl_lokanta_pkey PRIMARY KEY (lokanta_id);


--
-- Name: tbl_malzeme_kategori tbl_malzeme_kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_malzeme_kategori
    ADD CONSTRAINT tbl_malzeme_kategori_pkey PRIMARY KEY (mal_kategori_id);


--
-- Name: tbl_malzeme tbl_malzeme_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_malzeme
    ADD CONSTRAINT tbl_malzeme_pkey PRIMARY KEY (malzeme_id);


--
-- Name: tbl_musteri tbl_musteri_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_musteri
    ADD CONSTRAINT tbl_musteri_pkey PRIMARY KEY ("Insan_id");


--
-- Name: tbl_musteri_temsilcisi tbl_musteri_temsilcisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_musteri_temsilcisi
    ADD CONSTRAINT tbl_musteri_temsilcisi_pkey PRIMARY KEY ("Insan_id");


--
-- Name: tbl_personel tbl_personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_personel
    ADD CONSTRAINT tbl_personel_pkey PRIMARY KEY ("Insan_id");


--
-- Name: tbl_siparis tbl_siparis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_siparis
    ADD CONSTRAINT tbl_siparis_pkey PRIMARY KEY (siparis_id);


--
-- Name: tbl_tedarik tbl_tedarik_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_tedarik
    ADD CONSTRAINT tbl_tedarik_pkey PRIMARY KEY (tedarik_id);


--
-- Name: tbl_toplam_yemek tbl_toplam_yemek_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_toplam_yemek
    ADD CONSTRAINT tbl_toplam_yemek_pkey PRIMARY KEY (sayi);


--
-- Name: tbl_yemek_kategori tbl_yemek_kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_yemek_kategori
    ADD CONSTRAINT tbl_yemek_kategori_pkey PRIMARY KEY (kategori_id);


--
-- Name: tbl_yemek tbl_yemek_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_yemek
    ADD CONSTRAINT tbl_yemek_pkey PRIMARY KEY (yemek_id);


--
-- Name: fki_fk_Insan_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_fk_Insan_id" ON public.kurye_tbl USING btree ("Insan_id");


--
-- Name: fki_fk_fatura_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_fatura_id ON public.tbl_siparis USING btree (fatura_id);


--
-- Name: fki_fk_insan_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_insan_id ON public.tbl_musteri USING btree ("Insan_id");


--
-- Name: fki_fk_lokanta_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_lokanta_id ON public.tbl_yemek USING btree (lokanta_id);


--
-- Name: fki_fk_malzeme_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_malzeme_id ON public."tbl_MalzemeYemek" USING btree (malzeme_id);


--
-- Name: fki_fk_musteri_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_musteri_id ON public.kurye_tbl USING btree (musteri_id);


--
-- Name: fki_fk_personel_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_personel_id ON public.tbl_yemek USING btree (personel_id);


--
-- Name: fki_fk_siparis; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_siparis ON public.kurye_tbl USING btree (siparis_id);


--
-- Name: fki_fk_siparis_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_siparis_id ON public."tbl_YemekSiparis" USING btree (siparis_id);


--
-- Name: fki_fk_tedarik_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_tedarik_id ON public.tbl_malzeme USING btree (tedarik_id);


--
-- Name: fki_fk_temsilci_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_temsilci_id ON public.kurye_tbl USING btree (temsilci_id);


--
-- Name: fki_fk_yemek_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_fk_yemek_id ON public.kurye_tbl USING btree (yemek_id);


--
-- Name: fki_t; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_t ON public."tbl_YemekSiparis" USING btree (yemek_id);


--
-- Name: tbl_yemek silinenyemek; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER silinenyemek AFTER DELETE ON public.tbl_yemek FOR EACH ROW EXECUTE FUNCTION public.silinenyemek();


--
-- Name: tbl_yemek toplamyemektrigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER toplamyemektrigger AFTER INSERT ON public.tbl_yemek FOR EACH ROW EXECUTE FUNCTION public.toplamyemek();


--
-- Name: tbl_yemek toplamyemektrigger2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER toplamyemektrigger2 AFTER DELETE ON public.tbl_yemek FOR EACH ROW EXECUTE FUNCTION public.toplamyemek2();


--
-- Name: tbl_yemek yemekfiyatdegisim; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER yemekfiyatdegisim BEFORE UPDATE ON public.tbl_yemek FOR EACH ROW EXECUTE FUNCTION public.yemekguncel();


--
-- Name: kurye_tbl fk_Insan_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurye_tbl
    ADD CONSTRAINT "fk_Insan_id" FOREIGN KEY ("Insan_id") REFERENCES public.tbl_insan(insan_id);


--
-- Name: tbl_siparis fk_fatura_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_siparis
    ADD CONSTRAINT fk_fatura_id FOREIGN KEY (fatura_id) REFERENCES public.tbl_fatura(fatura_id);


--
-- Name: tbl_musteri fk_insan_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_musteri
    ADD CONSTRAINT fk_insan_id FOREIGN KEY ("Insan_id") REFERENCES public.tbl_insan(insan_id);


--
-- Name: tbl_musteri_temsilcisi fk_insan_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_musteri_temsilcisi
    ADD CONSTRAINT fk_insan_id FOREIGN KEY ("Insan_id") REFERENCES public.tbl_insan(insan_id);


--
-- Name: tbl_personel fk_insan_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_personel
    ADD CONSTRAINT fk_insan_id FOREIGN KEY ("Insan_id") REFERENCES public.tbl_insan(insan_id);


--
-- Name: tbl_yemek fk_lokanta_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_yemek
    ADD CONSTRAINT fk_lokanta_id FOREIGN KEY (lokanta_id) REFERENCES public.tbl_lokanta(lokanta_id);


--
-- Name: tbl_MalzemeYemek fk_malzeme_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tbl_MalzemeYemek"
    ADD CONSTRAINT fk_malzeme_id FOREIGN KEY (malzeme_id) REFERENCES public.tbl_malzeme(malzeme_id);


--
-- Name: tbl_malzeme_kategori fk_malzeme_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_malzeme_kategori
    ADD CONSTRAINT fk_malzeme_id FOREIGN KEY (malzeme_id) REFERENCES public.tbl_malzeme(malzeme_id);


--
-- Name: kurye_tbl fk_musteri_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurye_tbl
    ADD CONSTRAINT fk_musteri_id FOREIGN KEY (musteri_id) REFERENCES public.tbl_musteri("Insan_id");


--
-- Name: tbl_siparis fk_musteri_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_siparis
    ADD CONSTRAINT fk_musteri_id FOREIGN KEY (musteri_id) REFERENCES public.tbl_musteri("Insan_id");


--
-- Name: tbl_yemek fk_personel_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_yemek
    ADD CONSTRAINT fk_personel_id FOREIGN KEY (personel_id) REFERENCES public.tbl_personel("Insan_id");


--
-- Name: kurye_tbl fk_siparis; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurye_tbl
    ADD CONSTRAINT fk_siparis FOREIGN KEY (siparis_id) REFERENCES public.tbl_siparis(siparis_id);


--
-- Name: tbl_YemekSiparis fk_siparis_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tbl_YemekSiparis"
    ADD CONSTRAINT fk_siparis_id FOREIGN KEY (siparis_id) REFERENCES public.tbl_siparis(siparis_id);


--
-- Name: tbl_malzeme fk_tedarik_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_malzeme
    ADD CONSTRAINT fk_tedarik_id FOREIGN KEY (tedarik_id) REFERENCES public.tbl_tedarik(tedarik_id);


--
-- Name: kurye_tbl fk_temsilci_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurye_tbl
    ADD CONSTRAINT fk_temsilci_id FOREIGN KEY (temsilci_id) REFERENCES public.tbl_musteri_temsilcisi("Insan_id");


--
-- Name: tbl_musteri fk_temsilci_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_musteri
    ADD CONSTRAINT fk_temsilci_id FOREIGN KEY (temsilci_id) REFERENCES public.tbl_musteri_temsilcisi("Insan_id");


--
-- Name: kurye_tbl fk_yemek_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kurye_tbl
    ADD CONSTRAINT fk_yemek_id FOREIGN KEY (yemek_id) REFERENCES public.tbl_yemek(yemek_id);


--
-- Name: tbl_MalzemeYemek fk_yemek_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tbl_MalzemeYemek"
    ADD CONSTRAINT fk_yemek_id FOREIGN KEY (yemek_id) REFERENCES public.tbl_yemek(yemek_id);


--
-- Name: tbl_YemekSiparis fk_yemek_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."tbl_YemekSiparis"
    ADD CONSTRAINT fk_yemek_id FOREIGN KEY (yemek_id) REFERENCES public.tbl_yemek(yemek_id);


--
-- Name: tbl_yemek_kategori fk_yemek_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_yemek_kategori
    ADD CONSTRAINT fk_yemek_id FOREIGN KEY (yemek_id) REFERENCES public.tbl_yemek(yemek_id);


--
-- PostgreSQL database dump complete
--

