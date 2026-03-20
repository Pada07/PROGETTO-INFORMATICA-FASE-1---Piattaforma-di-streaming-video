CREATE TABLE GENERE (
    ID_Genere int(2) unsigned zerofill auto_increment NOT NULL,
    nome      varchar(15) NOT NULL,
    PRIMARY KEY (ID_Genere)
);


CREATE TABLE PERSONA (
    ID_Persona int(4) unsigned zerofill auto_increment NOT NULL,
    nome       varchar(20) NOT NULL,
    cognome    varchar(25) NOT NULL,
    nFilm      int(3)      NOT NULL,
    PRIMARY KEY (ID_Persona)
);


CREATE TABLE PRODUZIONE (
    ID_Produzione int(3) unsigned zerofill auto_increment NOT NULL,
    nome          varchar(30) NOT NULL, -- FIX: era varchar(12), troppo corto per nomi di case produttrici
    PRIMARY KEY (ID_Produzione)
);


CREATE TABLE TIPO_ABBONAMENTO (
    ID_TipoAbbonamento int(2) unsigned zerofill auto_increment NOT NULL,
    nome               varchar(20)                                    NOT NULL, -- FIX: era varchar(12), allargato per sicurezza
    costo              decimal(6,2)                                   NOT NULL, -- FIX: era float(3), decimal evita errori di arrotondamento su valori monetari
    qualita            enum('480','720','1080','2160')                 NOT NULL,
    nAcc               int(2)                                         NOT NULL,
    durata             int(2)                                         NOT NULL,
    PRIMARY KEY (ID_TipoAbbonamento)
);


CREATE TABLE CONTENUTO (
    ID_Contenuto int(5) unsigned zerofill auto_increment NOT NULL,
    titolo       varchar(40) NOT NULL,
    trama        text,
    dataUscita   date,
    perBambini   boolean DEFAULT FALSE,
    PRIMARY KEY (ID_Contenuto)
);


CREATE TABLE SERIE (
    FKID_Serie int(5) unsigned zerofill NOT NULL,
    -- NOTA: SERIE non ha attributi propri, funge da discriminatore nel pattern di specializzazione.
    -- Un contenuto presente in SERIE è un "contenitore" di episodi, non qualcosa di direttamente visionabile.
    PRIMARY KEY (FKID_Serie),

    CONSTRAINT FK_SERIE_CONTENUTO
        FOREIGN KEY (FKID_Serie) REFERENCES CONTENUTO (ID_Contenuto)
        ON DELETE CASCADE  -- Se cancello il CONTENUTO padre, la riga SERIE perde significato 
        ON UPDATE CASCADE
);


CREATE TABLE VISIONABILE (
    -- Un contenuto presente in VISIONABILE è qualcosa che può essere riprodotto in streaming.
    -- La presenza/assenza di questa riga determina la disponibilità del contenuto:
    -- se la riga esiste → il contenuto è streamabile; se non esiste → "non disponibile".
    -- Questo è il motivo per cuiserve questa tabella invece di un semplice boolean
    -- in CONTENUTO: VISIONABILE ha attributi propri (durata, download) che non avrebbero
    -- senso su una SERIE, e la struttura a tabella garantisce gli archi esclusivi.
    FKID_Visionabile int(5) unsigned zerofill NOT NULL,
    durataMinuti     int(3) unsigned          DEFAULT 0, -- FIX: era "unsignedDEFAULT" senza spazio
    download         boolean                  DEFAULT FALSE,
    PRIMARY KEY (FKID_Visionabile),

    CONSTRAINT FK_VISIONABILE_CONTENUTO
        FOREIGN KEY (FKID_Visionabile) REFERENCES CONTENUTO (ID_Contenuto)
        ON DELETE RESTRICT -- RESTRICT: se cancello CONTENUTO, voglio che mi venga impedito finché
                           -- il VISIONABILE esiste. Per rendere un film "non disponibile" si cancella
                           -- prima VISIONABILE, non CONTENUTO (i dati rimangono in CONTENUTO).
        ON UPDATE CASCADE
);


CREATE TABLE EPISODIO (
    FKID_Episodio    int(5) unsigned zerofill NOT NULL,
    FKID_SeriePadre  int(5) unsigned zerofill NOT NULL,
    nStag            int(2) unsigned          NOT NULL,
    nEP              int(2) unsigned          NOT NULL,
    PRIMARY KEY (FKID_Episodio),
    UNIQUE (FKID_SeriePadre, nStag, nEP), -- impedisce episodi duplicati nella stessa stagione

    CONSTRAINT FK_EPISODIO_VISIONABILE
        FOREIGN KEY (FKID_Episodio) REFERENCES VISIONABILE (FKID_Visionabile)
        ON DELETE CASCADE  -- FIX: era RESTRICT. EPISODIO non ha attributi propri oltre alla FK:
                           -- se cancello la riga in VISIONABILE (rendo l'episodio non disponibile),
                           -- la riga in EPISODIO è un discriminatore vuoto e va rimossa → CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FK_EPISODIO_SERIE
        -- FIX: era REFERENCES CONTENUTO. Referenziare SERIE invece di CONTENUTO garantisce
        -- che la serie padre sia effettivamente una SERIE e non un Film o Documentario.
        FOREIGN KEY (FKID_SeriePadre) REFERENCES SERIE (FKID_Serie)
        ON DELETE CASCADE  -- Se la SERIE padre viene cancellata, i suoi episodi non hanno più senso → CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE FILM (
    FKID_Film int(5) unsigned zerofill NOT NULL,
    -- NOTA: FILM non ha attributi propri, funge da discriminatore.
    -- Tutti i dati del film (titolo, trama, ecc.) stanno in CONTENUTO.
    PRIMARY KEY (FKID_Film),

    CONSTRAINT FK_FILM_VISIONABILE
        FOREIGN KEY (FKID_Film) REFERENCES VISIONABILE (FKID_Visionabile)
        ON DELETE CASCADE  -- FIX: era RESTRICT. FILM è solo un discriminatore senza dati propri.
                           -- Cancellare VISIONABILE per rendere il film non disponibile deve
                           -- poter rimuovere anche questa riga, senza perdere dati reali
                           -- (che restano in CONTENUTO grazie al RESTRICT su VISIONABILE→CONTENUTO).
        ON UPDATE CASCADE
);


CREATE TABLE DOCUMENTARIO (
    FKID_Documentario int(5) unsigned zerofill NOT NULL,
    categoria enum('Storico','Biografico','Psicologico','Antropologico','Naturalistico') NOT NULL,
    PRIMARY KEY (FKID_Documentario),

    CONSTRAINT FK_DOCUMENTARIO_VISIONABILE
        FOREIGN KEY (FKID_Documentario) REFERENCES VISIONABILE (FKID_Visionabile)
        ON DELETE CASCADE  -- FIX: era RESTRICT, stessa logica di FILM:
                           -- l'unico attributo proprio è "categoria", ma il documentario come
                           -- entità non ha senso senza il suo VISIONABILE → CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE PONTECONTENUTOGENERE (
    FKID_Contenuto int(5) unsigned zerofill NOT NULL,
    FKID_Genere    int(2) unsigned zerofill NOT NULL, -- FIX: aggiunto zerofill per coerenza con GENERE.ID_Genere
    PRIMARY KEY (FKID_Contenuto, FKID_Genere),

    CONSTRAINT FK_CG_CONTENUTO
        FOREIGN KEY (FKID_Contenuto) REFERENCES CONTENUTO (ID_Contenuto)
        ON DELETE CASCADE  -- Se il contenuto viene rimosso, i suoi generi associati non servono più
        ON UPDATE CASCADE,

    CONSTRAINT FK_CG_GENERE
        FOREIGN KEY (FKID_Genere) REFERENCES GENERE (ID_Genere)
        ON DELETE RESTRICT -- Non voglio cancellare un genere se è ancora associato a dei contenuti 
        ON UPDATE CASCADE
);


CREATE TABLE PONTECONTENUTORECITATOPERSONA (
    FKID_Persona   int(4) unsigned zerofill NOT NULL,
    FKID_Contenuto int(5) unsigned zerofill NOT NULL,
    ruolo          varchar(30) NOT NULL, -- FIX: era varchar(12), troppo corto (es. "Protagonista", "Personaggio secondario")
    PRIMARY KEY (FKID_Persona, FKID_Contenuto),

    CONSTRAINT FK_CRP_PERSONA
        FOREIGN KEY (FKID_Persona) REFERENCES PERSONA (ID_Persona)
        ON DELETE RESTRICT -- Non cancello un attore solo perché non recita più in quel contenuto;
                           -- la persona ha valore anagrafico indipendente 
        ON UPDATE CASCADE,

    CONSTRAINT FK_CRP_CONTENUTO
        FOREIGN KEY (FKID_Contenuto) REFERENCES CONTENUTO (ID_Contenuto)
        ON DELETE CASCADE  -- Se il contenuto viene rimosso, l'associazione attore-contenuto perde senso 
        ON UPDATE CASCADE
);


CREATE TABLE PONTECONTENUTOPRODUZIONE (
    FKID_Produzione int(3) unsigned zerofill NOT NULL,
    FKID_Contenuto  int(5) unsigned zerofill NOT NULL,
    PRIMARY KEY (FKID_Produzione, FKID_Contenuto),

    CONSTRAINT FK_CP_PRODUZIONE
        FOREIGN KEY (FKID_Produzione) REFERENCES PRODUZIONE (ID_Produzione)
        ON DELETE RESTRICT -- Non voglio cancellare una casa produttrice se ha ancora contenuti associati 
        ON UPDATE CASCADE,

    CONSTRAINT FK_CP_CONTENUTO
        FOREIGN KEY (FKID_Contenuto) REFERENCES CONTENUTO (ID_Contenuto)
        ON DELETE CASCADE  -- Se il contenuto viene rimosso, l'associazione produzione-contenuto perde senso
        ON UPDATE CASCADE
);


CREATE TABLE ABBONAMENTO (
    ID_Abbonamento      int(4) unsigned zerofill auto_increment NOT NULL, -- FIX: era int(2), max 99 abbonamenti era troppo limitante
    FKID_TipoAbbonamento int(2) unsigned zerofill NOT NULL, -- FIX: aggiunto zerofill per coerenza con TIPO_ABBONAMENTO
    dataInizio          date                                  NOT NULL,
    metodoPagamento     enum('Paypal','Carta','Bonifico')     NOT NULL, 
    PRIMARY KEY (ID_Abbonamento),

    CONSTRAINT FK_ABBONAMENTO_TIPO
        FOREIGN KEY (FKID_TipoAbbonamento) REFERENCES TIPO_ABBONAMENTO (ID_TipoAbbonamento)
        ON DELETE RESTRICT -- Non voglio cancellare un tipo di abbonamento se ci sono abbonamenti attivi 
        ON UPDATE CASCADE
);


CREATE TABLE UTENTE (
    ID_Utente       int(4) unsigned zerofill auto_increment NOT NULL,
    FKID_Abbonamento int(4) unsigned zerofill NULL, -- FIX: era int(2), ora coerente con ABBONAMENTO.ID_Abbonamento
    telefono        varchar(15)  NOT NULL,
    email           varchar(100) NOT NULL UNIQUE, -- FIX: era varchar(20), assolutamente troppo corto per email reali
    pwd             varchar(64)  NOT NULL,             
    salt            varchar(64)  NOT NULL,         
    nome            varchar(20)  NOT NULL,
    cognome         varchar(25)  NOT NULL,
    indirizzo       varchar(50)  NOT NULL, -- FIX: era varchar(30), allargato per indirizzi completi
    PRIMARY KEY (ID_Utente),

    CONSTRAINT FK_UTENTE_ABBONAMENTO
        FOREIGN KEY (FKID_Abbonamento) REFERENCES ABBONAMENTO (ID_Abbonamento)
        ON DELETE RESTRICT -- Non posso cancellare un abbonamento se un utente lo sta ancora usando 
        ON UPDATE CASCADE
);


CREATE TABLE ACCOUNT (
    ID_Account  int(4) unsigned zerofill auto_increment NOT NULL,
    FKID_Utente int(4) unsigned zerofill NOT NULL,
    nomeAcc     varchar(15)                             NOT NULL,
    tipoAcc     enum('Adulto','Bambino','Famiglia')      NOT NULL,
    PRIMARY KEY (ID_Account),

    CONSTRAINT FK_ACCOUNT_UTENTE
        FOREIGN KEY (FKID_Utente) REFERENCES UTENTE (ID_Utente)
        ON DELETE CASCADE  -- Se l'utente viene cancellato, tutti i suoi account non hanno più senso 
        ON UPDATE CASCADE
);


CREATE TABLE RECENSIONE (
    ID_Recensione  int(5) unsigned zerofill auto_increment NOT NULL,
    FKID_Utente    int(4) unsigned zerofill,               -- FIX: reso nullable per supportare ON DELETE SET NULL
    FKID_Contenuto int(5) unsigned zerofill NOT NULL,
    voto           int(1) NOT NULL CHECK (voto BETWEEN 1 AND 5), -- FIX: aggiunto CHECK per limitare i valori ammessi
    PRIMARY KEY (ID_Recensione),

    CONSTRAINT FK_RECENSIONE_UTENTE
        FOREIGN KEY (FKID_Utente) REFERENCES UTENTE (ID_Utente)
        ON DELETE SET NULL -- FIX: era CASCADE. Con SET NULL, se l'utente viene cancellato la FK diventa NULL
                           -- e l'applicazione può mostrare "Anonimo". La recensione e il voto vengono preservati.
        ON UPDATE CASCADE,

    CONSTRAINT FK_RECENSIONE_CONTENUTO
        FOREIGN KEY (FKID_Contenuto) REFERENCES CONTENUTO (ID_Contenuto)
        ON DELETE CASCADE  -- Se il contenuto viene rimosso, non ha senso mantenere le sue recensioni
        ON UPDATE CASCADE
);


CREATE TABLE LISTA (
    FKID_Account   int(4) unsigned zerofill NOT NULL,
    FKID_Contenuto int(5) unsigned zerofill NOT NULL,
    tipo           enum('Watchlist','Preferiti') NOT NULL,
    PRIMARY KEY (FKID_Account, FKID_Contenuto, tipo),

    CONSTRAINT FK_LISTA_ACCOUNT
        FOREIGN KEY (FKID_Account) REFERENCES ACCOUNT (ID_Account)
        ON DELETE CASCADE  -- Se l'account viene cancellato, le sue liste non hanno più senso 
        ON UPDATE CASCADE,

    CONSTRAINT FK_LISTA_CONTENUTO
        FOREIGN KEY (FKID_Contenuto) REFERENCES CONTENUTO (ID_Contenuto)
        ON DELETE CASCADE  -- FIX: era RESTRICT. Se un contenuto viene rimosso dalla piattaforma,
                           -- non ha senso che rimanga nelle liste degli utenti 
        ON UPDATE CASCADE
);


CREATE TABLE PONTEVISIONA (
    FKID_Account   int(4) unsigned zerofill NOT NULL,
    FKID_Contenuto int(5) unsigned zerofill NOT NULL,
    dataVisione    date                     NOT NULL,
    minuto         int(3) DEFAULT 0         NOT NULL, -- FIX: era int(2), max 99 min non copriva film lunghi
    PRIMARY KEY (FKID_Account, FKID_Contenuto, dataVisione),

    CONSTRAINT FK_VISIONA_ACCOUNT
        FOREIGN KEY (FKID_Account) REFERENCES ACCOUNT (ID_Account)
        ON DELETE CASCADE  -- Se l'account viene cancellato, la sua cronologia di visione non serve più 
        ON UPDATE CASCADE,

    CONSTRAINT FK_VISIONA_CONTENUTO
        FOREIGN KEY (FKID_Contenuto) REFERENCES CONTENUTO (ID_Contenuto)
        ON DELETE CASCADE  -- Se il contenuto viene rimosso, i dati di visione ad esso associati perdono senso 
        ON UPDATE CASCADE
);


-- ===========================
-- GENERE
-- ===========================
INSERT INTO GENERE (nome) VALUES 
('Horror'),
('Thriller'),
('Documentario'),
('Psicologico');

-- ===========================
-- PERSONA
-- ===========================
INSERT INTO PERSONA (nome, cognome, nFilm) VALUES
('Pascal', 'Laugier', 1),
('Alessandro', 'Redaelli', 1),
('Lucie', 'Joubert', 1),
('Emma', 'Roberts', 1);

-- ===========================
-- PRODUZIONE
-- ===========================
INSERT INTO PRODUZIONE (nome) VALUES
('ASC Distribution'),
('XYZ Films'),
('Documentary Italia');

-- ===========================
-- CONTENUTO – Film e Documentari
-- ===========================
INSERT INTO CONTENUTO (titolo, trama, dataUscita, perBambini) VALUES
('Martyrs', 'Due ragazze cercano vendetta, horror estremo.', '2008-09-10', FALSE),
('Inside', 'Una donna prigioniera subisce torture psicologiche.', '2007-03-15', FALSE),
('High Tension', 'Amicizia e sangue in una casa isolata.', '2003-06-20', FALSE),
('Funeralopolis', 'La storia di due ragazzi caduti nel tunnel della droga', '2020-11-01', FALSE),
('Death in Venice', 'Analisi culturale della morte in Europa.', '2019-05-12', FALSE),
('Memento Mori', 'Storie e tradizioni sul morire.', '2021-02-20', FALSE),
('Twin Peaks', 'Agente speciale Dale Cooper indaga su un misterioso omicidio.', '1990-04-08', FALSE),
('Twin Peaks Ep1', 'Episodio 1 della serie Twin Peaks.', '1990-04-08', FALSE),
('Twin Peaks Ep2', 'Episodio 2 della serie Twin Peaks.', '1990-04-15', FALSE),
('Twin Peaks Ep3', 'Episodio 3 della serie Twin Peaks.', '1990-04-22', FALSE),
('Twin Peaks Ep4', 'Episodio 4 della serie Twin Peaks.', '1990-04-29', FALSE);

-- ===========================
-- VISIONABILE
-- ===========================
INSERT INTO VISIONABILE (FKID_Visionabile, durataMinuti, download) VALUES
(1, 102, TRUE), -- Martyrs
(2, 86, TRUE),  -- Inside
(3, 91, TRUE),  -- High Tension
(4, 75, TRUE),  -- Funeralopolis
(5, 80, TRUE),  -- Death in Venice
(6, 70, TRUE),  -- Memento Mori
(8, 48, TRUE),  -- Twin Peaks Ep1
(9, 46, TRUE),  -- Twin Peaks Ep2
(10, 50, TRUE), -- Twin Peaks Ep3
(11, 47, TRUE); -- Twin Peaks Ep4

-- ===========================
-- FILM
-- ===========================
INSERT INTO FILM (FKID_Film) VALUES
(1),
(2),
(3);

-- ===========================
-- DOCUMENTARIO
-- ===========================
INSERT INTO DOCUMENTARIO (FKID_Documentario, categoria) VALUES
(4, 'Antropologico'),
(5, 'Storico'),
(6, 'Biografico');

-- ===========================
-- SERIE
-- ===========================
INSERT INTO SERIE (FKID_Serie) VALUES
(7); -- Twin Peaks

-- ===========================
-- EPISODIO – Twin Peaks primi 4 episodi
-- ===========================
INSERT INTO EPISODIO (FKID_Episodio, FKID_SeriePadre, nStag, nEP) VALUES
(8, 7, 1, 1),
(9, 7, 1, 2),
(10, 7, 1, 3),
(11, 7, 1, 4);

-- ===========================
-- PONTECONTENUTOGENERE
-- ===========================
-- Film horror
INSERT INTO PONTECONTENUTOGENERE (FKID_Contenuto, FKID_Genere) VALUES
(1, 1),
(2, 1),
(3, 1);

-- Documentari
INSERT INTO PONTECONTENUTOGENERE (FKID_Contenuto, FKID_Genere) VALUES
(4, 3),
(5, 3),
(6, 3);

-- Twin Peaks
INSERT INTO PONTECONTENUTOGENERE (FKID_Contenuto, FKID_Genere) VALUES
(7, 2);

-- ===========================
-- PONTECONTENUTORECITATOPERSONA
-- ===========================
-- Martyrs
INSERT INTO PONTECONTENUTORECITATOPERSONA (FKID_Persona, FKID_Contenuto, ruolo) VALUES
(1, 1, 'Regista'),
(3, 1, 'Protagonista');

-- Inside
INSERT INTO PONTECONTENUTORECITATOPERSONA (FKID_Persona, FKID_Contenuto, ruolo) VALUES
(4, 2, 'Protagonista');

-- Funeralopolis
INSERT INTO PONTECONTENUTORECITATOPERSONA (FKID_Persona, FKID_Contenuto, ruolo) VALUES
(2, 4, 'Regista');

-- ===========================
-- PONTECONTENUTOPRODUZIONE
-- ===========================
-- Film
INSERT INTO PONTECONTENUTOPRODUZIONE (FKID_Produzione, FKID_Contenuto) VALUES
(1, 1),
(2, 2),
(2, 3);

-- Documentari
INSERT INTO PONTECONTENUTOPRODUZIONE (FKID_Produzione, FKID_Contenuto) VALUES
(3, 4),
(3, 5),
(3, 6);