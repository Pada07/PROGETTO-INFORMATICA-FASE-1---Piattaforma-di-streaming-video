CREATE TABLE GENERE (
    ID_Genere varchar(10) PRIMARY KEY,
    nome varchar(15) NOT NULL
);

CREATE TABLE PERSONA (
    ID_Persona varchar(10) PRIMARY KEY,
    nome varchar(15) NOT NULL,
    cognome varchar(20) NOT NULL,
    nFilm int NOT NULL
);

CREATE TABLE PRODUZIONE (
    ID_Produzione varchar(10) PRIMARY KEY,
    nome varchar(15) NOT NULL,
    nomePresidente varchar(10) NOT NULL
);

CREATE TABLE TIPO_ABBONAMENTO (
    ID_TipoAbbonamento varchar(10) PRIMARY KEY,
    nome varchar(15) NOT NULL,
    costo float NOT NULL,
    qualita int NOT NULL,
    nAcc int NOT NULL,
    durata int NOT NULL
);

CREATE TABLE CONTENUTO (
    ID_Contenuto varchar(10) PRIMARY KEY,
    titolo varchar(100) NOT NULL,
    tipo enum('Film', 'Serie', 'Episodio', 'Documentario') NOT NULL,
    
    FKID_SeriePadre varchar(10) NULL,

    trama text,
    annoUscita int NOT NULL,
    dataUscita date,
    durataMinuti int DEFAULT 0,
    download BOOLEAN DEFAULT FALSE,
    perBambini BOOLEAN DEFAULT FALSE,
    
    nStag int NULL,
    nEP int NULL,

    CONSTRAINT FK_SERIE_PADRE
    FOREIGN KEY(FKID_SeriePadre) REFERENCES CONTENUTO(ID_Contenuto)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE PONTECONTENUTOGENERE (
    FKID_Contenuto varchar(10) NOT NULL,
    FKID_Genere varchar(10) NOT NULL,

    PRIMARY KEY(FKID_Contenuto, FKID_Genere),

    CONSTRAINT FK_CG
    FOREIGN KEY(FKID_Contenuto) REFERENCES CONTENUTO(ID_Contenuto)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_CG2
    FOREIGN KEY(FKID_Genere) REFERENCES GENERE(ID_Genere)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE PONTECONTENUTORECITATOPERSONA (
    FKID_Persona varchar(10) NOT NULL,
    FKID_Contenuto varchar(10) NOT NULL,
    ruolo varchar(10) NOT NULL,

    PRIMARY KEY (FKID_Persona, FKID_Contenuto),

    CONSTRAINT FK_CRP
    FOREIGN KEY(FKID_Persona) REFERENCES PERSONA(ID_Persona)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_CRP2
    FOREIGN KEY(FKID_Contenuto) REFERENCES CONTENUTO(ID_Contenuto)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE PONTECONTENUTOPRODUZIONE (
    FKID_Produzione varchar(10) NOT NULL,
    FKID_Contenuto varchar(10) NOT NULL,

    PRIMARY KEY(FKID_Produzione, FKID_Contenuto),

    CONSTRAINT FK_CP
    FOREIGN KEY(FKID_Produzione) REFERENCES PRODUZIONE(ID_Produzione)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_CP2
    FOREIGN KEY(FKID_Contenuto) REFERENCES CONTENUTO(ID_Contenuto)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE ABBONAMENTO (
    ID_Abbonamento varchar(10) PRIMARY KEY,
    FKID_TipoAbbonamento varchar(10) NOT NULL,
    dataInizio date NOT NULL,
    metodiPagamento enum('Paypal', 'Carta', 'Bonifico') NOT NULL,

    CONSTRAINT FK_ABBONAMENTO
    FOREIGN KEY(FKID_TipoAbbonamento) REFERENCES TIPO_ABBONAMENTO(ID_TipoAbbonamento)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE UTENTE (
    ID_Utente varchar(10) PRIMARY KEY,
    FKID_Abbonamento varchar(10) NOT NULL,
    telefono varchar(15) NOT NULL,
    email varchar(20) NOT NULL UNIQUE,
    pwd varchar(20) NOT NULL,
    nome varchar(15) NOT NULL,
    cognome varchar(20) NOT NULL,
    indirizzo varchar(30) NOT NULL,

    CONSTRAINT FK_UTENTE
    FOREIGN KEY(FKID_Abbonamento) REFERENCES ABBONAMENTO(ID_Abbonamento)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE ACCOUNT (
    ID_Account varchar(10) PRIMARY KEY,
    FKID_Utente varchar(10) NOT NULL,
    nomeAcc varchar(15) NOT NULL,
    tipoAcc enum('Adulto', 'Bambino', 'Famiglia') NOT NULL,

    CONSTRAINT FK_ACCOUNT
    FOREIGN KEY(FKID_Utente) REFERENCES UTENTE(ID_Utente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE RECENSIONE (
    ID_Recensione varchar(10) PRIMARY KEY,
    FKID_Utente varchar(10) NOT NULL, 
    FKID_Contenuto varchar(10) NOT NULL,
    voto int NOT NULL,

    CONSTRAINT FK_RECENSIONUTENTE
    FOREIGN KEY(FKID_Utente) REFERENCES UTENTE(ID_Utente)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_RECENSIONCONTENUTO
    FOREIGN KEY(FKID_Contenuto) REFERENCES CONTENUTO(ID_Contenuto)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE LISTA (
    ID_Lista varchar(10) PRIMARY KEY,
    FKID_Account varchar(10) NOT NULL,
    FKID_Contenuto varchar(10) NOT NULL,
    tipo enum('Watchlist', 'Preferiti') NOT NULL,

    CONSTRAINT FK_LISTACCOUNT
    FOREIGN KEY(FKID_Account) REFERENCES ACCOUNT(ID_Account)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_LISTACONTENUTO
    FOREIGN KEY(FKID_Contenuto) REFERENCES CONTENUTO(ID_Contenuto)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE PONTEVISIONA (
    FKID_Account varchar(10) NOT NULL,
    FKID_Contenuto varchar(10) NOT NULL,
    dataVisione date NOT NULL,
    minuto int DEFAULT 0 NOT NULL,

    PRIMARY KEY(FKID_Account, FKID_Contenuto, dataVisione),

    CONSTRAINT FK_VISIONA
    FOREIGN KEY(FKID_Account) REFERENCES ACCOUNT(ID_Account)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT FK_VISIONA2
    FOREIGN KEY(FKID_Contenuto) REFERENCES CONTENUTO(ID_Contenuto)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO GENERE (ID_Genere, nome) VALUES
('1', 'Drammatico'),
('2', 'Horror'),
('3', 'Thriller'),
('4', 'Documentario'),
('5', 'Sperimentale');

INSERT INTO CONTENUTO (ID_Contenuto, titolo, tipo, FKID_SeriePadre, trama, annoUscita, dataUscita, durataMinuti, download, perBambini, nStag, nEP) VALUES
('1', 'La chiave', 'Film', NULL, 'A Venezia, due coniugi confessano perversioni in un diario.', 1983, '1983-10-19', 116, true, false, NULL, NULL),
('2', 'A serbian film', 'Film', NULL, 'Un padre di famiglia accetta un ruolo in un film estremo.', 2010, '2010-06-16', 104, true, false, NULL, NULL),
('3', 'Funeralopolis', 'Documentario', NULL, 'La storia di un gruppo di amici eroinomani.', 2017, '2017-06-14', 94, false, false, NULL, NULL),
('4', 'Crazy murder', 'Film', NULL, 'Le vicende di un senzatetto nella grande mela.', 2014, '2014-08-09', 93, true, false, NULL, NULL),
('5', 'Dark', 'Serie', NULL, 'La scomparsa di due bambini in un villaggio tedesco.', 2017, '2017-12-01', 0, true, false, 3, 26),
('6', 'Segreti', 'Episodio', '5', 'Le indagini portano a galla torbidi segreti.', 2017, '2017-12-01', 60, true, false, 1, 1);

INSERT INTO PERSONA (ID_Persona, nome, cognome, nFilm) VALUES
('1', 'Tinto', 'Brass', 30),
('2', 'Srdjan', 'Spasojevic', 5),
('3', 'Alessandro', 'Redaelli', 3),
('4', 'Baran', 'bo Odar', 10),
('5', 'Stefania', 'Sandrelli', 100);

INSERT INTO PRODUZIONE (ID_Produzione, nome, nomePresidente) VALUES
('1', 'Warner Bros', 'Massimo'),
('2', 'Netflix', 'Davide'),
('3', 'Rai Cinema', 'Paolo'),
('4', 'Indie Production', 'Mario'),
('5', 'Universal', 'Maria');

INSERT INTO TIPO_ABBONAMENTO (ID_TipoAbbonamento, nome, costo, qualita, nAcc, durata) VALUES
('1', 'Base', 7.99, 720, 1, 30),
('2', 'Standard', 10.99, 1080, 2, 30),
('3', 'Premium', 15.99, 2160, 4, 30),
('4', 'Annual', 99.99, 1080, 2, 365),
('5', 'Student', 4.99, 720, 1, 30);

INSERT INTO PONTECONTENUTOGENERE (FKID_Contenuto, FKID_Genere) VALUES
('1', '1'),
('2', '2'),
('3', '4'),
('4', '5'),
('5', '3');

INSERT INTO PONTECONTENUTORECITATOPERSONA (FKID_Persona, FKID_Contenuto, ruolo) VALUES
('1', '1', 'Regista'),
('5', '1', 'Attore'),
('2', '2', 'Regista'),
('3', '3', 'Regista'),
('4', '5', 'Regista');

INSERT INTO PONTECONTENUTOPRODUZIONE (FKID_Produzione, FKID_Contenuto) VALUES
('4', '1'),
('4', '2'),
('4', '3'),
('4', '4'),
('2', '5');

INSERT INTO ABBONAMENTO (ID_Abbonamento, FKID_TipoAbbonamento, dataInizio, metodiPagamento) VALUES
('1', '3', '2023-01-01', 'Paypal'),
('2', '1', '2023-05-10', 'Carta'),
('3', '2', '2023-02-15', 'Bonifico'),
('4', '5', '2023-09-01', 'Carta'),
('5', '3', '2023-11-20', 'Paypal');

INSERT INTO UTENTE (ID_Utente, FKID_Abbonamento, telefono, email, pwd, nome, cognome, indirizzo) VALUES
('1', '1', '333111111', 'massimo@email.it', 'pass1', 'Massimo', 'Rossi', 'Via Roma 1'),
('2', '2', '333222222', 'luca@email.it', 'pass2', 'Luca', 'Verdi', 'Via Milano 2'),
('3', '3', '333333333', 'anna@email.it', 'pass3', 'Anna', 'Bianchi', 'Via Napoli 3'),
('4', '4', '333444444', 'giulia@email.it', 'pass4', 'Giulia', 'Neri', 'Via Torino 4'),
('5', '5', '333555555', 'paolo@email.it', 'pass5', 'Paolo', 'Gialli', 'Via Bari 5');

INSERT INTO ACCOUNT (ID_Account, FKID_Utente, nomeAcc, tipoAcc) VALUES
('1', '1', 'Massimo', 'Adulto'),
('2', '1', 'Marco', 'Bambino'),
('3', '2', 'Luca', 'Adulto'),
('4', '3', 'Anna', 'Famiglia'),
('5', '4', 'Giulia', 'Adulto');

INSERT INTO RECENSIONE (ID_Recensione, FKID_Utente, FKID_Contenuto, voto) VALUES
('1', '1', '1', 8),
('2', '1', '5', 9),
('3', '2', '2', 2),
('4', '3', '3', 7),
('5', '4', '5', 10);

INSERT INTO LISTA (ID_Lista, FKID_Account, FKID_Contenuto, tipo) VALUES
('1', '1', '5', 'Watchlist'),
('2', '1', '2', 'Preferiti'),
('3', '2', '5', 'Watchlist'),
('4', '3', '1', 'Preferiti'),
('5', '4', '3', 'Watchlist');

INSERT INTO PONTEVISIONA (FKID_Account, FKID_Contenuto, dataVisione, minuto) VALUES
('1', '1', '2023-10-10', 116),
('1', '5', '2023-10-12', 45),
('2', '5', '2023-10-15', 20),
('3', '2', '2023-11-01', 10),
('4', '3', '2023-11-05', 94);