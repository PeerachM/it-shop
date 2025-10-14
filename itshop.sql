--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-10-15 01:52:37

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
-- TOC entry 5009 (class 0 OID 18651)
-- Dependencies: 224
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auth_group (id, name) VALUES (2, 'admin');
INSERT INTO public.auth_group (id, name) VALUES (1, 'customer');


--
-- TOC entry 5005 (class 0 OID 18637)
-- Dependencies: 220
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_content_type (id, app_label, model) VALUES (1, 'admin', 'logentry');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (2, 'auth', 'permission');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (3, 'auth', 'group');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (4, 'auth', 'user');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (6, 'sessions', 'session');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (7, 'shop', 'category');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (8, 'shop', 'brand');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (9, 'shop', 'product');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (10, 'shop', 'customer');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (11, 'shop', 'address');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (12, 'shop', 'cartitem');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (13, 'shop', 'discountcode');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (14, 'shop', 'order');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (15, 'shop', 'orderitem');
INSERT INTO public.django_content_type (id, app_label, model) VALUES (16, 'shop', 'payment');


--
-- TOC entry 5007 (class 0 OID 18645)
-- Dependencies: 222
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (25, 'Can add category', 7, 'add_category');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (26, 'Can change category', 7, 'change_category');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (27, 'Can delete category', 7, 'delete_category');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (28, 'Can view category', 7, 'view_category');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (29, 'Can add brand', 8, 'add_brand');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (30, 'Can change brand', 8, 'change_brand');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (31, 'Can delete brand', 8, 'delete_brand');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (32, 'Can view brand', 8, 'view_brand');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (33, 'Can add product', 9, 'add_product');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (34, 'Can change product', 9, 'change_product');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (35, 'Can delete product', 9, 'delete_product');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (36, 'Can view product', 9, 'view_product');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (37, 'Can add customer', 10, 'add_customer');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (38, 'Can change customer', 10, 'change_customer');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (39, 'Can delete customer', 10, 'delete_customer');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (40, 'Can view customer', 10, 'view_customer');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (41, 'Can add address', 11, 'add_address');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (42, 'Can change address', 11, 'change_address');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (43, 'Can delete address', 11, 'delete_address');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (44, 'Can view address', 11, 'view_address');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (45, 'Can add cart item', 12, 'add_cartitem');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (46, 'Can change cart item', 12, 'change_cartitem');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (47, 'Can delete cart item', 12, 'delete_cartitem');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (48, 'Can view cart item', 12, 'view_cartitem');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (49, 'Can add discount code', 13, 'add_discountcode');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (50, 'Can change discount code', 13, 'change_discountcode');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (51, 'Can delete discount code', 13, 'delete_discountcode');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (52, 'Can view discount code', 13, 'view_discountcode');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (53, 'Can add order', 14, 'add_order');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (54, 'Can change order', 14, 'change_order');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (55, 'Can delete order', 14, 'delete_order');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (56, 'Can view order', 14, 'view_order');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (57, 'Can add order item', 15, 'add_orderitem');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (58, 'Can change order item', 15, 'change_orderitem');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (59, 'Can delete order item', 15, 'delete_orderitem');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (60, 'Can view order item', 15, 'view_orderitem');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (61, 'Can add payment', 16, 'add_payment');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (62, 'Can change payment', 16, 'change_payment');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (63, 'Can delete payment', 16, 'delete_payment');
INSERT INTO public.auth_permission (id, name, content_type_id, codename) VALUES (64, 'Can view payment', 16, 'view_payment');


--
-- TOC entry 5011 (class 0 OID 18659)
-- Dependencies: 226
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (1, 1, 64);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (2, 1, 38);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (3, 1, 40);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (4, 1, 41);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (5, 1, 42);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (6, 1, 43);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (7, 1, 44);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (8, 1, 45);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (9, 1, 48);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (12, 1, 56);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (13, 1, 61);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (16, 2, 25);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (17, 2, 26);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (18, 2, 27);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (19, 2, 28);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (20, 2, 29);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (21, 2, 30);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (22, 2, 31);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (23, 2, 32);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (24, 2, 33);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (25, 2, 34);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (26, 2, 35);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (27, 2, 36);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (28, 2, 40);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (29, 2, 44);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (34, 2, 50);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (35, 2, 52);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (36, 2, 53);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (37, 2, 54);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (38, 2, 55);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (39, 2, 56);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (40, 2, 60);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (41, 1, 14);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (42, 1, 46);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (43, 2, 64);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (44, 2, 49);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (45, 2, 51);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (46, 2, 62);
INSERT INTO public.auth_group_permissions (id, group_id, permission_id) VALUES (47, 1, 53);


--
-- TOC entry 5013 (class 0 OID 18665)
-- Dependencies: 228
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (4, 'pbkdf2_sha256$1000000$9R4F8SXKWsMqRCAaiJ3Brq$sCOANgVr9HTkiXYolzbcPjOp3xU1A+MGTm4JqyBKc2U=', '2025-10-14 22:33:06.255056+07', false, 'test', 'test', 'test', 'test@gamil.com', false, true, '2025-10-14 22:33:04.887271+07');
INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (2, 'pbkdf2_sha256$1000000$MXT9SHs7Oal1kvDGbT3P2F$O0hckebjMuTtfF+6/lEzgEnjDwVVXeeAhwEifnQR2UM=', '2025-10-15 01:45:42.125335+07', false, 'bob', 'Bob', 'Tan', 'bob@example.com', false, true, '2025-10-14 22:30:40.40209+07');
INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (3, 'pbkdf2_sha256$1000000$MXT9SHs7Oal1kvDGbT3P2F$O0hckebjMuTtfF+6/lEzgEnjDwVVXeeAhwEifnQR2UM=', '2025-10-15 01:46:37.957233+07', false, 'charlie', 'Charlie', 'Ng', 'charlie@example.com', false, true, '2025-10-14 22:30:40.40209+07');
INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (7, 'pbkdf2_sha256$1000000$NeSLU6bhaWRxEONbbaE4jA$a08tRzqXnJfxVyixONiVj6hcrTyye4No8eiagKGote0=', NULL, false, 'admin2', '', '', '', false, true, '2025-10-14 22:53:14+07');
INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (6, 'pbkdf2_sha256$1000000$XKlloxYr2GCM1EZmYexBuS$1LCo8Ed37uSfyZ/2O1CJJmLIrteaMAo6fwokcsy0760=', '2025-10-15 01:47:13.555709+07', false, 'admin1', '', '', '', false, true, '2025-10-14 22:52:46+07');
INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (5, 'pbkdf2_sha256$1000000$FrI1GYtxvkNsM15FE5tA3r$7wRkedKS1qXM8kT+RfETy4dAixds5oYB4QQ+yuS9piU=', '2025-10-15 00:47:26.674943+07', true, 'superadmin', '', '', 'admin@mail.com', true, true, '2025-10-14 22:35:39.785011+07');
INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (8, 'pbkdf2_sha256$1000000$ZXJEdz9YraPqYU05mtNljH$OWW8DLQOLWhvEeRvTjbWCKs7QwpaJE8VBytRIw7OLms=', '2025-10-15 01:31:04.021576+07', false, 'somchai', 'somchai', 'somsom', 'somchai@mail.com', false, true, '2025-10-15 00:40:59.286206+07');
INSERT INTO public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) VALUES (1, 'pbkdf2_sha256$1000000$MXT9SHs7Oal1kvDGbT3P2F$O0hckebjMuTtfF+6/lEzgEnjDwVVXeeAhwEifnQR2UM=', '2025-10-15 01:45:12.500724+07', false, 'alice', 'Alice', 'Wong', 'alice@example.com', false, true, '2025-10-14 22:30:40.40209+07');


--
-- TOC entry 5015 (class 0 OID 18673)
-- Dependencies: 230
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auth_user_groups (id, user_id, group_id) VALUES (1, 1, 1);
INSERT INTO public.auth_user_groups (id, user_id, group_id) VALUES (2, 2, 1);
INSERT INTO public.auth_user_groups (id, user_id, group_id) VALUES (3, 3, 1);
INSERT INTO public.auth_user_groups (id, user_id, group_id) VALUES (7, 4, 1);
INSERT INTO public.auth_user_groups (id, user_id, group_id) VALUES (8, 6, 2);
INSERT INTO public.auth_user_groups (id, user_id, group_id) VALUES (9, 7, 2);
INSERT INTO public.auth_user_groups (id, user_id, group_id) VALUES (10, 8, 1);


--
-- TOC entry 5017 (class 0 OID 18679)
-- Dependencies: 232
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5019 (class 0 OID 18737)
-- Dependencies: 234
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (1, '2025-10-14 22:36:49.633674+07', '1', 'customer', 2, '[{"changed": {"fields": ["Permissions"]}}]', 3, 5);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (2, '2025-10-14 22:52:47.139299+07', '6', 'admin1', 1, '[{"added": {}}]', 4, 5);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (3, '2025-10-14 22:53:03.197444+07', '6', 'admin1', 2, '[{"changed": {"fields": ["Groups"]}}]', 4, 5);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (4, '2025-10-14 22:53:15.822147+07', '7', 'admin2', 1, '[{"added": {}}]', 4, 5);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (5, '2025-10-14 22:53:23.887134+07', '7', 'admin2', 2, '[{"changed": {"fields": ["Groups"]}}]', 4, 5);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (6, '2025-10-14 23:01:00.006631+07', '2', 'admin', 2, '[{"changed": {"fields": ["Permissions"]}}]', 3, 5);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (7, '2025-10-14 23:06:12.016338+07', '1', 'customer', 2, '[{"changed": {"fields": ["Permissions"]}}]', 3, 5);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (8, '2025-10-15 00:48:51.25364+07', '1', 'customer', 2, '[{"changed": {"fields": ["Permissions"]}}]', 3, 5);
INSERT INTO public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) VALUES (9, '2025-10-15 00:49:42.466725+07', '1', 'customer', 2, '[]', 3, 5);


--
-- TOC entry 5003 (class 0 OID 18629)
-- Dependencies: 218
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_migrations (id, app, name, applied) VALUES (1, 'contenttypes', '0001_initial', '2025-09-28 21:50:38.883362+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (2, 'auth', '0001_initial', '2025-09-28 21:50:39.636576+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (3, 'admin', '0001_initial', '2025-09-28 21:50:39.958428+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2025-09-28 21:50:39.966676+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2025-09-28 21:50:39.976126+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2025-09-28 21:50:40.097718+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2025-09-28 21:50:40.106011+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (8, 'auth', '0003_alter_user_email_max_length', '2025-09-28 21:50:40.114247+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (9, 'auth', '0004_alter_user_username_opts', '2025-09-28 21:50:40.122644+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (10, 'auth', '0005_alter_user_last_login_null', '2025-09-28 21:50:40.133138+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (11, 'auth', '0006_require_contenttypes_0002', '2025-09-28 21:50:40.134873+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2025-09-28 21:50:40.142906+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (13, 'auth', '0008_alter_user_username_max_length', '2025-09-28 21:50:40.239078+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2025-09-28 21:50:40.247139+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (15, 'auth', '0010_alter_group_name_max_length', '2025-09-28 21:50:40.277464+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (16, 'auth', '0011_update_proxy_permissions', '2025-09-28 21:50:40.285305+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2025-09-28 21:50:40.294929+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (18, 'sessions', '0001_initial', '2025-09-28 21:50:40.357663+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (19, 'shop', '0001_initial', '2025-09-28 21:50:41.070746+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (20, 'shop', '0002_alter_brand_name_alter_category_name_and_more', '2025-10-13 17:01:26.204263+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (21, 'shop', '0003_order_total_price_alter_address_phone_and_more', '2025-10-13 17:02:45.787541+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (22, 'shop', '0004_rename_cutomer_order_customer_and_more', '2025-10-13 17:38:36.506799+07');
INSERT INTO public.django_migrations (id, app, name, applied) VALUES (23, 'shop', '0005_rename_dicount_price_orderitem_discount_price', '2025-10-13 17:40:12.100802+07');


--
-- TOC entry 5020 (class 0 OID 18765)
-- Dependencies: 235
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.django_session (session_key, session_data, expire_date) VALUES ('t72w8aq7dzf2y3k99npkd4ddltwk48mi', '.eJxVjDsOwjAQBe_iGlnJ-rOYkp4zWHZ2lwSQLcVJhbg7iZQC2jcz761iWpcxro3nOJG6KK9Ov1tOw5PLDuiRyr3qoZZlnrLeFX3Qpm-V-HU93L-DMbVxqzv2PWThszWO0EMOFoJz0rGQ9GgDCoMHYPL9YDzZDjeUMAuaIGDU5wvblTe6:1v8k3F:LfsiIAwFXjbq_epSRLQAPDudoTEgojDMQDwWUHFdFp0', '2025-10-29 01:47:13.566781+07');


--
-- TOC entry 5028 (class 0 OID 18798)
-- Dependencies: 243
-- Data for Name: shop_customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_customer (id, phone, image, user_id) VALUES (4, NULL, '', 4);
INSERT INTO public.shop_customer (id, phone, image, user_id) VALUES (5, '0991234121', 'customer_images/monkaHmm.png', 8);
INSERT INTO public.shop_customer (id, phone, image, user_id) VALUES (1, '0811111111', 'customer_images/AYAYA.png', 1);
INSERT INTO public.shop_customer (id, phone, image, user_id) VALUES (2, '0822222222', 'customer_images/monkas.png', 2);
INSERT INTO public.shop_customer (id, phone, image, user_id) VALUES (3, '0833333333', 'customer_images/KEKW_hesEEXg.png', 3);


--
-- TOC entry 5030 (class 0 OID 18806)
-- Dependencies: 245
-- Data for Name: shop_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_address (id, full_name, phone, address, district, sub_district, province, postal_code, customer_id) VALUES (1, 'Alice Wong', '0811111111', '123/4 หมู่ 5', 'เมืองเชียงใหม่', 'ช้างคลาน', 'เชียงใหม่', '50000', 1);
INSERT INTO public.shop_address (id, full_name, phone, address, district, sub_district, province, postal_code, customer_id) VALUES (2, 'Bob Tan', '0822222222', '88/9 ซอยสุขสวัสดิ์', 'ห้วยขวาง', 'บางกะปิ', 'กรุงเทพฯ', '10310', 2);
INSERT INTO public.shop_address (id, full_name, phone, address, district, sub_district, province, postal_code, customer_id) VALUES (3, 'Charlie Ng', '0833333333', '55/2 หมู่บ้านศิริวรรณ', 'บางพลี', 'เทพารักษ์', 'สมุทรปราการ', '10540', 3);
INSERT INTO public.shop_address (id, full_name, phone, address, district, sub_district, province, postal_code, customer_id) VALUES (4, 'somchai somsom', '0991112323', '123/42 หมู่บ้านาน่า หมู่8 ซอยซอส ถนนถนอม', 'เมือง', 'ดอกไม้', 'สมุครสาคร', '10233', 5);


--
-- TOC entry 5022 (class 0 OID 18775)
-- Dependencies: 237
-- Data for Name: shop_brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_brand (id, name, description) VALUES (1, 'Apple', 'ผลิตภัณฑ์จาก Apple');
INSERT INTO public.shop_brand (id, name, description) VALUES (2, 'Samsung', 'ผลิตภัณฑ์จาก Samsung');
INSERT INTO public.shop_brand (id, name, description) VALUES (3, 'Asus', 'ผลิตภัณฑ์จาก Asus');
INSERT INTO public.shop_brand (id, name, description) VALUES (4, 'Lenovo', 'ผลิตภัณฑ์จาก Lenovo');
INSERT INTO public.shop_brand (id, name, description) VALUES (5, 'Sony', 'ผลิตภัณฑ์จาก Sony');
INSERT INTO public.shop_brand (id, name, description) VALUES (6, 'Xiaomi', 'อุปกรณ์ไอทีราคาคุ้มค่า');
INSERT INTO public.shop_brand (id, name, description) VALUES (7, 'Dell', 'แบรนด์โน้ตบุ๊กชั้นนำ');


--
-- TOC entry 5024 (class 0 OID 18783)
-- Dependencies: 239
-- Data for Name: shop_category; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_category (id, name, description) VALUES (1, 'Smartphone', 'มือถือและอุปกรณ์สื่อสาร');
INSERT INTO public.shop_category (id, name, description) VALUES (2, 'Laptop', 'โน้ตบุ๊กสำหรับทำงานและเล่นเกม');
INSERT INTO public.shop_category (id, name, description) VALUES (3, 'Tablet', 'แท็บเล็ตสำหรับเรียนและทำงาน');
INSERT INTO public.shop_category (id, name, description) VALUES (4, 'Accessories', 'อุปกรณ์เสริมคอมพิวเตอร์');
INSERT INTO public.shop_category (id, name, description) VALUES (5, 'Audio', 'หูฟังและลำโพง');


--
-- TOC entry 5036 (class 0 OID 18834)
-- Dependencies: 251
-- Data for Name: shop_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (21, 'iPhone 17 Pro Max', 'ที่สุดแห่งสมาร์ตโฟนจาก Apple มาพร้อมชิป A19 Bionic ที่เร็วแรงยิ่งขึ้น จอ Super Retina XDR Pro ขนาดใหญ่ แสดงผลคมชัดทุกมุมมอง กล้องระดับโปรใหม่ล่าสุด พร้อมระบบ AI ถ่ายภาพล้ำสมัย แบตเตอรี่ใช้งานได้นานตลอดวัน ดีไซน์หรูหรา แข็งแกร่ง ด้วยวัสดุไทเทเนียมรุ่นใหม่', 43900.00, 4, 'product_images/iphone_17_Pro_Max_3.png', 'NONE', 0.00, true, 1, 1);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (1, 'iPhone 15 Pro', 'เบากว่า เร็วกว่า และล้ำหน้ากว่าที่เคย ด้วยดีไซน์ใหม่จากไทเทเนียม แข็งแกร่งแต่เบา ชิป A17 Pro ทรงพลังสำหรับประสบการณ์เล่นเกมและการใช้งานระดับโปร กล้องใหม่ถ่ายภาพได้สวยคมในทุกสภาพแสง พร้อมพอร์ต USB-C ที่ให้การโอนถ่ายข้อมูลเร็วเหนือชั้น', 45900.00, 20, 'product_images/iPhone-15-Pro-Max--Blue-Titanium.png', 'PERCENT', 10.00, true, 1, 1);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (2, 'iPhone 14', 'สมาร์ตโฟนที่พร้อมสำหรับทุกวัน มาพร้อมกล้องคู่ความละเอียดสูง ถ่ายภาพและวิดีโอได้อย่างสวยงามในทุกแสง ชิป A15 Bionic ให้การใช้งานลื่นไหล แบตเตอรี่ใช้งานได้ยาวนาน และฟีเจือนความปลอดภัยใหม่อย่าง Crash Detection ที่ช่วยเพิ่มความอุ่นใจในทุกการเดินทาง', 35900.00, 10, 'product_images/iPhone_14_Blue-square_medium.png', 'FIXED', 2000.00, true, 1, 1);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (3, 'Samsung Galaxy S24 Ultra', 'ที่สุดของสมาร์ตโฟนสายพรีเมียม มาพร้อมปากกา S Pen ในตัว จอ AMOLED 6.8" คมชัดระดับ QHD+ รีเฟรชเรต 120Hz ชิป Snapdragon 8 Gen 3 เร็วแรงประหยัดพลังงาน กล้องหลัก 200MP ถ่ายภาพได้คมชัดทั้งกลางวันและกลางคืน พร้อมฟีเจอร์ AI อัจฉริยะ ยกระดับการใช้งานทุกมิติ', 42900.00, 15, 'product_images/Samsung--Galaxy-S24-ULTRA--TITANIUM-5G-3-square_medium.jpg', 'PERCENT', 8.00, true, 2, 1);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (4, 'Xiaomi 14', 'สมาร์ตโฟนเรือธงดีไซน์พรีเมียม มาพร้อมกล้อง Leica คุณภาพระดับมืออาชีพ ชิป Snapdragon 8 Gen 3 ทรงพลัง หน้าจอ AMOLED 6.36" ความละเอียดสูง รีเฟรชเรต 120Hz ลื่นไหลทุกการใช้งาน รองรับการชาร์จไวทั้งแบบสายและไร้สาย ครบเครื่องทั้งความแรงและสไตล์ในเครื่องเดียว', 27900.00, 25, 'product_images/Xiaomi-14-Pro-Green.jpg', 'PERCENT', 5.00, true, 6, 1);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (5, 'Redmi Note 13 Pro', 'สมาร์ตโฟนสุดคุ้ม สเปกจัดเต็ม มาพร้อมกล้องความละเอียด 200MP ถ่ายชัดทุกช็อต หน้าจอ AMOLED ขนาดใหญ่ 6.67" รีเฟรชเรต 120Hz แสดงผลลื่นไหล ชิป Snapdragon ประสิทธิภาพสูง ใช้งานได้ลื่นทั้งวัน แบตใหญ่ 5,000mAh รองรับชาร์จไว 67W ตอบโจทย์ทั้งการทำงานและความบันเทิง', 12900.00, 50, 'product_images/Redmi-Note-13-Pro-White.jpg', 'NONE', 0.00, true, 6, 1);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (10, 'iPad Air (M2)', 'แท็บเล็ตทรงพลังด้วยชิป M2 ที่เร็วแรง พร้อมหน้าจอ Liquid Retina ขนาด 10.9 นิ้ว สีสันสดใสและคมชัด รองรับ Apple Pencil รุ่นที่ 2 เหมาะสำหรับงานสร้างสรรค์และความบันเทิง แบตเตอรี่ใช้งานได้นานตลอดวัน ดีไซน์บางเบาพกพาสะดวก', 28900.00, 15, 'product_images/iPad-Air-11-inch-M2-Cellular-Blue-2-square_medium.jpg', 'PERCENT', 5.00, true, 1, 3);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (19, 'Dell Wireless Mouse', 'เมาส์ไร้สายดีไซน์ทันสมัย ใช้งานง่าย เชื่อมต่อผ่าน Bluetooth หรือ USB ตัวเครื่องขนาดกะทัดรัด รองรับการใช้งานทั้งงานทั่วไปและเล่นเกม แบตเตอรี่อึด ใช้งานได้ยาวนาน พกพาสะดวก เหมาะกับทุกไลฟ์สไตล์', 790.00, 98, 'product_images/WM126_B-new.jpg', 'PERCENT', 5.00, true, 7, 4);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (6, 'Asus TUF Gaming F15', 'โน้ตบุ๊กเกมมิ่งสุดแกร่ง ดีไซน์ดุดัน มาพร้อมขุมพลัง Intel Core เจนล่าสุด และกราฟิกการ์ด NVIDIA GeForce RTX เล่นเกมลื่นไหลทุกแนว หน้าจอ 144Hz ตอบสนองไว พร้อมระบบระบายความร้อนประสิทธิภาพสูง รองรับการใช้งานหนักได้ต่อเนื่อง โครงสร้างแข็งแรงตามมาตรฐาน MIL-STD-810H', 32900.00, 9, 'product_images/notebook_11056_20210603-152649_c.webp', 'FIXED', 1000.00, true, 3, 2);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (7, 'Asus ZenBook 14', 'โน้ตบุ๊กบางเบาพรีเมียม เหมาะสำหรับคนทำงานที่ต้องการความคล่องตัว มาพร้อมหน้าจอ 14” ความละเอียดสูง ชิปประมวลผล Intel Core เจนล่าสุด ใช้งานลื่นไหลทั้งงานเอกสารและมัลติทาสก์ แบตเตอรี่อึด ใช้งานได้นานทั้งวัน ดีไซน์เรียบหรู ตัวเครื่องบางเฉียบ พกพาสะดวกทุกที่', 39900.00, 8, 'product_images/zenbook.png', 'PERCENT', 5.00, true, 3, 2);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (9, 'Lenovo IdeaPad 5', 'โน้ตบุ๊กสายทำงานที่ครบเครื่อง มาพร้อมประสิทธิภาพสูงด้วยชิป Intel หรือ AMD รุ่นใหม่ หน้าจอขนาด 14” หรือ 15.6” คมชัด สีสวยสด ใช้งานได้ลื่นไหลทั้งงานเอกสารและความบันเทิง แบตเตอรี่อึด พร้อมดีไซน์บางเบา พกพาสะดวก เหมาะกับคนที่ต้องการโน้ตบุ๊กที่ใช้งานได้ทุกวัน', 24900.00, 12, 'product_images/Lenovo-Notebook-IdeaPad-Slim-5-01-square_medium.jpg', 'NONE', 0.00, true, 4, 2);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (11, 'Galaxy Tab S9', 'แท็บเล็ตเรือธงจาก Samsung มาพร้อมจอ Dynamic AMOLED 2X ขนาด 11 นิ้ว สีสันสดใส คมชัดสุด ๆ ชิป Snapdragon 8 Gen 2 ประมวลผลแรง รองรับ S Pen สำหรับงานเขียนและวาดภาพได้อย่างลื่นไหล แบตเตอรี่ใช้งานได้ยาวนาน เหมาะทั้งงานสร้างสรรค์และความบันเทิงเต็มรูปแบบ', 29900.00, 10, 'product_images/Samsung-Galaxy-Tab-S9-Graphite.jpg', 'PERCENT', 8.00, true, 2, 3);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (12, 'Xiaomi Pad 6', 'แท็บเล็ตสเปกคุ้มค่า หน้าจอ 11 นิ้ว AMOLED ความละเอียดสูง สีสวยสดใส พร้อมชิป Snapdragon 8+ Gen 1 ประมวลผลแรง ใช้งานได้ลื่นไหล รองรับปากกา Stylus เหมาะสำหรับงานเรียน งานสร้างสรรค์ และความบันเทิงครบครัน แบตเตอรี่ใช้งานได้ยาวนาน', 13900.00, 20, 'product_images/xiaomi_pad_6_28.png', 'NONE', 0.00, true, 6, 3);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (13, 'Mi Power Bank 10000mAh', 'พาวเวอร์แบงค์ขนาดกะทัดรัด ความจุ 10,000mAh ชาร์จได้รวดเร็ว รองรับการชาร์จอุปกรณ์หลากหลายทั้งสมาร์ตโฟนและแท็บเล็ต ดีไซน์เรียบง่าย พกพาสะดวก เหมาะสำหรับคนที่ต้องการพลังงานสำรองไว้ใช้งานนอกบ้าน', 990.00, 100, 'product_images/41c032dd4c430380d74bd99902d8b1ef.png', 'FIXED', 100.00, true, 6, 4);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (14, 'Mi Smart Band 8', 'สายรัดข้อมืออัจฉริยะรุ่นล่าสุด จอ AMOLED สีสันสดใส ขนาดใหญ่ขึ้น รองรับการติดตามสุขภาพและกิจกรรมครบถ้วน ทั้งการนับก้าว วัดอัตราการเต้นหัวใจ และตรวจจับการนอนหลับ กันน้ำลึกสูงสุด 50 เมตร แบตเตอรี่อึดใช้งานได้หลายวัน พร้อมดีไซน์เบา สวมใส่สบาย', 1590.00, 80, 'product_images/07102023_20231100014-01_1.png', 'PERCENT', 10.00, true, 6, 4);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (16, 'Sony WH-1000XM5', 'หูฟังครอบหูไร้สายระดับพรีเมียม ระบบตัดเสียงรบกวนขั้นสูง (Noise Cancelling) ให้เสียงคมชัดสมจริง เบสลึกเต็มอารมณ์ สวมใส่สบายด้วยดีไซน์น้ำหนักเบา แบตเตอรี่ใช้งานได้นานถึง 30 ชั่วโมง พร้อมฟีเจอร์ชาร์จไวและเชื่อมต่อ Bluetooth เสถียร เหมาะสำหรับฟังเพลงและทำงานในทุกสถานการณ์', 13990.00, 25, 'product_images/WH-1000XM5_keyvisual_smokypink-Large_22fd4a3a-796e-4dbd-b985-76d5614ef106_600x.webp', 'PERCENT', 15.00, true, 5, 5);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (18, 'Galaxy Buds3 Pro', 'หูฟังไร้สายระดับพรีเมียมจาก Samsung มาพร้อมระบบตัดเสียงรบกวน ANC คุณภาพสูง เสียงสมจริง เบสแน่น ควบคุมง่ายผ่านระบบสัมผัส ดีไซน์กระชับสบาย พร้อมกันน้ำระดับ IPX7 ใช้งานได้ยาวนานตลอดวัน เหมาะสำหรับคนรักเสียงเพลงและชีวิตแอคทีฟ', 6990.00, 35, 'product_images/th-galaxy-buds3-pro-r630-sm-r630nzaaasa-thumb-542137124.webp', 'NONE', 0.00, true, 2, 5);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (20, 'Lenovo Keyboard', 'คีย์บอร์ดคุณภาพสูง ดีไซน์เรียบง่าย ทนทาน รองรับการพิมพ์ได้อย่างแม่นยำและรวดเร็ว เชื่อมต่อได้ทั้งแบบมีสายและไร้สาย เหมาะสำหรับงานสำนักงานและการใช้งานทั่วไป เพิ่มประสิทธิภาพการทำงานด้วยความสะดวกสบายในการพิมพ์', 690.00, 60, 'product_images/26897309786_00_202412200312191735728572662.webp', 'NONE', 0.00, true, 4, 4);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (15, 'Sony WF-1000XM5', 'หูฟังไร้สายระดับพรีเมียม มาพร้อมระบบตัดเสียงรบกวนอัจฉริยะ (Noise Cancelling) คุณภาพสูง เสียงคมชัด เบสลึก ควบคุมง่ายผ่านระบบสัมผัส ดีไซน์เล็กกระทัดรัด สวมใส่สบายตลอดวัน แบตเตอรี่ใช้งานได้นาน พร้อมเคสชาร์จที่ชาร์จไว', 9990.00, 30, 'product_images/HDPH-SN1-WF1000XM5B_6_241102_145849.jpeg', 'FIXED', 500.00, true, 5, 5);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (17, 'AirPods Pro 2', 'หูฟังไร้สายระดับพรีเมียม มาพร้อมระบบตัดเสียงรบกวน Active Noise Cancellation คุณภาพสูง เสียงใสคมชัด เบสทรงพลัง ดีไซน์กระชับสบาย ใช้งานง่ายด้วยชิป H2 รองรับฟีเจอร์เสียงรอบทิศทาง Spatial Audio แบตเตอรี่ใช้งานได้นาน พร้อมเคสชาร์จไร้สาย', 8990.00, 39, 'product_images/AirPods_Pro_2nd_Gen_with_USB-C_PDP_Image_Position-1__global.webp', 'FIXED', 500.00, true, 1, 5);
INSERT INTO public.shop_product (id, name, description, price, stock, image, discount_type, discount_value, is_active, brand_id, category_id) VALUES (8, 'Dell XPS 13', 'โน้ตบุ๊กระดับพรีเมียม ดีไซน์บางเฉียบ วัสดุอลูมิเนียมสุดหรู มาพร้อมหน้าจอขอบบาง InfinityEdge ให้ภาพสวยคมชัดเต็มตา ขับเคลื่อนด้วยชิป Intel Core เจนล่าสุด ประสิทธิภาพสูง ใช้งานลื่นไหลทั้งงานและความบันเทิง แบตเตอรี่อึด พกพาสะดวก เหมาะสำหรับมืออาชีพที่ต้องการความลงตัวระหว่างดีไซน์และพลัง', 45900.00, 2, 'product_images/13466-2.webp', 'PERCENT', 10.00, true, 7, 2);


--
-- TOC entry 5042 (class 0 OID 18860)
-- Dependencies: 257
-- Data for Name: shop_cartitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_cartitem (id, quantity, customer_id, product_id) VALUES (1, 2, 1, 5);
INSERT INTO public.shop_cartitem (id, quantity, customer_id, product_id) VALUES (2, 1, 2, 16);
INSERT INTO public.shop_cartitem (id, quantity, customer_id, product_id) VALUES (3, 1, 3, 10);


--
-- TOC entry 5040 (class 0 OID 18854)
-- Dependencies: 255
-- Data for Name: shop_customer_wishlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_customer_wishlist (id, customer_id, product_id) VALUES (1, 1, 7);
INSERT INTO public.shop_customer_wishlist (id, customer_id, product_id) VALUES (2, 5, 17);


--
-- TOC entry 5026 (class 0 OID 18791)
-- Dependencies: 241
-- Data for Name: shop_discountcode; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_discountcode (id, code, code_type, value, start_date, end_date, is_active, min_order_amount, max_discount_amount, usage_count) VALUES (2, 'SAVE500', 'FIXED', 500.00, '2025-10-14 22:30:40.40209+07', '2025-11-13 22:30:40.40209+07', true, 2000.00, NULL, 1);
INSERT INTO public.shop_discountcode (id, code, code_type, value, start_date, end_date, is_active, min_order_amount, max_discount_amount, usage_count) VALUES (3, 'OCTSALE', 'PERCENT', 15.00, '2025-10-14 22:30:40.40209+07', '2025-10-29 22:30:40.40209+07', true, 3000.00, 2000.00, 1);
INSERT INTO public.shop_discountcode (id, code, code_type, value, start_date, end_date, is_active, min_order_amount, max_discount_amount, usage_count) VALUES (1, 'WELCOME10', 'PERCENT', 10.00, '2025-10-14 22:30:40.40209+07', '2025-11-13 22:30:40.40209+07', true, 1000.00, 1000.00, 2);


--
-- TOC entry 5032 (class 0 OID 18814)
-- Dependencies: 247
-- Data for Name: shop_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_order (id, discount_amount, shipping_address, order_date, status, customer_id, discount_code_id, total_price) VALUES (3, 2085.00, '55/2 หมู่บ้านศิริวรรณ, บางพลี, สมุทรปราการ 10540', '2025-10-14 22:30:40.40209+07', 'DELIVERED', 3, 3, 13900.00);
INSERT INTO public.shop_order (id, discount_amount, shipping_address, order_date, status, customer_id, discount_code_id, total_price) VALUES (2, 500.00, '88/9 ซอยสุขสวัสดิ์, บางกะปิ, กรุงเทพฯ 10310', '2025-10-14 22:30:40.40209+07', 'PENDING', 2, 2, 78000.00);
INSERT INTO public.shop_order (id, discount_amount, shipping_address, order_date, status, customer_id, discount_code_id, total_price) VALUES (5, 0.00, 'somchai somsom (0991112323) - 123/42 หมู่บ้านาน่า หมู่8 ซอยซอส ถนนถนอม, ดอกไม้, เมือง, สมุครสาคร, 10233', '2025-10-15 01:44:38.880942+07', 'PENDING', 5, NULL, 40390.00);
INSERT INTO public.shop_order (id, discount_amount, shipping_address, order_date, status, customer_id, discount_code_id, total_price) VALUES (4, 150.10, 'somchai somsom (0991112323) - 123/42 หมู่บ้านาน่า หมู่8 ซอยซอส ถนนถนอม, ดอกไม้, เมือง, สมุครสาคร, 10233', '2025-10-15 01:43:05.102465+07', 'CANCELLED', 5, 1, 1501.00);
INSERT INTO public.shop_order (id, discount_amount, shipping_address, order_date, status, customer_id, discount_code_id, total_price) VALUES (1, 4500.00, '123/4 หมู่ 5, ช้างคลาน, เมืองเชียงใหม่, เชียงใหม่ 50000', '2025-10-14 22:30:40.40209+07', 'SHIPPING', 1, 1, 45000.00);


--
-- TOC entry 5038 (class 0 OID 18843)
-- Dependencies: 253
-- Data for Name: shop_orderitem; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_orderitem (id, quantity, unit_price, discount_price, order_id, product_id) VALUES (1, 1, 45900.00, 41310.00, 1, 1);
INSERT INTO public.shop_orderitem (id, quantity, unit_price, discount_price, order_id, product_id) VALUES (2, 2, 32900.00, 65300.00, 2, 6);
INSERT INTO public.shop_orderitem (id, quantity, unit_price, discount_price, order_id, product_id) VALUES (3, 1, 13900.00, 11815.00, 3, 12);
INSERT INTO public.shop_orderitem (id, quantity, unit_price, discount_price, order_id, product_id) VALUES (4, 2, 790.00, 39.50, 4, 19);
INSERT INTO public.shop_orderitem (id, quantity, unit_price, discount_price, order_id, product_id) VALUES (5, 1, 32900.00, 1000.00, 5, 6);
INSERT INTO public.shop_orderitem (id, quantity, unit_price, discount_price, order_id, product_id) VALUES (6, 1, 8990.00, 500.00, 5, 17);


--
-- TOC entry 5034 (class 0 OID 18826)
-- Dependencies: 249
-- Data for Name: shop_payment; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.shop_payment (id, payment_date, amount, slip_image, status, order_id) VALUES (1, '2025-10-14 22:30:40.40209+07', 41310.00, 'slip_images/1107056.jpg', 'VERIFIED', 1);
INSERT INTO public.shop_payment (id, payment_date, amount, slip_image, status, order_id) VALUES (2, '2025-10-14 22:30:40.40209+07', 65300.00, 'slip_images/1107056.jpg', 'PENDING', 2);
INSERT INTO public.shop_payment (id, payment_date, amount, slip_image, status, order_id) VALUES (3, '2025-10-14 22:30:40.40209+07', 11815.00, 'slip_images/1107056.jpg', 'VERIFIED', 3);
INSERT INTO public.shop_payment (id, payment_date, amount, slip_image, status, order_id) VALUES (4, '2025-10-15 01:43:00+07', 1350.90, 'slip_images/ba154685-db18-4ac7-b318-a4a2b15b9d4c_LqgIMDz.jpg', 'REJECTED', 4);


--
-- TOC entry 5048 (class 0 OID 0)
-- Dependencies: 223
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 2, true);


--
-- TOC entry 5049 (class 0 OID 0)
-- Dependencies: 225
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 47, true);


--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 221
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 64, true);


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 229
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 10, true);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 227
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 8, true);


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 231
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- TOC entry 5054 (class 0 OID 0)
-- Dependencies: 233
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 9, true);


--
-- TOC entry 5055 (class 0 OID 0)
-- Dependencies: 219
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 16, true);


--
-- TOC entry 5056 (class 0 OID 0)
-- Dependencies: 217
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 23, true);


--
-- TOC entry 5057 (class 0 OID 0)
-- Dependencies: 244
-- Name: shop_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_address_id_seq', 4, true);


--
-- TOC entry 5058 (class 0 OID 0)
-- Dependencies: 236
-- Name: shop_brand_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_brand_id_seq', 7, true);


--
-- TOC entry 5059 (class 0 OID 0)
-- Dependencies: 256
-- Name: shop_cartitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_cartitem_id_seq', 6, true);


--
-- TOC entry 5060 (class 0 OID 0)
-- Dependencies: 238
-- Name: shop_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_category_id_seq', 6, true);


--
-- TOC entry 5061 (class 0 OID 0)
-- Dependencies: 242
-- Name: shop_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_customer_id_seq', 5, true);


--
-- TOC entry 5062 (class 0 OID 0)
-- Dependencies: 254
-- Name: shop_customer_wishlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_customer_wishlist_id_seq', 2, true);


--
-- TOC entry 5063 (class 0 OID 0)
-- Dependencies: 240
-- Name: shop_discountcode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_discountcode_id_seq', 3, true);


--
-- TOC entry 5064 (class 0 OID 0)
-- Dependencies: 246
-- Name: shop_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_order_id_seq', 5, true);


--
-- TOC entry 5065 (class 0 OID 0)
-- Dependencies: 252
-- Name: shop_orderitem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_orderitem_id_seq', 6, true);


--
-- TOC entry 5066 (class 0 OID 0)
-- Dependencies: 248
-- Name: shop_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_payment_id_seq', 4, true);


--
-- TOC entry 5067 (class 0 OID 0)
-- Dependencies: 250
-- Name: shop_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shop_product_id_seq', 21, true);


-- Completed on 2025-10-15 01:52:38

--
-- PostgreSQL database dump complete
--

