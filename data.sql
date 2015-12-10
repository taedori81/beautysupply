--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: address_country; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE address_country (
    iso_3166_1_a2 character varying(2) NOT NULL,
    iso_3166_1_a3 character varying(3) NOT NULL,
    iso_3166_1_numeric character varying(3) NOT NULL,
    printable_name character varying(128) NOT NULL,
    name character varying(128) NOT NULL,
    display_order smallint NOT NULL,
    is_shipping_country boolean NOT NULL,
    CONSTRAINT address_country_display_order_check CHECK ((display_order >= 0))
);


ALTER TABLE public.address_country OWNER TO taedori;

--
-- Name: address_useraddress; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE address_useraddress (
    id integer NOT NULL,
    title character varying(64) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    line1 character varying(255) NOT NULL,
    line2 character varying(255) NOT NULL,
    line3 character varying(255) NOT NULL,
    line4 character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    postcode character varying(64) NOT NULL,
    search_text text NOT NULL,
    phone_number character varying(128) NOT NULL,
    notes text NOT NULL,
    is_default_for_shipping boolean NOT NULL,
    is_default_for_billing boolean NOT NULL,
    num_orders integer NOT NULL,
    hash character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    country_id character varying(2) NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT address_useraddress_num_orders_check CHECK ((num_orders >= 0))
);


ALTER TABLE public.address_useraddress OWNER TO taedori;

--
-- Name: address_useraddress_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE address_useraddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_useraddress_id_seq OWNER TO taedori;

--
-- Name: address_useraddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE address_useraddress_id_seq OWNED BY address_useraddress.id;


--
-- Name: analytics_productrecord; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE analytics_productrecord (
    id integer NOT NULL,
    num_views integer NOT NULL,
    num_basket_additions integer NOT NULL,
    num_purchases integer NOT NULL,
    score double precision NOT NULL,
    product_id integer NOT NULL,
    CONSTRAINT analytics_productrecord_num_basket_additions_check CHECK ((num_basket_additions >= 0)),
    CONSTRAINT analytics_productrecord_num_purchases_check CHECK ((num_purchases >= 0)),
    CONSTRAINT analytics_productrecord_num_views_check CHECK ((num_views >= 0))
);


ALTER TABLE public.analytics_productrecord OWNER TO taedori;

--
-- Name: analytics_productrecord_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE analytics_productrecord_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.analytics_productrecord_id_seq OWNER TO taedori;

--
-- Name: analytics_productrecord_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE analytics_productrecord_id_seq OWNED BY analytics_productrecord.id;


--
-- Name: analytics_userproductview; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE analytics_userproductview (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    product_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.analytics_userproductview OWNER TO taedori;

--
-- Name: analytics_userproductview_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE analytics_userproductview_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.analytics_userproductview_id_seq OWNER TO taedori;

--
-- Name: analytics_userproductview_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE analytics_userproductview_id_seq OWNED BY analytics_userproductview.id;


--
-- Name: analytics_userrecord; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE analytics_userrecord (
    id integer NOT NULL,
    num_product_views integer NOT NULL,
    num_basket_additions integer NOT NULL,
    num_orders integer NOT NULL,
    num_order_lines integer NOT NULL,
    num_order_items integer NOT NULL,
    total_spent numeric(12,2) NOT NULL,
    date_last_order timestamp with time zone,
    user_id integer NOT NULL,
    CONSTRAINT analytics_userrecord_num_basket_additions_check CHECK ((num_basket_additions >= 0)),
    CONSTRAINT analytics_userrecord_num_order_items_check CHECK ((num_order_items >= 0)),
    CONSTRAINT analytics_userrecord_num_order_lines_check CHECK ((num_order_lines >= 0)),
    CONSTRAINT analytics_userrecord_num_orders_check CHECK ((num_orders >= 0)),
    CONSTRAINT analytics_userrecord_num_product_views_check CHECK ((num_product_views >= 0))
);


ALTER TABLE public.analytics_userrecord OWNER TO taedori;

--
-- Name: analytics_userrecord_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE analytics_userrecord_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.analytics_userrecord_id_seq OWNER TO taedori;

--
-- Name: analytics_userrecord_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE analytics_userrecord_id_seq OWNED BY analytics_userrecord.id;


--
-- Name: analytics_usersearch; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE analytics_usersearch (
    id integer NOT NULL,
    query character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.analytics_usersearch OWNER TO taedori;

--
-- Name: analytics_usersearch_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE analytics_usersearch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.analytics_usersearch_id_seq OWNER TO taedori;

--
-- Name: analytics_usersearch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE analytics_usersearch_id_seq OWNED BY analytics_usersearch.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO taedori;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO taedori;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO taedori;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO taedori;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO taedori;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO taedori;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO taedori;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO taedori;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO taedori;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO taedori;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO taedori;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO taedori;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: basket_basket; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE basket_basket (
    id integer NOT NULL,
    status character varying(128) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_merged timestamp with time zone,
    date_submitted timestamp with time zone,
    owner_id integer
);


ALTER TABLE public.basket_basket OWNER TO taedori;

--
-- Name: basket_basket_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE basket_basket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basket_basket_id_seq OWNER TO taedori;

--
-- Name: basket_basket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE basket_basket_id_seq OWNED BY basket_basket.id;


--
-- Name: basket_basket_vouchers; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE basket_basket_vouchers (
    id integer NOT NULL,
    basket_id integer NOT NULL,
    voucher_id integer NOT NULL
);


ALTER TABLE public.basket_basket_vouchers OWNER TO taedori;

--
-- Name: basket_basket_vouchers_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE basket_basket_vouchers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basket_basket_vouchers_id_seq OWNER TO taedori;

--
-- Name: basket_basket_vouchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE basket_basket_vouchers_id_seq OWNED BY basket_basket_vouchers.id;


--
-- Name: basket_line; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE basket_line (
    id integer NOT NULL,
    line_reference character varying(128) NOT NULL,
    quantity integer NOT NULL,
    price_currency character varying(12) NOT NULL,
    price_excl_tax numeric(12,2),
    price_incl_tax numeric(12,2),
    date_created timestamp with time zone NOT NULL,
    basket_id integer NOT NULL,
    product_id integer NOT NULL,
    stockrecord_id integer NOT NULL,
    CONSTRAINT basket_line_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.basket_line OWNER TO taedori;

--
-- Name: basket_line_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE basket_line_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basket_line_id_seq OWNER TO taedori;

--
-- Name: basket_line_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE basket_line_id_seq OWNED BY basket_line.id;


--
-- Name: basket_lineattribute; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE basket_lineattribute (
    id integer NOT NULL,
    value character varying(255) NOT NULL,
    line_id integer NOT NULL,
    option_id integer NOT NULL
);


ALTER TABLE public.basket_lineattribute OWNER TO taedori;

--
-- Name: basket_lineattribute_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE basket_lineattribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.basket_lineattribute_id_seq OWNER TO taedori;

--
-- Name: basket_lineattribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE basket_lineattribute_id_seq OWNED BY basket_lineattribute.id;


--
-- Name: catalogue_attributeoption; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_attributeoption (
    id integer NOT NULL,
    option character varying(255) NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.catalogue_attributeoption OWNER TO taedori;

--
-- Name: catalogue_attributeoption_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_attributeoption_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_attributeoption_id_seq OWNER TO taedori;

--
-- Name: catalogue_attributeoption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_attributeoption_id_seq OWNED BY catalogue_attributeoption.id;


--
-- Name: catalogue_attributeoptiongroup; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_attributeoptiongroup (
    id integer NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE public.catalogue_attributeoptiongroup OWNER TO taedori;

--
-- Name: catalogue_attributeoptiongroup_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_attributeoptiongroup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_attributeoptiongroup_id_seq OWNER TO taedori;

--
-- Name: catalogue_attributeoptiongroup_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_attributeoptiongroup_id_seq OWNED BY catalogue_attributeoptiongroup.id;


--
-- Name: catalogue_category; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_category (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    depth integer NOT NULL,
    numchild integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    image character varying(255),
    slug character varying(255) NOT NULL,
    CONSTRAINT catalogue_category_depth_check CHECK ((depth >= 0)),
    CONSTRAINT catalogue_category_numchild_check CHECK ((numchild >= 0))
);


ALTER TABLE public.catalogue_category OWNER TO taedori;

--
-- Name: catalogue_category_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_category_id_seq OWNER TO taedori;

--
-- Name: catalogue_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_category_id_seq OWNED BY catalogue_category.id;


--
-- Name: catalogue_option; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_option (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    code character varying(128) NOT NULL,
    type character varying(128) NOT NULL
);


ALTER TABLE public.catalogue_option OWNER TO taedori;

--
-- Name: catalogue_option_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_option_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_option_id_seq OWNER TO taedori;

--
-- Name: catalogue_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_option_id_seq OWNED BY catalogue_option.id;


--
-- Name: catalogue_product; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_product (
    id integer NOT NULL,
    structure character varying(10) NOT NULL,
    upc character varying(64),
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text NOT NULL,
    rating double precision,
    date_created timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_discountable boolean NOT NULL,
    parent_id integer,
    product_class_id integer
);


ALTER TABLE public.catalogue_product OWNER TO taedori;

--
-- Name: catalogue_product_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_product_id_seq OWNER TO taedori;

--
-- Name: catalogue_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_product_id_seq OWNED BY catalogue_product.id;


--
-- Name: catalogue_product_product_options; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_product_product_options (
    id integer NOT NULL,
    product_id integer NOT NULL,
    option_id integer NOT NULL
);


ALTER TABLE public.catalogue_product_product_options OWNER TO taedori;

--
-- Name: catalogue_product_product_options_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_product_product_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_product_product_options_id_seq OWNER TO taedori;

--
-- Name: catalogue_product_product_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_product_product_options_id_seq OWNED BY catalogue_product_product_options.id;


--
-- Name: catalogue_productattribute; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_productattribute (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    code character varying(128) NOT NULL,
    type character varying(20) NOT NULL,
    required boolean NOT NULL,
    option_group_id integer,
    product_class_id integer
);


ALTER TABLE public.catalogue_productattribute OWNER TO taedori;

--
-- Name: catalogue_productattribute_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_productattribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_productattribute_id_seq OWNER TO taedori;

--
-- Name: catalogue_productattribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_productattribute_id_seq OWNED BY catalogue_productattribute.id;


--
-- Name: catalogue_productattributevalue; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_productattributevalue (
    id integer NOT NULL,
    value_text text,
    value_integer integer,
    value_boolean boolean,
    value_float double precision,
    value_richtext text,
    value_date date,
    value_file character varying(255),
    value_image character varying(255),
    entity_object_id integer,
    attribute_id integer NOT NULL,
    entity_content_type_id integer,
    product_id integer NOT NULL,
    value_option_id integer,
    CONSTRAINT catalogue_productattributevalue_entity_object_id_check CHECK ((entity_object_id >= 0))
);


ALTER TABLE public.catalogue_productattributevalue OWNER TO taedori;

--
-- Name: catalogue_productattributevalue_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_productattributevalue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_productattributevalue_id_seq OWNER TO taedori;

--
-- Name: catalogue_productattributevalue_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_productattributevalue_id_seq OWNED BY catalogue_productattributevalue.id;


--
-- Name: catalogue_productcategory; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_productcategory (
    id integer NOT NULL,
    category_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.catalogue_productcategory OWNER TO taedori;

--
-- Name: catalogue_productcategory_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_productcategory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_productcategory_id_seq OWNER TO taedori;

--
-- Name: catalogue_productcategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_productcategory_id_seq OWNED BY catalogue_productcategory.id;


--
-- Name: catalogue_productclass; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_productclass (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    slug character varying(128) NOT NULL,
    requires_shipping boolean NOT NULL,
    track_stock boolean NOT NULL
);


ALTER TABLE public.catalogue_productclass OWNER TO taedori;

--
-- Name: catalogue_productclass_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_productclass_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_productclass_id_seq OWNER TO taedori;

--
-- Name: catalogue_productclass_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_productclass_id_seq OWNED BY catalogue_productclass.id;


--
-- Name: catalogue_productclass_options; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_productclass_options (
    id integer NOT NULL,
    productclass_id integer NOT NULL,
    option_id integer NOT NULL
);


ALTER TABLE public.catalogue_productclass_options OWNER TO taedori;

--
-- Name: catalogue_productclass_options_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_productclass_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_productclass_options_id_seq OWNER TO taedori;

--
-- Name: catalogue_productclass_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_productclass_options_id_seq OWNED BY catalogue_productclass_options.id;


--
-- Name: catalogue_productimage; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_productimage (
    id integer NOT NULL,
    original character varying(255) NOT NULL,
    caption character varying(200) NOT NULL,
    display_order integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    product_id integer NOT NULL,
    CONSTRAINT catalogue_productimage_display_order_check CHECK ((display_order >= 0))
);


ALTER TABLE public.catalogue_productimage OWNER TO taedori;

--
-- Name: catalogue_productimage_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_productimage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_productimage_id_seq OWNER TO taedori;

--
-- Name: catalogue_productimage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_productimage_id_seq OWNED BY catalogue_productimage.id;


--
-- Name: catalogue_productrecommendation; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE catalogue_productrecommendation (
    id integer NOT NULL,
    ranking smallint NOT NULL,
    primary_id integer NOT NULL,
    recommendation_id integer NOT NULL,
    CONSTRAINT catalogue_productrecommendation_ranking_check CHECK ((ranking >= 0))
);


ALTER TABLE public.catalogue_productrecommendation OWNER TO taedori;

--
-- Name: catalogue_productrecommendation_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE catalogue_productrecommendation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.catalogue_productrecommendation_id_seq OWNER TO taedori;

--
-- Name: catalogue_productrecommendation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE catalogue_productrecommendation_id_seq OWNED BY catalogue_productrecommendation.id;


--
-- Name: customer_communicationeventtype; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE customer_communicationeventtype (
    id integer NOT NULL,
    code character varying(128) NOT NULL,
    name character varying(255) NOT NULL,
    category character varying(255) NOT NULL,
    email_subject_template character varying(255),
    email_body_template text,
    email_body_html_template text,
    sms_template character varying(170),
    date_created timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL
);


ALTER TABLE public.customer_communicationeventtype OWNER TO taedori;

--
-- Name: customer_communicationeventtype_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE customer_communicationeventtype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_communicationeventtype_id_seq OWNER TO taedori;

--
-- Name: customer_communicationeventtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE customer_communicationeventtype_id_seq OWNED BY customer_communicationeventtype.id;


--
-- Name: customer_email; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE customer_email (
    id integer NOT NULL,
    subject text NOT NULL,
    body_text text NOT NULL,
    body_html text NOT NULL,
    date_sent timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.customer_email OWNER TO taedori;

--
-- Name: customer_email_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE customer_email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_email_id_seq OWNER TO taedori;

--
-- Name: customer_email_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE customer_email_id_seq OWNED BY customer_email.id;


--
-- Name: customer_notification; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE customer_notification (
    id integer NOT NULL,
    subject character varying(255) NOT NULL,
    body text NOT NULL,
    category character varying(255) NOT NULL,
    location character varying(32) NOT NULL,
    date_sent timestamp with time zone NOT NULL,
    date_read timestamp with time zone,
    recipient_id integer NOT NULL,
    sender_id integer
);


ALTER TABLE public.customer_notification OWNER TO taedori;

--
-- Name: customer_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE customer_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_notification_id_seq OWNER TO taedori;

--
-- Name: customer_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE customer_notification_id_seq OWNED BY customer_notification.id;


--
-- Name: customer_productalert; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE customer_productalert (
    id integer NOT NULL,
    email character varying(75) NOT NULL,
    key character varying(128) NOT NULL,
    status character varying(20) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_confirmed timestamp with time zone,
    date_cancelled timestamp with time zone,
    date_closed timestamp with time zone,
    product_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.customer_productalert OWNER TO taedori;

--
-- Name: customer_productalert_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE customer_productalert_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_productalert_id_seq OWNER TO taedori;

--
-- Name: customer_productalert_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE customer_productalert_id_seq OWNED BY customer_productalert.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO taedori;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO taedori;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO taedori;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO taedori;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_flatpage; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE django_flatpage (
    id integer NOT NULL,
    url character varying(100) NOT NULL,
    title character varying(200) NOT NULL,
    content text NOT NULL,
    enable_comments boolean NOT NULL,
    template_name character varying(70) NOT NULL,
    registration_required boolean NOT NULL
);


ALTER TABLE public.django_flatpage OWNER TO taedori;

--
-- Name: django_flatpage_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE django_flatpage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_flatpage_id_seq OWNER TO taedori;

--
-- Name: django_flatpage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE django_flatpage_id_seq OWNED BY django_flatpage.id;


--
-- Name: django_flatpage_sites; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE django_flatpage_sites (
    id integer NOT NULL,
    flatpage_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.django_flatpage_sites OWNER TO taedori;

--
-- Name: django_flatpage_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE django_flatpage_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_flatpage_sites_id_seq OWNER TO taedori;

--
-- Name: django_flatpage_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE django_flatpage_sites_id_seq OWNED BY django_flatpage_sites.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO taedori;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO taedori;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO taedori;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO taedori;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO taedori;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: home_homepage; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE home_homepage (
    page_ptr_id integer NOT NULL
);


ALTER TABLE public.home_homepage OWNER TO taedori;

--
-- Name: home_promotionspage; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE home_promotionspage (
    page_ptr_id integer NOT NULL
);


ALTER TABLE public.home_promotionspage OWNER TO taedori;

--
-- Name: offer_benefit; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE offer_benefit (
    id integer NOT NULL,
    type character varying(128) NOT NULL,
    value numeric(12,2),
    max_affected_items integer,
    proxy_class character varying(255),
    range_id integer,
    CONSTRAINT offer_benefit_max_affected_items_check CHECK ((max_affected_items >= 0))
);


ALTER TABLE public.offer_benefit OWNER TO taedori;

--
-- Name: offer_benefit_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE offer_benefit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_benefit_id_seq OWNER TO taedori;

--
-- Name: offer_benefit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE offer_benefit_id_seq OWNED BY offer_benefit.id;


--
-- Name: offer_condition; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE offer_condition (
    id integer NOT NULL,
    type character varying(128) NOT NULL,
    value numeric(12,2),
    proxy_class character varying(255),
    range_id integer
);


ALTER TABLE public.offer_condition OWNER TO taedori;

--
-- Name: offer_condition_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE offer_condition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_condition_id_seq OWNER TO taedori;

--
-- Name: offer_condition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE offer_condition_id_seq OWNED BY offer_condition.id;


--
-- Name: offer_conditionaloffer; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE offer_conditionaloffer (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    slug character varying(128) NOT NULL,
    description text NOT NULL,
    offer_type character varying(128) NOT NULL,
    status character varying(64) NOT NULL,
    priority integer NOT NULL,
    start_datetime timestamp with time zone,
    end_datetime timestamp with time zone,
    max_global_applications integer,
    max_user_applications integer,
    max_basket_applications integer,
    max_discount numeric(12,2),
    total_discount numeric(12,2) NOT NULL,
    num_applications integer NOT NULL,
    num_orders integer NOT NULL,
    redirect_url character varying(200) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    benefit_id integer NOT NULL,
    condition_id integer NOT NULL,
    CONSTRAINT offer_conditionaloffer_max_basket_applications_check CHECK ((max_basket_applications >= 0)),
    CONSTRAINT offer_conditionaloffer_max_global_applications_check CHECK ((max_global_applications >= 0)),
    CONSTRAINT offer_conditionaloffer_max_user_applications_check CHECK ((max_user_applications >= 0)),
    CONSTRAINT offer_conditionaloffer_num_applications_check CHECK ((num_applications >= 0)),
    CONSTRAINT offer_conditionaloffer_num_orders_check CHECK ((num_orders >= 0))
);


ALTER TABLE public.offer_conditionaloffer OWNER TO taedori;

--
-- Name: offer_conditionaloffer_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE offer_conditionaloffer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_conditionaloffer_id_seq OWNER TO taedori;

--
-- Name: offer_conditionaloffer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE offer_conditionaloffer_id_seq OWNED BY offer_conditionaloffer.id;


--
-- Name: offer_range; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE offer_range (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    slug character varying(128) NOT NULL,
    description text NOT NULL,
    is_public boolean NOT NULL,
    includes_all_products boolean NOT NULL,
    proxy_class character varying(255),
    date_created timestamp with time zone NOT NULL
);


ALTER TABLE public.offer_range OWNER TO taedori;

--
-- Name: offer_range_classes; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE offer_range_classes (
    id integer NOT NULL,
    range_id integer NOT NULL,
    productclass_id integer NOT NULL
);


ALTER TABLE public.offer_range_classes OWNER TO taedori;

--
-- Name: offer_range_classes_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE offer_range_classes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_range_classes_id_seq OWNER TO taedori;

--
-- Name: offer_range_classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE offer_range_classes_id_seq OWNED BY offer_range_classes.id;


--
-- Name: offer_range_excluded_products; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE offer_range_excluded_products (
    id integer NOT NULL,
    range_id integer NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.offer_range_excluded_products OWNER TO taedori;

--
-- Name: offer_range_excluded_products_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE offer_range_excluded_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_range_excluded_products_id_seq OWNER TO taedori;

--
-- Name: offer_range_excluded_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE offer_range_excluded_products_id_seq OWNED BY offer_range_excluded_products.id;


--
-- Name: offer_range_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE offer_range_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_range_id_seq OWNER TO taedori;

--
-- Name: offer_range_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE offer_range_id_seq OWNED BY offer_range.id;


--
-- Name: offer_range_included_categories; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE offer_range_included_categories (
    id integer NOT NULL,
    range_id integer NOT NULL,
    category_id integer NOT NULL
);


ALTER TABLE public.offer_range_included_categories OWNER TO taedori;

--
-- Name: offer_range_included_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE offer_range_included_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_range_included_categories_id_seq OWNER TO taedori;

--
-- Name: offer_range_included_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE offer_range_included_categories_id_seq OWNED BY offer_range_included_categories.id;


--
-- Name: offer_rangeproduct; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE offer_rangeproduct (
    id integer NOT NULL,
    display_order integer NOT NULL,
    product_id integer NOT NULL,
    range_id integer NOT NULL
);


ALTER TABLE public.offer_rangeproduct OWNER TO taedori;

--
-- Name: offer_rangeproduct_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE offer_rangeproduct_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_rangeproduct_id_seq OWNER TO taedori;

--
-- Name: offer_rangeproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE offer_rangeproduct_id_seq OWNED BY offer_rangeproduct.id;


--
-- Name: offer_rangeproductfileupload; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE offer_rangeproductfileupload (
    id integer NOT NULL,
    filepath character varying(255) NOT NULL,
    size integer NOT NULL,
    date_uploaded timestamp with time zone NOT NULL,
    status character varying(32) NOT NULL,
    error_message character varying(255) NOT NULL,
    date_processed timestamp with time zone,
    num_new_skus integer,
    num_unknown_skus integer,
    num_duplicate_skus integer,
    range_id integer NOT NULL,
    uploaded_by_id integer NOT NULL,
    CONSTRAINT offer_rangeproductfileupload_num_duplicate_skus_check CHECK ((num_duplicate_skus >= 0)),
    CONSTRAINT offer_rangeproductfileupload_num_new_skus_check CHECK ((num_new_skus >= 0)),
    CONSTRAINT offer_rangeproductfileupload_num_unknown_skus_check CHECK ((num_unknown_skus >= 0)),
    CONSTRAINT offer_rangeproductfileupload_size_check CHECK ((size >= 0))
);


ALTER TABLE public.offer_rangeproductfileupload OWNER TO taedori;

--
-- Name: offer_rangeproductfileupload_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE offer_rangeproductfileupload_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offer_rangeproductfileupload_id_seq OWNER TO taedori;

--
-- Name: offer_rangeproductfileupload_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE offer_rangeproductfileupload_id_seq OWNED BY offer_rangeproductfileupload.id;


--
-- Name: order_billingaddress; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_billingaddress (
    id integer NOT NULL,
    title character varying(64) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    line1 character varying(255) NOT NULL,
    line2 character varying(255) NOT NULL,
    line3 character varying(255) NOT NULL,
    line4 character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    postcode character varying(64) NOT NULL,
    search_text text NOT NULL,
    country_id character varying(2) NOT NULL
);


ALTER TABLE public.order_billingaddress OWNER TO taedori;

--
-- Name: order_billingaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_billingaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_billingaddress_id_seq OWNER TO taedori;

--
-- Name: order_billingaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_billingaddress_id_seq OWNED BY order_billingaddress.id;


--
-- Name: order_communicationevent; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_communicationevent (
    id integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    event_type_id integer NOT NULL,
    order_id integer NOT NULL
);


ALTER TABLE public.order_communicationevent OWNER TO taedori;

--
-- Name: order_communicationevent_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_communicationevent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_communicationevent_id_seq OWNER TO taedori;

--
-- Name: order_communicationevent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_communicationevent_id_seq OWNED BY order_communicationevent.id;


--
-- Name: order_line; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_line (
    id integer NOT NULL,
    partner_name character varying(128) NOT NULL,
    partner_sku character varying(128) NOT NULL,
    partner_line_reference character varying(128) NOT NULL,
    partner_line_notes text NOT NULL,
    title character varying(255) NOT NULL,
    upc character varying(128),
    quantity integer NOT NULL,
    line_price_incl_tax numeric(12,2) NOT NULL,
    line_price_excl_tax numeric(12,2) NOT NULL,
    line_price_before_discounts_incl_tax numeric(12,2) NOT NULL,
    line_price_before_discounts_excl_tax numeric(12,2) NOT NULL,
    unit_cost_price numeric(12,2),
    unit_price_incl_tax numeric(12,2),
    unit_price_excl_tax numeric(12,2),
    unit_retail_price numeric(12,2),
    status character varying(255) NOT NULL,
    est_dispatch_date date,
    order_id integer NOT NULL,
    partner_id integer,
    product_id integer,
    stockrecord_id integer,
    CONSTRAINT order_line_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.order_line OWNER TO taedori;

--
-- Name: order_line_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_line_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_line_id_seq OWNER TO taedori;

--
-- Name: order_line_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_line_id_seq OWNED BY order_line.id;


--
-- Name: order_lineattribute; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_lineattribute (
    id integer NOT NULL,
    type character varying(128) NOT NULL,
    value character varying(255) NOT NULL,
    line_id integer NOT NULL,
    option_id integer
);


ALTER TABLE public.order_lineattribute OWNER TO taedori;

--
-- Name: order_lineattribute_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_lineattribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_lineattribute_id_seq OWNER TO taedori;

--
-- Name: order_lineattribute_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_lineattribute_id_seq OWNED BY order_lineattribute.id;


--
-- Name: order_lineprice; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_lineprice (
    id integer NOT NULL,
    quantity integer NOT NULL,
    price_incl_tax numeric(12,2) NOT NULL,
    price_excl_tax numeric(12,2) NOT NULL,
    shipping_incl_tax numeric(12,2) NOT NULL,
    shipping_excl_tax numeric(12,2) NOT NULL,
    line_id integer NOT NULL,
    order_id integer NOT NULL,
    CONSTRAINT order_lineprice_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.order_lineprice OWNER TO taedori;

--
-- Name: order_lineprice_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_lineprice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_lineprice_id_seq OWNER TO taedori;

--
-- Name: order_lineprice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_lineprice_id_seq OWNED BY order_lineprice.id;


--
-- Name: order_order; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_order (
    id integer NOT NULL,
    number character varying(128) NOT NULL,
    currency character varying(12) NOT NULL,
    total_incl_tax numeric(12,2) NOT NULL,
    total_excl_tax numeric(12,2) NOT NULL,
    shipping_incl_tax numeric(12,2) NOT NULL,
    shipping_excl_tax numeric(12,2) NOT NULL,
    shipping_method character varying(128) NOT NULL,
    shipping_code character varying(128) NOT NULL,
    status character varying(100) NOT NULL,
    guest_email character varying(75) NOT NULL,
    date_placed timestamp with time zone NOT NULL,
    basket_id integer,
    billing_address_id integer,
    shipping_address_id integer,
    site_id integer,
    user_id integer
);


ALTER TABLE public.order_order OWNER TO taedori;

--
-- Name: order_order_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_order_id_seq OWNER TO taedori;

--
-- Name: order_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_order_id_seq OWNED BY order_order.id;


--
-- Name: order_orderdiscount; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_orderdiscount (
    id integer NOT NULL,
    category character varying(64) NOT NULL,
    offer_id integer,
    offer_name character varying(128) NOT NULL,
    voucher_id integer,
    voucher_code character varying(128) NOT NULL,
    frequency integer,
    amount numeric(12,2) NOT NULL,
    message text NOT NULL,
    order_id integer NOT NULL,
    CONSTRAINT order_orderdiscount_frequency_check CHECK ((frequency >= 0)),
    CONSTRAINT order_orderdiscount_offer_id_check CHECK ((offer_id >= 0)),
    CONSTRAINT order_orderdiscount_voucher_id_check CHECK ((voucher_id >= 0))
);


ALTER TABLE public.order_orderdiscount OWNER TO taedori;

--
-- Name: order_orderdiscount_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_orderdiscount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_orderdiscount_id_seq OWNER TO taedori;

--
-- Name: order_orderdiscount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_orderdiscount_id_seq OWNED BY order_orderdiscount.id;


--
-- Name: order_ordernote; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_ordernote (
    id integer NOT NULL,
    note_type character varying(128) NOT NULL,
    message text NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    order_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.order_ordernote OWNER TO taedori;

--
-- Name: order_ordernote_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_ordernote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_ordernote_id_seq OWNER TO taedori;

--
-- Name: order_ordernote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_ordernote_id_seq OWNED BY order_ordernote.id;


--
-- Name: order_paymentevent; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_paymentevent (
    id integer NOT NULL,
    amount numeric(12,2) NOT NULL,
    reference character varying(128) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    event_type_id integer NOT NULL,
    order_id integer NOT NULL,
    shipping_event_id integer
);


ALTER TABLE public.order_paymentevent OWNER TO taedori;

--
-- Name: order_paymentevent_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_paymentevent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_paymentevent_id_seq OWNER TO taedori;

--
-- Name: order_paymentevent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_paymentevent_id_seq OWNED BY order_paymentevent.id;


--
-- Name: order_paymenteventquantity; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_paymenteventquantity (
    id integer NOT NULL,
    quantity integer NOT NULL,
    event_id integer NOT NULL,
    line_id integer NOT NULL,
    CONSTRAINT order_paymenteventquantity_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.order_paymenteventquantity OWNER TO taedori;

--
-- Name: order_paymenteventquantity_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_paymenteventquantity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_paymenteventquantity_id_seq OWNER TO taedori;

--
-- Name: order_paymenteventquantity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_paymenteventquantity_id_seq OWNED BY order_paymenteventquantity.id;


--
-- Name: order_paymenteventtype; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_paymenteventtype (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    code character varying(128) NOT NULL
);


ALTER TABLE public.order_paymenteventtype OWNER TO taedori;

--
-- Name: order_paymenteventtype_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_paymenteventtype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_paymenteventtype_id_seq OWNER TO taedori;

--
-- Name: order_paymenteventtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_paymenteventtype_id_seq OWNED BY order_paymenteventtype.id;


--
-- Name: order_shippingaddress; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_shippingaddress (
    id integer NOT NULL,
    title character varying(64) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    line1 character varying(255) NOT NULL,
    line2 character varying(255) NOT NULL,
    line3 character varying(255) NOT NULL,
    line4 character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    postcode character varying(64) NOT NULL,
    search_text text NOT NULL,
    phone_number character varying(128) NOT NULL,
    notes text NOT NULL,
    country_id character varying(2) NOT NULL
);


ALTER TABLE public.order_shippingaddress OWNER TO taedori;

--
-- Name: order_shippingaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_shippingaddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_shippingaddress_id_seq OWNER TO taedori;

--
-- Name: order_shippingaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_shippingaddress_id_seq OWNED BY order_shippingaddress.id;


--
-- Name: order_shippingevent; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_shippingevent (
    id integer NOT NULL,
    notes text NOT NULL,
    date_created timestamp with time zone NOT NULL,
    event_type_id integer NOT NULL,
    order_id integer NOT NULL
);


ALTER TABLE public.order_shippingevent OWNER TO taedori;

--
-- Name: order_shippingevent_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_shippingevent_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_shippingevent_id_seq OWNER TO taedori;

--
-- Name: order_shippingevent_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_shippingevent_id_seq OWNED BY order_shippingevent.id;


--
-- Name: order_shippingeventquantity; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_shippingeventquantity (
    id integer NOT NULL,
    quantity integer NOT NULL,
    event_id integer NOT NULL,
    line_id integer NOT NULL,
    CONSTRAINT order_shippingeventquantity_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.order_shippingeventquantity OWNER TO taedori;

--
-- Name: order_shippingeventquantity_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_shippingeventquantity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_shippingeventquantity_id_seq OWNER TO taedori;

--
-- Name: order_shippingeventquantity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_shippingeventquantity_id_seq OWNED BY order_shippingeventquantity.id;


--
-- Name: order_shippingeventtype; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE order_shippingeventtype (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(128) NOT NULL
);


ALTER TABLE public.order_shippingeventtype OWNER TO taedori;

--
-- Name: order_shippingeventtype_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE order_shippingeventtype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_shippingeventtype_id_seq OWNER TO taedori;

--
-- Name: order_shippingeventtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE order_shippingeventtype_id_seq OWNED BY order_shippingeventtype.id;


--
-- Name: partner_partner; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE partner_partner (
    id integer NOT NULL,
    code character varying(128) NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE public.partner_partner OWNER TO taedori;

--
-- Name: partner_partner_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE partner_partner_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partner_partner_id_seq OWNER TO taedori;

--
-- Name: partner_partner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE partner_partner_id_seq OWNED BY partner_partner.id;


--
-- Name: partner_partner_users; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE partner_partner_users (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.partner_partner_users OWNER TO taedori;

--
-- Name: partner_partner_users_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE partner_partner_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partner_partner_users_id_seq OWNER TO taedori;

--
-- Name: partner_partner_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE partner_partner_users_id_seq OWNED BY partner_partner_users.id;


--
-- Name: partner_partneraddress; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE partner_partneraddress (
    id integer NOT NULL,
    title character varying(64) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    line1 character varying(255) NOT NULL,
    line2 character varying(255) NOT NULL,
    line3 character varying(255) NOT NULL,
    line4 character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    postcode character varying(64) NOT NULL,
    search_text text NOT NULL,
    country_id character varying(2) NOT NULL,
    partner_id integer NOT NULL
);


ALTER TABLE public.partner_partneraddress OWNER TO taedori;

--
-- Name: partner_partneraddress_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE partner_partneraddress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partner_partneraddress_id_seq OWNER TO taedori;

--
-- Name: partner_partneraddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE partner_partneraddress_id_seq OWNED BY partner_partneraddress.id;


--
-- Name: partner_stockalert; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE partner_stockalert (
    id integer NOT NULL,
    threshold integer NOT NULL,
    status character varying(128) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_closed timestamp with time zone,
    stockrecord_id integer NOT NULL,
    CONSTRAINT partner_stockalert_threshold_check CHECK ((threshold >= 0))
);


ALTER TABLE public.partner_stockalert OWNER TO taedori;

--
-- Name: partner_stockalert_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE partner_stockalert_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partner_stockalert_id_seq OWNER TO taedori;

--
-- Name: partner_stockalert_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE partner_stockalert_id_seq OWNED BY partner_stockalert.id;


--
-- Name: partner_stockrecord; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE partner_stockrecord (
    id integer NOT NULL,
    partner_sku character varying(128) NOT NULL,
    price_currency character varying(12) NOT NULL,
    price_excl_tax numeric(12,2),
    price_retail numeric(12,2),
    cost_price numeric(12,2),
    num_in_stock integer,
    num_allocated integer,
    low_stock_threshold integer,
    date_created timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    partner_id integer NOT NULL,
    product_id integer NOT NULL,
    CONSTRAINT partner_stockrecord_low_stock_threshold_check CHECK ((low_stock_threshold >= 0)),
    CONSTRAINT partner_stockrecord_num_in_stock_check CHECK ((num_in_stock >= 0))
);


ALTER TABLE public.partner_stockrecord OWNER TO taedori;

--
-- Name: partner_stockrecord_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE partner_stockrecord_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partner_stockrecord_id_seq OWNER TO taedori;

--
-- Name: partner_stockrecord_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE partner_stockrecord_id_seq OWNED BY partner_stockrecord.id;


--
-- Name: payment_bankcard; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payment_bankcard (
    id integer NOT NULL,
    card_type character varying(128) NOT NULL,
    name character varying(255) NOT NULL,
    number character varying(32) NOT NULL,
    expiry_date date NOT NULL,
    partner_reference character varying(255) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.payment_bankcard OWNER TO taedori;

--
-- Name: payment_bankcard_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payment_bankcard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_bankcard_id_seq OWNER TO taedori;

--
-- Name: payment_bankcard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payment_bankcard_id_seq OWNED BY payment_bankcard.id;


--
-- Name: payment_source; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payment_source (
    id integer NOT NULL,
    currency character varying(12) NOT NULL,
    amount_allocated numeric(12,2) NOT NULL,
    amount_debited numeric(12,2) NOT NULL,
    amount_refunded numeric(12,2) NOT NULL,
    reference character varying(128) NOT NULL,
    label character varying(128) NOT NULL,
    order_id integer NOT NULL,
    source_type_id integer NOT NULL
);


ALTER TABLE public.payment_source OWNER TO taedori;

--
-- Name: payment_source_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payment_source_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_source_id_seq OWNER TO taedori;

--
-- Name: payment_source_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payment_source_id_seq OWNED BY payment_source.id;


--
-- Name: payment_sourcetype; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payment_sourcetype (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    code character varying(128) NOT NULL
);


ALTER TABLE public.payment_sourcetype OWNER TO taedori;

--
-- Name: payment_sourcetype_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payment_sourcetype_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_sourcetype_id_seq OWNER TO taedori;

--
-- Name: payment_sourcetype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payment_sourcetype_id_seq OWNED BY payment_sourcetype.id;


--
-- Name: payment_transaction; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payment_transaction (
    id integer NOT NULL,
    txn_type character varying(128) NOT NULL,
    amount numeric(12,2) NOT NULL,
    reference character varying(128) NOT NULL,
    status character varying(128) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    source_id integer NOT NULL
);


ALTER TABLE public.payment_transaction OWNER TO taedori;

--
-- Name: payment_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payment_transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_transaction_id_seq OWNER TO taedori;

--
-- Name: payment_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payment_transaction_id_seq OWNED BY payment_transaction.id;


--
-- Name: payments_charge; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payments_charge (
    id integer NOT NULL,
    stripe_id character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    customer_id integer NOT NULL,
    invoice_id integer,
    card_last_4 character varying(4) NOT NULL,
    card_kind character varying(50) NOT NULL,
    currency character varying(10) NOT NULL,
    amount numeric(9,2),
    amount_refunded numeric(9,2),
    description text NOT NULL,
    paid boolean,
    disputed boolean,
    refunded boolean,
    captured boolean,
    fee numeric(9,2),
    receipt_sent boolean NOT NULL,
    charge_created timestamp with time zone
);


ALTER TABLE public.payments_charge OWNER TO taedori;

--
-- Name: payments_charge_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payments_charge_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_charge_id_seq OWNER TO taedori;

--
-- Name: payments_charge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payments_charge_id_seq OWNED BY payments_charge.id;


--
-- Name: payments_currentsubscription; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payments_currentsubscription (
    id integer NOT NULL,
    customer_id integer,
    plan character varying(100) NOT NULL,
    quantity integer NOT NULL,
    start timestamp with time zone NOT NULL,
    status character varying(25) NOT NULL,
    cancel_at_period_end boolean NOT NULL,
    canceled_at timestamp with time zone,
    current_period_end timestamp with time zone,
    current_period_start timestamp with time zone,
    ended_at timestamp with time zone,
    trial_end timestamp with time zone,
    trial_start timestamp with time zone,
    amount numeric(9,2) NOT NULL,
    currency character varying(10) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.payments_currentsubscription OWNER TO taedori;

--
-- Name: payments_currentsubscription_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payments_currentsubscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_currentsubscription_id_seq OWNER TO taedori;

--
-- Name: payments_currentsubscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payments_currentsubscription_id_seq OWNED BY payments_currentsubscription.id;


--
-- Name: payments_customer; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payments_customer (
    id integer NOT NULL,
    stripe_id character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    user_id integer,
    card_fingerprint character varying(200) NOT NULL,
    card_last_4 character varying(4) NOT NULL,
    card_kind character varying(50) NOT NULL,
    date_purged timestamp with time zone
);


ALTER TABLE public.payments_customer OWNER TO taedori;

--
-- Name: payments_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payments_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_customer_id_seq OWNER TO taedori;

--
-- Name: payments_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payments_customer_id_seq OWNED BY payments_customer.id;


--
-- Name: payments_event; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payments_event (
    id integer NOT NULL,
    stripe_id character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    kind character varying(250) NOT NULL,
    livemode boolean NOT NULL,
    customer_id integer,
    webhook_message text NOT NULL,
    validated_message text,
    valid boolean,
    processed boolean NOT NULL
);


ALTER TABLE public.payments_event OWNER TO taedori;

--
-- Name: payments_event_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payments_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_event_id_seq OWNER TO taedori;

--
-- Name: payments_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payments_event_id_seq OWNED BY payments_event.id;


--
-- Name: payments_eventprocessingexception; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payments_eventprocessingexception (
    id integer NOT NULL,
    event_id integer,
    data text NOT NULL,
    message character varying(500) NOT NULL,
    traceback text NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.payments_eventprocessingexception OWNER TO taedori;

--
-- Name: payments_eventprocessingexception_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payments_eventprocessingexception_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_eventprocessingexception_id_seq OWNER TO taedori;

--
-- Name: payments_eventprocessingexception_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payments_eventprocessingexception_id_seq OWNED BY payments_eventprocessingexception.id;


--
-- Name: payments_invoice; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payments_invoice (
    id integer NOT NULL,
    stripe_id character varying(255) NOT NULL,
    customer_id integer NOT NULL,
    attempted boolean,
    attempts integer,
    closed boolean NOT NULL,
    paid boolean NOT NULL,
    period_end timestamp with time zone NOT NULL,
    period_start timestamp with time zone NOT NULL,
    subtotal numeric(9,2) NOT NULL,
    total numeric(9,2) NOT NULL,
    currency character varying(10) NOT NULL,
    date timestamp with time zone NOT NULL,
    charge character varying(50) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    CONSTRAINT payments_invoice_attempts_check CHECK ((attempts >= 0))
);


ALTER TABLE public.payments_invoice OWNER TO taedori;

--
-- Name: payments_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payments_invoice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_invoice_id_seq OWNER TO taedori;

--
-- Name: payments_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payments_invoice_id_seq OWNED BY payments_invoice.id;


--
-- Name: payments_invoiceitem; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payments_invoiceitem (
    id integer NOT NULL,
    stripe_id character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    invoice_id integer NOT NULL,
    amount numeric(9,2) NOT NULL,
    currency character varying(10) NOT NULL,
    period_start timestamp with time zone NOT NULL,
    period_end timestamp with time zone NOT NULL,
    proration boolean NOT NULL,
    line_type character varying(50) NOT NULL,
    description character varying(200) NOT NULL,
    plan character varying(100) NOT NULL,
    quantity integer
);


ALTER TABLE public.payments_invoiceitem OWNER TO taedori;

--
-- Name: payments_invoiceitem_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payments_invoiceitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_invoiceitem_id_seq OWNER TO taedori;

--
-- Name: payments_invoiceitem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payments_invoiceitem_id_seq OWNED BY payments_invoiceitem.id;


--
-- Name: payments_transfer; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payments_transfer (
    id integer NOT NULL,
    stripe_id character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    event_id integer NOT NULL,
    amount numeric(9,2) NOT NULL,
    currency character varying(25) NOT NULL,
    status character varying(25) NOT NULL,
    date timestamp with time zone NOT NULL,
    description text,
    adjustment_count integer,
    adjustment_fees numeric(9,2),
    adjustment_gross numeric(9,2),
    charge_count integer,
    charge_fees numeric(9,2),
    charge_gross numeric(9,2),
    collected_fee_count integer,
    collected_fee_gross numeric(9,2),
    net numeric(9,2),
    refund_count integer,
    refund_fees numeric(9,2),
    refund_gross numeric(9,2),
    validation_count integer,
    validation_fees numeric(9,2)
);


ALTER TABLE public.payments_transfer OWNER TO taedori;

--
-- Name: payments_transfer_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payments_transfer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_transfer_id_seq OWNER TO taedori;

--
-- Name: payments_transfer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payments_transfer_id_seq OWNED BY payments_transfer.id;


--
-- Name: payments_transferchargefee; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE payments_transferchargefee (
    id integer NOT NULL,
    transfer_id integer NOT NULL,
    amount numeric(9,2) NOT NULL,
    currency character varying(10) NOT NULL,
    application text,
    description text,
    kind character varying(150) NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.payments_transferchargefee OWNER TO taedori;

--
-- Name: payments_transferchargefee_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE payments_transferchargefee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_transferchargefee_id_seq OWNER TO taedori;

--
-- Name: payments_transferchargefee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE payments_transferchargefee_id_seq OWNED BY payments_transferchargefee.id;


--
-- Name: paypal_expresstransaction; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE paypal_expresstransaction (
    id integer NOT NULL,
    raw_request text NOT NULL,
    raw_response text NOT NULL,
    response_time double precision NOT NULL,
    date_created timestamp with time zone NOT NULL,
    method character varying(32) NOT NULL,
    version character varying(8) NOT NULL,
    amount numeric(12,2),
    currency character varying(8),
    ack character varying(32) NOT NULL,
    correlation_id character varying(32),
    token character varying(32),
    error_code character varying(32),
    error_message character varying(256)
);


ALTER TABLE public.paypal_expresstransaction OWNER TO taedori;

--
-- Name: paypal_expresstransaction_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE paypal_expresstransaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paypal_expresstransaction_id_seq OWNER TO taedori;

--
-- Name: paypal_expresstransaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE paypal_expresstransaction_id_seq OWNED BY paypal_expresstransaction.id;


--
-- Name: paypal_payflowtransaction; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE paypal_payflowtransaction (
    id integer NOT NULL,
    raw_request text NOT NULL,
    raw_response text NOT NULL,
    response_time double precision NOT NULL,
    date_created timestamp with time zone NOT NULL,
    comment1 character varying(128) NOT NULL,
    trxtype character varying(12) NOT NULL,
    tender character varying(12),
    amount numeric(12,2),
    pnref character varying(32),
    ppref character varying(32),
    result character varying(32),
    respmsg character varying(512) NOT NULL,
    authcode character varying(32),
    cvv2match character varying(12),
    avsaddr character varying(1),
    avszip character varying(1)
);


ALTER TABLE public.paypal_payflowtransaction OWNER TO taedori;

--
-- Name: paypal_payflowtransaction_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE paypal_payflowtransaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paypal_payflowtransaction_id_seq OWNER TO taedori;

--
-- Name: paypal_payflowtransaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE paypal_payflowtransaction_id_seq OWNED BY paypal_payflowtransaction.id;


--
-- Name: promotions_automaticproductlist; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_automaticproductlist (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    link_url character varying(200) NOT NULL,
    link_text character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    method character varying(128) NOT NULL,
    num_products smallint NOT NULL,
    CONSTRAINT promotions_automaticproductlist_num_products_check CHECK ((num_products >= 0))
);


ALTER TABLE public.promotions_automaticproductlist OWNER TO taedori;

--
-- Name: promotions_automaticproductlist_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE promotions_automaticproductlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotions_automaticproductlist_id_seq OWNER TO taedori;

--
-- Name: promotions_automaticproductlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE promotions_automaticproductlist_id_seq OWNED BY promotions_automaticproductlist.id;


--
-- Name: promotions_handpickedproductlist; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_handpickedproductlist (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    link_url character varying(200) NOT NULL,
    link_text character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL
);


ALTER TABLE public.promotions_handpickedproductlist OWNER TO taedori;

--
-- Name: promotions_handpickedproductlist_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE promotions_handpickedproductlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotions_handpickedproductlist_id_seq OWNER TO taedori;

--
-- Name: promotions_handpickedproductlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE promotions_handpickedproductlist_id_seq OWNED BY promotions_handpickedproductlist.id;


--
-- Name: promotions_image; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_image (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    link_url character varying(200) NOT NULL,
    image character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL
);


ALTER TABLE public.promotions_image OWNER TO taedori;

--
-- Name: promotions_image_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE promotions_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotions_image_id_seq OWNER TO taedori;

--
-- Name: promotions_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE promotions_image_id_seq OWNED BY promotions_image.id;


--
-- Name: promotions_keywordpromotion; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_keywordpromotion (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "position" character varying(100) NOT NULL,
    display_order integer NOT NULL,
    clicks integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    keyword character varying(200) NOT NULL,
    filter character varying(200) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT promotions_keywordpromotion_clicks_check CHECK ((clicks >= 0)),
    CONSTRAINT promotions_keywordpromotion_display_order_check CHECK ((display_order >= 0)),
    CONSTRAINT promotions_keywordpromotion_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.promotions_keywordpromotion OWNER TO taedori;

--
-- Name: promotions_keywordpromotion_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE promotions_keywordpromotion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotions_keywordpromotion_id_seq OWNER TO taedori;

--
-- Name: promotions_keywordpromotion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE promotions_keywordpromotion_id_seq OWNED BY promotions_keywordpromotion.id;


--
-- Name: promotions_multiimage; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_multiimage (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    date_created timestamp with time zone NOT NULL
);


ALTER TABLE public.promotions_multiimage OWNER TO taedori;

--
-- Name: promotions_multiimage_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE promotions_multiimage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotions_multiimage_id_seq OWNER TO taedori;

--
-- Name: promotions_multiimage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE promotions_multiimage_id_seq OWNED BY promotions_multiimage.id;


--
-- Name: promotions_multiimage_images; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_multiimage_images (
    id integer NOT NULL,
    multiimage_id integer NOT NULL,
    image_id integer NOT NULL
);


ALTER TABLE public.promotions_multiimage_images OWNER TO taedori;

--
-- Name: promotions_multiimage_images_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE promotions_multiimage_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotions_multiimage_images_id_seq OWNER TO taedori;

--
-- Name: promotions_multiimage_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE promotions_multiimage_images_id_seq OWNED BY promotions_multiimage_images.id;


--
-- Name: promotions_orderedproduct; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_orderedproduct (
    id integer NOT NULL,
    display_order integer NOT NULL,
    list_id integer NOT NULL,
    product_id integer NOT NULL,
    CONSTRAINT promotions_orderedproduct_display_order_check CHECK ((display_order >= 0))
);


ALTER TABLE public.promotions_orderedproduct OWNER TO taedori;

--
-- Name: promotions_orderedproduct_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE promotions_orderedproduct_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotions_orderedproduct_id_seq OWNER TO taedori;

--
-- Name: promotions_orderedproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE promotions_orderedproduct_id_seq OWNED BY promotions_orderedproduct.id;


--
-- Name: promotions_orderedproductlist; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_orderedproductlist (
    handpickedproductlist_ptr_id integer NOT NULL,
    display_order integer NOT NULL,
    tabbed_block_id integer NOT NULL,
    CONSTRAINT promotions_orderedproductlist_display_order_check CHECK ((display_order >= 0))
);


ALTER TABLE public.promotions_orderedproductlist OWNER TO taedori;

--
-- Name: promotions_pagepromotion; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_pagepromotion (
    id integer NOT NULL,
    object_id integer NOT NULL,
    "position" character varying(100) NOT NULL,
    display_order integer NOT NULL,
    clicks integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    page_url character varying(128) NOT NULL,
    content_type_id integer NOT NULL,
    CONSTRAINT promotions_pagepromotion_clicks_check CHECK ((clicks >= 0)),
    CONSTRAINT promotions_pagepromotion_display_order_check CHECK ((display_order >= 0)),
    CONSTRAINT promotions_pagepromotion_object_id_check CHECK ((object_id >= 0))
);


ALTER TABLE public.promotions_pagepromotion OWNER TO taedori;

--
-- Name: promotions_pagepromotion_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE promotions_pagepromotion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotions_pagepromotion_id_seq OWNER TO taedori;

--
-- Name: promotions_pagepromotion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE promotions_pagepromotion_id_seq OWNED BY promotions_pagepromotion.id;


--
-- Name: promotions_rawhtml; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_rawhtml (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    display_type character varying(128) NOT NULL,
    body text NOT NULL,
    date_created timestamp with time zone NOT NULL
);


ALTER TABLE public.promotions_rawhtml OWNER TO taedori;

--
-- Name: promotions_rawhtml_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE promotions_rawhtml_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotions_rawhtml_id_seq OWNER TO taedori;

--
-- Name: promotions_rawhtml_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE promotions_rawhtml_id_seq OWNED BY promotions_rawhtml.id;


--
-- Name: promotions_singleproduct; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_singleproduct (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    description text NOT NULL,
    date_created timestamp with time zone NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE public.promotions_singleproduct OWNER TO taedori;

--
-- Name: promotions_singleproduct_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE promotions_singleproduct_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotions_singleproduct_id_seq OWNER TO taedori;

--
-- Name: promotions_singleproduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE promotions_singleproduct_id_seq OWNED BY promotions_singleproduct.id;


--
-- Name: promotions_tabbedblock; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE promotions_tabbedblock (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL
);


ALTER TABLE public.promotions_tabbedblock OWNER TO taedori;

--
-- Name: promotions_tabbedblock_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE promotions_tabbedblock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotions_tabbedblock_id_seq OWNER TO taedori;

--
-- Name: promotions_tabbedblock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE promotions_tabbedblock_id_seq OWNED BY promotions_tabbedblock.id;


--
-- Name: reviews_productreview; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE reviews_productreview (
    id integer NOT NULL,
    score smallint NOT NULL,
    title character varying(255) NOT NULL,
    body text NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(75) NOT NULL,
    homepage character varying(200) NOT NULL,
    status smallint NOT NULL,
    total_votes integer NOT NULL,
    delta_votes integer NOT NULL,
    date_created timestamp with time zone NOT NULL,
    product_id integer,
    user_id integer
);


ALTER TABLE public.reviews_productreview OWNER TO taedori;

--
-- Name: reviews_productreview_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE reviews_productreview_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_productreview_id_seq OWNER TO taedori;

--
-- Name: reviews_productreview_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE reviews_productreview_id_seq OWNED BY reviews_productreview.id;


--
-- Name: reviews_vote; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE reviews_vote (
    id integer NOT NULL,
    delta smallint NOT NULL,
    date_created timestamp with time zone NOT NULL,
    review_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.reviews_vote OWNER TO taedori;

--
-- Name: reviews_vote_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE reviews_vote_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_vote_id_seq OWNER TO taedori;

--
-- Name: reviews_vote_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE reviews_vote_id_seq OWNED BY reviews_vote.id;


--
-- Name: shipping_orderanditemcharges; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE shipping_orderanditemcharges (
    id integer NOT NULL,
    code character varying(128) NOT NULL,
    name character varying(128) NOT NULL,
    description text NOT NULL,
    price_per_order numeric(12,2) NOT NULL,
    price_per_item numeric(12,2) NOT NULL,
    free_shipping_threshold numeric(12,2)
);


ALTER TABLE public.shipping_orderanditemcharges OWNER TO taedori;

--
-- Name: shipping_orderanditemcharges_countries; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE shipping_orderanditemcharges_countries (
    id integer NOT NULL,
    orderanditemcharges_id integer NOT NULL,
    country_id character varying(2) NOT NULL
);


ALTER TABLE public.shipping_orderanditemcharges_countries OWNER TO taedori;

--
-- Name: shipping_orderanditemcharges_countries_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE shipping_orderanditemcharges_countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipping_orderanditemcharges_countries_id_seq OWNER TO taedori;

--
-- Name: shipping_orderanditemcharges_countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE shipping_orderanditemcharges_countries_id_seq OWNED BY shipping_orderanditemcharges_countries.id;


--
-- Name: shipping_orderanditemcharges_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE shipping_orderanditemcharges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipping_orderanditemcharges_id_seq OWNER TO taedori;

--
-- Name: shipping_orderanditemcharges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE shipping_orderanditemcharges_id_seq OWNED BY shipping_orderanditemcharges.id;


--
-- Name: shipping_weightband; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE shipping_weightband (
    id integer NOT NULL,
    upper_limit numeric(12,3) NOT NULL,
    charge numeric(12,2) NOT NULL,
    method_id integer NOT NULL
);


ALTER TABLE public.shipping_weightband OWNER TO taedori;

--
-- Name: shipping_weightband_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE shipping_weightband_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipping_weightband_id_seq OWNER TO taedori;

--
-- Name: shipping_weightband_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE shipping_weightband_id_seq OWNED BY shipping_weightband.id;


--
-- Name: shipping_weightbased; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE shipping_weightbased (
    id integer NOT NULL,
    code character varying(128) NOT NULL,
    name character varying(128) NOT NULL,
    description text NOT NULL,
    default_weight numeric(12,3) NOT NULL
);


ALTER TABLE public.shipping_weightbased OWNER TO taedori;

--
-- Name: shipping_weightbased_countries; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE shipping_weightbased_countries (
    id integer NOT NULL,
    weightbased_id integer NOT NULL,
    country_id character varying(2) NOT NULL
);


ALTER TABLE public.shipping_weightbased_countries OWNER TO taedori;

--
-- Name: shipping_weightbased_countries_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE shipping_weightbased_countries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipping_weightbased_countries_id_seq OWNER TO taedori;

--
-- Name: shipping_weightbased_countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE shipping_weightbased_countries_id_seq OWNED BY shipping_weightbased_countries.id;


--
-- Name: shipping_weightbased_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE shipping_weightbased_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shipping_weightbased_id_seq OWNER TO taedori;

--
-- Name: shipping_weightbased_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE shipping_weightbased_id_seq OWNED BY shipping_weightbased.id;


--
-- Name: taggit_tag; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE taggit_tag (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    slug character varying(100) NOT NULL
);


ALTER TABLE public.taggit_tag OWNER TO taedori;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE taggit_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_tag_id_seq OWNER TO taedori;

--
-- Name: taggit_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE taggit_tag_id_seq OWNED BY taggit_tag.id;


--
-- Name: taggit_taggeditem; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE taggit_taggeditem (
    id integer NOT NULL,
    object_id integer NOT NULL,
    content_type_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.taggit_taggeditem OWNER TO taedori;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE taggit_taggeditem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.taggit_taggeditem_id_seq OWNER TO taedori;

--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE taggit_taggeditem_id_seq OWNED BY taggit_taggeditem.id;


--
-- Name: thumbnail_kvstore; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE thumbnail_kvstore (
    key character varying(200) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.thumbnail_kvstore OWNER TO taedori;

--
-- Name: voucher_voucher; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE voucher_voucher (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    code character varying(128) NOT NULL,
    usage character varying(128) NOT NULL,
    start_datetime timestamp with time zone NOT NULL,
    end_datetime timestamp with time zone NOT NULL,
    num_basket_additions integer NOT NULL,
    num_orders integer NOT NULL,
    total_discount numeric(12,2) NOT NULL,
    date_created date NOT NULL,
    CONSTRAINT voucher_voucher_num_basket_additions_check CHECK ((num_basket_additions >= 0)),
    CONSTRAINT voucher_voucher_num_orders_check CHECK ((num_orders >= 0))
);


ALTER TABLE public.voucher_voucher OWNER TO taedori;

--
-- Name: voucher_voucher_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE voucher_voucher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.voucher_voucher_id_seq OWNER TO taedori;

--
-- Name: voucher_voucher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE voucher_voucher_id_seq OWNED BY voucher_voucher.id;


--
-- Name: voucher_voucher_offers; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE voucher_voucher_offers (
    id integer NOT NULL,
    voucher_id integer NOT NULL,
    conditionaloffer_id integer NOT NULL
);


ALTER TABLE public.voucher_voucher_offers OWNER TO taedori;

--
-- Name: voucher_voucher_offers_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE voucher_voucher_offers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.voucher_voucher_offers_id_seq OWNER TO taedori;

--
-- Name: voucher_voucher_offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE voucher_voucher_offers_id_seq OWNED BY voucher_voucher_offers.id;


--
-- Name: voucher_voucherapplication; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE voucher_voucherapplication (
    id integer NOT NULL,
    date_created date NOT NULL,
    order_id integer NOT NULL,
    user_id integer,
    voucher_id integer NOT NULL
);


ALTER TABLE public.voucher_voucherapplication OWNER TO taedori;

--
-- Name: voucher_voucherapplication_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE voucher_voucherapplication_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.voucher_voucherapplication_id_seq OWNER TO taedori;

--
-- Name: voucher_voucherapplication_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE voucher_voucherapplication_id_seq OWNED BY voucher_voucherapplication.id;


--
-- Name: wagtailcore_grouppagepermission; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailcore_grouppagepermission (
    id integer NOT NULL,
    permission_type character varying(20) NOT NULL,
    group_id integer NOT NULL,
    page_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_grouppagepermission OWNER TO taedori;

--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailcore_grouppagepermission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_grouppagepermission_id_seq OWNER TO taedori;

--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailcore_grouppagepermission_id_seq OWNED BY wagtailcore_grouppagepermission.id;


--
-- Name: wagtailcore_page; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailcore_page (
    id integer NOT NULL,
    path character varying(255) NOT NULL,
    depth integer NOT NULL,
    numchild integer NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    live boolean NOT NULL,
    has_unpublished_changes boolean NOT NULL,
    url_path text NOT NULL,
    seo_title character varying(255) NOT NULL,
    show_in_menus boolean NOT NULL,
    search_description text NOT NULL,
    go_live_at timestamp with time zone,
    expire_at timestamp with time zone,
    expired boolean NOT NULL,
    content_type_id integer NOT NULL,
    owner_id integer,
    locked boolean NOT NULL,
    latest_revision_created_at timestamp with time zone,
    first_published_at timestamp with time zone,
    CONSTRAINT wagtailcore_page_depth_check CHECK ((depth >= 0)),
    CONSTRAINT wagtailcore_page_numchild_check CHECK ((numchild >= 0))
);


ALTER TABLE public.wagtailcore_page OWNER TO taedori;

--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailcore_page_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_page_id_seq OWNER TO taedori;

--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailcore_page_id_seq OWNED BY wagtailcore_page.id;


--
-- Name: wagtailcore_pagerevision; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailcore_pagerevision (
    id integer NOT NULL,
    submitted_for_moderation boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    content_json text NOT NULL,
    approved_go_live_at timestamp with time zone,
    page_id integer NOT NULL,
    user_id integer
);


ALTER TABLE public.wagtailcore_pagerevision OWNER TO taedori;

--
-- Name: wagtailcore_pagerevision_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailcore_pagerevision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pagerevision_id_seq OWNER TO taedori;

--
-- Name: wagtailcore_pagerevision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailcore_pagerevision_id_seq OWNED BY wagtailcore_pagerevision.id;


--
-- Name: wagtailcore_pageviewrestriction; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailcore_pageviewrestriction (
    id integer NOT NULL,
    password character varying(255) NOT NULL,
    page_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_pageviewrestriction OWNER TO taedori;

--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailcore_pageviewrestriction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_pageviewrestriction_id_seq OWNER TO taedori;

--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailcore_pageviewrestriction_id_seq OWNED BY wagtailcore_pageviewrestriction.id;


--
-- Name: wagtailcore_site; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailcore_site (
    id integer NOT NULL,
    hostname character varying(255) NOT NULL,
    port integer NOT NULL,
    is_default_site boolean NOT NULL,
    root_page_id integer NOT NULL
);


ALTER TABLE public.wagtailcore_site OWNER TO taedori;

--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailcore_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailcore_site_id_seq OWNER TO taedori;

--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailcore_site_id_seq OWNED BY wagtailcore_site.id;


--
-- Name: wagtaildocs_document; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtaildocs_document (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    file character varying(100) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    uploaded_by_user_id integer
);


ALTER TABLE public.wagtaildocs_document OWNER TO taedori;

--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtaildocs_document_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtaildocs_document_id_seq OWNER TO taedori;

--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtaildocs_document_id_seq OWNED BY wagtaildocs_document.id;


--
-- Name: wagtailembeds_embed; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailembeds_embed (
    id integer NOT NULL,
    url character varying(200) NOT NULL,
    max_width smallint,
    type character varying(10) NOT NULL,
    html text NOT NULL,
    title text NOT NULL,
    author_name text NOT NULL,
    provider_name text NOT NULL,
    thumbnail_url character varying(200),
    width integer,
    height integer,
    last_updated timestamp with time zone NOT NULL
);


ALTER TABLE public.wagtailembeds_embed OWNER TO taedori;

--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailembeds_embed_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailembeds_embed_id_seq OWNER TO taedori;

--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailembeds_embed_id_seq OWNED BY wagtailembeds_embed.id;


--
-- Name: wagtailforms_formsubmission; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailforms_formsubmission (
    id integer NOT NULL,
    form_data text NOT NULL,
    submit_time timestamp with time zone NOT NULL,
    page_id integer NOT NULL
);


ALTER TABLE public.wagtailforms_formsubmission OWNER TO taedori;

--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailforms_formsubmission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailforms_formsubmission_id_seq OWNER TO taedori;

--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailforms_formsubmission_id_seq OWNED BY wagtailforms_formsubmission.id;


--
-- Name: wagtailimages_filter; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailimages_filter (
    id integer NOT NULL,
    spec character varying(255) NOT NULL
);


ALTER TABLE public.wagtailimages_filter OWNER TO taedori;

--
-- Name: wagtailimages_filter_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailimages_filter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailimages_filter_id_seq OWNER TO taedori;

--
-- Name: wagtailimages_filter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailimages_filter_id_seq OWNED BY wagtailimages_filter.id;


--
-- Name: wagtailimages_image; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailimages_image (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    file character varying(100) NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    focal_point_x integer,
    focal_point_y integer,
    focal_point_width integer,
    focal_point_height integer,
    uploaded_by_user_id integer,
    file_size integer,
    CONSTRAINT wagtailimages_image_file_size_check CHECK ((file_size >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_height_check CHECK ((focal_point_height >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_width_check CHECK ((focal_point_width >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_x_check CHECK ((focal_point_x >= 0)),
    CONSTRAINT wagtailimages_image_focal_point_y_check CHECK ((focal_point_y >= 0))
);


ALTER TABLE public.wagtailimages_image OWNER TO taedori;

--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailimages_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailimages_image_id_seq OWNER TO taedori;

--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailimages_image_id_seq OWNED BY wagtailimages_image.id;


--
-- Name: wagtailimages_rendition; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailimages_rendition (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    focal_point_key character varying(255) NOT NULL,
    filter_id integer NOT NULL,
    image_id integer NOT NULL
);


ALTER TABLE public.wagtailimages_rendition OWNER TO taedori;

--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailimages_rendition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailimages_rendition_id_seq OWNER TO taedori;

--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailimages_rendition_id_seq OWNED BY wagtailimages_rendition.id;


--
-- Name: wagtailredirects_redirect; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailredirects_redirect (
    id integer NOT NULL,
    old_path character varying(255) NOT NULL,
    is_permanent boolean NOT NULL,
    redirect_link character varying(200) NOT NULL,
    redirect_page_id integer,
    site_id integer
);


ALTER TABLE public.wagtailredirects_redirect OWNER TO taedori;

--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailredirects_redirect_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailredirects_redirect_id_seq OWNER TO taedori;

--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailredirects_redirect_id_seq OWNED BY wagtailredirects_redirect.id;


--
-- Name: wagtailsearch_editorspick; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailsearch_editorspick (
    id integer NOT NULL,
    sort_order integer,
    description text NOT NULL,
    page_id integer NOT NULL,
    query_id integer NOT NULL
);


ALTER TABLE public.wagtailsearch_editorspick OWNER TO taedori;

--
-- Name: wagtailsearch_editorspick_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailsearch_editorspick_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailsearch_editorspick_id_seq OWNER TO taedori;

--
-- Name: wagtailsearch_editorspick_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailsearch_editorspick_id_seq OWNED BY wagtailsearch_editorspick.id;


--
-- Name: wagtailsearch_query; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailsearch_query (
    id integer NOT NULL,
    query_string character varying(255) NOT NULL
);


ALTER TABLE public.wagtailsearch_query OWNER TO taedori;

--
-- Name: wagtailsearch_query_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailsearch_query_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailsearch_query_id_seq OWNER TO taedori;

--
-- Name: wagtailsearch_query_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailsearch_query_id_seq OWNED BY wagtailsearch_query.id;


--
-- Name: wagtailsearch_querydailyhits; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailsearch_querydailyhits (
    id integer NOT NULL,
    date date NOT NULL,
    hits integer NOT NULL,
    query_id integer NOT NULL
);


ALTER TABLE public.wagtailsearch_querydailyhits OWNER TO taedori;

--
-- Name: wagtailsearch_querydailyhits_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailsearch_querydailyhits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailsearch_querydailyhits_id_seq OWNER TO taedori;

--
-- Name: wagtailsearch_querydailyhits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailsearch_querydailyhits_id_seq OWNED BY wagtailsearch_querydailyhits.id;


--
-- Name: wagtailusers_userprofile; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wagtailusers_userprofile (
    id integer NOT NULL,
    submitted_notifications boolean NOT NULL,
    approved_notifications boolean NOT NULL,
    rejected_notifications boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.wagtailusers_userprofile OWNER TO taedori;

--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wagtailusers_userprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wagtailusers_userprofile_id_seq OWNER TO taedori;

--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wagtailusers_userprofile_id_seq OWNED BY wagtailusers_userprofile.id;


--
-- Name: wishlists_line; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wishlists_line (
    id integer NOT NULL,
    quantity integer NOT NULL,
    title character varying(255) NOT NULL,
    product_id integer,
    wishlist_id integer NOT NULL,
    CONSTRAINT wishlists_line_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.wishlists_line OWNER TO taedori;

--
-- Name: wishlists_line_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wishlists_line_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wishlists_line_id_seq OWNER TO taedori;

--
-- Name: wishlists_line_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wishlists_line_id_seq OWNED BY wishlists_line.id;


--
-- Name: wishlists_wishlist; Type: TABLE; Schema: public; Owner: taedori; Tablespace: 
--

CREATE TABLE wishlists_wishlist (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(6) NOT NULL,
    visibility character varying(20) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    owner_id integer NOT NULL
);


ALTER TABLE public.wishlists_wishlist OWNER TO taedori;

--
-- Name: wishlists_wishlist_id_seq; Type: SEQUENCE; Schema: public; Owner: taedori
--

CREATE SEQUENCE wishlists_wishlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wishlists_wishlist_id_seq OWNER TO taedori;

--
-- Name: wishlists_wishlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: taedori
--

ALTER SEQUENCE wishlists_wishlist_id_seq OWNED BY wishlists_wishlist.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY address_useraddress ALTER COLUMN id SET DEFAULT nextval('address_useraddress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY analytics_productrecord ALTER COLUMN id SET DEFAULT nextval('analytics_productrecord_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY analytics_userproductview ALTER COLUMN id SET DEFAULT nextval('analytics_userproductview_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY analytics_userrecord ALTER COLUMN id SET DEFAULT nextval('analytics_userrecord_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY analytics_usersearch ALTER COLUMN id SET DEFAULT nextval('analytics_usersearch_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_basket ALTER COLUMN id SET DEFAULT nextval('basket_basket_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_basket_vouchers ALTER COLUMN id SET DEFAULT nextval('basket_basket_vouchers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_line ALTER COLUMN id SET DEFAULT nextval('basket_line_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_lineattribute ALTER COLUMN id SET DEFAULT nextval('basket_lineattribute_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_attributeoption ALTER COLUMN id SET DEFAULT nextval('catalogue_attributeoption_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_attributeoptiongroup ALTER COLUMN id SET DEFAULT nextval('catalogue_attributeoptiongroup_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_category ALTER COLUMN id SET DEFAULT nextval('catalogue_category_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_option ALTER COLUMN id SET DEFAULT nextval('catalogue_option_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_product ALTER COLUMN id SET DEFAULT nextval('catalogue_product_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_product_product_options ALTER COLUMN id SET DEFAULT nextval('catalogue_product_product_options_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productattribute ALTER COLUMN id SET DEFAULT nextval('catalogue_productattribute_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productattributevalue ALTER COLUMN id SET DEFAULT nextval('catalogue_productattributevalue_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productcategory ALTER COLUMN id SET DEFAULT nextval('catalogue_productcategory_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productclass ALTER COLUMN id SET DEFAULT nextval('catalogue_productclass_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productclass_options ALTER COLUMN id SET DEFAULT nextval('catalogue_productclass_options_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productimage ALTER COLUMN id SET DEFAULT nextval('catalogue_productimage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productrecommendation ALTER COLUMN id SET DEFAULT nextval('catalogue_productrecommendation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY customer_communicationeventtype ALTER COLUMN id SET DEFAULT nextval('customer_communicationeventtype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY customer_email ALTER COLUMN id SET DEFAULT nextval('customer_email_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY customer_notification ALTER COLUMN id SET DEFAULT nextval('customer_notification_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY customer_productalert ALTER COLUMN id SET DEFAULT nextval('customer_productalert_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY django_flatpage ALTER COLUMN id SET DEFAULT nextval('django_flatpage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY django_flatpage_sites ALTER COLUMN id SET DEFAULT nextval('django_flatpage_sites_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_benefit ALTER COLUMN id SET DEFAULT nextval('offer_benefit_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_condition ALTER COLUMN id SET DEFAULT nextval('offer_condition_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_conditionaloffer ALTER COLUMN id SET DEFAULT nextval('offer_conditionaloffer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_range ALTER COLUMN id SET DEFAULT nextval('offer_range_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_range_classes ALTER COLUMN id SET DEFAULT nextval('offer_range_classes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_range_excluded_products ALTER COLUMN id SET DEFAULT nextval('offer_range_excluded_products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_range_included_categories ALTER COLUMN id SET DEFAULT nextval('offer_range_included_categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_rangeproduct ALTER COLUMN id SET DEFAULT nextval('offer_rangeproduct_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_rangeproductfileupload ALTER COLUMN id SET DEFAULT nextval('offer_rangeproductfileupload_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_billingaddress ALTER COLUMN id SET DEFAULT nextval('order_billingaddress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_communicationevent ALTER COLUMN id SET DEFAULT nextval('order_communicationevent_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_line ALTER COLUMN id SET DEFAULT nextval('order_line_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_lineattribute ALTER COLUMN id SET DEFAULT nextval('order_lineattribute_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_lineprice ALTER COLUMN id SET DEFAULT nextval('order_lineprice_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_order ALTER COLUMN id SET DEFAULT nextval('order_order_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_orderdiscount ALTER COLUMN id SET DEFAULT nextval('order_orderdiscount_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_ordernote ALTER COLUMN id SET DEFAULT nextval('order_ordernote_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_paymentevent ALTER COLUMN id SET DEFAULT nextval('order_paymentevent_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_paymenteventquantity ALTER COLUMN id SET DEFAULT nextval('order_paymenteventquantity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_paymenteventtype ALTER COLUMN id SET DEFAULT nextval('order_paymenteventtype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_shippingaddress ALTER COLUMN id SET DEFAULT nextval('order_shippingaddress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_shippingevent ALTER COLUMN id SET DEFAULT nextval('order_shippingevent_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_shippingeventquantity ALTER COLUMN id SET DEFAULT nextval('order_shippingeventquantity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_shippingeventtype ALTER COLUMN id SET DEFAULT nextval('order_shippingeventtype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_partner ALTER COLUMN id SET DEFAULT nextval('partner_partner_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_partner_users ALTER COLUMN id SET DEFAULT nextval('partner_partner_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_partneraddress ALTER COLUMN id SET DEFAULT nextval('partner_partneraddress_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_stockalert ALTER COLUMN id SET DEFAULT nextval('partner_stockalert_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_stockrecord ALTER COLUMN id SET DEFAULT nextval('partner_stockrecord_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payment_bankcard ALTER COLUMN id SET DEFAULT nextval('payment_bankcard_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payment_source ALTER COLUMN id SET DEFAULT nextval('payment_source_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payment_sourcetype ALTER COLUMN id SET DEFAULT nextval('payment_sourcetype_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payment_transaction ALTER COLUMN id SET DEFAULT nextval('payment_transaction_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_charge ALTER COLUMN id SET DEFAULT nextval('payments_charge_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_currentsubscription ALTER COLUMN id SET DEFAULT nextval('payments_currentsubscription_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_customer ALTER COLUMN id SET DEFAULT nextval('payments_customer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_event ALTER COLUMN id SET DEFAULT nextval('payments_event_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_eventprocessingexception ALTER COLUMN id SET DEFAULT nextval('payments_eventprocessingexception_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_invoice ALTER COLUMN id SET DEFAULT nextval('payments_invoice_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_invoiceitem ALTER COLUMN id SET DEFAULT nextval('payments_invoiceitem_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_transfer ALTER COLUMN id SET DEFAULT nextval('payments_transfer_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_transferchargefee ALTER COLUMN id SET DEFAULT nextval('payments_transferchargefee_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY paypal_expresstransaction ALTER COLUMN id SET DEFAULT nextval('paypal_expresstransaction_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY paypal_payflowtransaction ALTER COLUMN id SET DEFAULT nextval('paypal_payflowtransaction_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_automaticproductlist ALTER COLUMN id SET DEFAULT nextval('promotions_automaticproductlist_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_handpickedproductlist ALTER COLUMN id SET DEFAULT nextval('promotions_handpickedproductlist_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_image ALTER COLUMN id SET DEFAULT nextval('promotions_image_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_keywordpromotion ALTER COLUMN id SET DEFAULT nextval('promotions_keywordpromotion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_multiimage ALTER COLUMN id SET DEFAULT nextval('promotions_multiimage_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_multiimage_images ALTER COLUMN id SET DEFAULT nextval('promotions_multiimage_images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_orderedproduct ALTER COLUMN id SET DEFAULT nextval('promotions_orderedproduct_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_pagepromotion ALTER COLUMN id SET DEFAULT nextval('promotions_pagepromotion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_rawhtml ALTER COLUMN id SET DEFAULT nextval('promotions_rawhtml_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_singleproduct ALTER COLUMN id SET DEFAULT nextval('promotions_singleproduct_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_tabbedblock ALTER COLUMN id SET DEFAULT nextval('promotions_tabbedblock_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY reviews_productreview ALTER COLUMN id SET DEFAULT nextval('reviews_productreview_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY reviews_vote ALTER COLUMN id SET DEFAULT nextval('reviews_vote_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY shipping_orderanditemcharges ALTER COLUMN id SET DEFAULT nextval('shipping_orderanditemcharges_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY shipping_orderanditemcharges_countries ALTER COLUMN id SET DEFAULT nextval('shipping_orderanditemcharges_countries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY shipping_weightband ALTER COLUMN id SET DEFAULT nextval('shipping_weightband_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY shipping_weightbased ALTER COLUMN id SET DEFAULT nextval('shipping_weightbased_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY shipping_weightbased_countries ALTER COLUMN id SET DEFAULT nextval('shipping_weightbased_countries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY taggit_tag ALTER COLUMN id SET DEFAULT nextval('taggit_tag_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY taggit_taggeditem ALTER COLUMN id SET DEFAULT nextval('taggit_taggeditem_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY voucher_voucher ALTER COLUMN id SET DEFAULT nextval('voucher_voucher_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY voucher_voucher_offers ALTER COLUMN id SET DEFAULT nextval('voucher_voucher_offers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY voucher_voucherapplication ALTER COLUMN id SET DEFAULT nextval('voucher_voucherapplication_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_grouppagepermission ALTER COLUMN id SET DEFAULT nextval('wagtailcore_grouppagepermission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_page ALTER COLUMN id SET DEFAULT nextval('wagtailcore_page_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_pagerevision ALTER COLUMN id SET DEFAULT nextval('wagtailcore_pagerevision_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_pageviewrestriction ALTER COLUMN id SET DEFAULT nextval('wagtailcore_pageviewrestriction_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_site ALTER COLUMN id SET DEFAULT nextval('wagtailcore_site_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtaildocs_document ALTER COLUMN id SET DEFAULT nextval('wagtaildocs_document_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailembeds_embed ALTER COLUMN id SET DEFAULT nextval('wagtailembeds_embed_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailforms_formsubmission ALTER COLUMN id SET DEFAULT nextval('wagtailforms_formsubmission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailimages_filter ALTER COLUMN id SET DEFAULT nextval('wagtailimages_filter_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailimages_image ALTER COLUMN id SET DEFAULT nextval('wagtailimages_image_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailimages_rendition ALTER COLUMN id SET DEFAULT nextval('wagtailimages_rendition_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailredirects_redirect ALTER COLUMN id SET DEFAULT nextval('wagtailredirects_redirect_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailsearch_editorspick ALTER COLUMN id SET DEFAULT nextval('wagtailsearch_editorspick_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailsearch_query ALTER COLUMN id SET DEFAULT nextval('wagtailsearch_query_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailsearch_querydailyhits ALTER COLUMN id SET DEFAULT nextval('wagtailsearch_querydailyhits_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailusers_userprofile ALTER COLUMN id SET DEFAULT nextval('wagtailusers_userprofile_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wishlists_line ALTER COLUMN id SET DEFAULT nextval('wishlists_line_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wishlists_wishlist ALTER COLUMN id SET DEFAULT nextval('wishlists_wishlist_id_seq'::regclass);


--
-- Data for Name: address_country; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY address_country (iso_3166_1_a2, iso_3166_1_a3, iso_3166_1_numeric, printable_name, name, display_order, is_shipping_country) FROM stdin;
AF	AFG	004	Afghanistan	Islamic Republic of Afghanistan	0	f
AX	ALA	248	Åland Islands		0	f
AL	ALB	008	Albania	Republic of Albania	0	f
DZ	DZA	012	Algeria	People's Democratic Republic of Algeria	0	f
AS	ASM	016	American Samoa		0	f
AD	AND	020	Andorra	Principality of Andorra	0	f
AO	AGO	024	Angola	Republic of Angola	0	f
AI	AIA	660	Anguilla		0	f
AQ	ATA	010	Antarctica		0	f
AG	ATG	028	Antigua and Barbuda		0	f
AR	ARG	032	Argentina	Argentine Republic	0	f
AM	ARM	051	Armenia	Republic of Armenia	0	f
AW	ABW	533	Aruba		0	f
AU	AUS	036	Australia		0	f
AT	AUT	040	Austria	Republic of Austria	0	f
AZ	AZE	031	Azerbaijan	Republic of Azerbaijan	0	f
BS	BHS	044	Bahamas	Commonwealth of the Bahamas	0	f
BH	BHR	048	Bahrain	Kingdom of Bahrain	0	f
BD	BGD	050	Bangladesh	People's Republic of Bangladesh	0	f
BB	BRB	052	Barbados		0	f
BY	BLR	112	Belarus	Republic of Belarus	0	f
BE	BEL	056	Belgium	Kingdom of Belgium	0	f
BZ	BLZ	084	Belize		0	f
BJ	BEN	204	Benin	Republic of Benin	0	f
BM	BMU	060	Bermuda		0	f
BT	BTN	064	Bhutan	Kingdom of Bhutan	0	f
BO	BOL	068	Bolivia, Plurinational State of	Plurinational State of Bolivia	0	f
BQ	BES	535	Bonaire, Sint Eustatius and Saba	Bonaire, Sint Eustatius and Saba	0	f
BA	BIH	070	Bosnia and Herzegovina	Republic of Bosnia and Herzegovina	0	f
BW	BWA	072	Botswana	Republic of Botswana	0	f
BV	BVT	074	Bouvet Island		0	f
BR	BRA	076	Brazil	Federative Republic of Brazil	0	f
IO	IOT	086	British Indian Ocean Territory		0	f
BN	BRN	096	Brunei Darussalam		0	f
BG	BGR	100	Bulgaria	Republic of Bulgaria	0	f
BF	BFA	854	Burkina Faso		0	f
BI	BDI	108	Burundi	Republic of Burundi	0	f
KH	KHM	116	Cambodia	Kingdom of Cambodia	0	f
CM	CMR	120	Cameroon	Republic of Cameroon	0	f
CA	CAN	124	Canada		0	f
CV	CPV	132	Cape Verde	Republic of Cape Verde	0	f
KY	CYM	136	Cayman Islands		0	f
CF	CAF	140	Central African Republic		0	f
TD	TCD	148	Chad	Republic of Chad	0	f
CL	CHL	152	Chile	Republic of Chile	0	f
CN	CHN	156	China	People's Republic of China	0	f
CX	CXR	162	Christmas Island		0	f
CC	CCK	166	Cocos (Keeling) Islands		0	f
CO	COL	170	Colombia	Republic of Colombia	0	f
KM	COM	174	Comoros	Union of the Comoros	0	f
CG	COG	178	Congo	Republic of the Congo	0	f
CD	COD	180	Congo, The Democratic Republic of the		0	f
CK	COK	184	Cook Islands		0	f
CR	CRI	188	Costa Rica	Republic of Costa Rica	0	f
CI	CIV	384	Côte d'Ivoire	Republic of Côte d'Ivoire	0	f
HR	HRV	191	Croatia	Republic of Croatia	0	f
CU	CUB	192	Cuba	Republic of Cuba	0	f
CW	CUW	531	Curaçao	Curaçao	0	f
CY	CYP	196	Cyprus	Republic of Cyprus	0	f
CZ	CZE	203	Czech Republic		0	f
DK	DNK	208	Denmark	Kingdom of Denmark	0	f
DJ	DJI	262	Djibouti	Republic of Djibouti	0	f
DM	DMA	212	Dominica	Commonwealth of Dominica	0	f
DO	DOM	214	Dominican Republic		0	f
EC	ECU	218	Ecuador	Republic of Ecuador	0	f
EG	EGY	818	Egypt	Arab Republic of Egypt	0	f
SV	SLV	222	El Salvador	Republic of El Salvador	0	f
GQ	GNQ	226	Equatorial Guinea	Republic of Equatorial Guinea	0	f
ER	ERI	232	Eritrea	the State of Eritrea	0	f
EE	EST	233	Estonia	Republic of Estonia	0	f
ET	ETH	231	Ethiopia	Federal Democratic Republic of Ethiopia	0	f
FK	FLK	238	Falkland Islands (Malvinas)		0	f
FO	FRO	234	Faroe Islands		0	f
FJ	FJI	242	Fiji	Republic of Fiji	0	f
FI	FIN	246	Finland	Republic of Finland	0	f
FR	FRA	250	France	French Republic	0	f
GF	GUF	254	French Guiana		0	f
PF	PYF	258	French Polynesia		0	f
TF	ATF	260	French Southern Territories		0	f
GA	GAB	266	Gabon	Gabonese Republic	0	f
GM	GMB	270	Gambia	Republic of the Gambia	0	f
GE	GEO	268	Georgia		0	f
DE	DEU	276	Germany	Federal Republic of Germany	0	f
GH	GHA	288	Ghana	Republic of Ghana	0	f
GI	GIB	292	Gibraltar		0	f
GR	GRC	300	Greece	Hellenic Republic	0	f
GL	GRL	304	Greenland		0	f
GD	GRD	308	Grenada		0	f
GP	GLP	312	Guadeloupe		0	f
GU	GUM	316	Guam		0	f
GT	GTM	320	Guatemala	Republic of Guatemala	0	f
GG	GGY	831	Guernsey		0	f
GN	GIN	324	Guinea	Republic of Guinea	0	f
GW	GNB	624	Guinea-Bissau	Republic of Guinea-Bissau	0	f
GY	GUY	328	Guyana	Republic of Guyana	0	f
HT	HTI	332	Haiti	Republic of Haiti	0	f
HM	HMD	334	Heard Island and McDonald Islands		0	f
VA	VAT	336	Holy See (Vatican City State)		0	f
HN	HND	340	Honduras	Republic of Honduras	0	f
HK	HKG	344	Hong Kong	Hong Kong Special Administrative Region of China	0	f
HU	HUN	348	Hungary	Hungary	0	f
IS	ISL	352	Iceland	Republic of Iceland	0	f
IN	IND	356	India	Republic of India	0	f
ID	IDN	360	Indonesia	Republic of Indonesia	0	f
IR	IRN	364	Iran, Islamic Republic of	Islamic Republic of Iran	0	f
IQ	IRQ	368	Iraq	Republic of Iraq	0	f
IE	IRL	372	Ireland		0	f
IM	IMN	833	Isle of Man		0	f
IL	ISR	376	Israel	State of Israel	0	f
IT	ITA	380	Italy	Italian Republic	0	f
JM	JAM	388	Jamaica		0	f
JP	JPN	392	Japan		0	f
JE	JEY	832	Jersey		0	f
JO	JOR	400	Jordan	Hashemite Kingdom of Jordan	0	f
KZ	KAZ	398	Kazakhstan	Republic of Kazakhstan	0	f
KE	KEN	404	Kenya	Republic of Kenya	0	f
KI	KIR	296	Kiribati	Republic of Kiribati	0	f
KP	PRK	408	Korea, Democratic People's Republic of	Democratic People's Republic of Korea	0	f
KR	KOR	410	Korea, Republic of		0	f
KW	KWT	414	Kuwait	State of Kuwait	0	f
KG	KGZ	417	Kyrgyzstan	Kyrgyz Republic	0	f
LA	LAO	418	Lao People's Democratic Republic		0	f
LV	LVA	428	Latvia	Republic of Latvia	0	f
LB	LBN	422	Lebanon	Lebanese Republic	0	f
LS	LSO	426	Lesotho	Kingdom of Lesotho	0	f
LR	LBR	430	Liberia	Republic of Liberia	0	f
LY	LBY	434	Libya	Libya	0	f
LI	LIE	438	Liechtenstein	Principality of Liechtenstein	0	f
LT	LTU	440	Lithuania	Republic of Lithuania	0	f
LU	LUX	442	Luxembourg	Grand Duchy of Luxembourg	0	f
MO	MAC	446	Macao	Macao Special Administrative Region of China	0	f
MK	MKD	807	Macedonia, Republic of	The Former Yugoslav Republic of Macedonia	0	f
MG	MDG	450	Madagascar	Republic of Madagascar	0	f
MW	MWI	454	Malawi	Republic of Malawi	0	f
MY	MYS	458	Malaysia		0	f
MV	MDV	462	Maldives	Republic of Maldives	0	f
ML	MLI	466	Mali	Republic of Mali	0	f
MT	MLT	470	Malta	Republic of Malta	0	f
MH	MHL	584	Marshall Islands	Republic of the Marshall Islands	0	f
MQ	MTQ	474	Martinique		0	f
MR	MRT	478	Mauritania	Islamic Republic of Mauritania	0	f
MU	MUS	480	Mauritius	Republic of Mauritius	0	f
YT	MYT	175	Mayotte		0	f
MX	MEX	484	Mexico	United Mexican States	0	f
FM	FSM	583	Micronesia, Federated States of	Federated States of Micronesia	0	f
MD	MDA	498	Moldova, Republic of	Republic of Moldova	0	f
MC	MCO	492	Monaco	Principality of Monaco	0	f
MN	MNG	496	Mongolia		0	f
ME	MNE	499	Montenegro	Montenegro	0	f
MS	MSR	500	Montserrat		0	f
MA	MAR	504	Morocco	Kingdom of Morocco	0	f
MZ	MOZ	508	Mozambique	Republic of Mozambique	0	f
MM	MMR	104	Myanmar	Republic of Myanmar	0	f
NA	NAM	516	Namibia	Republic of Namibia	0	f
NR	NRU	520	Nauru	Republic of Nauru	0	f
NP	NPL	524	Nepal	Federal Democratic Republic of Nepal	0	f
NL	NLD	528	Netherlands	Kingdom of the Netherlands	0	f
NC	NCL	540	New Caledonia		0	f
NZ	NZL	554	New Zealand		0	f
NI	NIC	558	Nicaragua	Republic of Nicaragua	0	f
NE	NER	562	Niger	Republic of the Niger	0	f
NG	NGA	566	Nigeria	Federal Republic of Nigeria	0	f
NU	NIU	570	Niue	Niue	0	f
NF	NFK	574	Norfolk Island		0	f
MP	MNP	580	Northern Mariana Islands	Commonwealth of the Northern Mariana Islands	0	f
NO	NOR	578	Norway	Kingdom of Norway	0	f
OM	OMN	512	Oman	Sultanate of Oman	0	f
PK	PAK	586	Pakistan	Islamic Republic of Pakistan	0	f
PW	PLW	585	Palau	Republic of Palau	0	f
PS	PSE	275	Palestine, State of	the State of Palestine	0	f
PA	PAN	591	Panama	Republic of Panama	0	f
PG	PNG	598	Papua New Guinea	Independent State of Papua New Guinea	0	f
PY	PRY	600	Paraguay	Republic of Paraguay	0	f
PE	PER	604	Peru	Republic of Peru	0	f
PH	PHL	608	Philippines	Republic of the Philippines	0	f
PN	PCN	612	Pitcairn		0	f
PL	POL	616	Poland	Republic of Poland	0	f
PT	PRT	620	Portugal	Portuguese Republic	0	f
PR	PRI	630	Puerto Rico		0	f
QA	QAT	634	Qatar	State of Qatar	0	f
RE	REU	638	Réunion		0	f
RO	ROU	642	Romania		0	f
RU	RUS	643	Russian Federation		0	f
RW	RWA	646	Rwanda	Rwandese Republic	0	f
BL	BLM	652	Saint Barthélemy		0	f
SH	SHN	654	Saint Helena, Ascension and Tristan da Cunha		0	f
KN	KNA	659	Saint Kitts and Nevis		0	f
LC	LCA	662	Saint Lucia		0	f
MF	MAF	663	Saint Martin (French part)		0	f
PM	SPM	666	Saint Pierre and Miquelon		0	f
VC	VCT	670	Saint Vincent and the Grenadines		0	f
WS	WSM	882	Samoa	Independent State of Samoa	0	f
SM	SMR	674	San Marino	Republic of San Marino	0	f
ST	STP	678	Sao Tome and Principe	Democratic Republic of Sao Tome and Principe	0	f
SA	SAU	682	Saudi Arabia	Kingdom of Saudi Arabia	0	f
SN	SEN	686	Senegal	Republic of Senegal	0	f
RS	SRB	688	Serbia	Republic of Serbia	0	f
SC	SYC	690	Seychelles	Republic of Seychelles	0	f
SL	SLE	694	Sierra Leone	Republic of Sierra Leone	0	f
SG	SGP	702	Singapore	Republic of Singapore	0	f
SX	SXM	534	Sint Maarten (Dutch part)	Sint Maarten (Dutch part)	0	f
SK	SVK	703	Slovakia	Slovak Republic	0	f
SI	SVN	705	Slovenia	Republic of Slovenia	0	f
SB	SLB	090	Solomon Islands		0	f
SO	SOM	706	Somalia	Federal Republic of Somalia	0	f
ZA	ZAF	710	South Africa	Republic of South Africa	0	f
GS	SGS	239	South Georgia and the South Sandwich Islands		0	f
ES	ESP	724	Spain	Kingdom of Spain	0	f
LK	LKA	144	Sri Lanka	Democratic Socialist Republic of Sri Lanka	0	f
SD	SDN	729	Sudan	Republic of the Sudan	0	f
SR	SUR	740	Suriname	Republic of Suriname	0	f
SS	SSD	728	South Sudan	Republic of South Sudan	0	f
SJ	SJM	744	Svalbard and Jan Mayen		0	f
SZ	SWZ	748	Swaziland	Kingdom of Swaziland	0	f
SE	SWE	752	Sweden	Kingdom of Sweden	0	f
CH	CHE	756	Switzerland	Swiss Confederation	0	f
SY	SYR	760	Syrian Arab Republic		0	f
TW	TWN	158	Taiwan, Province of China	Taiwan, Province of China	0	f
TJ	TJK	762	Tajikistan	Republic of Tajikistan	0	f
TZ	TZA	834	Tanzania, United Republic of	United Republic of Tanzania	0	f
TH	THA	764	Thailand	Kingdom of Thailand	0	f
TL	TLS	626	Timor-Leste	Democratic Republic of Timor-Leste	0	f
TG	TGO	768	Togo	Togolese Republic	0	f
TK	TKL	772	Tokelau		0	f
TO	TON	776	Tonga	Kingdom of Tonga	0	f
TT	TTO	780	Trinidad and Tobago	Republic of Trinidad and Tobago	0	f
TN	TUN	788	Tunisia	Republic of Tunisia	0	f
TR	TUR	792	Turkey	Republic of Turkey	0	f
TM	TKM	795	Turkmenistan		0	f
TC	TCA	796	Turks and Caicos Islands		0	f
TV	TUV	798	Tuvalu		0	f
UG	UGA	800	Uganda	Republic of Uganda	0	f
UA	UKR	804	Ukraine		0	f
AE	ARE	784	United Arab Emirates		0	f
GB	GBR	826	United Kingdom	United Kingdom of Great Britain and Northern Ireland	0	f
UM	UMI	581	United States Minor Outlying Islands		0	f
UY	URY	858	Uruguay	Eastern Republic of Uruguay	0	f
UZ	UZB	860	Uzbekistan	Republic of Uzbekistan	0	f
VU	VUT	548	Vanuatu	Republic of Vanuatu	0	f
VE	VEN	862	Venezuela, Bolivarian Republic of	Bolivarian Republic of Venezuela	0	f
VN	VNM	704	Viet Nam	Socialist Republic of Viet Nam	0	f
VG	VGB	092	Virgin Islands, British	British Virgin Islands	0	f
VI	VIR	850	Virgin Islands, U.S.	Virgin Islands of the United States	0	f
WF	WLF	876	Wallis and Futuna		0	f
EH	ESH	732	Western Sahara		0	f
YE	YEM	887	Yemen	Republic of Yemen	0	f
ZM	ZMB	894	Zambia	Republic of Zambia	0	f
ZW	ZWE	716	Zimbabwe	Republic of Zimbabwe	0	f
US	USA	840	United States	United States of America	0	t
\.


--
-- Data for Name: address_useraddress; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY address_useraddress (id, title, first_name, last_name, line1, line2, line3, line4, state, postcode, search_text, phone_number, notes, is_default_for_shipping, is_default_for_billing, num_orders, hash, date_created, country_id, user_id) FROM stdin;
\.


--
-- Name: address_useraddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('address_useraddress_id_seq', 1, false);


--
-- Data for Name: analytics_productrecord; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY analytics_productrecord (id, num_views, num_basket_additions, num_purchases, score, product_id) FROM stdin;
5	0	1	0	0	5
1	48	0	0	0	2
2	8	0	0	0	6
3	0	1	0	0	11
4	0	1	0	0	12
\.


--
-- Name: analytics_productrecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('analytics_productrecord_id_seq', 5, true);


--
-- Data for Name: analytics_userproductview; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY analytics_userproductview (id, date_created, product_id, user_id) FROM stdin;
1	2015-12-07 11:00:12.260063-08	2	1
2	2015-12-07 11:02:36.107993-08	2	1
3	2015-12-07 11:06:03.256126-08	2	1
4	2015-12-07 11:15:03.532537-08	2	1
5	2015-12-07 11:41:04.493835-08	2	1
6	2015-12-07 11:41:35.57772-08	2	1
7	2015-12-07 11:42:15.780567-08	2	1
8	2015-12-07 11:42:50.841207-08	2	1
9	2015-12-07 11:44:41.160418-08	2	1
10	2015-12-07 11:46:27.182978-08	2	1
11	2015-12-07 11:51:26.047646-08	6	1
12	2015-12-07 11:56:51.510638-08	2	1
13	2015-12-07 11:59:15.531104-08	2	1
14	2015-12-07 12:04:05.930569-08	6	1
15	2015-12-07 12:07:21.860824-08	2	1
16	2015-12-07 12:08:11.434462-08	2	1
17	2015-12-07 12:08:55.915448-08	2	1
18	2015-12-07 12:10:12.778563-08	6	1
19	2015-12-07 13:21:06.100133-08	6	1
20	2015-12-07 13:22:01.03403-08	6	1
21	2015-12-07 13:41:00.38341-08	2	1
22	2015-12-07 13:48:03.531172-08	2	1
23	2015-12-07 13:49:14.960582-08	2	1
24	2015-12-07 13:49:33.416726-08	2	1
25	2015-12-07 13:50:16.520497-08	2	1
26	2015-12-07 16:01:01.055662-08	2	1
27	2015-12-07 16:02:04.91499-08	2	1
28	2015-12-07 16:02:38.454048-08	2	1
29	2015-12-07 16:04:54.606459-08	2	1
30	2015-12-07 16:05:11.594103-08	2	1
31	2015-12-07 16:05:53.444935-08	2	1
32	2015-12-07 16:10:52.596248-08	2	1
33	2015-12-07 16:20:50.238595-08	2	1
34	2015-12-07 16:21:28.751165-08	2	1
35	2015-12-07 16:26:05.967965-08	2	1
36	2015-12-07 16:36:26.697962-08	2	1
37	2015-12-07 16:38:10.735966-08	2	1
38	2015-12-07 16:40:08.088786-08	2	1
39	2015-12-07 16:40:26.661348-08	2	1
40	2015-12-07 16:41:27.574692-08	2	1
41	2015-12-07 16:51:57.061366-08	2	1
42	2015-12-07 16:55:04.396132-08	2	1
43	2015-12-07 17:15:13.472559-08	2	1
44	2015-12-07 17:20:06.434744-08	2	1
45	2015-12-07 17:21:29.252562-08	2	1
46	2015-12-08 14:03:16.328829-08	2	1
47	2015-12-08 14:34:05.464966-08	2	1
48	2015-12-09 08:23:31.022302-08	2	1
49	2015-12-09 11:15:29.043079-08	2	1
50	2015-12-09 11:16:42.067026-08	2	1
51	2015-12-09 12:30:16.390909-08	6	1
\.


--
-- Name: analytics_userproductview_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('analytics_userproductview_id_seq', 51, true);


--
-- Data for Name: analytics_userrecord; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY analytics_userrecord (id, num_product_views, num_basket_additions, num_orders, num_order_lines, num_order_items, total_spent, date_last_order, user_id) FROM stdin;
1	51	3	0	0	0	0.00	\N	1
\.


--
-- Name: analytics_userrecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('analytics_userrecord_id_seq', 1, true);


--
-- Data for Name: analytics_usersearch; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY analytics_usersearch (id, query, date_created, user_id) FROM stdin;
\.


--
-- Name: analytics_usersearch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('analytics_usersearch_id_seq', 1, false);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY auth_group (id, name) FROM stdin;
1	Moderators
2	Editors
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('auth_group_id_seq', 2, true);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	112
2	2	112
3	1	19
4	1	20
5	1	21
6	2	19
7	2	20
8	2	21
9	1	24
10	1	22
11	1	23
12	2	24
13	2	22
14	2	23
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 14, true);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add home page	1	add_homepage
2	Can change home page	1	change_homepage
3	Can delete home page	1	delete_homepage
4	Can add promotions page	2	add_promotionspage
5	Can change promotions page	2	change_promotionspage
6	Can delete promotions page	2	delete_promotionspage
7	Can add Form Submission	3	add_formsubmission
8	Can change Form Submission	3	change_formsubmission
9	Can delete Form Submission	3	delete_formsubmission
10	Can add Redirect	4	add_redirect
11	Can change Redirect	4	change_redirect
12	Can delete Redirect	4	delete_redirect
13	Can add Embed	5	add_embed
14	Can change Embed	5	change_embed
15	Can delete Embed	5	delete_embed
16	Can add User Profile	6	add_userprofile
17	Can change User Profile	6	change_userprofile
18	Can delete User Profile	6	delete_userprofile
19	Can add Document	7	add_document
20	Can change Document	7	change_document
21	Can delete Document	7	delete_document
22	Can add image	8	add_image
23	Can change image	8	change_image
24	Can delete image	8	delete_image
25	Can add filter	9	add_filter
26	Can change filter	9	change_filter
27	Can delete filter	9	delete_filter
28	Can add rendition	10	add_rendition
29	Can change rendition	10	change_rendition
30	Can delete rendition	10	delete_rendition
31	Can add query	11	add_query
32	Can change query	11	change_query
33	Can delete query	11	delete_query
34	Can add Query Daily Hits	12	add_querydailyhits
35	Can change Query Daily Hits	12	change_querydailyhits
36	Can delete Query Daily Hits	12	delete_querydailyhits
37	Can add site	13	add_site
38	Can change site	13	change_site
39	Can delete site	13	delete_site
40	Can add page	14	add_page
41	Can change page	14	change_page
42	Can delete page	14	delete_page
43	Can add page revision	15	add_pagerevision
44	Can change page revision	15	change_pagerevision
45	Can delete page revision	15	delete_pagerevision
46	Can add group page permission	16	add_grouppagepermission
47	Can change group page permission	16	change_grouppagepermission
48	Can delete group page permission	16	delete_grouppagepermission
49	Can add page view restriction	17	add_pageviewrestriction
50	Can change page view restriction	17	change_pageviewrestriction
51	Can delete page view restriction	17	delete_pageviewrestriction
52	Can add Tag	18	add_tag
53	Can change Tag	18	change_tag
54	Can delete Tag	18	delete_tag
55	Can add Tagged Item	19	add_taggeditem
56	Can change Tagged Item	19	change_taggeditem
57	Can delete Tagged Item	19	delete_taggeditem
58	Can add express transaction	20	add_expresstransaction
59	Can change express transaction	20	change_expresstransaction
60	Can delete express transaction	20	delete_expresstransaction
61	Can add payflow transaction	21	add_payflowtransaction
62	Can change payflow transaction	21	change_payflowtransaction
63	Can delete payflow transaction	21	delete_payflowtransaction
64	Can add event processing exception	22	add_eventprocessingexception
65	Can change event processing exception	22	change_eventprocessingexception
66	Can delete event processing exception	22	delete_eventprocessingexception
67	Can add event	23	add_event
68	Can change event	23	change_event
69	Can delete event	23	delete_event
70	Can add transfer	24	add_transfer
71	Can change transfer	24	change_transfer
72	Can delete transfer	24	delete_transfer
73	Can add transfer charge fee	25	add_transferchargefee
74	Can change transfer charge fee	25	change_transferchargefee
75	Can delete transfer charge fee	25	delete_transferchargefee
76	Can add customer	26	add_customer
77	Can change customer	26	change_customer
78	Can delete customer	26	delete_customer
79	Can add current subscription	27	add_currentsubscription
80	Can change current subscription	27	change_currentsubscription
81	Can delete current subscription	27	delete_currentsubscription
82	Can add invoice	28	add_invoice
83	Can change invoice	28	change_invoice
84	Can delete invoice	28	delete_invoice
85	Can add invoice item	29	add_invoiceitem
86	Can change invoice item	29	change_invoiceitem
87	Can delete invoice item	29	delete_invoiceitem
88	Can add charge	30	add_charge
89	Can change charge	30	change_charge
90	Can delete charge	30	delete_charge
91	Can add log entry	31	add_logentry
92	Can change log entry	31	change_logentry
93	Can delete log entry	31	delete_logentry
94	Can add permission	32	add_permission
95	Can change permission	32	change_permission
96	Can delete permission	32	delete_permission
97	Can add group	33	add_group
98	Can change group	33	change_group
99	Can delete group	33	delete_group
100	Can add user	34	add_user
101	Can change user	34	change_user
102	Can delete user	34	delete_user
103	Can add content type	35	add_contenttype
104	Can change content type	35	change_contenttype
105	Can delete content type	35	delete_contenttype
106	Can add session	36	add_session
107	Can change session	36	change_session
108	Can delete session	36	delete_session
109	Can add site	37	add_site
110	Can change site	37	change_site
111	Can delete site	37	delete_site
112	Can access Wagtail admin	38	access_admin
113	Can add flat page	39	add_flatpage
114	Can change flat page	39	change_flatpage
115	Can delete flat page	39	delete_flatpage
116	Can add Product record	40	add_productrecord
117	Can change Product record	40	change_productrecord
118	Can delete Product record	40	delete_productrecord
119	Can add User record	41	add_userrecord
120	Can change User record	41	change_userrecord
121	Can delete User record	41	delete_userrecord
122	Can add User product view	42	add_userproductview
123	Can change User product view	42	change_userproductview
124	Can delete User product view	42	delete_userproductview
125	Can add User search query	43	add_usersearch
126	Can change User search query	43	change_usersearch
127	Can delete User search query	43	delete_usersearch
128	Can add User address	44	add_useraddress
129	Can change User address	44	change_useraddress
130	Can delete User address	44	delete_useraddress
131	Can add Country	45	add_country
132	Can change Country	45	change_country
133	Can delete Country	45	delete_country
134	Can add Order and Item Charge	46	add_orderanditemcharges
135	Can change Order and Item Charge	46	change_orderanditemcharges
136	Can delete Order and Item Charge	46	delete_orderanditemcharges
137	Can add Weight-based Shipping Method	47	add_weightbased
138	Can change Weight-based Shipping Method	47	change_weightbased
139	Can delete Weight-based Shipping Method	47	delete_weightbased
140	Can add Weight Band	48	add_weightband
141	Can change Weight Band	48	change_weightband
142	Can delete Weight Band	48	delete_weightband
143	Can add Product	49	add_product
144	Can change Product	49	change_product
145	Can delete Product	49	delete_product
146	Can add Product attribute value	50	add_productattributevalue
147	Can change Product attribute value	50	change_productattributevalue
148	Can delete Product attribute value	50	delete_productattributevalue
149	Can add Product class	51	add_productclass
150	Can change Product class	51	change_productclass
151	Can delete Product class	51	delete_productclass
152	Can add Category	52	add_category
153	Can change Category	52	change_category
154	Can delete Category	52	delete_category
155	Can add Product category	53	add_productcategory
156	Can change Product category	53	change_productcategory
157	Can delete Product category	53	delete_productcategory
158	Can add Product recommendation	54	add_productrecommendation
159	Can change Product recommendation	54	change_productrecommendation
160	Can delete Product recommendation	54	delete_productrecommendation
161	Can add Product attribute	55	add_productattribute
162	Can change Product attribute	55	change_productattribute
163	Can delete Product attribute	55	delete_productattribute
164	Can add Attribute option group	56	add_attributeoptiongroup
165	Can change Attribute option group	56	change_attributeoptiongroup
166	Can delete Attribute option group	56	delete_attributeoptiongroup
167	Can add Attribute option	57	add_attributeoption
168	Can change Attribute option	57	change_attributeoption
169	Can delete Attribute option	57	delete_attributeoption
170	Can add Option	58	add_option
171	Can change Option	58	change_option
172	Can delete Option	58	delete_option
173	Can add Product image	59	add_productimage
174	Can change Product image	59	change_productimage
175	Can delete Product image	59	delete_productimage
176	Can add Product review	60	add_productreview
177	Can change Product review	60	change_productreview
178	Can delete Product review	60	delete_productreview
179	Can add Vote	61	add_vote
180	Can change Vote	61	change_vote
181	Can delete Vote	61	delete_vote
182	Can add Fulfillment partner	62	add_partner
183	Can change Fulfillment partner	62	change_partner
184	Can delete Fulfillment partner	62	delete_partner
185	Can access dashboard	62	dashboard_access
186	Can add Partner address	63	add_partneraddress
187	Can change Partner address	63	change_partneraddress
188	Can delete Partner address	63	delete_partneraddress
189	Can add Stock record	64	add_stockrecord
190	Can change Stock record	64	change_stockrecord
191	Can delete Stock record	64	delete_stockrecord
192	Can add Stock alert	65	add_stockalert
193	Can change Stock alert	65	change_stockalert
194	Can delete Stock alert	65	delete_stockalert
195	Can add Basket	66	add_basket
196	Can change Basket	66	change_basket
197	Can delete Basket	66	delete_basket
198	Can add Basket line	67	add_line
199	Can change Basket line	67	change_line
200	Can delete Basket line	67	delete_line
201	Can add Line attribute	68	add_lineattribute
202	Can change Line attribute	68	change_lineattribute
203	Can delete Line attribute	68	delete_lineattribute
204	Can add Transaction	69	add_transaction
205	Can change Transaction	69	change_transaction
206	Can delete Transaction	69	delete_transaction
207	Can add Source	70	add_source
208	Can change Source	70	change_source
209	Can delete Source	70	delete_source
210	Can add Source Type	71	add_sourcetype
211	Can change Source Type	71	change_sourcetype
212	Can delete Source Type	71	delete_sourcetype
213	Can add Bankcard	72	add_bankcard
214	Can change Bankcard	72	change_bankcard
215	Can delete Bankcard	72	delete_bankcard
216	Can add Conditional offer	73	add_conditionaloffer
217	Can change Conditional offer	73	change_conditionaloffer
218	Can delete Conditional offer	73	delete_conditionaloffer
219	Can add Benefit	74	add_benefit
220	Can change Benefit	74	change_benefit
221	Can delete Benefit	74	delete_benefit
222	Can add Condition	75	add_condition
223	Can change Condition	75	change_condition
224	Can delete Condition	75	delete_condition
225	Can add Range	76	add_range
226	Can change Range	76	change_range
227	Can delete Range	76	delete_range
228	Can add range product	77	add_rangeproduct
229	Can change range product	77	change_rangeproduct
230	Can delete range product	77	delete_rangeproduct
231	Can add Range Product Uploaded File	78	add_rangeproductfileupload
232	Can change Range Product Uploaded File	78	change_rangeproductfileupload
233	Can delete Range Product Uploaded File	78	delete_rangeproductfileupload
234	Can add Count condition	75	add_countcondition
235	Can change Count condition	75	change_countcondition
236	Can delete Count condition	75	delete_countcondition
237	Can add Coverage Condition	75	add_coveragecondition
238	Can change Coverage Condition	75	change_coveragecondition
239	Can delete Coverage Condition	75	delete_coveragecondition
240	Can add Value condition	75	add_valuecondition
241	Can change Value condition	75	change_valuecondition
242	Can delete Value condition	75	delete_valuecondition
243	Can add Percentage discount benefit	74	add_percentagediscountbenefit
244	Can change Percentage discount benefit	74	change_percentagediscountbenefit
245	Can delete Percentage discount benefit	74	delete_percentagediscountbenefit
246	Can add Absolute discount benefit	74	add_absolutediscountbenefit
247	Can change Absolute discount benefit	74	change_absolutediscountbenefit
248	Can delete Absolute discount benefit	74	delete_absolutediscountbenefit
249	Can add Fixed price benefit	74	add_fixedpricebenefit
250	Can change Fixed price benefit	74	change_fixedpricebenefit
251	Can delete Fixed price benefit	74	delete_fixedpricebenefit
252	Can add Multibuy discount benefit	74	add_multibuydiscountbenefit
253	Can change Multibuy discount benefit	74	change_multibuydiscountbenefit
254	Can delete Multibuy discount benefit	74	delete_multibuydiscountbenefit
255	Can add shipping benefit	74	add_shippingbenefit
256	Can change shipping benefit	74	change_shippingbenefit
257	Can delete shipping benefit	74	delete_shippingbenefit
258	Can add Shipping absolute discount benefit	74	add_shippingabsolutediscountbenefit
259	Can change Shipping absolute discount benefit	74	change_shippingabsolutediscountbenefit
260	Can delete Shipping absolute discount benefit	74	delete_shippingabsolutediscountbenefit
261	Can add Fixed price shipping benefit	74	add_shippingfixedpricebenefit
262	Can change Fixed price shipping benefit	74	change_shippingfixedpricebenefit
263	Can delete Fixed price shipping benefit	74	delete_shippingfixedpricebenefit
264	Can add Shipping percentage discount benefit	74	add_shippingpercentagediscountbenefit
265	Can change Shipping percentage discount benefit	74	change_shippingpercentagediscountbenefit
266	Can delete Shipping percentage discount benefit	74	delete_shippingpercentagediscountbenefit
267	Can add Payment Event Quantity	90	add_paymenteventquantity
268	Can change Payment Event Quantity	90	change_paymenteventquantity
269	Can delete Payment Event Quantity	90	delete_paymenteventquantity
270	Can add Shipping Event Quantity	91	add_shippingeventquantity
271	Can change Shipping Event Quantity	91	change_shippingeventquantity
272	Can delete Shipping Event Quantity	91	delete_shippingeventquantity
273	Can add Order	92	add_order
274	Can change Order	92	change_order
275	Can delete Order	92	delete_order
276	Can add Order Note	93	add_ordernote
277	Can change Order Note	93	change_ordernote
278	Can delete Order Note	93	delete_ordernote
279	Can add Communication Event	94	add_communicationevent
280	Can change Communication Event	94	change_communicationevent
281	Can delete Communication Event	94	delete_communicationevent
282	Can add Shipping address	95	add_shippingaddress
283	Can change Shipping address	95	change_shippingaddress
284	Can delete Shipping address	95	delete_shippingaddress
285	Can add Billing address	96	add_billingaddress
286	Can change Billing address	96	change_billingaddress
287	Can delete Billing address	96	delete_billingaddress
288	Can add Order Line	97	add_line
289	Can change Order Line	97	change_line
290	Can delete Order Line	97	delete_line
291	Can add Line Price	98	add_lineprice
292	Can change Line Price	98	change_lineprice
293	Can delete Line Price	98	delete_lineprice
294	Can add Line Attribute	99	add_lineattribute
295	Can change Line Attribute	99	change_lineattribute
296	Can delete Line Attribute	99	delete_lineattribute
297	Can add Shipping Event	100	add_shippingevent
298	Can change Shipping Event	100	change_shippingevent
299	Can delete Shipping Event	100	delete_shippingevent
300	Can add Shipping Event Type	101	add_shippingeventtype
301	Can change Shipping Event Type	101	change_shippingeventtype
302	Can delete Shipping Event Type	101	delete_shippingeventtype
303	Can add Payment Event	102	add_paymentevent
304	Can change Payment Event	102	change_paymentevent
305	Can delete Payment Event	102	delete_paymentevent
306	Can add Payment Event Type	103	add_paymenteventtype
307	Can change Payment Event Type	103	change_paymenteventtype
308	Can delete Payment Event Type	103	delete_paymenteventtype
309	Can add Order Discount	104	add_orderdiscount
310	Can change Order Discount	104	change_orderdiscount
311	Can delete Order Discount	104	delete_orderdiscount
312	Can add Email	105	add_email
313	Can change Email	105	change_email
314	Can delete Email	105	delete_email
315	Can add Communication event type	106	add_communicationeventtype
316	Can change Communication event type	106	change_communicationeventtype
317	Can delete Communication event type	106	delete_communicationeventtype
318	Can add Notification	107	add_notification
319	Can change Notification	107	change_notification
320	Can delete Notification	107	delete_notification
321	Can add Product alert	108	add_productalert
322	Can change Product alert	108	change_productalert
323	Can delete Product alert	108	delete_productalert
324	Can add Page Promotion	109	add_pagepromotion
325	Can change Page Promotion	109	change_pagepromotion
326	Can delete Page Promotion	109	delete_pagepromotion
327	Can add Keyword Promotion	110	add_keywordpromotion
328	Can change Keyword Promotion	110	change_keywordpromotion
329	Can delete Keyword Promotion	110	delete_keywordpromotion
330	Can add Raw HTML	111	add_rawhtml
331	Can change Raw HTML	111	change_rawhtml
332	Can delete Raw HTML	111	delete_rawhtml
333	Can add Image	112	add_image
334	Can change Image	112	change_image
335	Can delete Image	112	delete_image
336	Can add Multi Image	113	add_multiimage
337	Can change Multi Image	113	change_multiimage
338	Can delete Multi Image	113	delete_multiimage
339	Can add Single product	114	add_singleproduct
340	Can change Single product	114	change_singleproduct
341	Can delete Single product	114	delete_singleproduct
342	Can add Hand Picked Product List	115	add_handpickedproductlist
343	Can change Hand Picked Product List	115	change_handpickedproductlist
344	Can delete Hand Picked Product List	115	delete_handpickedproductlist
345	Can add Ordered product	116	add_orderedproduct
346	Can change Ordered product	116	change_orderedproduct
347	Can delete Ordered product	116	delete_orderedproduct
348	Can add Automatic product list	117	add_automaticproductlist
349	Can change Automatic product list	117	change_automaticproductlist
350	Can delete Automatic product list	117	delete_automaticproductlist
351	Can add Ordered Product List	118	add_orderedproductlist
352	Can change Ordered Product List	118	change_orderedproductlist
353	Can delete Ordered Product List	118	delete_orderedproductlist
354	Can add Tabbed Block	119	add_tabbedblock
355	Can change Tabbed Block	119	change_tabbedblock
356	Can delete Tabbed Block	119	delete_tabbedblock
357	Can add Voucher	120	add_voucher
358	Can change Voucher	120	change_voucher
359	Can delete Voucher	120	delete_voucher
360	Can add Voucher Application	121	add_voucherapplication
361	Can change Voucher Application	121	change_voucherapplication
362	Can delete Voucher Application	121	delete_voucherapplication
363	Can add Wish List	122	add_wishlist
364	Can change Wish List	122	change_wishlist
365	Can delete Wish List	122	delete_wishlist
366	Can add Wish list line	123	add_line
367	Can change Wish list line	123	change_line
368	Can delete Wish list line	123	delete_line
369	Can add kv store	124	add_kvstore
370	Can change kv store	124	change_kvstore
371	Can delete kv store	124	delete_kvstore
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('auth_permission_id_seq', 371, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$20000$F8l36r8Pna6O$/bCyrxd4r2tXnU7qAP71qQuPw4Q73wOyRDUTzcKOLo8=	2015-12-07 13:20:31.704835-08	t	taedori			taedori@outlook.com	t	t	2015-12-04 23:41:54.206764-08
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('auth_user_id_seq', 1, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: basket_basket; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY basket_basket (id, status, date_created, date_merged, date_submitted, owner_id) FROM stdin;
1	Frozen	2015-12-07 08:45:39.760537-08	\N	\N	1
2	Open	2015-12-08 14:33:30.638469-08	\N	\N	1
\.


--
-- Name: basket_basket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('basket_basket_id_seq', 2, true);


--
-- Data for Name: basket_basket_vouchers; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY basket_basket_vouchers (id, basket_id, voucher_id) FROM stdin;
\.


--
-- Name: basket_basket_vouchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('basket_basket_vouchers_id_seq', 1, false);


--
-- Data for Name: basket_line; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY basket_line (id, line_reference, quantity, price_currency, price_excl_tax, price_incl_tax, date_created, basket_id, product_id, stockrecord_id) FROM stdin;
1	11_8	1	USD	69.99	\N	2015-12-07 13:50:16.239403-08	1	11	8
2	12_9	2	USD	78.99	\N	2015-12-07 16:21:28.45435-08	1	12	9
3	5_1	1	USD	29.99	\N	2015-12-09 11:16:41.673278-08	2	5	1
\.


--
-- Name: basket_line_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('basket_line_id_seq', 3, true);


--
-- Data for Name: basket_lineattribute; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY basket_lineattribute (id, value, line_id, option_id) FROM stdin;
\.


--
-- Name: basket_lineattribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('basket_lineattribute_id_seq', 1, false);


--
-- Data for Name: catalogue_attributeoption; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_attributeoption (id, option, group_id) FROM stdin;
1	1-Black	1
2	1B-Off Black	1
3	2-Dark Brown	1
4	4-Medium Dark Brown	1
5	6-Chestnut Brown	1
6	8-Medium Ash Brown	1
7	27-Strawberry Blonde	1
8	30-Light Auburn	1
9	4N-Dark Brown	1
10	6N-Medium Brown	1
11	10s Inch	2
12	10 Inch	2
13	12 Inch	2
14	14 Inch	2
15	16 Inch	2
16	18 Inch	2
17	20 Inch	2
18	22 Inch	2
\.


--
-- Name: catalogue_attributeoption_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_attributeoption_id_seq', 18, true);


--
-- Data for Name: catalogue_attributeoptiongroup; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_attributeoptiongroup (id, name) FROM stdin;
1	Color
2	Length
\.


--
-- Name: catalogue_attributeoptiongroup_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_attributeoptiongroup_id_seq', 2, true);


--
-- Data for Name: catalogue_category; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_category (id, path, depth, numchild, name, description, image, slug) FROM stdin;
2	0002	1	0	Braiding	<p>Description for Braiding</p>		braiding
3	00010001	2	0	Yaky / Perm Yaky			yaky-perm-yaky
4	00010002	2	0	Silky / European			silky-european
5	00010003	2	0	Brazilian / Indian			brazilian-indian
6	00010004	2	0	Unprocessed			unprocessed
1	0001	1	5	Weaving	<p>Description for weave hair</p>		weave-hair
7	00010005	2	0	Wavy / Curly			wavy-curly
\.


--
-- Name: catalogue_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_category_id_seq', 7, true);


--
-- Data for Name: catalogue_option; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_option (id, name, code, type) FROM stdin;
\.


--
-- Name: catalogue_option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_option_id_seq', 1, true);


--
-- Data for Name: catalogue_product; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_product (id, structure, upc, title, slug, description, rating, date_created, date_updated, is_discountable, parent_id, product_class_id) FROM stdin;
5	child	\N		bobbi-bossr-vissotm-yaky-100-human-hair		\N	2015-12-07 10:59:57.835765-08	2015-12-07 11:05:58.557105-08	t	2	\N
4	child	\N		bobbi-bossr-vissotm-yaky-100-human-hair		\N	2015-12-07 10:59:43.887162-08	2015-12-07 11:46:23.21475-08	t	2	\N
3	child	\N		bobbi-bossr-vissotm-yaky-100-human-hair		\N	2015-12-07 10:59:29.596415-08	2015-12-07 16:26:00.309662-08	t	2	\N
7	child	\N		vissotm-remi-hair-elegant-wave		\N	2015-12-07 11:49:48.856354-08	2015-12-07 11:49:57.331171-08	t	6	\N
8	child	\N		vissotm-remi-hair-elegant-wave		\N	2015-12-07 11:50:40.192956-08	2015-12-07 11:50:40.192987-08	t	6	\N
9	child	\N		vissotm-remi-hair-elegant-wave		\N	2015-12-07 11:51:11.651307-08	2015-12-07 11:51:11.651335-08	t	6	\N
6	parent	\N	VISSO™ REMI HAIR ELEGANT WAVE	vissotm-remi-hair-elegant-wave	<p>VISSO™ Remi Hair is constructed with luxurious natural texture for superb, youthful looks. The extensive color provides more choices to fit your style need to obtain the most creative style. You will adore the lasting rich shine, smoothness &amp; natural luster of VISSO™ Remi Hair. It's premium volume and extra long length give your style a fuller and better appearance and feel.</p>\r\n<p><strong>·</strong> Weaving Hair<br /><strong>·</strong> 100% Human Hair<br /><strong>·</strong> <strong>SINGLE</strong> Pack Ordering<br /><strong>·Comes Elegant Wave Style in Pack</strong><br /><strong>·</strong> Can Be Washed<br /><strong>·</strong> Available in Lengths 12", 14" and 18"</p>	\N	2015-12-07 11:48:54.011558-08	2015-12-07 13:21:03.035659-08	t	\N	1
10	child	\N		vissotm-remi-hair-elegant-wave		\N	2015-12-07 13:21:02.966059-08	2015-12-07 13:21:57.910611-08	t	6	\N
11	child	\N		bobbi-bossr-vissotm-yaky-100-human-hair		\N	2015-12-07 13:49:10.616629-08	2015-12-07 13:49:28.39566-08	t	2	\N
12	child	\N		bobbi-bossr-vissotm-yaky-100-human-hair		\N	2015-12-07 16:20:45.700665-08	2015-12-07 16:20:45.700697-08	t	2	\N
13	child	\N		bobbi-bossr-vissotm-yaky-100-human-hair		\N	2015-12-07 17:21:25.684447-08	2015-12-07 17:21:25.684474-08	t	2	\N
2	parent	1000	BOBBI BOSS® VISSO™ Yaky 100% Human Hair	bobbi-bossr-vissotm-yaky-100-human-hair	<h2><strong>VISSO™ YAKY HAIR</strong></h2>\r\n<p> </p>\r\n<p>VISSO™ Hair is constructed with luxurious natural texture for superb, youthful looks. The extensive color provides more choices to fit your style need to obtain the most creative style. You will adore the lasting rich shine, smoothness &amp; natural luster of VISSO™ Hair. It's premium volume and extra long length give your style a fuller and better appearance and feel.</p>\r\n<p><strong>·</strong> Weaving Hair<br /><strong>·</strong> 100% Human Hair<br /><strong>·</strong> <strong>SINGLE</strong> Pack Ordering<br /><strong>·</strong> Comes Straight in Pack<br /><strong>·</strong> Can Be Curled and Straightened<br /><strong>·</strong> Can Be Washed<br /><strong>· </strong>Available in Lengths 10s" - 22" for selective colors</p>	\N	2015-12-07 10:58:34.074761-08	2015-12-07 17:21:25.761599-08	t	\N	1
\.


--
-- Name: catalogue_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_product_id_seq', 13, true);


--
-- Data for Name: catalogue_product_product_options; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_product_product_options (id, product_id, option_id) FROM stdin;
\.


--
-- Name: catalogue_product_product_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_product_product_options_id_seq', 1, false);


--
-- Data for Name: catalogue_productattribute; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_productattribute (id, name, code, type, required, option_group_id, product_class_id) FROM stdin;
1	Length	length	option	f	2	1
2	Color	color	option	f	1	1
3	Price	price	text	f	\N	1
4	Length	length	option	f	2	2
5	Color	color	option	f	1	2
6	Price	price	text	f	\N	2
\.


--
-- Name: catalogue_productattribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_productattribute_id_seq', 6, true);


--
-- Data for Name: catalogue_productattributevalue; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_productattributevalue (id, value_text, value_integer, value_boolean, value_float, value_richtext, value_date, value_file, value_image, entity_object_id, attribute_id, entity_content_type_id, product_id, value_option_id) FROM stdin;
1	\N	\N	\N	\N	\N	\N			\N	2	\N	3	10
2	\N	\N	\N	\N	\N	\N			\N	1	\N	3	18
4	\N	\N	\N	\N	\N	\N			\N	2	\N	4	9
5	\N	\N	\N	\N	\N	\N			\N	1	\N	4	17
6	$42.99	\N	\N	\N	\N	\N			\N	3	\N	4	\N
7	\N	\N	\N	\N	\N	\N			\N	2	\N	5	8
8	\N	\N	\N	\N	\N	\N			\N	1	\N	5	12
9	$29.99	\N	\N	\N	\N	\N			\N	3	\N	5	\N
11	\N	\N	\N	\N	\N	\N			\N	2	\N	7	1
12	\N	\N	\N	\N	\N	\N			\N	1	\N	7	13
13	$29.99	\N	\N	\N	\N	\N			\N	3	\N	7	\N
14	\N	\N	\N	\N	\N	\N			\N	2	\N	8	2
15	\N	\N	\N	\N	\N	\N			\N	1	\N	8	14
16	$39.99	\N	\N	\N	\N	\N			\N	3	\N	8	\N
17	\N	\N	\N	\N	\N	\N			\N	2	\N	9	6
18	\N	\N	\N	\N	\N	\N			\N	1	\N	9	16
19	$65.99	\N	\N	\N	\N	\N			\N	3	\N	9	\N
20	\N	\N	\N	\N	\N	\N			\N	2	\N	10	4
21	\N	\N	\N	\N	\N	\N			\N	1	\N	10	13
22	$29.99	\N	\N	\N	\N	\N			\N	3	\N	10	\N
23	\N	\N	\N	\N	\N	\N			\N	2	\N	11	7
24	\N	\N	\N	\N	\N	\N			\N	1	\N	11	16
25	$69.99	\N	\N	\N	\N	\N			\N	3	\N	11	\N
26	\N	\N	\N	\N	\N	\N			\N	2	\N	12	6
27	\N	\N	\N	\N	\N	\N			\N	1	\N	12	15
28	$78.99	\N	\N	\N	\N	\N			\N	3	\N	12	\N
3	$109.99	\N	\N	\N	\N	\N			\N	3	\N	3	\N
29	\N	\N	\N	\N	\N	\N			\N	2	\N	13	7
30	\N	\N	\N	\N	\N	\N			\N	1	\N	13	14
31	$69.99	\N	\N	\N	\N	\N			\N	3	\N	13	\N
\.


--
-- Name: catalogue_productattributevalue_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_productattributevalue_id_seq', 31, true);


--
-- Data for Name: catalogue_productcategory; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_productcategory (id, category_id, product_id) FROM stdin;
1	3	2
2	7	6
\.


--
-- Name: catalogue_productcategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_productcategory_id_seq', 2, true);


--
-- Data for Name: catalogue_productclass; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_productclass (id, name, slug, requires_shipping, track_stock) FROM stdin;
2	Braiding	braiding	t	t
1	Weaving	weave	t	t
\.


--
-- Name: catalogue_productclass_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_productclass_id_seq', 2, true);


--
-- Data for Name: catalogue_productclass_options; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_productclass_options (id, productclass_id, option_id) FROM stdin;
\.


--
-- Name: catalogue_productclass_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_productclass_options_id_seq', 1, false);


--
-- Data for Name: catalogue_productimage; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_productimage (id, original, caption, display_order, date_created, product_id) FROM stdin;
3	images/products/2015/12/Beauty-Depot-VI_2_H700.png		0	2015-12-07 11:41:00.371001-08	2
4	images/products/2015/12/vissoi-shop_3fca2bf7-5242-4b93-a226-27473a03aebe_1024x1024.png		1	2015-12-07 11:41:00.379419-08	2
6	images/products/2015/12/vissoielegant-shop_large.png		0	2015-12-07 12:02:19.545425-08	6
\.


--
-- Name: catalogue_productimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_productimage_id_seq', 6, true);


--
-- Data for Name: catalogue_productrecommendation; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY catalogue_productrecommendation (id, ranking, primary_id, recommendation_id) FROM stdin;
\.


--
-- Name: catalogue_productrecommendation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('catalogue_productrecommendation_id_seq', 1, false);


--
-- Data for Name: customer_communicationeventtype; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY customer_communicationeventtype (id, code, name, category, email_subject_template, email_body_template, email_body_html_template, sms_template, date_created, date_updated) FROM stdin;
\.


--
-- Name: customer_communicationeventtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('customer_communicationeventtype_id_seq', 1, false);


--
-- Data for Name: customer_email; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY customer_email (id, subject, body_text, body_html, date_sent, user_id) FROM stdin;
\.


--
-- Name: customer_email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('customer_email_id_seq', 1, false);


--
-- Data for Name: customer_notification; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY customer_notification (id, subject, body, category, location, date_sent, date_read, recipient_id, sender_id) FROM stdin;
\.


--
-- Name: customer_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('customer_notification_id_seq', 1, false);


--
-- Data for Name: customer_productalert; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY customer_productalert (id, email, key, status, date_created, date_confirmed, date_cancelled, date_closed, product_id, user_id) FROM stdin;
\.


--
-- Name: customer_productalert_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('customer_productalert_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2015-12-07 10:48:58.050214-08	1	Length	1		56	1
2	2015-12-07 10:49:06.700785-08	1	Color	2	Changed name.	56	1
3	2015-12-07 10:50:05.553441-08	2	Length	1		56	1
4	2015-12-07 11:58:57.591496-08	2	Length	2	Changed option for Attribute option "10s Inch". Changed option for Attribute option "10 Inch". Changed option for Attribute option "12 Inch". Changed option for Attribute option "14 Inch". Changed option for Attribute option "16 Inch". Changed option for Attribute option "18 Inch". Changed option for Attribute option "20 Inch". Changed option for Attribute option "22 Inch".	56	1
5	2015-12-07 15:37:08.788076-08	1	Length	1		58	1
6	2015-12-07 15:37:39.933921-08	1	Length	3		58	1
7	2015-12-08 14:22:20.855777-08	US	United States	2	Changed is_shipping_country.	45	1
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 7, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	home	homepage
2	home	promotionspage
3	wagtailforms	formsubmission
4	wagtailredirects	redirect
5	wagtailembeds	embed
6	wagtailusers	userprofile
7	wagtaildocs	document
8	wagtailimages	image
9	wagtailimages	filter
10	wagtailimages	rendition
11	wagtailsearch	query
12	wagtailsearch	querydailyhits
13	wagtailcore	site
14	wagtailcore	page
15	wagtailcore	pagerevision
16	wagtailcore	grouppagepermission
17	wagtailcore	pageviewrestriction
18	taggit	tag
19	taggit	taggeditem
20	paypal	expresstransaction
21	paypal	payflowtransaction
22	payments	eventprocessingexception
23	payments	event
24	payments	transfer
25	payments	transferchargefee
26	payments	customer
27	payments	currentsubscription
28	payments	invoice
29	payments	invoiceitem
30	payments	charge
31	admin	logentry
32	auth	permission
33	auth	group
34	auth	user
35	contenttypes	contenttype
36	sessions	session
37	sites	site
38	wagtailadmin	admin
39	flatpages	flatpage
40	analytics	productrecord
41	analytics	userrecord
42	analytics	userproductview
43	analytics	usersearch
44	address	useraddress
45	address	country
46	shipping	orderanditemcharges
47	shipping	weightbased
48	shipping	weightband
49	catalogue	product
50	catalogue	productattributevalue
51	catalogue	productclass
52	catalogue	category
53	catalogue	productcategory
54	catalogue	productrecommendation
55	catalogue	productattribute
56	catalogue	attributeoptiongroup
57	catalogue	attributeoption
58	catalogue	option
59	catalogue	productimage
60	reviews	productreview
61	reviews	vote
62	partner	partner
63	partner	partneraddress
64	partner	stockrecord
65	partner	stockalert
66	basket	basket
67	basket	line
68	basket	lineattribute
69	payment	transaction
70	payment	source
71	payment	sourcetype
72	payment	bankcard
73	offer	conditionaloffer
74	offer	benefit
75	offer	condition
76	offer	range
77	offer	rangeproduct
78	offer	rangeproductfileupload
79	offer	countcondition
80	offer	shippingfixedpricebenefit
81	offer	shippingbenefit
82	offer	fixedpricebenefit
83	offer	valuecondition
84	offer	multibuydiscountbenefit
85	offer	absolutediscountbenefit
86	offer	coveragecondition
87	offer	percentagediscountbenefit
88	offer	shippingpercentagediscountbenefit
89	offer	shippingabsolutediscountbenefit
90	order	paymenteventquantity
91	order	shippingeventquantity
92	order	order
93	order	ordernote
94	order	communicationevent
95	order	shippingaddress
96	order	billingaddress
97	order	line
98	order	lineprice
99	order	lineattribute
100	order	shippingevent
101	order	shippingeventtype
102	order	paymentevent
103	order	paymenteventtype
104	order	orderdiscount
105	customer	email
106	customer	communicationeventtype
107	customer	notification
108	customer	productalert
109	promotions	pagepromotion
110	promotions	keywordpromotion
111	promotions	rawhtml
112	promotions	image
113	promotions	multiimage
114	promotions	singleproduct
115	promotions	handpickedproductlist
116	promotions	orderedproduct
117	promotions	automaticproductlist
118	promotions	orderedproductlist
119	promotions	tabbedblock
120	voucher	voucher
121	voucher	voucherapplication
122	wishlists	wishlist
123	wishlists	line
124	thumbnail	kvstore
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('django_content_type_id_seq', 124, true);


--
-- Data for Name: django_flatpage; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY django_flatpage (id, url, title, content, enable_comments, template_name, registration_required) FROM stdin;
\.


--
-- Name: django_flatpage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('django_flatpage_id_seq', 1, false);


--
-- Data for Name: django_flatpage_sites; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY django_flatpage_sites (id, flatpage_id, site_id) FROM stdin;
\.


--
-- Name: django_flatpage_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('django_flatpage_sites_id_seq', 1, false);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2015-12-04 23:38:54.205612-08
2	contenttypes	0002_remove_content_type_name	2015-12-04 23:38:54.310808-08
3	auth	0001_initial	2015-12-04 23:38:54.452692-08
4	auth	0002_alter_permission_name_max_length	2015-12-04 23:38:54.493933-08
5	auth	0003_alter_user_email_max_length	2015-12-04 23:38:54.532123-08
6	auth	0004_alter_user_username_opts	2015-12-04 23:38:54.568214-08
7	auth	0005_alter_user_last_login_null	2015-12-04 23:38:54.605492-08
8	auth	0006_require_contenttypes_0002	2015-12-04 23:38:54.60868-08
9	address	0001_initial	2015-12-04 23:40:56.997027-08
10	admin	0001_initial	2015-12-04 23:40:57.062154-08
11	catalogue	0001_initial	2015-12-04 23:40:58.582611-08
12	analytics	0001_initial	2015-12-04 23:40:58.832905-08
13	analytics	0002_auto_20140827_1705	2015-12-04 23:40:59.005931-08
14	sites	0001_initial	2015-12-04 23:40:59.025485-08
15	partner	0001_initial	2015-12-04 23:40:59.439993-08
16	customer	0001_initial	2015-12-04 23:40:59.78544-08
17	basket	0001_initial	2015-12-04 23:40:59.879163-08
18	basket	0002_auto_20140827_1705	2015-12-04 23:41:00.363765-08
19	order	0001_initial	2015-12-04 23:41:03.562091-08
20	offer	0001_initial	2015-12-04 23:41:04.770134-08
21	voucher	0001_initial	2015-12-04 23:41:05.231213-08
22	basket	0003_basket_vouchers	2015-12-04 23:41:05.463257-08
23	basket	0004_auto_20141007_2032	2015-12-04 23:41:05.650748-08
24	basket	0005_auto_20150604_1450	2015-12-04 23:41:05.979251-08
25	catalogue	0002_auto_20150217_1221	2015-12-04 23:41:06.313134-08
26	catalogue	0003_data_migration_slugs	2015-12-04 23:41:06.324869-08
27	catalogue	0004_auto_20150217_1710	2015-12-04 23:41:06.448592-08
28	catalogue	0005_auto_20150604_1450	2015-12-04 23:41:06.695037-08
29	catalogue	0006_auto_20151028_2341	2015-12-04 23:41:06.875289-08
30	catalogue	0007_auto_20151125_1945	2015-12-04 23:41:07.559453-08
31	checkout	0001_initial	2015-12-04 23:41:07.600916-08
32	checkout	0002_delete_userinfo	2015-12-04 23:41:07.623499-08
33	customer	0002_auto_20151028_2341	2015-12-04 23:41:07.759749-08
34	flatpages	0001_initial	2015-12-04 23:41:07.955177-08
35	wagtailcore	0001_initial	2015-12-04 23:41:09.488023-08
36	wagtailcore	0002_initial_data	2015-12-04 23:41:09.492538-08
37	wagtailcore	0003_add_uniqueness_constraint_on_group_page_permission	2015-12-04 23:41:09.497142-08
38	wagtailcore	0004_page_locked	2015-12-04 23:41:09.501655-08
39	wagtailcore	0005_add_page_lock_permission_to_moderators	2015-12-04 23:41:09.511735-08
40	wagtailcore	0006_add_lock_page_permission	2015-12-04 23:41:09.521895-08
41	wagtailcore	0007_page_latest_revision_created_at	2015-12-04 23:41:09.526309-08
42	wagtailcore	0008_populate_latest_revision_created_at	2015-12-04 23:41:09.530861-08
43	wagtailcore	0009_remove_auto_now_add_from_pagerevision_created_at	2015-12-04 23:41:09.535414-08
44	wagtailcore	0010_change_page_owner_to_null_on_delete	2015-12-04 23:41:09.540048-08
45	wagtailcore	0011_page_first_published_at	2015-12-04 23:41:09.544596-08
46	wagtailcore	0012_extend_page_slug_field	2015-12-04 23:41:09.549171-08
47	wagtailcore	0013_update_golive_expire_help_text	2015-12-04 23:41:09.553519-08
48	wagtailcore	0014_add_verbose_name	2015-12-04 23:41:09.557942-08
49	wagtailcore	0015_add_more_verbose_names	2015-12-04 23:41:09.562379-08
50	wagtailcore	0016_change_page_url_path_to_text_field	2015-12-04 23:41:09.566778-08
51	wagtailcore	0017_change_edit_page_permission_description	2015-12-04 23:41:09.774165-08
52	wagtailcore	0018_pagerevision_submitted_for_moderation_index	2015-12-04 23:41:09.923962-08
53	wagtailcore	0019_verbose_names_cleanup	2015-12-04 23:41:10.605052-08
54	wagtailcore	0020_add_index_on_page_first_published_at	2015-12-04 23:41:11.21093-08
55	home	0001_initial	2015-12-04 23:41:11.36004-08
56	home	0002_create_homepage	2015-12-04 23:41:11.384891-08
57	home	0003_promotionspage	2015-12-04 23:41:11.510812-08
58	order	0002_auto_20141007_2032	2015-12-04 23:41:11.632998-08
59	order	0003_auto_20150113_1629	2015-12-04 23:41:11.751587-08
60	partner	0002_auto_20141007_2032	2015-12-04 23:41:11.87286-08
61	partner	0003_auto_20150604_1450	2015-12-04 23:41:12.206427-08
62	payment	0001_initial	2015-12-04 23:41:12.823252-08
63	payment	0002_auto_20141007_2032	2015-12-04 23:41:12.987716-08
64	promotions	0001_initial	2015-12-04 23:41:14.263776-08
65	promotions	0002_auto_20150604_1450	2015-12-04 23:41:14.715086-08
66	reviews	0001_initial	2015-12-04 23:41:15.972844-08
67	sessions	0001_initial	2015-12-04 23:41:16.022886-08
68	shipping	0001_initial	2015-12-04 23:41:16.899042-08
69	shipping	0002_auto_20150604_1450	2015-12-04 23:41:17.968475-08
70	taggit	0001_initial	2015-12-04 23:41:18.293814-08
71	taggit	0002_auto_20150616_2121	2015-12-04 23:41:18.523779-08
72	wagtailadmin	0001_create_admin_access_permissions	2015-12-04 23:41:18.564013-08
73	wagtaildocs	0001_initial	2015-12-04 23:41:18.830602-08
74	wagtaildocs	0002_initial_data	2015-12-04 23:41:18.856007-08
75	wagtaildocs	0003_add_verbose_names	2015-12-04 23:41:19.579403-08
76	wagtailembeds	0001_initial	2015-12-04 23:41:19.666271-08
77	wagtailembeds	0002_add_verbose_names	2015-12-04 23:41:19.700227-08
78	wagtailforms	0001_initial	2015-12-04 23:41:19.978126-08
79	wagtailforms	0002_add_verbose_names	2015-12-04 23:41:20.92322-08
80	wagtailimages	0001_initial	2015-12-04 23:41:21.505097-08
81	wagtailimages	0002_initial_data	2015-12-04 23:41:21.531357-08
82	wagtailimages	0003_fix_focal_point_fields	2015-12-04 23:41:22.196186-08
83	wagtailimages	0004_make_focal_point_key_not_nullable	2015-12-04 23:41:22.367798-08
84	wagtailimages	0005_make_filter_spec_unique	2015-12-04 23:41:22.532652-08
85	wagtailimages	0006_add_verbose_names	2015-12-04 23:41:23.381374-08
86	wagtailimages	0007_image_file_size	2015-12-04 23:41:23.541526-08
87	wagtailimages	0008_image_created_at_index	2015-12-04 23:41:23.713621-08
88	wagtailredirects	0001_initial	2015-12-04 23:41:24.424141-08
89	wagtailredirects	0002_add_verbose_names	2015-12-04 23:41:24.830553-08
90	wagtailredirects	0003_make_site_field_editable	2015-12-04 23:41:25.07088-08
91	wagtailredirects	0004_set_unique_on_path_and_site	2015-12-04 23:41:25.557158-08
92	wagtailsearch	0001_initial	2015-12-04 23:41:26.084199-08
93	wagtailsearch	0002_add_verbose_names	2015-12-04 23:41:26.961022-08
94	wagtailsearch	0003_remove_editors_pick	2015-12-04 23:41:27.200856-08
95	wagtailusers	0001_initial	2015-12-04 23:41:27.4241-08
96	wagtailusers	0002_add_verbose_name_on_userprofile	2015-12-04 23:41:28.001086-08
97	wagtailusers	0003_add_verbose_names	2015-12-04 23:41:28.69539-08
98	wishlists	0001_initial	2015-12-04 23:41:29.425799-08
99	wagtailcore	0001_squashed_0016_change_page_url_path_to_text_field	2015-12-04 23:41:29.43191-08
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('django_migrations_id_seq', 99, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
z2z33y1jgvk6qtb915jv0udc2yy2mnnl	NTQ3YmZkYmZlMTg1OTdjNTNhNjNlMDIxZWZjZjQ5MzVkOTNjMDA0Nzp7ImNoZWNrb3V0X2RhdGEiOnsic2hpcHBpbmciOnsibmV3X2FkZHJlc3NfZmllbGRzIjp7ImZpcnN0X25hbWUiOiJUYWVod2FuIiwibGluZTQiOiJMb3MgQW5nZWxlcyIsImxpbmUxIjoiNzQ2IFMgQnVybGluZ3RvbiBBdmUiLCJwb3N0Y29kZSI6IjkwMDU3IiwiY291bnRyeV9pZCI6IlVTIiwic3RhdGUiOiJDQSIsInNlYXJjaF90ZXh0IjoiIiwibGluZTMiOiIiLCJub3RlcyI6IkZhc3Qgc2hpcHBpbmcgcGxlYXNlLiIsInRpdGxlIjoiIiwiaWQiOm51bGwsImxhc3RfbmFtZSI6IkxlZSIsImxpbmUyIjoiIzMyMCIsInBob25lX251bWJlciI6IisxIDIxMy01MDUtNTgxOSJ9LCJtZXRob2RfY29kZSI6ImV4cHJlc3MifX0sIl9hdXRoX3VzZXJfaGFzaCI6Ijg0MjM5NDA0MmYzODEwZTNlMGY1Y2NiYzY4YmExYjRkZTgyYzVhZjMiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6Im9zY2FyLmFwcHMuY3VzdG9tZXIuYXV0aF9iYWNrZW5kcy5FbWFpbEJhY2tlbmQifQ==	2015-12-22 14:25:43.045774-08
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Data for Name: home_homepage; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY home_homepage (page_ptr_id) FROM stdin;
3
\.


--
-- Data for Name: home_promotionspage; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY home_promotionspage (page_ptr_id) FROM stdin;
\.


--
-- Data for Name: offer_benefit; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY offer_benefit (id, type, value, max_affected_items, proxy_class, range_id) FROM stdin;
\.


--
-- Name: offer_benefit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('offer_benefit_id_seq', 1, false);


--
-- Data for Name: offer_condition; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY offer_condition (id, type, value, proxy_class, range_id) FROM stdin;
\.


--
-- Name: offer_condition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('offer_condition_id_seq', 1, false);


--
-- Data for Name: offer_conditionaloffer; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY offer_conditionaloffer (id, name, slug, description, offer_type, status, priority, start_datetime, end_datetime, max_global_applications, max_user_applications, max_basket_applications, max_discount, total_discount, num_applications, num_orders, redirect_url, date_created, benefit_id, condition_id) FROM stdin;
\.


--
-- Name: offer_conditionaloffer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('offer_conditionaloffer_id_seq', 1, false);


--
-- Data for Name: offer_range; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY offer_range (id, name, slug, description, is_public, includes_all_products, proxy_class, date_created) FROM stdin;
\.


--
-- Data for Name: offer_range_classes; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY offer_range_classes (id, range_id, productclass_id) FROM stdin;
\.


--
-- Name: offer_range_classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('offer_range_classes_id_seq', 1, false);


--
-- Data for Name: offer_range_excluded_products; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY offer_range_excluded_products (id, range_id, product_id) FROM stdin;
\.


--
-- Name: offer_range_excluded_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('offer_range_excluded_products_id_seq', 1, false);


--
-- Name: offer_range_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('offer_range_id_seq', 1, false);


--
-- Data for Name: offer_range_included_categories; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY offer_range_included_categories (id, range_id, category_id) FROM stdin;
\.


--
-- Name: offer_range_included_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('offer_range_included_categories_id_seq', 1, false);


--
-- Data for Name: offer_rangeproduct; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY offer_rangeproduct (id, display_order, product_id, range_id) FROM stdin;
\.


--
-- Name: offer_rangeproduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('offer_rangeproduct_id_seq', 1, false);


--
-- Data for Name: offer_rangeproductfileupload; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY offer_rangeproductfileupload (id, filepath, size, date_uploaded, status, error_message, date_processed, num_new_skus, num_unknown_skus, num_duplicate_skus, range_id, uploaded_by_id) FROM stdin;
\.


--
-- Name: offer_rangeproductfileupload_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('offer_rangeproductfileupload_id_seq', 1, false);


--
-- Data for Name: order_billingaddress; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_billingaddress (id, title, first_name, last_name, line1, line2, line3, line4, state, postcode, search_text, country_id) FROM stdin;
\.


--
-- Name: order_billingaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_billingaddress_id_seq', 1, false);


--
-- Data for Name: order_communicationevent; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_communicationevent (id, date_created, event_type_id, order_id) FROM stdin;
\.


--
-- Name: order_communicationevent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_communicationevent_id_seq', 1, false);


--
-- Data for Name: order_line; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_line (id, partner_name, partner_sku, partner_line_reference, partner_line_notes, title, upc, quantity, line_price_incl_tax, line_price_excl_tax, line_price_before_discounts_incl_tax, line_price_before_discounts_excl_tax, unit_cost_price, unit_price_incl_tax, unit_price_excl_tax, unit_retail_price, status, est_dispatch_date, order_id, partner_id, product_id, stockrecord_id) FROM stdin;
\.


--
-- Name: order_line_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_line_id_seq', 1, false);


--
-- Data for Name: order_lineattribute; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_lineattribute (id, type, value, line_id, option_id) FROM stdin;
\.


--
-- Name: order_lineattribute_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_lineattribute_id_seq', 1, false);


--
-- Data for Name: order_lineprice; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_lineprice (id, quantity, price_incl_tax, price_excl_tax, shipping_incl_tax, shipping_excl_tax, line_id, order_id) FROM stdin;
\.


--
-- Name: order_lineprice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_lineprice_id_seq', 1, false);


--
-- Data for Name: order_order; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_order (id, number, currency, total_incl_tax, total_excl_tax, shipping_incl_tax, shipping_excl_tax, shipping_method, shipping_code, status, guest_email, date_placed, basket_id, billing_address_id, shipping_address_id, site_id, user_id) FROM stdin;
\.


--
-- Name: order_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_order_id_seq', 1, false);


--
-- Data for Name: order_orderdiscount; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_orderdiscount (id, category, offer_id, offer_name, voucher_id, voucher_code, frequency, amount, message, order_id) FROM stdin;
\.


--
-- Name: order_orderdiscount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_orderdiscount_id_seq', 1, false);


--
-- Data for Name: order_ordernote; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_ordernote (id, note_type, message, date_created, date_updated, order_id, user_id) FROM stdin;
\.


--
-- Name: order_ordernote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_ordernote_id_seq', 1, false);


--
-- Data for Name: order_paymentevent; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_paymentevent (id, amount, reference, date_created, event_type_id, order_id, shipping_event_id) FROM stdin;
\.


--
-- Name: order_paymentevent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_paymentevent_id_seq', 1, false);


--
-- Data for Name: order_paymenteventquantity; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_paymenteventquantity (id, quantity, event_id, line_id) FROM stdin;
\.


--
-- Name: order_paymenteventquantity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_paymenteventquantity_id_seq', 1, false);


--
-- Data for Name: order_paymenteventtype; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_paymenteventtype (id, name, code) FROM stdin;
\.


--
-- Name: order_paymenteventtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_paymenteventtype_id_seq', 1, false);


--
-- Data for Name: order_shippingaddress; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_shippingaddress (id, title, first_name, last_name, line1, line2, line3, line4, state, postcode, search_text, phone_number, notes, country_id) FROM stdin;
\.


--
-- Name: order_shippingaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_shippingaddress_id_seq', 1, false);


--
-- Data for Name: order_shippingevent; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_shippingevent (id, notes, date_created, event_type_id, order_id) FROM stdin;
\.


--
-- Name: order_shippingevent_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_shippingevent_id_seq', 1, false);


--
-- Data for Name: order_shippingeventquantity; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_shippingeventquantity (id, quantity, event_id, line_id) FROM stdin;
\.


--
-- Name: order_shippingeventquantity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_shippingeventquantity_id_seq', 1, false);


--
-- Data for Name: order_shippingeventtype; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY order_shippingeventtype (id, name, code) FROM stdin;
\.


--
-- Name: order_shippingeventtype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('order_shippingeventtype_id_seq', 1, false);


--
-- Data for Name: partner_partner; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY partner_partner (id, code, name) FROM stdin;
1	sk-beauty	SK Beauty
\.


--
-- Name: partner_partner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('partner_partner_id_seq', 1, true);


--
-- Data for Name: partner_partner_users; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY partner_partner_users (id, partner_id, user_id) FROM stdin;
\.


--
-- Name: partner_partner_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('partner_partner_users_id_seq', 1, false);


--
-- Data for Name: partner_partneraddress; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY partner_partneraddress (id, title, first_name, last_name, line1, line2, line3, line4, state, postcode, search_text, country_id, partner_id) FROM stdin;
\.


--
-- Name: partner_partneraddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('partner_partneraddress_id_seq', 1, false);


--
-- Data for Name: partner_stockalert; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY partner_stockalert (id, threshold, status, date_created, date_closed, stockrecord_id) FROM stdin;
\.


--
-- Name: partner_stockalert_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('partner_stockalert_id_seq', 1, false);


--
-- Data for Name: partner_stockrecord; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY partner_stockrecord (id, partner_sku, price_currency, price_excl_tax, price_retail, cost_price, num_in_stock, num_allocated, low_stock_threshold, date_created, date_updated, partner_id, product_id) FROM stdin;
1	1000	USD	29.99	29.99	29.99	10	\N	5	2015-12-07 11:05:58.593544-08	2015-12-07 11:05:58.593563-08	1	5
3	1002	USD	42.99	42.99	42.99	10	\N	10	2015-12-07 11:46:23.248577-08	2015-12-07 11:46:23.248595-08	1	4
4	2000	USD	29.99	29.99	29.99	10	\N	5	2015-12-07 11:49:48.958634-08	2015-12-07 11:49:48.958652-08	1	7
5	2001	USD	39.99	39.99	39.99	10	\N	5	2015-12-07 11:50:40.286592-08	2015-12-07 11:50:40.286611-08	1	8
6	2003	USD	65.99	65.99	65.99	10	\N	5	2015-12-07 11:51:11.744536-08	2015-12-07 11:51:11.744554-08	1	9
7	2005	USD	29.99	29.99	29.99	10	\N	5	2015-12-07 13:21:57.94196-08	2015-12-07 13:21:57.941974-08	1	10
8	2007	USD	69.99	69.99	69.99	10	\N	5	2015-12-07 13:49:10.732408-08	2015-12-07 13:49:10.73243-08	1	11
9	2010	USD	78.99	78.99	78.99	10	\N	5	2015-12-07 16:20:45.811417-08	2015-12-07 16:20:45.81144-08	1	12
2	1001	USD	109.99	109.99	109.99	10	\N	5	2015-12-07 11:44:24.647861-08	2015-12-07 16:26:00.346164-08	1	3
10	2011	USD	69.99	69.99	69.99	10	\N	5	2015-12-07 17:21:25.773291-08	2015-12-07 17:21:25.773309-08	1	13
\.


--
-- Name: partner_stockrecord_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('partner_stockrecord_id_seq', 10, true);


--
-- Data for Name: payment_bankcard; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payment_bankcard (id, card_type, name, number, expiry_date, partner_reference, user_id) FROM stdin;
\.


--
-- Name: payment_bankcard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payment_bankcard_id_seq', 1, false);


--
-- Data for Name: payment_source; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payment_source (id, currency, amount_allocated, amount_debited, amount_refunded, reference, label, order_id, source_type_id) FROM stdin;
\.


--
-- Name: payment_source_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payment_source_id_seq', 1, false);


--
-- Data for Name: payment_sourcetype; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payment_sourcetype (id, name, code) FROM stdin;
\.


--
-- Name: payment_sourcetype_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payment_sourcetype_id_seq', 1, false);


--
-- Data for Name: payment_transaction; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payment_transaction (id, txn_type, amount, reference, status, date_created, source_id) FROM stdin;
\.


--
-- Name: payment_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payment_transaction_id_seq', 1, false);


--
-- Data for Name: payments_charge; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payments_charge (id, stripe_id, created_at, customer_id, invoice_id, card_last_4, card_kind, currency, amount, amount_refunded, description, paid, disputed, refunded, captured, fee, receipt_sent, charge_created) FROM stdin;
\.


--
-- Name: payments_charge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payments_charge_id_seq', 1, false);


--
-- Data for Name: payments_currentsubscription; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payments_currentsubscription (id, customer_id, plan, quantity, start, status, cancel_at_period_end, canceled_at, current_period_end, current_period_start, ended_at, trial_end, trial_start, amount, currency, created_at) FROM stdin;
\.


--
-- Name: payments_currentsubscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payments_currentsubscription_id_seq', 1, false);


--
-- Data for Name: payments_customer; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payments_customer (id, stripe_id, created_at, user_id, card_fingerprint, card_last_4, card_kind, date_purged) FROM stdin;
\.


--
-- Name: payments_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payments_customer_id_seq', 1, false);


--
-- Data for Name: payments_event; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payments_event (id, stripe_id, created_at, kind, livemode, customer_id, webhook_message, validated_message, valid, processed) FROM stdin;
\.


--
-- Name: payments_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payments_event_id_seq', 1, false);


--
-- Data for Name: payments_eventprocessingexception; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payments_eventprocessingexception (id, event_id, data, message, traceback, created_at) FROM stdin;
\.


--
-- Name: payments_eventprocessingexception_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payments_eventprocessingexception_id_seq', 1, false);


--
-- Data for Name: payments_invoice; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payments_invoice (id, stripe_id, customer_id, attempted, attempts, closed, paid, period_end, period_start, subtotal, total, currency, date, charge, created_at) FROM stdin;
\.


--
-- Name: payments_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payments_invoice_id_seq', 1, false);


--
-- Data for Name: payments_invoiceitem; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payments_invoiceitem (id, stripe_id, created_at, invoice_id, amount, currency, period_start, period_end, proration, line_type, description, plan, quantity) FROM stdin;
\.


--
-- Name: payments_invoiceitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payments_invoiceitem_id_seq', 1, false);


--
-- Data for Name: payments_transfer; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payments_transfer (id, stripe_id, created_at, event_id, amount, currency, status, date, description, adjustment_count, adjustment_fees, adjustment_gross, charge_count, charge_fees, charge_gross, collected_fee_count, collected_fee_gross, net, refund_count, refund_fees, refund_gross, validation_count, validation_fees) FROM stdin;
\.


--
-- Name: payments_transfer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payments_transfer_id_seq', 1, false);


--
-- Data for Name: payments_transferchargefee; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY payments_transferchargefee (id, transfer_id, amount, currency, application, description, kind, created_at) FROM stdin;
\.


--
-- Name: payments_transferchargefee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('payments_transferchargefee_id_seq', 1, false);


--
-- Data for Name: paypal_expresstransaction; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY paypal_expresstransaction (id, raw_request, raw_response, response_time, date_created, method, version, amount, currency, ack, correlation_id, token, error_code, error_message) FROM stdin;
1	EMAIL=taedori%40outlook.com&PAYMENTREQUEST_0_TAXAMT=0.00&RETURNURL=https%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fpreview%2F1%2F&L_SHIPPINGOPTIONISDEFAULT1=false&MAXAMT=271.77&L_PAYMENTREQUEST_0_NAME1=BOBBI+BOSS%C2%AE+VISSO%E2%84%A2+Yaky+100%25+Human+Hair&L_PAYMENTREQUEST_0_AMT1=76.99&L_SHIPPINGOPTIONNAME0=Standard&L_PAYMENTREQUEST_0_AMT0=86.89&ALLOWNOTE=1&USER=taedori-facilitator_api1.outlook.com&PAYMENTREQUEST_0_ITEMAMT=250.77&SIGNATURE=AFcWxV21C7fd0v3bYYYRCpSSRl31AvhDL5MCT2FxtvbrQyruwKdDk-Lk&L_SHIPPINGOPTIONNAME1=Express&PAYMENTREQUEST_0_MAXAMT=271.77&L_SHIPPINGOPTIONISDEFAULT0=true&L_PAYMENTREQUEST_0_QTY0=2&L_PAYMENTREQUEST_0_NUMBER1=&PAYMENTREQUEST_0_SHIPPINGAMT=11.00&L_PAYMENTREQUEST_0_NAME0=BOBBI+BOSS%C2%AE+VISSO%E2%84%A2+Yaky+100%25+Human+Hair&VERSION=119&PAYMENTREQUEST_0_CURRENCYCODE=USD&PWD=XXTKL86TAR594CQ5&PAYMENTREQUEST_0_AMT=261.77&METHOD=SetExpressCheckout&PAYMENTREQUEST_0_HANDLINGAMT=0.00&L_PAYMENTREQUEST_0_DESC0=&L_PAYMENTREQUEST_0_QTY1=1&CALLBACK=https%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fshipping-options%2F1%2F&L_SHIPPINGOPTIONAMOUNT1=21.00&L_PAYMENTREQUEST_0_NUMBER0=&L_SHIPPINGOPTIONAMOUNT0=11.00&CANCELURL=https%3A%2F%2Flocalhost%3A8000%2Fcheckout%2Fpaypal%2Fcancel%2F1%2F&CALLBACKTIMEOUT=3&PAYMENTREQUEST_0_PAYMENTACTION=Sale&L_PAYMENTREQUEST_0_DESC1=	TOKEN=EC%2d2R738617XM440512W&TIMESTAMP=2015%2d12%2d08T22%3a25%3a49Z&CORRELATIONID=f018355b6da47&ACK=Success&VERSION=119&BUILD=18308778	564.21661376953125	2015-12-08 14:25:49.799909-08	SetExpressCheckout	119	261.77	USD	Success	f018355b6da47	EC-2R738617XM440512W	\N	\N
\.


--
-- Name: paypal_expresstransaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('paypal_expresstransaction_id_seq', 1, true);


--
-- Data for Name: paypal_payflowtransaction; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY paypal_payflowtransaction (id, raw_request, raw_response, response_time, date_created, comment1, trxtype, tender, amount, pnref, ppref, result, respmsg, authcode, cvv2match, avsaddr, avszip) FROM stdin;
\.


--
-- Name: paypal_payflowtransaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('paypal_payflowtransaction_id_seq', 1, false);


--
-- Data for Name: promotions_automaticproductlist; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_automaticproductlist (id, name, description, link_url, link_text, date_created, method, num_products) FROM stdin;
\.


--
-- Name: promotions_automaticproductlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('promotions_automaticproductlist_id_seq', 1, false);


--
-- Data for Name: promotions_handpickedproductlist; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_handpickedproductlist (id, name, description, link_url, link_text, date_created) FROM stdin;
\.


--
-- Name: promotions_handpickedproductlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('promotions_handpickedproductlist_id_seq', 1, false);


--
-- Data for Name: promotions_image; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_image (id, name, link_url, image, date_created) FROM stdin;
\.


--
-- Name: promotions_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('promotions_image_id_seq', 1, false);


--
-- Data for Name: promotions_keywordpromotion; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_keywordpromotion (id, object_id, "position", display_order, clicks, date_created, keyword, filter, content_type_id) FROM stdin;
\.


--
-- Name: promotions_keywordpromotion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('promotions_keywordpromotion_id_seq', 1, false);


--
-- Data for Name: promotions_multiimage; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_multiimage (id, name, date_created) FROM stdin;
\.


--
-- Name: promotions_multiimage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('promotions_multiimage_id_seq', 1, false);


--
-- Data for Name: promotions_multiimage_images; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_multiimage_images (id, multiimage_id, image_id) FROM stdin;
\.


--
-- Name: promotions_multiimage_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('promotions_multiimage_images_id_seq', 1, false);


--
-- Data for Name: promotions_orderedproduct; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_orderedproduct (id, display_order, list_id, product_id) FROM stdin;
\.


--
-- Name: promotions_orderedproduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('promotions_orderedproduct_id_seq', 1, false);


--
-- Data for Name: promotions_orderedproductlist; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_orderedproductlist (handpickedproductlist_ptr_id, display_order, tabbed_block_id) FROM stdin;
\.


--
-- Data for Name: promotions_pagepromotion; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_pagepromotion (id, object_id, "position", display_order, clicks, date_created, page_url, content_type_id) FROM stdin;
\.


--
-- Name: promotions_pagepromotion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('promotions_pagepromotion_id_seq', 1, false);


--
-- Data for Name: promotions_rawhtml; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_rawhtml (id, name, display_type, body, date_created) FROM stdin;
\.


--
-- Name: promotions_rawhtml_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('promotions_rawhtml_id_seq', 1, false);


--
-- Data for Name: promotions_singleproduct; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_singleproduct (id, name, description, date_created, product_id) FROM stdin;
\.


--
-- Name: promotions_singleproduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('promotions_singleproduct_id_seq', 1, false);


--
-- Data for Name: promotions_tabbedblock; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY promotions_tabbedblock (id, name, date_created) FROM stdin;
\.


--
-- Name: promotions_tabbedblock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('promotions_tabbedblock_id_seq', 1, false);


--
-- Data for Name: reviews_productreview; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY reviews_productreview (id, score, title, body, name, email, homepage, status, total_votes, delta_votes, date_created, product_id, user_id) FROM stdin;
\.


--
-- Name: reviews_productreview_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('reviews_productreview_id_seq', 1, false);


--
-- Data for Name: reviews_vote; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY reviews_vote (id, delta, date_created, review_id, user_id) FROM stdin;
\.


--
-- Name: reviews_vote_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('reviews_vote_id_seq', 1, false);


--
-- Data for Name: shipping_orderanditemcharges; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY shipping_orderanditemcharges (id, code, name, description, price_per_order, price_per_item, free_shipping_threshold) FROM stdin;
\.


--
-- Data for Name: shipping_orderanditemcharges_countries; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY shipping_orderanditemcharges_countries (id, orderanditemcharges_id, country_id) FROM stdin;
\.


--
-- Name: shipping_orderanditemcharges_countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('shipping_orderanditemcharges_countries_id_seq', 1, false);


--
-- Name: shipping_orderanditemcharges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('shipping_orderanditemcharges_id_seq', 1, false);


--
-- Data for Name: shipping_weightband; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY shipping_weightband (id, upper_limit, charge, method_id) FROM stdin;
\.


--
-- Name: shipping_weightband_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('shipping_weightband_id_seq', 1, false);


--
-- Data for Name: shipping_weightbased; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY shipping_weightbased (id, code, name, description, default_weight) FROM stdin;
\.


--
-- Data for Name: shipping_weightbased_countries; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY shipping_weightbased_countries (id, weightbased_id, country_id) FROM stdin;
\.


--
-- Name: shipping_weightbased_countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('shipping_weightbased_countries_id_seq', 1, false);


--
-- Name: shipping_weightbased_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('shipping_weightbased_id_seq', 1, false);


--
-- Data for Name: taggit_tag; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY taggit_tag (id, name, slug) FROM stdin;
\.


--
-- Name: taggit_tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('taggit_tag_id_seq', 1, false);


--
-- Data for Name: taggit_taggeditem; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY taggit_taggeditem (id, object_id, content_type_id, tag_id) FROM stdin;
\.


--
-- Name: taggit_taggeditem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('taggit_taggeditem_id_seq', 1, false);


--
-- Data for Name: thumbnail_kvstore; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY thumbnail_kvstore (key, value) FROM stdin;
sorl-thumbnail||image||1205a08dec03ab8a1b93457c5e198652	{"storage": "django.core.files.storage.FileSystemStorage", "name": "images/products/2015/12/Beauty-Depot-VI_2_H700.png", "size": [467, 700]}
sorl-thumbnail||image||16c57b9c266f59606e0ac95ada5e995d	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/c7/bb/c7bb81f39e5e14ca950141d5d6bff824.jpg", "size": [133, 200]}
sorl-thumbnail||thumbnails||1205a08dec03ab8a1b93457c5e198652	["16c57b9c266f59606e0ac95ada5e995d"]
sorl-thumbnail||image||cc78faa248ebaa5da0e97f49db9cba00	{"storage": "django.core.files.storage.FileSystemStorage", "name": "images/products/2015/12/vissoi-shop_3fca2bf7-5242-4b93-a226-27473a03aebe_1024x1024.png", "size": [600, 705]}
sorl-thumbnail||image||299b00384699b7c86c1b1acc2cf652fa	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/e9/6b/e96ba929355f5e6cf63c2c345ec61428.jpg", "size": [170, 200]}
sorl-thumbnail||thumbnails||cc78faa248ebaa5da0e97f49db9cba00	["299b00384699b7c86c1b1acc2cf652fa"]
sorl-thumbnail||image||f5969f0120502ec741fbc54692fc4689	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/6d/e3/6de3eaaa31698e77d641d277337228cc.jpg", "size": [298, 446]}
sorl-thumbnail||image||f95695558b6cddda07c6f7606c533ea8	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/63/fe/63fe68709d2281f5f60e46427e166e8f.jpg", "size": [360, 423]}
sorl-thumbnail||image||c21ecea8ff2b20d3dee6dff19d741256	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/40/77/4077a6e9e7892f5468dea531a1400ba6.jpg", "size": [167, 250]}
sorl-thumbnail||image||1b6b83c55fcda8bd87accfee5d05cc56	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/3c/7f/3c7f35360a75ececa1ac406878be9ab6.jpg", "size": [467, 700]}
sorl-thumbnail||image||f976657bd083ab72661876484dad3c0c	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/47/81/4781b63e0d1ad885ed890310f2cc6b5d.jpg", "size": [596, 700]}
sorl-thumbnail||image||5f502ff112abfda6e98f2a9339f38cc1	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/66/30/66309e22a7cbbdf8faa4597136256a41.jpg", "size": [47, 70]}
sorl-thumbnail||image||333d9bc5d06398a67bb04eb910e0936c	{"storage": "django.core.files.storage.FileSystemStorage", "name": "image_not_found.jpg", "size": [400, 300]}
sorl-thumbnail||image||973a4d869ef81a3c875e4db0440aa413	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/d3/9b/d39b50b4eafab673a0bb5d595b996a93.jpg", "size": [333, 250]}
sorl-thumbnail||thumbnails||333d9bc5d06398a67bb04eb910e0936c	["973a4d869ef81a3c875e4db0440aa413"]
sorl-thumbnail||image||68437fa12fa99481f457a974268c15e6	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/65/eb/65ebecab9adc07a21ad5e379c867e21e.jpg", "size": [167, 250]}
sorl-thumbnail||image||c66be9ab7a298b7a89b9913695ce75c5	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/d6/50/d650026bbcb43cc93243f640cb538a8b.jpg", "size": [213, 250]}
sorl-thumbnail||image||e6887ed940c52acf21dc9877fc050d29	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/6c/85/6c85575a117c841798a5815f27ec07bb.jpg", "size": [400, 300]}
sorl-thumbnail||image||e749d4431dc651e4e50b3d8cac4d59d3	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/ef/86/ef86d1309f53cbdfbec3620fd3e82f90.jpg", "size": [234, 350]}
sorl-thumbnail||image||209b24187ded55b74169321648527d2d	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/05/be/05bebd3ef5c91fff00e1aeb5242b6569.jpg", "size": [298, 350]}
sorl-thumbnail||image||62badb9fca6576a06d9e32369f1b12f5	{"storage": "django.core.files.storage.FileSystemStorage", "name": "images/products/2015/12/vissoielegant-shop_large.png", "size": [596, 700]}
sorl-thumbnail||image||6f91776085980efcac74c2fb105ffeaa	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/67/a7/67a7ca2f5885d8434d650e0ca2ecdc66.jpg", "size": [170, 200]}
sorl-thumbnail||thumbnails||62badb9fca6576a06d9e32369f1b12f5	["6f91776085980efcac74c2fb105ffeaa"]
sorl-thumbnail||image||e00e6d5cf8e7f54497a2c03554302c28	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/f4/f4/f4f4991e055377f592ecdc71deb62d4d.jpg", "size": [298, 350]}
sorl-thumbnail||image||5755aac4a86428477f895d982f16e891	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/23/22/2322604ef736745ebfe6a1c25faf1f8b.jpg", "size": [596, 700]}
sorl-thumbnail||image||978a3a7f937888781625dbae05459b9f	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/03/c4/03c4d7c7ac7784562df12d5477a1c9bd.jpg", "size": [213, 250]}
sorl-thumbnail||image||4aa6a67aca8d9cd4f2fd8465aec59f39	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/32/1c/321cb7bcae948db6367c19567110be59.jpg", "size": [213, 250]}
sorl-thumbnail||image||7c8f32403c2dbab87cbe07f692621b7e	{"size": [60, 70], "name": "cache/f8/f3/f8f3ad214c032d7c744c850789424f6f.jpg", "storage": "django.core.files.storage.FileSystemStorage"}
sorl-thumbnail||image||76c6ea1cfb4abbba835b7d21bda9fb94	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/05/45/05451bdf995802c5e2e4111331757bc6.jpg", "size": [150, 225]}
sorl-thumbnail||image||623c25b1dbb02cff2ad95aba8a21cae7	{"storage": "django.core.files.storage.FileSystemStorage", "name": "cache/c5/7e/c57e81f6363c38a325ef0fdc9d0709ec.jpg", "size": [150, 176]}
\.


--
-- Data for Name: voucher_voucher; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY voucher_voucher (id, name, code, usage, start_datetime, end_datetime, num_basket_additions, num_orders, total_discount, date_created) FROM stdin;
\.


--
-- Name: voucher_voucher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('voucher_voucher_id_seq', 1, false);


--
-- Data for Name: voucher_voucher_offers; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY voucher_voucher_offers (id, voucher_id, conditionaloffer_id) FROM stdin;
\.


--
-- Name: voucher_voucher_offers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('voucher_voucher_offers_id_seq', 1, false);


--
-- Data for Name: voucher_voucherapplication; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY voucher_voucherapplication (id, date_created, order_id, user_id, voucher_id) FROM stdin;
\.


--
-- Name: voucher_voucherapplication_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('voucher_voucherapplication_id_seq', 1, false);


--
-- Data for Name: wagtailcore_grouppagepermission; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailcore_grouppagepermission (id, permission_type, group_id, page_id) FROM stdin;
1	add	1	1
2	edit	1	1
3	publish	1	1
4	add	2	1
5	edit	2	1
6	lock	1	1
\.


--
-- Name: wagtailcore_grouppagepermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailcore_grouppagepermission_id_seq', 6, true);


--
-- Data for Name: wagtailcore_page; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailcore_page (id, path, depth, numchild, title, slug, live, has_unpublished_changes, url_path, seo_title, show_in_menus, search_description, go_live_at, expire_at, expired, content_type_id, owner_id, locked, latest_revision_created_at, first_published_at) FROM stdin;
1	0001	1	1	Root	root	t	f	/		f		\N	\N	f	14	\N	f	\N	\N
3	00010001	2	0	Homepage	home	t	f	/home/		f		\N	\N	f	1	\N	f	\N	\N
\.


--
-- Name: wagtailcore_page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailcore_page_id_seq', 3, true);


--
-- Data for Name: wagtailcore_pagerevision; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailcore_pagerevision (id, submitted_for_moderation, created_at, content_json, approved_go_live_at, page_id, user_id) FROM stdin;
\.


--
-- Name: wagtailcore_pagerevision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailcore_pagerevision_id_seq', 1, false);


--
-- Data for Name: wagtailcore_pageviewrestriction; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailcore_pageviewrestriction (id, password, page_id) FROM stdin;
\.


--
-- Name: wagtailcore_pageviewrestriction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailcore_pageviewrestriction_id_seq', 1, false);


--
-- Data for Name: wagtailcore_site; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailcore_site (id, hostname, port, is_default_site, root_page_id) FROM stdin;
2	localhost	80	t	3
\.


--
-- Name: wagtailcore_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailcore_site_id_seq', 2, true);


--
-- Data for Name: wagtaildocs_document; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtaildocs_document (id, title, file, created_at, uploaded_by_user_id) FROM stdin;
\.


--
-- Name: wagtaildocs_document_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtaildocs_document_id_seq', 1, false);


--
-- Data for Name: wagtailembeds_embed; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailembeds_embed (id, url, max_width, type, html, title, author_name, provider_name, thumbnail_url, width, height, last_updated) FROM stdin;
\.


--
-- Name: wagtailembeds_embed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailembeds_embed_id_seq', 1, false);


--
-- Data for Name: wagtailforms_formsubmission; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailforms_formsubmission (id, form_data, submit_time, page_id) FROM stdin;
\.


--
-- Name: wagtailforms_formsubmission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailforms_formsubmission_id_seq', 1, false);


--
-- Data for Name: wagtailimages_filter; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailimages_filter (id, spec) FROM stdin;
\.


--
-- Name: wagtailimages_filter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailimages_filter_id_seq', 1, false);


--
-- Data for Name: wagtailimages_image; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailimages_image (id, title, file, width, height, created_at, focal_point_x, focal_point_y, focal_point_width, focal_point_height, uploaded_by_user_id, file_size) FROM stdin;
\.


--
-- Name: wagtailimages_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailimages_image_id_seq', 1, false);


--
-- Data for Name: wagtailimages_rendition; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailimages_rendition (id, file, width, height, focal_point_key, filter_id, image_id) FROM stdin;
\.


--
-- Name: wagtailimages_rendition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailimages_rendition_id_seq', 1, false);


--
-- Data for Name: wagtailredirects_redirect; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailredirects_redirect (id, old_path, is_permanent, redirect_link, redirect_page_id, site_id) FROM stdin;
\.


--
-- Name: wagtailredirects_redirect_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailredirects_redirect_id_seq', 1, false);


--
-- Data for Name: wagtailsearch_editorspick; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailsearch_editorspick (id, sort_order, description, page_id, query_id) FROM stdin;
\.


--
-- Name: wagtailsearch_editorspick_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailsearch_editorspick_id_seq', 1, false);


--
-- Data for Name: wagtailsearch_query; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailsearch_query (id, query_string) FROM stdin;
\.


--
-- Name: wagtailsearch_query_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailsearch_query_id_seq', 1, false);


--
-- Data for Name: wagtailsearch_querydailyhits; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailsearch_querydailyhits (id, date, hits, query_id) FROM stdin;
\.


--
-- Name: wagtailsearch_querydailyhits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailsearch_querydailyhits_id_seq', 1, false);


--
-- Data for Name: wagtailusers_userprofile; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wagtailusers_userprofile (id, submitted_notifications, approved_notifications, rejected_notifications, user_id) FROM stdin;
\.


--
-- Name: wagtailusers_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wagtailusers_userprofile_id_seq', 1, false);


--
-- Data for Name: wishlists_line; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wishlists_line (id, quantity, title, product_id, wishlist_id) FROM stdin;
\.


--
-- Name: wishlists_line_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wishlists_line_id_seq', 1, false);


--
-- Data for Name: wishlists_wishlist; Type: TABLE DATA; Schema: public; Owner: taedori
--

COPY wishlists_wishlist (id, name, key, visibility, date_created, owner_id) FROM stdin;
\.


--
-- Name: wishlists_wishlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: taedori
--

SELECT pg_catalog.setval('wishlists_wishlist_id_seq', 1, false);


--
-- Name: address_country_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY address_country
    ADD CONSTRAINT address_country_pkey PRIMARY KEY (iso_3166_1_a2);


--
-- Name: address_useraddress_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY address_useraddress
    ADD CONSTRAINT address_useraddress_pkey PRIMARY KEY (id);


--
-- Name: address_useraddress_user_id_5d70abe49d8bc399_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY address_useraddress
    ADD CONSTRAINT address_useraddress_user_id_5d70abe49d8bc399_uniq UNIQUE (user_id, hash);


--
-- Name: analytics_productrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY analytics_productrecord
    ADD CONSTRAINT analytics_productrecord_pkey PRIMARY KEY (id);


--
-- Name: analytics_productrecord_product_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY analytics_productrecord
    ADD CONSTRAINT analytics_productrecord_product_id_key UNIQUE (product_id);


--
-- Name: analytics_userproductview_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY analytics_userproductview
    ADD CONSTRAINT analytics_userproductview_pkey PRIMARY KEY (id);


--
-- Name: analytics_userrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY analytics_userrecord
    ADD CONSTRAINT analytics_userrecord_pkey PRIMARY KEY (id);


--
-- Name: analytics_userrecord_user_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY analytics_userrecord
    ADD CONSTRAINT analytics_userrecord_user_id_key UNIQUE (user_id);


--
-- Name: analytics_usersearch_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY analytics_usersearch
    ADD CONSTRAINT analytics_usersearch_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: basket_basket_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY basket_basket
    ADD CONSTRAINT basket_basket_pkey PRIMARY KEY (id);


--
-- Name: basket_basket_vouchers_basket_id_voucher_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY basket_basket_vouchers
    ADD CONSTRAINT basket_basket_vouchers_basket_id_voucher_id_key UNIQUE (basket_id, voucher_id);


--
-- Name: basket_basket_vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY basket_basket_vouchers
    ADD CONSTRAINT basket_basket_vouchers_pkey PRIMARY KEY (id);


--
-- Name: basket_line_basket_id_5be04c0971f70189_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY basket_line
    ADD CONSTRAINT basket_line_basket_id_5be04c0971f70189_uniq UNIQUE (basket_id, line_reference);


--
-- Name: basket_line_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY basket_line
    ADD CONSTRAINT basket_line_pkey PRIMARY KEY (id);


--
-- Name: basket_lineattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY basket_lineattribute
    ADD CONSTRAINT basket_lineattribute_pkey PRIMARY KEY (id);


--
-- Name: catalogue_attributeoption_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_attributeoption
    ADD CONSTRAINT catalogue_attributeoption_pkey PRIMARY KEY (id);


--
-- Name: catalogue_attributeoptiongroup_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_attributeoptiongroup
    ADD CONSTRAINT catalogue_attributeoptiongroup_pkey PRIMARY KEY (id);


--
-- Name: catalogue_category_path_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_category
    ADD CONSTRAINT catalogue_category_path_key UNIQUE (path);


--
-- Name: catalogue_category_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_category
    ADD CONSTRAINT catalogue_category_pkey PRIMARY KEY (id);


--
-- Name: catalogue_option_code_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_option
    ADD CONSTRAINT catalogue_option_code_key UNIQUE (code);


--
-- Name: catalogue_option_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_option
    ADD CONSTRAINT catalogue_option_pkey PRIMARY KEY (id);


--
-- Name: catalogue_product_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_product
    ADD CONSTRAINT catalogue_product_pkey PRIMARY KEY (id);


--
-- Name: catalogue_product_product_options_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_product_product_options
    ADD CONSTRAINT catalogue_product_product_options_pkey PRIMARY KEY (id);


--
-- Name: catalogue_product_product_options_product_id_option_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_product_product_options
    ADD CONSTRAINT catalogue_product_product_options_product_id_option_id_key UNIQUE (product_id, option_id);


--
-- Name: catalogue_product_upc_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_product
    ADD CONSTRAINT catalogue_product_upc_key UNIQUE (upc);


--
-- Name: catalogue_productattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productattribute
    ADD CONSTRAINT catalogue_productattribute_pkey PRIMARY KEY (id);


--
-- Name: catalogue_productattributeva_attribute_id_7ab554ae8468f5ac_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productattributevalue
    ADD CONSTRAINT catalogue_productattributeva_attribute_id_7ab554ae8468f5ac_uniq UNIQUE (attribute_id, product_id);


--
-- Name: catalogue_productattributevalue_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productattributevalue
    ADD CONSTRAINT catalogue_productattributevalue_pkey PRIMARY KEY (id);


--
-- Name: catalogue_productcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productcategory
    ADD CONSTRAINT catalogue_productcategory_pkey PRIMARY KEY (id);


--
-- Name: catalogue_productcategory_product_id_5caec44f716ec678_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productcategory
    ADD CONSTRAINT catalogue_productcategory_product_id_5caec44f716ec678_uniq UNIQUE (product_id, category_id);


--
-- Name: catalogue_productclass_options_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productclass_options
    ADD CONSTRAINT catalogue_productclass_options_pkey PRIMARY KEY (id);


--
-- Name: catalogue_productclass_options_productclass_id_option_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productclass_options
    ADD CONSTRAINT catalogue_productclass_options_productclass_id_option_id_key UNIQUE (productclass_id, option_id);


--
-- Name: catalogue_productclass_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productclass
    ADD CONSTRAINT catalogue_productclass_pkey PRIMARY KEY (id);


--
-- Name: catalogue_productclass_slug_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productclass
    ADD CONSTRAINT catalogue_productclass_slug_key UNIQUE (slug);


--
-- Name: catalogue_productimage_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productimage
    ADD CONSTRAINT catalogue_productimage_pkey PRIMARY KEY (id);


--
-- Name: catalogue_productimage_product_id_607eba7dc4cc5131_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productimage
    ADD CONSTRAINT catalogue_productimage_product_id_607eba7dc4cc5131_uniq UNIQUE (product_id, display_order);


--
-- Name: catalogue_productrecommendatio_primary_id_1493967f0cce94fd_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productrecommendation
    ADD CONSTRAINT catalogue_productrecommendatio_primary_id_1493967f0cce94fd_uniq UNIQUE (primary_id, recommendation_id);


--
-- Name: catalogue_productrecommendation_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY catalogue_productrecommendation
    ADD CONSTRAINT catalogue_productrecommendation_pkey PRIMARY KEY (id);


--
-- Name: customer_communicationeventtype_code_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY customer_communicationeventtype
    ADD CONSTRAINT customer_communicationeventtype_code_key UNIQUE (code);


--
-- Name: customer_communicationeventtype_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY customer_communicationeventtype
    ADD CONSTRAINT customer_communicationeventtype_pkey PRIMARY KEY (id);


--
-- Name: customer_email_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY customer_email
    ADD CONSTRAINT customer_email_pkey PRIMARY KEY (id);


--
-- Name: customer_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY customer_notification
    ADD CONSTRAINT customer_notification_pkey PRIMARY KEY (id);


--
-- Name: customer_productalert_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY customer_productalert
    ADD CONSTRAINT customer_productalert_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_6ec8d7c27a230a_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_6ec8d7c27a230a_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_flatpage_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY django_flatpage
    ADD CONSTRAINT django_flatpage_pkey PRIMARY KEY (id);


--
-- Name: django_flatpage_sites_flatpage_id_site_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT django_flatpage_sites_flatpage_id_site_id_key UNIQUE (flatpage_id, site_id);


--
-- Name: django_flatpage_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT django_flatpage_sites_pkey PRIMARY KEY (id);


--
-- Name: django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: home_homepage_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY home_homepage
    ADD CONSTRAINT home_homepage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: home_promotionspage_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY home_promotionspage
    ADD CONSTRAINT home_promotionspage_pkey PRIMARY KEY (page_ptr_id);


--
-- Name: offer_benefit_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_benefit
    ADD CONSTRAINT offer_benefit_pkey PRIMARY KEY (id);


--
-- Name: offer_benefit_proxy_class_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_benefit
    ADD CONSTRAINT offer_benefit_proxy_class_key UNIQUE (proxy_class);


--
-- Name: offer_condition_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_condition
    ADD CONSTRAINT offer_condition_pkey PRIMARY KEY (id);


--
-- Name: offer_condition_proxy_class_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_condition
    ADD CONSTRAINT offer_condition_proxy_class_key UNIQUE (proxy_class);


--
-- Name: offer_conditionaloffer_name_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_conditionaloffer
    ADD CONSTRAINT offer_conditionaloffer_name_key UNIQUE (name);


--
-- Name: offer_conditionaloffer_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_conditionaloffer
    ADD CONSTRAINT offer_conditionaloffer_pkey PRIMARY KEY (id);


--
-- Name: offer_conditionaloffer_slug_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_conditionaloffer
    ADD CONSTRAINT offer_conditionaloffer_slug_key UNIQUE (slug);


--
-- Name: offer_range_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_range_classes
    ADD CONSTRAINT offer_range_classes_pkey PRIMARY KEY (id);


--
-- Name: offer_range_classes_range_id_productclass_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_range_classes
    ADD CONSTRAINT offer_range_classes_range_id_productclass_id_key UNIQUE (range_id, productclass_id);


--
-- Name: offer_range_excluded_products_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_range_excluded_products
    ADD CONSTRAINT offer_range_excluded_products_pkey PRIMARY KEY (id);


--
-- Name: offer_range_excluded_products_range_id_product_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_range_excluded_products
    ADD CONSTRAINT offer_range_excluded_products_range_id_product_id_key UNIQUE (range_id, product_id);


--
-- Name: offer_range_included_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_range_included_categories
    ADD CONSTRAINT offer_range_included_categories_pkey PRIMARY KEY (id);


--
-- Name: offer_range_included_categories_range_id_category_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_range_included_categories
    ADD CONSTRAINT offer_range_included_categories_range_id_category_id_key UNIQUE (range_id, category_id);


--
-- Name: offer_range_name_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_range
    ADD CONSTRAINT offer_range_name_key UNIQUE (name);


--
-- Name: offer_range_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_range
    ADD CONSTRAINT offer_range_pkey PRIMARY KEY (id);


--
-- Name: offer_range_proxy_class_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_range
    ADD CONSTRAINT offer_range_proxy_class_key UNIQUE (proxy_class);


--
-- Name: offer_range_slug_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_range
    ADD CONSTRAINT offer_range_slug_key UNIQUE (slug);


--
-- Name: offer_rangeproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_rangeproduct
    ADD CONSTRAINT offer_rangeproduct_pkey PRIMARY KEY (id);


--
-- Name: offer_rangeproduct_range_id_46b5d0c7baa19765_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_rangeproduct
    ADD CONSTRAINT offer_rangeproduct_range_id_46b5d0c7baa19765_uniq UNIQUE (range_id, product_id);


--
-- Name: offer_rangeproductfileupload_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY offer_rangeproductfileupload
    ADD CONSTRAINT offer_rangeproductfileupload_pkey PRIMARY KEY (id);


--
-- Name: order_billingaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_billingaddress
    ADD CONSTRAINT order_billingaddress_pkey PRIMARY KEY (id);


--
-- Name: order_communicationevent_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_communicationevent
    ADD CONSTRAINT order_communicationevent_pkey PRIMARY KEY (id);


--
-- Name: order_line_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_line
    ADD CONSTRAINT order_line_pkey PRIMARY KEY (id);


--
-- Name: order_lineattribute_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_lineattribute
    ADD CONSTRAINT order_lineattribute_pkey PRIMARY KEY (id);


--
-- Name: order_lineprice_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_lineprice
    ADD CONSTRAINT order_lineprice_pkey PRIMARY KEY (id);


--
-- Name: order_order_number_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_number_key UNIQUE (number);


--
-- Name: order_order_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_pkey PRIMARY KEY (id);


--
-- Name: order_orderdiscount_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_orderdiscount
    ADD CONSTRAINT order_orderdiscount_pkey PRIMARY KEY (id);


--
-- Name: order_ordernote_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_ordernote
    ADD CONSTRAINT order_ordernote_pkey PRIMARY KEY (id);


--
-- Name: order_paymentevent_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_paymentevent
    ADD CONSTRAINT order_paymentevent_pkey PRIMARY KEY (id);


--
-- Name: order_paymenteventquantity_event_id_5b7a84ed279fef4e_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_paymenteventquantity
    ADD CONSTRAINT order_paymenteventquantity_event_id_5b7a84ed279fef4e_uniq UNIQUE (event_id, line_id);


--
-- Name: order_paymenteventquantity_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_paymenteventquantity
    ADD CONSTRAINT order_paymenteventquantity_pkey PRIMARY KEY (id);


--
-- Name: order_paymenteventtype_code_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_paymenteventtype
    ADD CONSTRAINT order_paymenteventtype_code_key UNIQUE (code);


--
-- Name: order_paymenteventtype_name_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_paymenteventtype
    ADD CONSTRAINT order_paymenteventtype_name_key UNIQUE (name);


--
-- Name: order_paymenteventtype_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_paymenteventtype
    ADD CONSTRAINT order_paymenteventtype_pkey PRIMARY KEY (id);


--
-- Name: order_shippingaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_shippingaddress
    ADD CONSTRAINT order_shippingaddress_pkey PRIMARY KEY (id);


--
-- Name: order_shippingevent_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_shippingevent
    ADD CONSTRAINT order_shippingevent_pkey PRIMARY KEY (id);


--
-- Name: order_shippingeventquantity_event_id_3f3c8edd4ef56aea_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_shippingeventquantity
    ADD CONSTRAINT order_shippingeventquantity_event_id_3f3c8edd4ef56aea_uniq UNIQUE (event_id, line_id);


--
-- Name: order_shippingeventquantity_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_shippingeventquantity
    ADD CONSTRAINT order_shippingeventquantity_pkey PRIMARY KEY (id);


--
-- Name: order_shippingeventtype_code_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_shippingeventtype
    ADD CONSTRAINT order_shippingeventtype_code_key UNIQUE (code);


--
-- Name: order_shippingeventtype_name_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_shippingeventtype
    ADD CONSTRAINT order_shippingeventtype_name_key UNIQUE (name);


--
-- Name: order_shippingeventtype_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY order_shippingeventtype
    ADD CONSTRAINT order_shippingeventtype_pkey PRIMARY KEY (id);


--
-- Name: partner_partner_code_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY partner_partner
    ADD CONSTRAINT partner_partner_code_key UNIQUE (code);


--
-- Name: partner_partner_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY partner_partner
    ADD CONSTRAINT partner_partner_pkey PRIMARY KEY (id);


--
-- Name: partner_partner_users_partner_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY partner_partner_users
    ADD CONSTRAINT partner_partner_users_partner_id_user_id_key UNIQUE (partner_id, user_id);


--
-- Name: partner_partner_users_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY partner_partner_users
    ADD CONSTRAINT partner_partner_users_pkey PRIMARY KEY (id);


--
-- Name: partner_partneraddress_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY partner_partneraddress
    ADD CONSTRAINT partner_partneraddress_pkey PRIMARY KEY (id);


--
-- Name: partner_stockalert_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY partner_stockalert
    ADD CONSTRAINT partner_stockalert_pkey PRIMARY KEY (id);


--
-- Name: partner_stockrecord_partner_id_67f01eea9b25570_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY partner_stockrecord
    ADD CONSTRAINT partner_stockrecord_partner_id_67f01eea9b25570_uniq UNIQUE (partner_id, partner_sku);


--
-- Name: partner_stockrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY partner_stockrecord
    ADD CONSTRAINT partner_stockrecord_pkey PRIMARY KEY (id);


--
-- Name: payment_bankcard_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payment_bankcard
    ADD CONSTRAINT payment_bankcard_pkey PRIMARY KEY (id);


--
-- Name: payment_source_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payment_source
    ADD CONSTRAINT payment_source_pkey PRIMARY KEY (id);


--
-- Name: payment_sourcetype_code_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payment_sourcetype
    ADD CONSTRAINT payment_sourcetype_code_key UNIQUE (code);


--
-- Name: payment_sourcetype_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payment_sourcetype
    ADD CONSTRAINT payment_sourcetype_pkey PRIMARY KEY (id);


--
-- Name: payment_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payment_transaction
    ADD CONSTRAINT payment_transaction_pkey PRIMARY KEY (id);


--
-- Name: payments_charge_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_charge
    ADD CONSTRAINT payments_charge_pkey PRIMARY KEY (id);


--
-- Name: payments_charge_stripe_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_charge
    ADD CONSTRAINT payments_charge_stripe_id_key UNIQUE (stripe_id);


--
-- Name: payments_currentsubscription_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_currentsubscription
    ADD CONSTRAINT payments_currentsubscription_customer_id_key UNIQUE (customer_id);


--
-- Name: payments_currentsubscription_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_currentsubscription
    ADD CONSTRAINT payments_currentsubscription_pkey PRIMARY KEY (id);


--
-- Name: payments_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_customer
    ADD CONSTRAINT payments_customer_pkey PRIMARY KEY (id);


--
-- Name: payments_customer_stripe_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_customer
    ADD CONSTRAINT payments_customer_stripe_id_key UNIQUE (stripe_id);


--
-- Name: payments_customer_user_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_customer
    ADD CONSTRAINT payments_customer_user_id_key UNIQUE (user_id);


--
-- Name: payments_event_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_event
    ADD CONSTRAINT payments_event_pkey PRIMARY KEY (id);


--
-- Name: payments_event_stripe_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_event
    ADD CONSTRAINT payments_event_stripe_id_key UNIQUE (stripe_id);


--
-- Name: payments_eventprocessingexception_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_eventprocessingexception
    ADD CONSTRAINT payments_eventprocessingexception_pkey PRIMARY KEY (id);


--
-- Name: payments_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_invoice
    ADD CONSTRAINT payments_invoice_pkey PRIMARY KEY (id);


--
-- Name: payments_invoiceitem_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_invoiceitem
    ADD CONSTRAINT payments_invoiceitem_pkey PRIMARY KEY (id);


--
-- Name: payments_transfer_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_transfer
    ADD CONSTRAINT payments_transfer_pkey PRIMARY KEY (id);


--
-- Name: payments_transfer_stripe_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_transfer
    ADD CONSTRAINT payments_transfer_stripe_id_key UNIQUE (stripe_id);


--
-- Name: payments_transferchargefee_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY payments_transferchargefee
    ADD CONSTRAINT payments_transferchargefee_pkey PRIMARY KEY (id);


--
-- Name: paypal_expresstransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY paypal_expresstransaction
    ADD CONSTRAINT paypal_expresstransaction_pkey PRIMARY KEY (id);


--
-- Name: paypal_payflowtransaction_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY paypal_payflowtransaction
    ADD CONSTRAINT paypal_payflowtransaction_pkey PRIMARY KEY (id);


--
-- Name: paypal_payflowtransaction_ppref_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY paypal_payflowtransaction
    ADD CONSTRAINT paypal_payflowtransaction_ppref_key UNIQUE (ppref);


--
-- Name: promotions_automaticproductlist_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_automaticproductlist
    ADD CONSTRAINT promotions_automaticproductlist_pkey PRIMARY KEY (id);


--
-- Name: promotions_handpickedproductlist_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_handpickedproductlist
    ADD CONSTRAINT promotions_handpickedproductlist_pkey PRIMARY KEY (id);


--
-- Name: promotions_image_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_image
    ADD CONSTRAINT promotions_image_pkey PRIMARY KEY (id);


--
-- Name: promotions_keywordpromotion_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_keywordpromotion
    ADD CONSTRAINT promotions_keywordpromotion_pkey PRIMARY KEY (id);


--
-- Name: promotions_multiimage_images_multiimage_id_image_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_multiimage_images
    ADD CONSTRAINT promotions_multiimage_images_multiimage_id_image_id_key UNIQUE (multiimage_id, image_id);


--
-- Name: promotions_multiimage_images_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_multiimage_images
    ADD CONSTRAINT promotions_multiimage_images_pkey PRIMARY KEY (id);


--
-- Name: promotions_multiimage_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_multiimage
    ADD CONSTRAINT promotions_multiimage_pkey PRIMARY KEY (id);


--
-- Name: promotions_orderedproduct_list_id_1366b111f6aa8997_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_orderedproduct
    ADD CONSTRAINT promotions_orderedproduct_list_id_1366b111f6aa8997_uniq UNIQUE (list_id, product_id);


--
-- Name: promotions_orderedproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_orderedproduct
    ADD CONSTRAINT promotions_orderedproduct_pkey PRIMARY KEY (id);


--
-- Name: promotions_orderedproductlist_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_orderedproductlist
    ADD CONSTRAINT promotions_orderedproductlist_pkey PRIMARY KEY (handpickedproductlist_ptr_id);


--
-- Name: promotions_pagepromotion_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_pagepromotion
    ADD CONSTRAINT promotions_pagepromotion_pkey PRIMARY KEY (id);


--
-- Name: promotions_rawhtml_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_rawhtml
    ADD CONSTRAINT promotions_rawhtml_pkey PRIMARY KEY (id);


--
-- Name: promotions_singleproduct_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_singleproduct
    ADD CONSTRAINT promotions_singleproduct_pkey PRIMARY KEY (id);


--
-- Name: promotions_tabbedblock_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY promotions_tabbedblock
    ADD CONSTRAINT promotions_tabbedblock_pkey PRIMARY KEY (id);


--
-- Name: reviews_productreview_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY reviews_productreview
    ADD CONSTRAINT reviews_productreview_pkey PRIMARY KEY (id);


--
-- Name: reviews_productreview_product_id_360cffc32e922f92_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY reviews_productreview
    ADD CONSTRAINT reviews_productreview_product_id_360cffc32e922f92_uniq UNIQUE (product_id, user_id);


--
-- Name: reviews_vote_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY reviews_vote
    ADD CONSTRAINT reviews_vote_pkey PRIMARY KEY (id);


--
-- Name: reviews_vote_user_id_5e14992d9ef3e7b6_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY reviews_vote
    ADD CONSTRAINT reviews_vote_user_id_5e14992d9ef3e7b6_uniq UNIQUE (user_id, review_id);


--
-- Name: shipping_orderanditemcharges__orderanditemcharges_id_countr_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY shipping_orderanditemcharges_countries
    ADD CONSTRAINT shipping_orderanditemcharges__orderanditemcharges_id_countr_key UNIQUE (orderanditemcharges_id, country_id);


--
-- Name: shipping_orderanditemcharges_code_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY shipping_orderanditemcharges
    ADD CONSTRAINT shipping_orderanditemcharges_code_key UNIQUE (code);


--
-- Name: shipping_orderanditemcharges_countries_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY shipping_orderanditemcharges_countries
    ADD CONSTRAINT shipping_orderanditemcharges_countries_pkey PRIMARY KEY (id);


--
-- Name: shipping_orderanditemcharges_name_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY shipping_orderanditemcharges
    ADD CONSTRAINT shipping_orderanditemcharges_name_key UNIQUE (name);


--
-- Name: shipping_orderanditemcharges_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY shipping_orderanditemcharges
    ADD CONSTRAINT shipping_orderanditemcharges_pkey PRIMARY KEY (id);


--
-- Name: shipping_weightband_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY shipping_weightband
    ADD CONSTRAINT shipping_weightband_pkey PRIMARY KEY (id);


--
-- Name: shipping_weightbased_code_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY shipping_weightbased
    ADD CONSTRAINT shipping_weightbased_code_key UNIQUE (code);


--
-- Name: shipping_weightbased_countries_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY shipping_weightbased_countries
    ADD CONSTRAINT shipping_weightbased_countries_pkey PRIMARY KEY (id);


--
-- Name: shipping_weightbased_countries_weightbased_id_country_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY shipping_weightbased_countries
    ADD CONSTRAINT shipping_weightbased_countries_weightbased_id_country_id_key UNIQUE (weightbased_id, country_id);


--
-- Name: shipping_weightbased_name_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY shipping_weightbased
    ADD CONSTRAINT shipping_weightbased_name_key UNIQUE (name);


--
-- Name: shipping_weightbased_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY shipping_weightbased
    ADD CONSTRAINT shipping_weightbased_pkey PRIMARY KEY (id);


--
-- Name: taggit_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY taggit_tag
    ADD CONSTRAINT taggit_tag_name_key UNIQUE (name);


--
-- Name: taggit_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY taggit_tag
    ADD CONSTRAINT taggit_tag_pkey PRIMARY KEY (id);


--
-- Name: taggit_tag_slug_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY taggit_tag
    ADD CONSTRAINT taggit_tag_slug_key UNIQUE (slug);


--
-- Name: taggit_taggeditem_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_pkey PRIMARY KEY (id);


--
-- Name: thumbnail_kvstore_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY thumbnail_kvstore
    ADD CONSTRAINT thumbnail_kvstore_pkey PRIMARY KEY (key);


--
-- Name: voucher_voucher_code_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY voucher_voucher
    ADD CONSTRAINT voucher_voucher_code_key UNIQUE (code);


--
-- Name: voucher_voucher_offers_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY voucher_voucher_offers
    ADD CONSTRAINT voucher_voucher_offers_pkey PRIMARY KEY (id);


--
-- Name: voucher_voucher_offers_voucher_id_conditionaloffer_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY voucher_voucher_offers
    ADD CONSTRAINT voucher_voucher_offers_voucher_id_conditionaloffer_id_key UNIQUE (voucher_id, conditionaloffer_id);


--
-- Name: voucher_voucher_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY voucher_voucher
    ADD CONSTRAINT voucher_voucher_pkey PRIMARY KEY (id);


--
-- Name: voucher_voucherapplication_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY voucher_voucherapplication
    ADD CONSTRAINT voucher_voucherapplication_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_grouppagepermission_group_id_16dce7822bba8126_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppagepermission_group_id_16dce7822bba8126_uniq UNIQUE (group_id, page_id, permission_type);


--
-- Name: wagtailcore_grouppagepermission_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppagepermission_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_page_path_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_path_key UNIQUE (path);


--
-- Name: wagtailcore_page_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pagerevision_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailcore_pagerevision
    ADD CONSTRAINT wagtailcore_pagerevision_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_pageviewrestriction_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailcore_pageviewrestriction
    ADD CONSTRAINT wagtailcore_pageviewrestriction_pkey PRIMARY KEY (id);


--
-- Name: wagtailcore_site_hostname_320427da5b875ea4_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailcore_site
    ADD CONSTRAINT wagtailcore_site_hostname_320427da5b875ea4_uniq UNIQUE (hostname, port);


--
-- Name: wagtailcore_site_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailcore_site
    ADD CONSTRAINT wagtailcore_site_pkey PRIMARY KEY (id);


--
-- Name: wagtaildocs_document_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtaildocs_document
    ADD CONSTRAINT wagtaildocs_document_pkey PRIMARY KEY (id);


--
-- Name: wagtailembeds_embed_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailembeds_embed
    ADD CONSTRAINT wagtailembeds_embed_pkey PRIMARY KEY (id);


--
-- Name: wagtailembeds_embed_url_5dd68afc152fa96f_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailembeds_embed
    ADD CONSTRAINT wagtailembeds_embed_url_5dd68afc152fa96f_uniq UNIQUE (url, max_width);


--
-- Name: wagtailforms_formsubmission_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailforms_formsubmission
    ADD CONSTRAINT wagtailforms_formsubmission_pkey PRIMARY KEY (id);


--
-- Name: wagtailimages_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailimages_filter
    ADD CONSTRAINT wagtailimages_filter_pkey PRIMARY KEY (id);


--
-- Name: wagtailimages_filter_spec_50a6f8f1f8ec3c10_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailimages_filter
    ADD CONSTRAINT wagtailimages_filter_spec_50a6f8f1f8ec3c10_uniq UNIQUE (spec);


--
-- Name: wagtailimages_image_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailimages_image
    ADD CONSTRAINT wagtailimages_image_pkey PRIMARY KEY (id);


--
-- Name: wagtailimages_rendition_image_id_79613956ee642381_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailimages_rendition
    ADD CONSTRAINT wagtailimages_rendition_image_id_79613956ee642381_uniq UNIQUE (image_id, filter_id, focal_point_key);


--
-- Name: wagtailimages_rendition_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailimages_rendition
    ADD CONSTRAINT wagtailimages_rendition_pkey PRIMARY KEY (id);


--
-- Name: wagtailredirects_redirect_old_path_3b42ca8be002e5de_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_redirect_old_path_3b42ca8be002e5de_uniq UNIQUE (old_path, site_id);


--
-- Name: wagtailredirects_redirect_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirects_redirect_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_editorspick_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailsearch_editorspick
    ADD CONSTRAINT wagtailsearch_editorspick_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_query_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailsearch_query
    ADD CONSTRAINT wagtailsearch_query_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_query_query_string_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailsearch_query
    ADD CONSTRAINT wagtailsearch_query_query_string_key UNIQUE (query_string);


--
-- Name: wagtailsearch_querydailyhits_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailsearch_querydailyhits
    ADD CONSTRAINT wagtailsearch_querydailyhits_pkey PRIMARY KEY (id);


--
-- Name: wagtailsearch_querydailyhits_query_id_50188608bc1cce25_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailsearch_querydailyhits
    ADD CONSTRAINT wagtailsearch_querydailyhits_query_id_50188608bc1cce25_uniq UNIQUE (query_id, date);


--
-- Name: wagtailusers_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailusers_userprofile
    ADD CONSTRAINT wagtailusers_userprofile_pkey PRIMARY KEY (id);


--
-- Name: wagtailusers_userprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wagtailusers_userprofile
    ADD CONSTRAINT wagtailusers_userprofile_user_id_key UNIQUE (user_id);


--
-- Name: wishlists_line_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wishlists_line
    ADD CONSTRAINT wishlists_line_pkey PRIMARY KEY (id);


--
-- Name: wishlists_line_wishlist_id_51a0c623cc99f81d_uniq; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wishlists_line
    ADD CONSTRAINT wishlists_line_wishlist_id_51a0c623cc99f81d_uniq UNIQUE (wishlist_id, product_id);


--
-- Name: wishlists_wishlist_key_key; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wishlists_wishlist
    ADD CONSTRAINT wishlists_wishlist_key_key UNIQUE (key);


--
-- Name: wishlists_wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: taedori; Tablespace: 
--

ALTER TABLE ONLY wishlists_wishlist
    ADD CONSTRAINT wishlists_wishlist_pkey PRIMARY KEY (id);


--
-- Name: address_country_010c8bce; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX address_country_010c8bce ON address_country USING btree (display_order);


--
-- Name: address_country_0b3676f8; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX address_country_0b3676f8 ON address_country USING btree (is_shipping_country);


--
-- Name: address_country_iso_3166_1_a2_6fcfa1b0cd9f4dba_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX address_country_iso_3166_1_a2_6fcfa1b0cd9f4dba_like ON address_country USING btree (iso_3166_1_a2 varchar_pattern_ops);


--
-- Name: address_useraddress_0800fc57; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX address_useraddress_0800fc57 ON address_useraddress USING btree (hash);


--
-- Name: address_useraddress_93bfec8a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX address_useraddress_93bfec8a ON address_useraddress USING btree (country_id);


--
-- Name: address_useraddress_country_id_4355f10dabea58a1_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX address_useraddress_country_id_4355f10dabea58a1_like ON address_useraddress USING btree (country_id varchar_pattern_ops);


--
-- Name: address_useraddress_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX address_useraddress_e8701ad4 ON address_useraddress USING btree (user_id);


--
-- Name: address_useraddress_hash_5375af36428a66bb_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX address_useraddress_hash_5375af36428a66bb_like ON address_useraddress USING btree (hash varchar_pattern_ops);


--
-- Name: analytics_productrecord_81a5c7b1; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX analytics_productrecord_81a5c7b1 ON analytics_productrecord USING btree (num_purchases);


--
-- Name: analytics_userproductview_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX analytics_userproductview_9bea82de ON analytics_userproductview USING btree (product_id);


--
-- Name: analytics_userproductview_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX analytics_userproductview_e8701ad4 ON analytics_userproductview USING btree (user_id);


--
-- Name: analytics_userrecord_25cd4b4a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX analytics_userrecord_25cd4b4a ON analytics_userrecord USING btree (num_order_items);


--
-- Name: analytics_userrecord_29bdb5ea; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX analytics_userrecord_29bdb5ea ON analytics_userrecord USING btree (num_orders);


--
-- Name: analytics_userrecord_89bb6879; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX analytics_userrecord_89bb6879 ON analytics_userrecord USING btree (num_order_lines);


--
-- Name: analytics_usersearch_1b1cc7f0; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX analytics_usersearch_1b1cc7f0 ON analytics_usersearch USING btree (query);


--
-- Name: analytics_usersearch_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX analytics_usersearch_e8701ad4 ON analytics_usersearch USING btree (user_id);


--
-- Name: analytics_usersearch_query_18703f8a372a0c2c_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX analytics_usersearch_query_18703f8a372a0c2c_like ON analytics_usersearch USING btree (query varchar_pattern_ops);


--
-- Name: auth_group_name_640c59b637284a1_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX auth_group_name_640c59b637284a1_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_430bc33a550f03b9_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX auth_user_username_430bc33a550f03b9_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: basket_basket_5e7b1936; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX basket_basket_5e7b1936 ON basket_basket USING btree (owner_id);


--
-- Name: basket_basket_vouchers_3e8639ee; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX basket_basket_vouchers_3e8639ee ON basket_basket_vouchers USING btree (voucher_id);


--
-- Name: basket_basket_vouchers_afdeaea9; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX basket_basket_vouchers_afdeaea9 ON basket_basket_vouchers USING btree (basket_id);


--
-- Name: basket_line_271c5733; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX basket_line_271c5733 ON basket_line USING btree (stockrecord_id);


--
-- Name: basket_line_767217f5; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX basket_line_767217f5 ON basket_line USING btree (line_reference);


--
-- Name: basket_line_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX basket_line_9bea82de ON basket_line USING btree (product_id);


--
-- Name: basket_line_afdeaea9; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX basket_line_afdeaea9 ON basket_line USING btree (basket_id);


--
-- Name: basket_line_line_reference_fc1912f36283aa5_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX basket_line_line_reference_fc1912f36283aa5_like ON basket_line USING btree (line_reference varchar_pattern_ops);


--
-- Name: basket_lineattribute_28df3725; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX basket_lineattribute_28df3725 ON basket_lineattribute USING btree (option_id);


--
-- Name: basket_lineattribute_b3ae486a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX basket_lineattribute_b3ae486a ON basket_lineattribute USING btree (line_id);


--
-- Name: catalogue_attributeoption_0e939a4f; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_attributeoption_0e939a4f ON catalogue_attributeoption USING btree (group_id);


--
-- Name: catalogue_category_2dbcba41; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_category_2dbcba41 ON catalogue_category USING btree (slug);


--
-- Name: catalogue_category_b068931c; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_category_b068931c ON catalogue_category USING btree (name);


--
-- Name: catalogue_category_name_792b8359f8564fd8_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_category_name_792b8359f8564fd8_like ON catalogue_category USING btree (name varchar_pattern_ops);


--
-- Name: catalogue_category_path_72fff6fc3e912ab9_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_category_path_72fff6fc3e912ab9_like ON catalogue_category USING btree (path varchar_pattern_ops);


--
-- Name: catalogue_category_slug_410aae84b135f7f3_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_category_slug_410aae84b135f7f3_like ON catalogue_category USING btree (slug varchar_pattern_ops);


--
-- Name: catalogue_option_code_7b4d3996876d497_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_option_code_7b4d3996876d497_like ON catalogue_option USING btree (code varchar_pattern_ops);


--
-- Name: catalogue_product_2dbcba41; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_product_2dbcba41 ON catalogue_product USING btree (slug);


--
-- Name: catalogue_product_6be37982; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_product_6be37982 ON catalogue_product USING btree (parent_id);


--
-- Name: catalogue_product_9474e4b5; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_product_9474e4b5 ON catalogue_product USING btree (date_updated);


--
-- Name: catalogue_product_c6619e6f; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_product_c6619e6f ON catalogue_product USING btree (product_class_id);


--
-- Name: catalogue_product_product_options_28df3725; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_product_product_options_28df3725 ON catalogue_product_product_options USING btree (option_id);


--
-- Name: catalogue_product_product_options_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_product_product_options_9bea82de ON catalogue_product_product_options USING btree (product_id);


--
-- Name: catalogue_product_slug_6c902bf87c346163_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_product_slug_6c902bf87c346163_like ON catalogue_product USING btree (slug varchar_pattern_ops);


--
-- Name: catalogue_product_upc_371c95e09d4e78ea_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_product_upc_371c95e09d4e78ea_like ON catalogue_product USING btree (upc varchar_pattern_ops);


--
-- Name: catalogue_productattribute_2f493fea; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productattribute_2f493fea ON catalogue_productattribute USING btree (option_group_id);


--
-- Name: catalogue_productattribute_c1336794; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productattribute_c1336794 ON catalogue_productattribute USING btree (code);


--
-- Name: catalogue_productattribute_c6619e6f; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productattribute_c6619e6f ON catalogue_productattribute USING btree (product_class_id);


--
-- Name: catalogue_productattribute_code_4f74054d231c0773_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productattribute_code_4f74054d231c0773_like ON catalogue_productattribute USING btree (code varchar_pattern_ops);


--
-- Name: catalogue_productattributevalue_314d12bc; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productattributevalue_314d12bc ON catalogue_productattributevalue USING btree (value_option_id);


--
-- Name: catalogue_productattributevalue_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productattributevalue_9bea82de ON catalogue_productattributevalue USING btree (product_id);


--
-- Name: catalogue_productattributevalue_e582ed73; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productattributevalue_e582ed73 ON catalogue_productattributevalue USING btree (attribute_id);


--
-- Name: catalogue_productattributevalue_ed18ba79; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productattributevalue_ed18ba79 ON catalogue_productattributevalue USING btree (entity_content_type_id);


--
-- Name: catalogue_productcategory_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productcategory_9bea82de ON catalogue_productcategory USING btree (product_id);


--
-- Name: catalogue_productcategory_b583a629; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productcategory_b583a629 ON catalogue_productcategory USING btree (category_id);


--
-- Name: catalogue_productclass_options_28df3725; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productclass_options_28df3725 ON catalogue_productclass_options USING btree (option_id);


--
-- Name: catalogue_productclass_options_ebf7b0c6; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productclass_options_ebf7b0c6 ON catalogue_productclass_options USING btree (productclass_id);


--
-- Name: catalogue_productclass_slug_25934e14f1c08a08_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productclass_slug_25934e14f1c08a08_like ON catalogue_productclass USING btree (slug varchar_pattern_ops);


--
-- Name: catalogue_productimage_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productimage_9bea82de ON catalogue_productimage USING btree (product_id);


--
-- Name: catalogue_productrecommendation_095f2624; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productrecommendation_095f2624 ON catalogue_productrecommendation USING btree (primary_id);


--
-- Name: catalogue_productrecommendation_c65d5c4d; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX catalogue_productrecommendation_c65d5c4d ON catalogue_productrecommendation USING btree (recommendation_id);


--
-- Name: customer_communicationeventtype_code_32eab2799040f323_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX customer_communicationeventtype_code_32eab2799040f323_like ON customer_communicationeventtype USING btree (code varchar_pattern_ops);


--
-- Name: customer_email_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX customer_email_e8701ad4 ON customer_email USING btree (user_id);


--
-- Name: customer_notification_8b938c66; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX customer_notification_8b938c66 ON customer_notification USING btree (recipient_id);


--
-- Name: customer_notification_924b1846; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX customer_notification_924b1846 ON customer_notification USING btree (sender_id);


--
-- Name: customer_productalert_0c83f57c; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX customer_productalert_0c83f57c ON customer_productalert USING btree (email);


--
-- Name: customer_productalert_3c6e0b8a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX customer_productalert_3c6e0b8a ON customer_productalert USING btree (key);


--
-- Name: customer_productalert_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX customer_productalert_9bea82de ON customer_productalert USING btree (product_id);


--
-- Name: customer_productalert_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX customer_productalert_e8701ad4 ON customer_productalert USING btree (user_id);


--
-- Name: customer_productalert_email_766c9cb38830dfda_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX customer_productalert_email_766c9cb38830dfda_like ON customer_productalert USING btree (email varchar_pattern_ops);


--
-- Name: customer_productalert_key_54fb8aba411c2eaa_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX customer_productalert_key_54fb8aba411c2eaa_like ON customer_productalert USING btree (key varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_flatpage_572d4e42; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX django_flatpage_572d4e42 ON django_flatpage USING btree (url);


--
-- Name: django_flatpage_sites_9365d6e7; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX django_flatpage_sites_9365d6e7 ON django_flatpage_sites USING btree (site_id);


--
-- Name: django_flatpage_sites_c3368d3a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX django_flatpage_sites_c3368d3a ON django_flatpage_sites USING btree (flatpage_id);


--
-- Name: django_flatpage_url_10ccb4bba4692836_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX django_flatpage_url_10ccb4bba4692836_like ON django_flatpage USING btree (url varchar_pattern_ops);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_75ff2da29e264575_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX django_session_session_key_75ff2da29e264575_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: offer_benefit_ee6537b7; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_benefit_ee6537b7 ON offer_benefit USING btree (range_id);


--
-- Name: offer_benefit_proxy_class_3324400414f3fb0a_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_benefit_proxy_class_3324400414f3fb0a_like ON offer_benefit USING btree (proxy_class varchar_pattern_ops);


--
-- Name: offer_condition_ee6537b7; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_condition_ee6537b7 ON offer_condition USING btree (range_id);


--
-- Name: offer_condition_proxy_class_3ed8b8842ced3ec6_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_condition_proxy_class_3ed8b8842ced3ec6_like ON offer_condition USING btree (proxy_class varchar_pattern_ops);


--
-- Name: offer_conditionaloffer_326fa416; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_conditionaloffer_326fa416 ON offer_conditionaloffer USING btree (benefit_id);


--
-- Name: offer_conditionaloffer_bb531585; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_conditionaloffer_bb531585 ON offer_conditionaloffer USING btree (condition_id);


--
-- Name: offer_conditionaloffer_name_5f9d71fd64c2a95d_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_conditionaloffer_name_5f9d71fd64c2a95d_like ON offer_conditionaloffer USING btree (name varchar_pattern_ops);


--
-- Name: offer_conditionaloffer_slug_e52ede682e1720e_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_conditionaloffer_slug_e52ede682e1720e_like ON offer_conditionaloffer USING btree (slug varchar_pattern_ops);


--
-- Name: offer_range_classes_ebf7b0c6; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_range_classes_ebf7b0c6 ON offer_range_classes USING btree (productclass_id);


--
-- Name: offer_range_classes_ee6537b7; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_range_classes_ee6537b7 ON offer_range_classes USING btree (range_id);


--
-- Name: offer_range_excluded_products_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_range_excluded_products_9bea82de ON offer_range_excluded_products USING btree (product_id);


--
-- Name: offer_range_excluded_products_ee6537b7; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_range_excluded_products_ee6537b7 ON offer_range_excluded_products USING btree (range_id);


--
-- Name: offer_range_included_categories_b583a629; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_range_included_categories_b583a629 ON offer_range_included_categories USING btree (category_id);


--
-- Name: offer_range_included_categories_ee6537b7; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_range_included_categories_ee6537b7 ON offer_range_included_categories USING btree (range_id);


--
-- Name: offer_range_name_6db2c9439b051650_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_range_name_6db2c9439b051650_like ON offer_range USING btree (name varchar_pattern_ops);


--
-- Name: offer_range_proxy_class_7c6d614350bc13b2_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_range_proxy_class_7c6d614350bc13b2_like ON offer_range USING btree (proxy_class varchar_pattern_ops);


--
-- Name: offer_range_slug_3c682cf098e88ae5_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_range_slug_3c682cf098e88ae5_like ON offer_range USING btree (slug varchar_pattern_ops);


--
-- Name: offer_rangeproduct_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_rangeproduct_9bea82de ON offer_rangeproduct USING btree (product_id);


--
-- Name: offer_rangeproduct_ee6537b7; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_rangeproduct_ee6537b7 ON offer_rangeproduct USING btree (range_id);


--
-- Name: offer_rangeproductfileupload_4095e96b; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_rangeproductfileupload_4095e96b ON offer_rangeproductfileupload USING btree (uploaded_by_id);


--
-- Name: offer_rangeproductfileupload_ee6537b7; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX offer_rangeproductfileupload_ee6537b7 ON offer_rangeproductfileupload USING btree (range_id);


--
-- Name: order_billingaddress_93bfec8a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_billingaddress_93bfec8a ON order_billingaddress USING btree (country_id);


--
-- Name: order_billingaddress_country_id_360dcdbd68dcbb0e_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_billingaddress_country_id_360dcdbd68dcbb0e_like ON order_billingaddress USING btree (country_id varchar_pattern_ops);


--
-- Name: order_communicationevent_5e891baf; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_communicationevent_5e891baf ON order_communicationevent USING btree (event_type_id);


--
-- Name: order_communicationevent_69dfcb07; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_communicationevent_69dfcb07 ON order_communicationevent USING btree (order_id);


--
-- Name: order_line_271c5733; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_line_271c5733 ON order_line USING btree (stockrecord_id);


--
-- Name: order_line_4e98b6eb; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_line_4e98b6eb ON order_line USING btree (partner_id);


--
-- Name: order_line_69dfcb07; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_line_69dfcb07 ON order_line USING btree (order_id);


--
-- Name: order_line_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_line_9bea82de ON order_line USING btree (product_id);


--
-- Name: order_lineattribute_28df3725; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_lineattribute_28df3725 ON order_lineattribute USING btree (option_id);


--
-- Name: order_lineattribute_b3ae486a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_lineattribute_b3ae486a ON order_lineattribute USING btree (line_id);


--
-- Name: order_lineprice_69dfcb07; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_lineprice_69dfcb07 ON order_lineprice USING btree (order_id);


--
-- Name: order_lineprice_b3ae486a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_lineprice_b3ae486a ON order_lineprice USING btree (line_id);


--
-- Name: order_order_8fb9ffec; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_order_8fb9ffec ON order_order USING btree (shipping_address_id);


--
-- Name: order_order_90e84921; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_order_90e84921 ON order_order USING btree (date_placed);


--
-- Name: order_order_9365d6e7; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_order_9365d6e7 ON order_order USING btree (site_id);


--
-- Name: order_order_afdeaea9; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_order_afdeaea9 ON order_order USING btree (basket_id);


--
-- Name: order_order_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_order_e8701ad4 ON order_order USING btree (user_id);


--
-- Name: order_order_e9192ced; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_order_e9192ced ON order_order USING btree (billing_address_id);


--
-- Name: order_order_number_409dc89cf541cccf_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_order_number_409dc89cf541cccf_like ON order_order USING btree (number varchar_pattern_ops);


--
-- Name: order_orderdiscount_08e4f7cd; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_orderdiscount_08e4f7cd ON order_orderdiscount USING btree (voucher_code);


--
-- Name: order_orderdiscount_69dfcb07; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_orderdiscount_69dfcb07 ON order_orderdiscount USING btree (order_id);


--
-- Name: order_orderdiscount_9eeed246; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_orderdiscount_9eeed246 ON order_orderdiscount USING btree (offer_name);


--
-- Name: order_orderdiscount_offer_name_319d1a3c00c7fc56_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_orderdiscount_offer_name_319d1a3c00c7fc56_like ON order_orderdiscount USING btree (offer_name varchar_pattern_ops);


--
-- Name: order_orderdiscount_voucher_code_7f3d974522782061_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_orderdiscount_voucher_code_7f3d974522782061_like ON order_orderdiscount USING btree (voucher_code varchar_pattern_ops);


--
-- Name: order_ordernote_69dfcb07; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_ordernote_69dfcb07 ON order_ordernote USING btree (order_id);


--
-- Name: order_ordernote_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_ordernote_e8701ad4 ON order_ordernote USING btree (user_id);


--
-- Name: order_paymentevent_5e891baf; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_paymentevent_5e891baf ON order_paymentevent USING btree (event_type_id);


--
-- Name: order_paymentevent_69dfcb07; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_paymentevent_69dfcb07 ON order_paymentevent USING btree (order_id);


--
-- Name: order_paymentevent_78cafb71; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_paymentevent_78cafb71 ON order_paymentevent USING btree (shipping_event_id);


--
-- Name: order_paymenteventquantity_4437cfac; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_paymenteventquantity_4437cfac ON order_paymenteventquantity USING btree (event_id);


--
-- Name: order_paymenteventquantity_b3ae486a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_paymenteventquantity_b3ae486a ON order_paymenteventquantity USING btree (line_id);


--
-- Name: order_paymenteventtype_code_637528d65ea895d2_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_paymenteventtype_code_637528d65ea895d2_like ON order_paymenteventtype USING btree (code varchar_pattern_ops);


--
-- Name: order_paymenteventtype_name_4fb0b6699a034873_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_paymenteventtype_name_4fb0b6699a034873_like ON order_paymenteventtype USING btree (name varchar_pattern_ops);


--
-- Name: order_shippingaddress_93bfec8a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_shippingaddress_93bfec8a ON order_shippingaddress USING btree (country_id);


--
-- Name: order_shippingaddress_country_id_229f6b8680303aea_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_shippingaddress_country_id_229f6b8680303aea_like ON order_shippingaddress USING btree (country_id varchar_pattern_ops);


--
-- Name: order_shippingevent_5e891baf; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_shippingevent_5e891baf ON order_shippingevent USING btree (event_type_id);


--
-- Name: order_shippingevent_69dfcb07; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_shippingevent_69dfcb07 ON order_shippingevent USING btree (order_id);


--
-- Name: order_shippingeventquantity_4437cfac; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_shippingeventquantity_4437cfac ON order_shippingeventquantity USING btree (event_id);


--
-- Name: order_shippingeventquantity_b3ae486a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_shippingeventquantity_b3ae486a ON order_shippingeventquantity USING btree (line_id);


--
-- Name: order_shippingeventtype_code_46b0304ead4fd08_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_shippingeventtype_code_46b0304ead4fd08_like ON order_shippingeventtype USING btree (code varchar_pattern_ops);


--
-- Name: order_shippingeventtype_name_1cc8d9ebda3afc1d_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX order_shippingeventtype_name_1cc8d9ebda3afc1d_like ON order_shippingeventtype USING btree (name varchar_pattern_ops);


--
-- Name: partner_partner_code_7a9bd76000087098_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX partner_partner_code_7a9bd76000087098_like ON partner_partner USING btree (code varchar_pattern_ops);


--
-- Name: partner_partner_users_4e98b6eb; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX partner_partner_users_4e98b6eb ON partner_partner_users USING btree (partner_id);


--
-- Name: partner_partner_users_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX partner_partner_users_e8701ad4 ON partner_partner_users USING btree (user_id);


--
-- Name: partner_partneraddress_4e98b6eb; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX partner_partneraddress_4e98b6eb ON partner_partneraddress USING btree (partner_id);


--
-- Name: partner_partneraddress_93bfec8a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX partner_partneraddress_93bfec8a ON partner_partneraddress USING btree (country_id);


--
-- Name: partner_partneraddress_country_id_73028540ebf842ce_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX partner_partneraddress_country_id_73028540ebf842ce_like ON partner_partneraddress USING btree (country_id varchar_pattern_ops);


--
-- Name: partner_stockalert_271c5733; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX partner_stockalert_271c5733 ON partner_stockalert USING btree (stockrecord_id);


--
-- Name: partner_stockrecord_4e98b6eb; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX partner_stockrecord_4e98b6eb ON partner_stockrecord USING btree (partner_id);


--
-- Name: partner_stockrecord_9474e4b5; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX partner_stockrecord_9474e4b5 ON partner_stockrecord USING btree (date_updated);


--
-- Name: partner_stockrecord_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX partner_stockrecord_9bea82de ON partner_stockrecord USING btree (product_id);


--
-- Name: payment_bankcard_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payment_bankcard_e8701ad4 ON payment_bankcard USING btree (user_id);


--
-- Name: payment_source_69dfcb07; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payment_source_69dfcb07 ON payment_source USING btree (order_id);


--
-- Name: payment_source_ed5cb66b; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payment_source_ed5cb66b ON payment_source USING btree (source_type_id);


--
-- Name: payment_sourcetype_code_7e738d40cd6c761b_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payment_sourcetype_code_7e738d40cd6c761b_like ON payment_sourcetype USING btree (code varchar_pattern_ops);


--
-- Name: payment_transaction_0afd9202; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payment_transaction_0afd9202 ON payment_transaction USING btree (source_id);


--
-- Name: payments_charge_cb24373b; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_charge_cb24373b ON payments_charge USING btree (customer_id);


--
-- Name: payments_charge_f1f5d967; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_charge_f1f5d967 ON payments_charge USING btree (invoice_id);


--
-- Name: payments_charge_stripe_id_311d353314a82cd2_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_charge_stripe_id_311d353314a82cd2_like ON payments_charge USING btree (stripe_id varchar_pattern_ops);


--
-- Name: payments_customer_stripe_id_7dfeadd6750832fd_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_customer_stripe_id_7dfeadd6750832fd_like ON payments_customer USING btree (stripe_id varchar_pattern_ops);


--
-- Name: payments_event_cb24373b; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_event_cb24373b ON payments_event USING btree (customer_id);


--
-- Name: payments_event_stripe_id_5ee18b5ee13bb6be_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_event_stripe_id_5ee18b5ee13bb6be_like ON payments_event USING btree (stripe_id varchar_pattern_ops);


--
-- Name: payments_eventprocessingexception_4437cfac; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_eventprocessingexception_4437cfac ON payments_eventprocessingexception USING btree (event_id);


--
-- Name: payments_invoice_cb24373b; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_invoice_cb24373b ON payments_invoice USING btree (customer_id);


--
-- Name: payments_invoiceitem_f1f5d967; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_invoiceitem_f1f5d967 ON payments_invoiceitem USING btree (invoice_id);


--
-- Name: payments_transfer_4437cfac; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_transfer_4437cfac ON payments_transfer USING btree (event_id);


--
-- Name: payments_transfer_stripe_id_1a9a8191cbc6ba2b_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_transfer_stripe_id_1a9a8191cbc6ba2b_like ON payments_transfer USING btree (stripe_id varchar_pattern_ops);


--
-- Name: payments_transferchargefee_684f267f; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX payments_transferchargefee_684f267f ON payments_transferchargefee USING btree (transfer_id);


--
-- Name: paypal_payflowtransaction_4e83d0f4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX paypal_payflowtransaction_4e83d0f4 ON paypal_payflowtransaction USING btree (comment1);


--
-- Name: paypal_payflowtransaction_comment1_3ffb65f8444aa6a0_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX paypal_payflowtransaction_comment1_3ffb65f8444aa6a0_like ON paypal_payflowtransaction USING btree (comment1 varchar_pattern_ops);


--
-- Name: paypal_payflowtransaction_ppref_504108bba7da3935_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX paypal_payflowtransaction_ppref_504108bba7da3935_like ON paypal_payflowtransaction USING btree (ppref varchar_pattern_ops);


--
-- Name: promotions_keywordpromotion_417f1b1c; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX promotions_keywordpromotion_417f1b1c ON promotions_keywordpromotion USING btree (content_type_id);


--
-- Name: promotions_multiimage_images_8f22ac31; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX promotions_multiimage_images_8f22ac31 ON promotions_multiimage_images USING btree (multiimage_id);


--
-- Name: promotions_multiimage_images_f33175e6; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX promotions_multiimage_images_f33175e6 ON promotions_multiimage_images USING btree (image_id);


--
-- Name: promotions_orderedproduct_4da3e820; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX promotions_orderedproduct_4da3e820 ON promotions_orderedproduct USING btree (list_id);


--
-- Name: promotions_orderedproduct_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX promotions_orderedproduct_9bea82de ON promotions_orderedproduct USING btree (product_id);


--
-- Name: promotions_orderedproductlist_1f46f425; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX promotions_orderedproductlist_1f46f425 ON promotions_orderedproductlist USING btree (tabbed_block_id);


--
-- Name: promotions_pagepromotion_072c6e88; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX promotions_pagepromotion_072c6e88 ON promotions_pagepromotion USING btree (page_url);


--
-- Name: promotions_pagepromotion_417f1b1c; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX promotions_pagepromotion_417f1b1c ON promotions_pagepromotion USING btree (content_type_id);


--
-- Name: promotions_pagepromotion_page_url_224511aec587289c_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX promotions_pagepromotion_page_url_224511aec587289c_like ON promotions_pagepromotion USING btree (page_url varchar_pattern_ops);


--
-- Name: promotions_singleproduct_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX promotions_singleproduct_9bea82de ON promotions_singleproduct USING btree (product_id);


--
-- Name: reviews_productreview_979acfd1; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX reviews_productreview_979acfd1 ON reviews_productreview USING btree (delta_votes);


--
-- Name: reviews_productreview_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX reviews_productreview_9bea82de ON reviews_productreview USING btree (product_id);


--
-- Name: reviews_productreview_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX reviews_productreview_e8701ad4 ON reviews_productreview USING btree (user_id);


--
-- Name: reviews_vote_5bd2a989; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX reviews_vote_5bd2a989 ON reviews_vote USING btree (review_id);


--
-- Name: reviews_vote_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX reviews_vote_e8701ad4 ON reviews_vote USING btree (user_id);


--
-- Name: shipping_orderanditemcharges_c_country_id_7cfe5f65f8f5bf29_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX shipping_orderanditemcharges_c_country_id_7cfe5f65f8f5bf29_like ON shipping_orderanditemcharges_countries USING btree (country_id varchar_pattern_ops);


--
-- Name: shipping_orderanditemcharges_code_6d0c39adddb15165_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX shipping_orderanditemcharges_code_6d0c39adddb15165_like ON shipping_orderanditemcharges USING btree (code varchar_pattern_ops);


--
-- Name: shipping_orderanditemcharges_countries_2e9e2d8d; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX shipping_orderanditemcharges_countries_2e9e2d8d ON shipping_orderanditemcharges_countries USING btree (orderanditemcharges_id);


--
-- Name: shipping_orderanditemcharges_countries_93bfec8a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX shipping_orderanditemcharges_countries_93bfec8a ON shipping_orderanditemcharges_countries USING btree (country_id);


--
-- Name: shipping_orderanditemcharges_name_e93991f4a3c397a_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX shipping_orderanditemcharges_name_e93991f4a3c397a_like ON shipping_orderanditemcharges USING btree (name varchar_pattern_ops);


--
-- Name: shipping_weightband_836f12fb; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX shipping_weightband_836f12fb ON shipping_weightband USING btree (method_id);


--
-- Name: shipping_weightbased_code_6936c9281b454fc5_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX shipping_weightbased_code_6936c9281b454fc5_like ON shipping_weightbased USING btree (code varchar_pattern_ops);


--
-- Name: shipping_weightbased_countries_30de71ed; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX shipping_weightbased_countries_30de71ed ON shipping_weightbased_countries USING btree (weightbased_id);


--
-- Name: shipping_weightbased_countries_93bfec8a; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX shipping_weightbased_countries_93bfec8a ON shipping_weightbased_countries USING btree (country_id);


--
-- Name: shipping_weightbased_countries_country_id_2ac2ea9bc3f0914e_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX shipping_weightbased_countries_country_id_2ac2ea9bc3f0914e_like ON shipping_weightbased_countries USING btree (country_id varchar_pattern_ops);


--
-- Name: shipping_weightbased_name_f97a5cbe49f2b30_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX shipping_weightbased_name_f97a5cbe49f2b30_like ON shipping_weightbased USING btree (name varchar_pattern_ops);


--
-- Name: taggit_tag_name_1d5a83dd096f8ed_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX taggit_tag_name_1d5a83dd096f8ed_like ON taggit_tag USING btree (name varchar_pattern_ops);


--
-- Name: taggit_tag_slug_727af5429a8288de_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX taggit_tag_slug_727af5429a8288de_like ON taggit_tag USING btree (slug varchar_pattern_ops);


--
-- Name: taggit_taggeditem_417f1b1c; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX taggit_taggeditem_417f1b1c ON taggit_taggeditem USING btree (content_type_id);


--
-- Name: taggit_taggeditem_76f094bc; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX taggit_taggeditem_76f094bc ON taggit_taggeditem USING btree (tag_id);


--
-- Name: taggit_taggeditem_af31437c; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX taggit_taggeditem_af31437c ON taggit_taggeditem USING btree (object_id);


--
-- Name: taggit_taggeditem_content_type_id_4775a7a808e2987b_idx; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX taggit_taggeditem_content_type_id_4775a7a808e2987b_idx ON taggit_taggeditem USING btree (content_type_id, object_id);


--
-- Name: thumbnail_kvstore_key_3a842f6f0183c1a2_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX thumbnail_kvstore_key_3a842f6f0183c1a2_like ON thumbnail_kvstore USING btree (key varchar_pattern_ops);


--
-- Name: voucher_voucher_code_711300cc48e91bf0_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX voucher_voucher_code_711300cc48e91bf0_like ON voucher_voucher USING btree (code varchar_pattern_ops);


--
-- Name: voucher_voucher_offers_3e8639ee; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX voucher_voucher_offers_3e8639ee ON voucher_voucher_offers USING btree (voucher_id);


--
-- Name: voucher_voucher_offers_a8841877; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX voucher_voucher_offers_a8841877 ON voucher_voucher_offers USING btree (conditionaloffer_id);


--
-- Name: voucher_voucherapplication_3e8639ee; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX voucher_voucherapplication_3e8639ee ON voucher_voucherapplication USING btree (voucher_id);


--
-- Name: voucher_voucherapplication_69dfcb07; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX voucher_voucherapplication_69dfcb07 ON voucher_voucherapplication USING btree (order_id);


--
-- Name: voucher_voucherapplication_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX voucher_voucherapplication_e8701ad4 ON voucher_voucherapplication USING btree (user_id);


--
-- Name: wagtailcore_grouppagepermission_0e939a4f; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_grouppagepermission_0e939a4f ON wagtailcore_grouppagepermission USING btree (group_id);


--
-- Name: wagtailcore_grouppagepermission_1a63c800; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_grouppagepermission_1a63c800 ON wagtailcore_grouppagepermission USING btree (page_id);


--
-- Name: wagtailcore_page_2dbcba41; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_page_2dbcba41 ON wagtailcore_page USING btree (slug);


--
-- Name: wagtailcore_page_417f1b1c; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_page_417f1b1c ON wagtailcore_page USING btree (content_type_id);


--
-- Name: wagtailcore_page_5e7b1936; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_page_5e7b1936 ON wagtailcore_page USING btree (owner_id);


--
-- Name: wagtailcore_page_first_published_at_3d0322aa600d4df9_uniq; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_page_first_published_at_3d0322aa600d4df9_uniq ON wagtailcore_page USING btree (first_published_at);


--
-- Name: wagtailcore_page_path_203e50dfde5e1849_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_page_path_203e50dfde5e1849_like ON wagtailcore_page USING btree (path varchar_pattern_ops);


--
-- Name: wagtailcore_page_slug_45b255f5fc731cdd_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_page_slug_45b255f5fc731cdd_like ON wagtailcore_page USING btree (slug varchar_pattern_ops);


--
-- Name: wagtailcore_pager_submitted_for_moderation_2cb175c6fc81adb_uniq; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_pager_submitted_for_moderation_2cb175c6fc81adb_uniq ON wagtailcore_pagerevision USING btree (submitted_for_moderation);


--
-- Name: wagtailcore_pagerevision_1a63c800; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_pagerevision_1a63c800 ON wagtailcore_pagerevision USING btree (page_id);


--
-- Name: wagtailcore_pagerevision_e8701ad4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_pagerevision_e8701ad4 ON wagtailcore_pagerevision USING btree (user_id);


--
-- Name: wagtailcore_pageviewrestriction_1a63c800; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_pageviewrestriction_1a63c800 ON wagtailcore_pageviewrestriction USING btree (page_id);


--
-- Name: wagtailcore_site_0897acf4; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_site_0897acf4 ON wagtailcore_site USING btree (hostname);


--
-- Name: wagtailcore_site_8372b497; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_site_8372b497 ON wagtailcore_site USING btree (root_page_id);


--
-- Name: wagtailcore_site_hostname_a780b84d598ab8f_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailcore_site_hostname_a780b84d598ab8f_like ON wagtailcore_site USING btree (hostname varchar_pattern_ops);


--
-- Name: wagtaildocs_document_ef01e2b6; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtaildocs_document_ef01e2b6 ON wagtaildocs_document USING btree (uploaded_by_user_id);


--
-- Name: wagtailforms_formsubmission_1a63c800; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailforms_formsubmission_1a63c800 ON wagtailforms_formsubmission USING btree (page_id);


--
-- Name: wagtailimages_filter_b979c293; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailimages_filter_b979c293 ON wagtailimages_filter USING btree (spec);


--
-- Name: wagtailimages_filter_spec_50a6f8f1f8ec3c10_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailimages_filter_spec_50a6f8f1f8ec3c10_like ON wagtailimages_filter USING btree (spec varchar_pattern_ops);


--
-- Name: wagtailimages_image_created_at_53352c1f0eb96cdd_uniq; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailimages_image_created_at_53352c1f0eb96cdd_uniq ON wagtailimages_image USING btree (created_at);


--
-- Name: wagtailimages_image_ef01e2b6; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailimages_image_ef01e2b6 ON wagtailimages_image USING btree (uploaded_by_user_id);


--
-- Name: wagtailimages_rendition_0a317463; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailimages_rendition_0a317463 ON wagtailimages_rendition USING btree (filter_id);


--
-- Name: wagtailimages_rendition_f33175e6; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailimages_rendition_f33175e6 ON wagtailimages_rendition USING btree (image_id);


--
-- Name: wagtailredirects_redirect_2fd79f37; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailredirects_redirect_2fd79f37 ON wagtailredirects_redirect USING btree (redirect_page_id);


--
-- Name: wagtailredirects_redirect_9365d6e7; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailredirects_redirect_9365d6e7 ON wagtailredirects_redirect USING btree (site_id);


--
-- Name: wagtailredirects_redirect_old_path_894340b98c5fb15_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailredirects_redirect_old_path_894340b98c5fb15_like ON wagtailredirects_redirect USING btree (old_path varchar_pattern_ops);


--
-- Name: wagtailsearch_editorspick_0bbeda9c; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailsearch_editorspick_0bbeda9c ON wagtailsearch_editorspick USING btree (query_id);


--
-- Name: wagtailsearch_editorspick_1a63c800; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailsearch_editorspick_1a63c800 ON wagtailsearch_editorspick USING btree (page_id);


--
-- Name: wagtailsearch_query_query_string_7c208aba58783990_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailsearch_query_query_string_7c208aba58783990_like ON wagtailsearch_query USING btree (query_string varchar_pattern_ops);


--
-- Name: wagtailsearch_querydailyhits_0bbeda9c; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wagtailsearch_querydailyhits_0bbeda9c ON wagtailsearch_querydailyhits USING btree (query_id);


--
-- Name: wishlists_line_9bea82de; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wishlists_line_9bea82de ON wishlists_line USING btree (product_id);


--
-- Name: wishlists_line_e2f8e270; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wishlists_line_e2f8e270 ON wishlists_line USING btree (wishlist_id);


--
-- Name: wishlists_wishlist_5e7b1936; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wishlists_wishlist_5e7b1936 ON wishlists_wishlist USING btree (owner_id);


--
-- Name: wishlists_wishlist_key_41d744349e6f493_like; Type: INDEX; Schema: public; Owner: taedori; Tablespace: 
--

CREATE INDEX wishlists_wishlist_key_41d744349e6f493_like ON wishlists_wishlist USING btree (key varchar_pattern_ops);


--
-- Name: D10b6c7d28349b24b1db6dd335fe0aca; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productattributevalue
    ADD CONSTRAINT "D10b6c7d28349b24b1db6dd335fe0aca" FOREIGN KEY (entity_content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D19cabd0ff247799cab92aaecd797ddc; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY shipping_orderanditemcharges_countries
    ADD CONSTRAINT "D19cabd0ff247799cab92aaecd797ddc" FOREIGN KEY (orderanditemcharges_id) REFERENCES shipping_orderanditemcharges(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D7a053ea098a5dfb7b5193eb3987cb77; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY voucher_voucher_offers
    ADD CONSTRAINT "D7a053ea098a5dfb7b5193eb3987cb77" FOREIGN KEY (conditionaloffer_id) REFERENCES offer_conditionaloffer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D7c61875694036cccba603a8f2427034; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productattributevalue
    ADD CONSTRAINT "D7c61875694036cccba603a8f2427034" FOREIGN KEY (value_option_id) REFERENCES catalogue_attributeoption(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: D8d4c1635673088a055084acf76f34bb; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_communicationevent
    ADD CONSTRAINT "D8d4c1635673088a055084acf76f34bb" FOREIGN KEY (event_type_id) REFERENCES customer_communicationeventtype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: aa30d6644ba9799ea568a3b1a0894cd7; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productattribute
    ADD CONSTRAINT aa30d6644ba9799ea568a3b1a0894cd7 FOREIGN KEY (option_group_id) REFERENCES catalogue_attributeoptiongroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ad_country_id_4355f10dabea58a1_fk_address_country_iso_3166_1_a2; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY address_useraddress
    ADD CONSTRAINT ad_country_id_4355f10dabea58a1_fk_address_country_iso_3166_1_a2 FOREIGN KEY (country_id) REFERENCES address_country(iso_3166_1_a2) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: address_useraddress_user_id_33ad87f34b5d9aee_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY address_useraddress
    ADD CONSTRAINT address_useraddress_user_id_33ad87f34b5d9aee_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: analytics_pr_product_id_fccd90dfae6c888_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY analytics_productrecord
    ADD CONSTRAINT analytics_pr_product_id_fccd90dfae6c888_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: analytics_u_product_id_6505922ce44921ec_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY analytics_userproductview
    ADD CONSTRAINT analytics_u_product_id_6505922ce44921ec_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: analytics_userproductv_user_id_2f1ec5dc14d8edfb_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY analytics_userproductview
    ADD CONSTRAINT analytics_userproductv_user_id_2f1ec5dc14d8edfb_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: analytics_userrecord_user_id_3bf70358754f7c1f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY analytics_userrecord
    ADD CONSTRAINT analytics_userrecord_user_id_3bf70358754f7c1f_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: analytics_usersearch_user_id_58a23df9bdecb925_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY analytics_usersearch
    ADD CONSTRAINT analytics_usersearch_user_id_58a23df9bdecb925_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: attribute_id_578c720e1dfb1f7f_fk_catalogue_productattribute_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productattributevalue
    ADD CONSTRAINT attribute_id_578c720e1dfb1f7f_fk_catalogue_productattribute_id FOREIGN KEY (attribute_id) REFERENCES catalogue_productattribute(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_content_type_id_2bb283b54c100a33_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_content_type_id_2bb283b54c100a33_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissio_group_id_65482d3ccccce83b_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_group_id_65482d3ccccce83b_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permission_id_139c04f164f6c017_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permission_id_139c04f164f6c017_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user__permission_id_5e803856978b9bf7_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user__permission_id_5e803856978b9bf7_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_40a3f96d94c05224_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_40a3f96d94c05224_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_user_id_4686e06a34bbb887_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_4686e06a34bbb887_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permiss_user_id_349490017b733bfa_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permiss_user_id_349490017b733bfa_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: b84e6f581af392d09a47a14dd62e3f93; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_orderedproduct
    ADD CONSTRAINT b84e6f581af392d09a47a14dd62e3f93 FOREIGN KEY (list_id) REFERENCES promotions_handpickedproductlist(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: baske_stockrecord_id_7a32eca1cbe45a60_fk_partner_stockrecord_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_line
    ADD CONSTRAINT baske_stockrecord_id_7a32eca1cbe45a60_fk_partner_stockrecord_id FOREIGN KEY (stockrecord_id) REFERENCES partner_stockrecord(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basket_basket__voucher_id_e0f40856b6227ee_fk_voucher_voucher_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_basket_vouchers
    ADD CONSTRAINT basket_basket__voucher_id_e0f40856b6227ee_fk_voucher_voucher_id FOREIGN KEY (voucher_id) REFERENCES voucher_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basket_basket_owner_id_70e11fc441d31389_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_basket
    ADD CONSTRAINT basket_basket_owner_id_70e11fc441d31389_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basket_basket_vo_basket_id_2016a13753571583_fk_basket_basket_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_basket_vouchers
    ADD CONSTRAINT basket_basket_vo_basket_id_2016a13753571583_fk_basket_basket_id FOREIGN KEY (basket_id) REFERENCES basket_basket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basket_line_basket_id_5dc3fa203ab64743_fk_basket_basket_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_line
    ADD CONSTRAINT basket_line_basket_id_5dc3fa203ab64743_fk_basket_basket_id FOREIGN KEY (basket_id) REFERENCES basket_basket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basket_line_product_id_46580085fac53f62_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_line
    ADD CONSTRAINT basket_line_product_id_46580085fac53f62_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basket_lineatt_option_id_699e3fd504909a8_fk_catalogue_option_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_lineattribute
    ADD CONSTRAINT basket_lineatt_option_id_699e3fd504909a8_fk_catalogue_option_id FOREIGN KEY (option_id) REFERENCES catalogue_option(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: basket_lineattribute_line_id_7dc4e43be325dc04_fk_basket_line_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY basket_lineattribute
    ADD CONSTRAINT basket_lineattribute_line_id_7dc4e43be325dc04_fk_basket_line_id FOREIGN KEY (line_id) REFERENCES basket_line(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bf07eed655530bc614cb8ccc013b2a2f; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT bf07eed655530bc614cb8ccc013b2a2f FOREIGN KEY (shipping_address_id) REFERENCES order_shippingaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: billing_address_id_164e37c2010e7845_fk_order_billingaddress_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT billing_address_id_164e37c2010e7845_fk_order_billingaddress_id FOREIGN KEY (billing_address_id) REFERENCES order_billingaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: c55f85b69b47ac41060e7d500f3e6a63; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_orderedproductlist
    ADD CONSTRAINT c55f85b69b47ac41060e7d500f3e6a63 FOREIGN KEY (handpickedproductlist_ptr_id) REFERENCES promotions_handpickedproductlist(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ca_productclass_id_aa1ca9dd96114c5_fk_catalogue_productclass_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productclass_options
    ADD CONSTRAINT ca_productclass_id_aa1ca9dd96114c5_fk_catalogue_productclass_id FOREIGN KEY (productclass_id) REFERENCES catalogue_productclass(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cata_recommendation_id_4c059ce9fafecad8_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productrecommendation
    ADD CONSTRAINT cata_recommendation_id_4c059ce9fafecad8_fk_catalogue_product_id FOREIGN KEY (recommendation_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: catalogue_category_id_143c3519505a5ed2_fk_catalogue_category_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productcategory
    ADD CONSTRAINT catalogue_category_id_143c3519505a5ed2_fk_catalogue_category_id FOREIGN KEY (category_id) REFERENCES catalogue_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: catalogue_p_primary_id_3e7917d164d7eb78_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productrecommendation
    ADD CONSTRAINT catalogue_p_primary_id_3e7917d164d7eb78_fk_catalogue_product_id FOREIGN KEY (primary_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: catalogue_p_product_id_2599d933b62773f0_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productcategory
    ADD CONSTRAINT catalogue_p_product_id_2599d933b62773f0_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: catalogue_p_product_id_75a9c549e4d118ea_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_product_product_options
    ADD CONSTRAINT catalogue_p_product_id_75a9c549e4d118ea_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: catalogue_p_product_id_7efc1a8ce09c4e5f_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productimage
    ADD CONSTRAINT catalogue_p_product_id_7efc1a8ce09c4e5f_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: catalogue_pr_parent_id_4e49e594ed2726b3_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_product
    ADD CONSTRAINT catalogue_pr_parent_id_4e49e594ed2726b3_fk_catalogue_product_id FOREIGN KEY (parent_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: catalogue_pr_product_id_c14735c3707a43b_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productattributevalue
    ADD CONSTRAINT catalogue_pr_product_id_c14735c3707a43b_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: catalogue_pro_option_id_3ae955193daee981_fk_catalogue_option_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productclass_options
    ADD CONSTRAINT catalogue_pro_option_id_3ae955193daee981_fk_catalogue_option_id FOREIGN KEY (option_id) REFERENCES catalogue_option(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: catalogue_pro_option_id_6841ca5648dd1347_fk_catalogue_option_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_product_product_options
    ADD CONSTRAINT catalogue_pro_option_id_6841ca5648dd1347_fk_catalogue_option_id FOREIGN KEY (option_id) REFERENCES catalogue_option(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_email_user_id_25360aba8fe7273d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY customer_email
    ADD CONSTRAINT customer_email_user_id_25360aba8fe7273d_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_notificat_recipient_id_56f054bfb85003c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY customer_notification
    ADD CONSTRAINT customer_notificat_recipient_id_56f054bfb85003c_fk_auth_user_id FOREIGN KEY (recipient_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_notificatio_sender_id_7a80c48f7c5845dd_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY customer_notification
    ADD CONSTRAINT customer_notificatio_sender_id_7a80c48f7c5845dd_fk_auth_user_id FOREIGN KEY (sender_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_pr_product_id_17d7787bedc52951_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY customer_productalert
    ADD CONSTRAINT customer_pr_product_id_17d7787bedc52951_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_productalert_user_id_15509acf0c0c7170_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY customer_productalert
    ADD CONSTRAINT customer_productalert_user_id_15509acf0c0c7170_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: djan_content_type_id_65fe7b229ea3992a_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT djan_content_type_id_65fe7b229ea3992a_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_4965d3cce354ce0c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_4965d3cce354ce0c_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_flatp_flatpage_id_517d97c88df479d3_fk_django_flatpage_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT django_flatp_flatpage_id_517d97c88df479d3_fk_django_flatpage_id FOREIGN KEY (flatpage_id) REFERENCES django_flatpage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_flatpage_sites_site_id_d795bfda263c26a_fk_django_site_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY django_flatpage_sites
    ADD CONSTRAINT django_flatpage_sites_site_id_d795bfda263c26a_fk_django_site_id FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_4a3567bd81e20419_fk_catalogue_attributeoptiongroup_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_attributeoption
    ADD CONSTRAINT group_id_4a3567bd81e20419_fk_catalogue_attributeoptiongroup_id FOREIGN KEY (group_id) REFERENCES catalogue_attributeoptiongroup(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: home_homepa_page_ptr_id_3c675964203d7c0c_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY home_homepage
    ADD CONSTRAINT home_homepa_page_ptr_id_3c675964203d7c0c_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: home_promot_page_ptr_id_4fde64545480605a_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY home_promotionspage
    ADD CONSTRAINT home_promot_page_ptr_id_4fde64545480605a_fk_wagtailcore_page_id FOREIGN KEY (page_ptr_id) REFERENCES wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: o_productclass_id_11a09748ab082197_fk_catalogue_productclass_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_range_classes
    ADD CONSTRAINT o_productclass_id_11a09748ab082197_fk_catalogue_productclass_id FOREIGN KEY (productclass_id) REFERENCES catalogue_productclass(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_benefit_range_id_48fca73e82264869_fk_offer_range_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_benefit
    ADD CONSTRAINT offer_benefit_range_id_48fca73e82264869_fk_offer_range_id FOREIGN KEY (range_id) REFERENCES offer_range(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_condi_condition_id_4c7057ed321762cd_fk_offer_condition_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_conditionaloffer
    ADD CONSTRAINT offer_condi_condition_id_4c7057ed321762cd_fk_offer_condition_id FOREIGN KEY (condition_id) REFERENCES offer_condition(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_condition_benefit_id_2659f6761ba6356f_fk_offer_benefit_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_conditionaloffer
    ADD CONSTRAINT offer_condition_benefit_id_2659f6761ba6356f_fk_offer_benefit_id FOREIGN KEY (benefit_id) REFERENCES offer_benefit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_condition_range_id_7a5420b28092ee99_fk_offer_range_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_condition
    ADD CONSTRAINT offer_condition_range_id_7a5420b28092ee99_fk_offer_range_id FOREIGN KEY (range_id) REFERENCES offer_range(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_ran_category_id_4adc1afa130bcb33_fk_catalogue_category_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_range_included_categories
    ADD CONSTRAINT offer_ran_category_id_4adc1afa130bcb33_fk_catalogue_category_id FOREIGN KEY (category_id) REFERENCES catalogue_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_range__product_id_571250a44a9d74f_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_range_excluded_products
    ADD CONSTRAINT offer_range__product_id_571250a44a9d74f_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_range_classes_range_id_4e1a4e9a0c3b4b22_fk_offer_range_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_range_classes
    ADD CONSTRAINT offer_range_classes_range_id_4e1a4e9a0c3b4b22_fk_offer_range_id FOREIGN KEY (range_id) REFERENCES offer_range(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_range_exclude_range_id_7e8b7a7457a84527_fk_offer_range_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_range_excluded_products
    ADD CONSTRAINT offer_range_exclude_range_id_7e8b7a7457a84527_fk_offer_range_id FOREIGN KEY (range_id) REFERENCES offer_range(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_range_included_range_id_920c42b588b8439_fk_offer_range_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_range_included_categories
    ADD CONSTRAINT offer_range_included_range_id_920c42b588b8439_fk_offer_range_id FOREIGN KEY (range_id) REFERENCES offer_range(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_range_product_id_43ea3e49f043ffe4_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_rangeproduct
    ADD CONSTRAINT offer_range_product_id_43ea3e49f043ffe4_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_rangeprodu_uploaded_by_id_e60a29f63eab8cb_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_rangeproductfileupload
    ADD CONSTRAINT offer_rangeprodu_uploaded_by_id_e60a29f63eab8cb_fk_auth_user_id FOREIGN KEY (uploaded_by_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_rangeproduct_range_id_4261909cd23e9534_fk_offer_range_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_rangeproduct
    ADD CONSTRAINT offer_rangeproduct_range_id_4261909cd23e9534_fk_offer_range_id FOREIGN KEY (range_id) REFERENCES offer_range(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offer_rangeproductf_range_id_1eff93c680efe46e_fk_offer_range_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY offer_rangeproductfileupload
    ADD CONSTRAINT offer_rangeproductf_range_id_1eff93c680efe46e_fk_offer_range_id FOREIGN KEY (range_id) REFERENCES offer_range(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: or_country_id_229f6b8680303aea_fk_address_country_iso_3166_1_a2; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_shippingaddress
    ADD CONSTRAINT or_country_id_229f6b8680303aea_fk_address_country_iso_3166_1_a2 FOREIGN KEY (country_id) REFERENCES address_country(iso_3166_1_a2) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: or_country_id_360dcdbd68dcbb0e_fk_address_country_iso_3166_1_a2; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_billingaddress
    ADD CONSTRAINT or_country_id_360dcdbd68dcbb0e_fk_address_country_iso_3166_1_a2 FOREIGN KEY (country_id) REFERENCES address_country(iso_3166_1_a2) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: or_event_type_id_2ada98e51f7df79d_fk_order_shippingeventtype_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_shippingevent
    ADD CONSTRAINT or_event_type_id_2ada98e51f7df79d_fk_order_shippingeventtype_id FOREIGN KEY (event_type_id) REFERENCES order_shippingeventtype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: or_shipping_event_id_457e36385c9a0b6e_fk_order_shippingevent_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_paymentevent
    ADD CONSTRAINT or_shipping_event_id_457e36385c9a0b6e_fk_order_shippingevent_id FOREIGN KEY (shipping_event_id) REFERENCES order_shippingevent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ord_event_type_id_3854bac70a4f6464_fk_order_paymenteventtype_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_paymentevent
    ADD CONSTRAINT ord_event_type_id_3854bac70a4f6464_fk_order_paymenteventtype_id FOREIGN KEY (event_type_id) REFERENCES order_paymenteventtype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_communication_order_id_3372e20437dc8902_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_communicationevent
    ADD CONSTRAINT order_communication_order_id_3372e20437dc8902_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_line_order_id_50457b703d05cb99_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_line
    ADD CONSTRAINT order_line_order_id_50457b703d05cb99_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_line_partner_id_3a6be407c35b47dc_fk_partner_partner_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_line
    ADD CONSTRAINT order_line_partner_id_3a6be407c35b47dc_fk_partner_partner_id FOREIGN KEY (partner_id) REFERENCES partner_partner(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_line_product_id_5d895b6d87e57fe0_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_line
    ADD CONSTRAINT order_line_product_id_5d895b6d87e57fe0_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_lineatt_option_id_1bc83362192fbf9f_fk_catalogue_option_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_lineattribute
    ADD CONSTRAINT order_lineatt_option_id_1bc83362192fbf9f_fk_catalogue_option_id FOREIGN KEY (option_id) REFERENCES catalogue_option(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_lineattribute_line_id_63774391616692ed_fk_order_line_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_lineattribute
    ADD CONSTRAINT order_lineattribute_line_id_63774391616692ed_fk_order_line_id FOREIGN KEY (line_id) REFERENCES order_line(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_lineprice_line_id_7788dfdd43838506_fk_order_line_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_lineprice
    ADD CONSTRAINT order_lineprice_line_id_7788dfdd43838506_fk_order_line_id FOREIGN KEY (line_id) REFERENCES order_line(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_lineprice_order_id_3ad50c616eaf1e9c_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_lineprice
    ADD CONSTRAINT order_lineprice_order_id_3ad50c616eaf1e9c_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order_basket_id_d9b0fd1dbe15d81_fk_basket_basket_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_basket_id_d9b0fd1dbe15d81_fk_basket_basket_id FOREIGN KEY (basket_id) REFERENCES basket_basket(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order_site_id_444129e049392ed5_fk_django_site_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_site_id_444129e049392ed5_fk_django_site_id FOREIGN KEY (site_id) REFERENCES django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_order_user_id_4b766dc581812e19_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_order
    ADD CONSTRAINT order_order_user_id_4b766dc581812e19_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_orderdiscount_order_id_1161fd922758ad09_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_orderdiscount
    ADD CONSTRAINT order_orderdiscount_order_id_1161fd922758ad09_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_ordernote_order_id_557c430ec7361d2e_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_ordernote
    ADD CONSTRAINT order_ordernote_order_id_557c430ec7361d2e_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_ordernote_user_id_7dd9f2287e633c4c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_ordernote
    ADD CONSTRAINT order_ordernote_user_id_7dd9f2287e633c4c_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_paymen_event_id_13491f6723ddb37c_fk_order_paymentevent_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_paymenteventquantity
    ADD CONSTRAINT order_paymen_event_id_13491f6723ddb37c_fk_order_paymentevent_id FOREIGN KEY (event_id) REFERENCES order_paymentevent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_paymentevent_order_id_6b3acb09484a1408_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_paymentevent
    ADD CONSTRAINT order_paymentevent_order_id_6b3acb09484a1408_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_paymenteventqua_line_id_2949cf9090ce675f_fk_order_line_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_paymenteventquantity
    ADD CONSTRAINT order_paymenteventqua_line_id_2949cf9090ce675f_fk_order_line_id FOREIGN KEY (line_id) REFERENCES order_line(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_shipp_event_id_41b3cd656de279a0_fk_order_shippingevent_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_shippingeventquantity
    ADD CONSTRAINT order_shipp_event_id_41b3cd656de279a0_fk_order_shippingevent_id FOREIGN KEY (event_id) REFERENCES order_shippingevent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_shippingevent_order_id_36c9cf6e4b3ad3d7_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_shippingevent
    ADD CONSTRAINT order_shippingevent_order_id_36c9cf6e4b3ad3d7_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_shippingeventqu_line_id_700424f580ad4445_fk_order_line_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_shippingeventquantity
    ADD CONSTRAINT order_shippingeventqu_line_id_700424f580ad4445_fk_order_line_id FOREIGN KEY (line_id) REFERENCES order_line(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: order_stockrecord_id_301ef0d1bb72161e_fk_partner_stockrecord_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY order_line
    ADD CONSTRAINT order_stockrecord_id_301ef0d1bb72161e_fk_partner_stockrecord_id FOREIGN KEY (stockrecord_id) REFERENCES partner_stockrecord(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: p_tabbed_block_id_78d50c2f88cb869f_fk_promotions_tabbedblock_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_orderedproductlist
    ADD CONSTRAINT p_tabbed_block_id_78d50c2f88cb869f_fk_promotions_tabbedblock_id FOREIGN KEY (tabbed_block_id) REFERENCES promotions_tabbedblock(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: pa_country_id_73028540ebf842ce_fk_address_country_iso_3166_1_a2; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_partneraddress
    ADD CONSTRAINT pa_country_id_73028540ebf842ce_fk_address_country_iso_3166_1_a2 FOREIGN KEY (country_id) REFERENCES address_country(iso_3166_1_a2) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partn_stockrecord_id_2983539e4c519f77_fk_partner_stockrecord_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_stockalert
    ADD CONSTRAINT partn_stockrecord_id_2983539e4c519f77_fk_partner_stockrecord_id FOREIGN KEY (stockrecord_id) REFERENCES partner_stockrecord(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partner_partn_partner_id_40dc27e11c96254d_fk_partner_partner_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_partner_users
    ADD CONSTRAINT partner_partn_partner_id_40dc27e11c96254d_fk_partner_partner_id FOREIGN KEY (partner_id) REFERENCES partner_partner(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partner_partne_partner_id_dae18af45f929b6_fk_partner_partner_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_partneraddress
    ADD CONSTRAINT partner_partne_partner_id_dae18af45f929b6_fk_partner_partner_id FOREIGN KEY (partner_id) REFERENCES partner_partner(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partner_partner_users_user_id_da640af4949b0d0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_partner_users
    ADD CONSTRAINT partner_partner_users_user_id_da640af4949b0d0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partner_sto_product_id_3d65257c74bc7761_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_stockrecord
    ADD CONSTRAINT partner_sto_product_id_3d65257c74bc7761_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: partner_stock_partner_id_66d9a9bca783f71d_fk_partner_partner_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY partner_stockrecord
    ADD CONSTRAINT partner_stock_partner_id_66d9a9bca783f71d_fk_partner_partner_id FOREIGN KEY (partner_id) REFERENCES partner_partner(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: paymen_source_type_id_6554b4fb3556a0cb_fk_payment_sourcetype_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payment_source
    ADD CONSTRAINT paymen_source_type_id_6554b4fb3556a0cb_fk_payment_sourcetype_id FOREIGN KEY (source_type_id) REFERENCES payment_sourcetype(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payment_bankcard_user_id_6c02f71a041b3c5c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payment_bankcard
    ADD CONSTRAINT payment_bankcard_user_id_6c02f71a041b3c5c_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payment_source_order_id_19e9923f4dd47e3e_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payment_source
    ADD CONSTRAINT payment_source_order_id_19e9923f4dd47e3e_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payment_transac_source_id_7ba1dfbb7947ce92_fk_payment_source_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payment_transaction
    ADD CONSTRAINT payment_transac_source_id_7ba1dfbb7947ce92_fk_payment_source_id FOREIGN KEY (source_id) REFERENCES payment_source(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_c_customer_id_1906cc9e7be15de7_fk_payments_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_charge
    ADD CONSTRAINT payments_c_customer_id_1906cc9e7be15de7_fk_payments_customer_id FOREIGN KEY (customer_id) REFERENCES payments_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_c_customer_id_653bc5bdb8211944_fk_payments_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_currentsubscription
    ADD CONSTRAINT payments_c_customer_id_653bc5bdb8211944_fk_payments_customer_id FOREIGN KEY (customer_id) REFERENCES payments_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_cha_invoice_id_72c033377fd78ccd_fk_payments_invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_charge
    ADD CONSTRAINT payments_cha_invoice_id_72c033377fd78ccd_fk_payments_invoice_id FOREIGN KEY (invoice_id) REFERENCES payments_invoice(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_customer_user_id_24d4dfe9b3b589bb_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_customer
    ADD CONSTRAINT payments_customer_user_id_24d4dfe9b3b589bb_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_e_customer_id_4f7ab04bf4397df7_fk_payments_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_event
    ADD CONSTRAINT payments_e_customer_id_4f7ab04bf4397df7_fk_payments_customer_id FOREIGN KEY (customer_id) REFERENCES payments_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_eventpr_event_id_1cac3cebb42b8fc1_fk_payments_event_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_eventprocessingexception
    ADD CONSTRAINT payments_eventpr_event_id_1cac3cebb42b8fc1_fk_payments_event_id FOREIGN KEY (event_id) REFERENCES payments_event(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_i_customer_id_1106838e41f9592b_fk_payments_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_invoice
    ADD CONSTRAINT payments_i_customer_id_1106838e41f9592b_fk_payments_customer_id FOREIGN KEY (customer_id) REFERENCES payments_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_invo_invoice_id_2dd82fcb236e3f1_fk_payments_invoice_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_invoiceitem
    ADD CONSTRAINT payments_invo_invoice_id_2dd82fcb236e3f1_fk_payments_invoice_id FOREIGN KEY (invoice_id) REFERENCES payments_invoice(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_tr_transfer_id_ba6b74b5c544284_fk_payments_transfer_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_transferchargefee
    ADD CONSTRAINT payments_tr_transfer_id_ba6b74b5c544284_fk_payments_transfer_id FOREIGN KEY (transfer_id) REFERENCES payments_transfer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: payments_transfe_event_id_4fcaa7ef4c860cce_fk_payments_event_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY payments_transfer
    ADD CONSTRAINT payments_transfe_event_id_4fcaa7ef4c860cce_fk_payments_event_id FOREIGN KEY (event_id) REFERENCES payments_event(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_class_id_27eca5dbee349a79_fk_catalogue_productclass_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_productattribute
    ADD CONSTRAINT product_class_id_27eca5dbee349a79_fk_catalogue_productclass_id FOREIGN KEY (product_class_id) REFERENCES catalogue_productclass(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_class_id_2b1269b5cc2fc061_fk_catalogue_productclass_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY catalogue_product
    ADD CONSTRAINT product_class_id_2b1269b5cc2fc061_fk_catalogue_productclass_id FOREIGN KEY (product_class_id) REFERENCES catalogue_productclass(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prom_content_type_id_2fdbeb8c4950eadb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_keywordpromotion
    ADD CONSTRAINT prom_content_type_id_2fdbeb8c4950eadb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: prom_multiimage_id_5d792640b6f79013_fk_promotions_multiimage_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_multiimage_images
    ADD CONSTRAINT prom_multiimage_id_5d792640b6f79013_fk_promotions_multiimage_id FOREIGN KEY (multiimage_id) REFERENCES promotions_multiimage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: promo_content_type_id_ba73340029d583e_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_pagepromotion
    ADD CONSTRAINT promo_content_type_id_ba73340029d583e_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: promotions__product_id_1d590b695dd05b0f_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_orderedproduct
    ADD CONSTRAINT promotions__product_id_1d590b695dd05b0f_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: promotions__product_id_4af3d933376a96bc_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_singleproduct
    ADD CONSTRAINT promotions__product_id_4af3d933376a96bc_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: promotions_mul_image_id_7d0e3537bffeb9db_fk_promotions_image_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY promotions_multiimage_images
    ADD CONSTRAINT promotions_mul_image_id_7d0e3537bffeb9db_fk_promotions_image_id FOREIGN KEY (image_id) REFERENCES promotions_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews__review_id_66ad0f327a71d754_fk_reviews_productreview_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY reviews_vote
    ADD CONSTRAINT reviews__review_id_66ad0f327a71d754_fk_reviews_productreview_id FOREIGN KEY (review_id) REFERENCES reviews_productreview(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews_pro_product_id_28f31b217867b926_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY reviews_productreview
    ADD CONSTRAINT reviews_pro_product_id_28f31b217867b926_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews_productreview_user_id_557532b8611f7fe7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY reviews_productreview
    ADD CONSTRAINT reviews_productreview_user_id_557532b8611f7fe7_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: reviews_vote_user_id_58462bf835bc201e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY reviews_vote
    ADD CONSTRAINT reviews_vote_user_id_58462bf835bc201e_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sh_country_id_2ac2ea9bc3f0914e_fk_address_country_iso_3166_1_a2; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY shipping_weightbased_countries
    ADD CONSTRAINT sh_country_id_2ac2ea9bc3f0914e_fk_address_country_iso_3166_1_a2 FOREIGN KEY (country_id) REFERENCES address_country(iso_3166_1_a2) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sh_country_id_7cfe5f65f8f5bf29_fk_address_country_iso_3166_1_a2; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY shipping_orderanditemcharges_countries
    ADD CONSTRAINT sh_country_id_7cfe5f65f8f5bf29_fk_address_country_iso_3166_1_a2 FOREIGN KEY (country_id) REFERENCES address_country(iso_3166_1_a2) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: ship_weightbased_id_6ebde34c50bbbe2f_fk_shipping_weightbased_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY shipping_weightbased_countries
    ADD CONSTRAINT ship_weightbased_id_6ebde34c50bbbe2f_fk_shipping_weightbased_id FOREIGN KEY (weightbased_id) REFERENCES shipping_weightbased(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: shipping__method_id_6e7d7eb5d6351926_fk_shipping_weightbased_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY shipping_weightband
    ADD CONSTRAINT shipping__method_id_6e7d7eb5d6351926_fk_shipping_weightbased_id FOREIGN KEY (method_id) REFERENCES shipping_weightbased(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tagg_content_type_id_6c7fdcb70c705b65_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY taggit_taggeditem
    ADD CONSTRAINT tagg_content_type_id_6c7fdcb70c705b65_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: taggit_taggeditem_tag_id_cabfd7752d085ae_fk_taggit_tag_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY taggit_taggeditem
    ADD CONSTRAINT taggit_taggeditem_tag_id_cabfd7752d085ae_fk_taggit_tag_id FOREIGN KEY (tag_id) REFERENCES taggit_tag(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: voucher_vouch_voucher_id_22bc5b7404958da6_fk_voucher_voucher_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY voucher_voucher_offers
    ADD CONSTRAINT voucher_vouch_voucher_id_22bc5b7404958da6_fk_voucher_voucher_id FOREIGN KEY (voucher_id) REFERENCES voucher_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: voucher_vouch_voucher_id_3d2c0463de35ed92_fk_voucher_voucher_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY voucher_voucherapplication
    ADD CONSTRAINT voucher_vouch_voucher_id_3d2c0463de35ed92_fk_voucher_voucher_id FOREIGN KEY (voucher_id) REFERENCES voucher_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: voucher_voucherappli_order_id_11d330ffe361917_fk_order_order_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY voucher_voucherapplication
    ADD CONSTRAINT voucher_voucherappli_order_id_11d330ffe361917_fk_order_order_id FOREIGN KEY (order_id) REFERENCES order_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: voucher_voucherapplica_user_id_71a6e6c51852d911_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY voucher_voucherapplication
    ADD CONSTRAINT voucher_voucherapplica_user_id_71a6e6c51852d911_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagt_content_type_id_58c7c9c6ca212cf0_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_page
    ADD CONSTRAINT wagt_content_type_id_58c7c9c6ca212cf0_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtai_redirect_page_id_2bb6b4cd1bc44599_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailredirects_redirect
    ADD CONSTRAINT wagtai_redirect_page_id_2bb6b4cd1bc44599_fk_wagtailcore_page_id FOREIGN KEY (redirect_page_id) REFERENCES wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcor_root_page_id_5f1e84f39801f28a_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_site
    ADD CONSTRAINT wagtailcor_root_page_id_5f1e84f39801f28a_fk_wagtailcore_page_id FOREIGN KEY (root_page_id) REFERENCES wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_grou_page_id_cad8877c1cf45f8_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grou_page_id_cad8877c1cf45f8_fk_wagtailcore_page_id FOREIGN KEY (page_id) REFERENCES wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_grouppag_group_id_76836081a08241e8_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_grouppagepermission
    ADD CONSTRAINT wagtailcore_grouppag_group_id_76836081a08241e8_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pag_page_id_3a42aeeaba73be15_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_pageviewrestriction
    ADD CONSTRAINT wagtailcore_pag_page_id_3a42aeeaba73be15_fk_wagtailcore_page_id FOREIGN KEY (page_id) REFERENCES wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pag_page_id_46f3b33d51a63802_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_pagerevision
    ADD CONSTRAINT wagtailcore_pag_page_id_46f3b33d51a63802_fk_wagtailcore_page_id FOREIGN KEY (page_id) REFERENCES wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_page_owner_id_48986d2d58097dda_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_page
    ADD CONSTRAINT wagtailcore_page_owner_id_48986d2d58097dda_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailcore_pagerevisi_user_id_759a97c1f3777beb_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailcore_pagerevision
    ADD CONSTRAINT wagtailcore_pagerevisi_user_id_759a97c1f3777beb_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtaildoc_uploaded_by_user_id_61ef63b9fe2fcc85_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtaildocs_document
    ADD CONSTRAINT wagtaildoc_uploaded_by_user_id_61ef63b9fe2fcc85_fk_auth_user_id FOREIGN KEY (uploaded_by_user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailforms_fo_page_id_6799702a0001fb22_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailforms_formsubmission
    ADD CONSTRAINT wagtailforms_fo_page_id_6799702a0001fb22_fk_wagtailcore_page_id FOREIGN KEY (page_id) REFERENCES wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailim_filter_id_6c5656dc7441a8e7_fk_wagtailimages_filter_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailimages_rendition
    ADD CONSTRAINT wagtailim_filter_id_6c5656dc7441a8e7_fk_wagtailimages_filter_id FOREIGN KEY (filter_id) REFERENCES wagtailimages_filter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailima_uploaded_by_user_id_7d5d8fa009040516_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailimages_image
    ADD CONSTRAINT wagtailima_uploaded_by_user_id_7d5d8fa009040516_fk_auth_user_id FOREIGN KEY (uploaded_by_user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailimag_image_id_5d5499ce6d2dd9e2_fk_wagtailimages_image_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailimages_rendition
    ADD CONSTRAINT wagtailimag_image_id_5d5499ce6d2dd9e2_fk_wagtailimages_image_id FOREIGN KEY (image_id) REFERENCES wagtailimages_image(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailredirect_site_id_422edaa7f4c93cde_fk_wagtailcore_site_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailredirects_redirect
    ADD CONSTRAINT wagtailredirect_site_id_422edaa7f4c93cde_fk_wagtailcore_site_id FOREIGN KEY (site_id) REFERENCES wagtailcore_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailsear_query_id_1ec8a3172ec69ae5_fk_wagtailsearch_query_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailsearch_querydailyhits
    ADD CONSTRAINT wagtailsear_query_id_1ec8a3172ec69ae5_fk_wagtailsearch_query_id FOREIGN KEY (query_id) REFERENCES wagtailsearch_query(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailsear_query_id_670e65fec91f90ef_fk_wagtailsearch_query_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailsearch_editorspick
    ADD CONSTRAINT wagtailsear_query_id_670e65fec91f90ef_fk_wagtailsearch_query_id FOREIGN KEY (query_id) REFERENCES wagtailsearch_query(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailsearch_e_page_id_6893e8e446af2e80_fk_wagtailcore_page_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailsearch_editorspick
    ADD CONSTRAINT wagtailsearch_e_page_id_6893e8e446af2e80_fk_wagtailcore_page_id FOREIGN KEY (page_id) REFERENCES wagtailcore_page(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wagtailusers_userprofi_user_id_20d1d315b23d54d0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wagtailusers_userprofile
    ADD CONSTRAINT wagtailusers_userprofi_user_id_20d1d315b23d54d0_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wishlists_l_product_id_6eb8ed2c10a6e469_fk_catalogue_product_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wishlists_line
    ADD CONSTRAINT wishlists_l_product_id_6eb8ed2c10a6e469_fk_catalogue_product_id FOREIGN KEY (product_id) REFERENCES catalogue_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wishlists_wishlist_id_3b594fdfda8f2801_fk_wishlists_wishlist_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wishlists_line
    ADD CONSTRAINT wishlists_wishlist_id_3b594fdfda8f2801_fk_wishlists_wishlist_id FOREIGN KEY (wishlist_id) REFERENCES wishlists_wishlist(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: wishlists_wishlist_owner_id_2ca347be1926a4ff_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: taedori
--

ALTER TABLE ONLY wishlists_wishlist
    ADD CONSTRAINT wishlists_wishlist_owner_id_2ca347be1926a4ff_fk_auth_user_id FOREIGN KEY (owner_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

