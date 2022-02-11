-- Popolamento della tabella "assets" per gli ambienti di DEV e di TEST
-- cfr. Triplette_REMEDY-asset_id_CRM_v02.xlsx

INSERT INTO "zammad"."assets"
(id, asset_type, name, created_at, updated_at)
VALUES
(31, 'sw', 'Il mio medico - Scelta e revoca rivolta al cittadino', NOW(), NOW()),
(27, 'sw', 'AUTOCERTIFICAZIONE ESENZIONE PER REDDITO CITTADINI', NOW(), NOW()),
(24, 'sw', 'GESTIONE VACCINAZIONI CITTADINO', NOW(), NOW()),
(25, 'sw', 'GESTIONE CONSENSI E PREFERENZE CITTADINI', NOW(), NOW()),
(20, 'sw', 'ROL per cittadino', NOW(), NOW()),
(32, 'sw', 'SERVIZI PER LA STAMPA DEL PROMEMORIA', NOW(), NOW()),
(22, 'sw', 'Deleghe Cittadini Adulti', NOW(), NOW()),
(6, 'sw', 'Dematerializzazione buoni pazienti celiaci', NOW(), NOW()),
(14, 'sw', 'Gestione appuntamenti screening tumori femminili (cittadini)', NOW(), NOW()),
(11, 'sw', 'FSE per cittadino', NOW(), NOW()),
(16, 'sw', 'La Mia Salute', NOW(), NOW()),
(29, 'sw', 'COVID SOL CITTADINO', NOW(), NOW()),
(17, 'sw', 'Pagamento ticket via web', NOW(), NOW()),
(33, 'sw', 'AUTOCERTIFICAZIONE ESENZIONE PER PATOLOGIA CITTADINI', NOW(), NOW()),
(34, 'sw', 'Trova un', NOW(), NOW()),
(35, 'sw', 'FSE - Taccuino per cittadino', NOW(), NOW()),
(36, 'sw', 'SOL ESTRATTO CONTO TICKET SANITARI', NOW(), NOW()),
(37, 'sw', 'AMINDER Gestione Ammortizzatori Sociali in Deroga', NOW(), NOW()),
(38, 'sw', 'Gestione online comunicazioni obbligatorie (geco)', NOW(), NOW()),
(39, 'sw', 'Comunicazioni Massive file XML (COMMAX)', NOW(), NOW()),
(40, 'sw', 'Prospetto Disabili (PRODIS)', NOW(), NOW()),
(41, 'sw', 'Portale Apprendistato', NOW(), NOW()),
(42, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE', NOW(), NOW()),
(43, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BANDI 2020', NOW(), NOW()),
(44, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BANDI 2021', NOW(), NOW()),
(45, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BANDI 2022', NOW(), NOW()),
(46, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BANDI 2023', NOW(), NOW()),
(47, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BANDI 2024', NOW(), NOW()),
(48, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BANDO INNOMETRO', NOW(), NOW()),
(49, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BANDI 2026', NOW(), NOW()),
(50, 'sw', 'FINDOM - Gestionale Domanda Finpiemonte - Bonus Turismo', NOW(), NOW()),
(51, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BONUS APS', NOW(), NOW()),
(52, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - MEZZI INQUINANTI', NOW(), NOW()),
(53, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BONUS CULTURA', NOW(), NOW()),
(54, 'sw', 'FINDOM - GESTIONALE DOMANDA BANDI A16', NOW(), NOW()),
(55, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BONUS CULTURA', NOW(), NOW()),
(56, 'sw', 'FINDOM - GEST.DOMANDA FINPIEMONTE-MEZZI INQUINANTI PRIVATI', NOW(), NOW()),
(57, 'sw', 'FINDOM - GEST. DOM. FINPIEMONTE - LAVORATORI SVANTAGGIATI', NOW(), NOW()),
(58, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - RISTORO NEVE', NOW(), NOW()),
(59, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BANDO SMARTWORKING', NOW(), NOW()),
(60, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - BANDO GEN.BIOMASSE', NOW(), NOW()),
(61, 'sw', 'FINDOM - GEST.DOM - TESTATE GIORNALISTICHE - A19', NOW(), NOW()),
(62, 'sw', 'FINDOM - GEST.DOM - BENI LIBRARI 2021', NOW(), NOW()),
(63, 'sw', 'FINDOM - GEST.DOM - PROMOZIONE EDITORIA 2021', NOW(), NOW()),
(64, 'sw', 'FINDOM - GEST.DOM - VOUCHER SALONE LIBRO 2021', NOW(), NOW()),
(65, 'sw', 'FINDOM - GEST.DOM. FINPIEMONTE - STRUTT. RICETTIVE PMI', NOW(), NOW()),
(66, 'sw', 'GEST.DOM – ATTIVITA''  CULTURALI 2021', NOW(), NOW()),
(67, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE- SOSTEGNO FORMAZIONE', NOW(), NOW()),
(68, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - RISTORO NEVE-M.12', NOW(), NOW()),
(69, 'sw', 'FINDOM - GESTIONALE DOMANDA FINPIEMONTE - RISTORO NEVE 12-21', NOW(), NOW()),
(70, 'sw', 'FINDOM - Gestionale Domanda FESR', NOW(), NOW()),
(71, 'sw', 'FINDOM- GESTIONALE DOMANDA A21 SPORT', NOW(), NOW()),
(72, 'sw', 'Gestione e monitoraggio finanziamenti - Gestionale Finanziamenti Regione - FESR', NOW(), NOW())
(73, 'sw', 'Sanità', NOW(), NOW()),
(74, 'sw', 'Tributi', NOW(), NOW()),
(75, 'sw', 'Mobilità e trasporti', NOW(), NOW()),
(76, 'sw', 'Istruzione formazione e lavoro', NOW(), NOW()),
(77, 'sw', 'Agricoltura', NOW(), NOW()),
(78, 'sw', 'Adozioni', NOW(), NOW()),
(79, 'sw', 'Altri argomenti', NOW(), NOW()),
(80, 'sw', 'Linea interrotta/Errore coda telefonica', NOW(), NOW()),
(81, 'sw', 'Sis. Gest. Tassa Auto – Serv. online contrib. (Vis., Rich.)', NOW(), NOW())