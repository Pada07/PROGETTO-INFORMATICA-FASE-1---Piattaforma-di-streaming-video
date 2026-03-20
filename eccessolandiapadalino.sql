-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mar 20, 2026 alle 12:58
-- Versione del server: 10.4.13-MariaDB
-- Versione PHP: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eccessolandiapadalino`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `abbonamento`
--

CREATE TABLE `abbonamento` (
  `ID_Abbonamento` int(4) UNSIGNED ZEROFILL NOT NULL,
  `FKID_TipoAbbonamento` int(2) UNSIGNED ZEROFILL NOT NULL,
  `dataInizio` date NOT NULL,
  `metodoPagamento` enum('Paypal','Carta','Bonifico') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `account`
--

CREATE TABLE `account` (
  `ID_Account` int(4) UNSIGNED ZEROFILL NOT NULL,
  `FKID_Utente` int(4) UNSIGNED ZEROFILL NOT NULL,
  `nomeAcc` varchar(15) NOT NULL,
  `tipoAcc` enum('Adulto','Bambino','Famiglia') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `account`
--

INSERT INTO `account` (`ID_Account`, `FKID_Utente`, `nomeAcc`, `tipoAcc`) VALUES
(0001, 0001, 'Ale', 'Adulto'),
(0002, 0002, 'Pada', 'Adulto'),
(0003, 0010, 'Massimo', 'Adulto');

-- --------------------------------------------------------

--
-- Struttura della tabella `contenuto`
--

CREATE TABLE `contenuto` (
  `ID_Contenuto` int(5) UNSIGNED ZEROFILL NOT NULL,
  `titolo` varchar(40) NOT NULL,
  `trama` text DEFAULT NULL,
  `dataUscita` date DEFAULT NULL,
  `perBambini` tinyint(1) DEFAULT 0,
  `cover` varchar(100) NOT NULL DEFAULT 'https://placehold.co/600x400?text=Cover+Film'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `contenuto`
--

INSERT INTO `contenuto` (`ID_Contenuto`, `titolo`, `trama`, `dataUscita`, `perBambini`, `cover`) VALUES
(00001, 'Martyrs', 'Due giovani donne, entrambe vittime di abusi subiti da bambine, intraprendono una sanguinosa ricerca di vendetta, solo per ritrovarsi immerse in un inferno di depravazione.', '2008-09-10', 0, '/Eccessolandia/img/00001.jpg'),
(00002, 'Inside', 'Dopo la morte di suo marito, Sarah vive sola. Alla vigilia del parto, Sarah riceve la visita di una donna misteriosa. Preoccupata, non apre la porta e decide di chiamare la polizia. Tuttavia, la sconosciuta è determinata ad entrare per parlarle.', '2007-03-15', 0, '/Eccessolandia/img/inside.jpg'),
(00003, 'High Tension', 'Una bella studentessa francese cerca di salvare un\'amica che è stata sequestrata da un assassino spietato.', '2003-06-20', 0, '/Eccessolandia/img/hightension.jpg'),
(00004, 'Funeralopolis', 'La storia di due ragazzi caduti nel tunnel della droga', '2020-11-01', 0, '/Eccessolandia/img/funeralopolis.jpg'),
(00005, 'Titicut Follies', 'Tradotto dall\'inglese-Titicut Follies è un film documentario americano del 1967 prodotto, scritto e diretto da Frederick Wiseman e girato da John Marshall. Si tratta dei pazienti-detenuti del Bridgewater State Hospital for the Criminally Insane, un istituto correzionale del Massachusetts a Bridgewater, Massachusetts.', '1967-10-03', 0, '/Eccessolandia/img/titicutfollies.jpg'),
(00006, 'Faces of Death', '\"Le facce della morte\" (Faces of Death) è un controverso film \"mondo\" del 1978 che presenta una serie di sequenze, tra il reale e lo staged, sulla morte. Il Dr. Gröss introduce filmati che mostrano autopsie, sacrifici rituali, incidenti mortali, esecuzioni, scene di mattatoio e violenza animale/umana, esplorando diverse \"facce\" del decesso.', '1978-11-10', 0, '/Eccessolandia/img/facesofdeath.jpg'),
(00007, 'Twin Peaks', 'Twin Peaks è una serie cult creata da David Lynch e Mark Frost incentrata sull\'indagine dell\'agente FBI Dale Cooper per l\'omicidio della liceale Laura Palmer nella cittadina di montagna omonima. La trama unisce noir, soap opera e soprannaturale, esplorando l\'oscurità nascosta dietro la facciata idilliaca del paese. ', '1990-04-08', 0, '/Eccessolandia/img/twinpeaks.jpg'),
(00008, 'Twin Peaks Ep1', 'Episodio 1 della serie Twin Peaks.', '1990-04-08', 0, 'https://placehold.co/600x400?text=Cover+Film'),
(00009, 'Twin Peaks Ep2', 'Episodio 2 della serie Twin Peaks.', '1990-04-15', 0, 'https://placehold.co/600x400?text=Cover+Film'),
(00010, 'Twin Peaks Ep3', 'Episodio 3 della serie Twin Peaks.', '1990-04-22', 0, 'https://placehold.co/600x400?text=Cover+Film'),
(00011, 'Twin Peaks Ep4', 'Episodio 4 della serie Twin Peaks.', '1990-04-29', 0, 'https://placehold.co/600x400?text=Cover+Film');

-- --------------------------------------------------------

--
-- Struttura della tabella `documentario`
--

CREATE TABLE `documentario` (
  `FKID_Documentario` int(5) UNSIGNED ZEROFILL NOT NULL,
  `categoria` enum('Storico','Biografico','Psicologico','Antropologico','Naturalistico') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `documentario`
--

INSERT INTO `documentario` (`FKID_Documentario`, `categoria`) VALUES
(00004, 'Antropologico'),
(00005, 'Storico'),
(00006, 'Biografico');

-- --------------------------------------------------------

--
-- Struttura della tabella `episodio`
--

CREATE TABLE `episodio` (
  `FKID_Episodio` int(5) UNSIGNED ZEROFILL NOT NULL,
  `FKID_SeriePadre` int(5) UNSIGNED ZEROFILL NOT NULL,
  `nStag` int(2) UNSIGNED NOT NULL,
  `nEP` int(2) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `episodio`
--

INSERT INTO `episodio` (`FKID_Episodio`, `FKID_SeriePadre`, `nStag`, `nEP`) VALUES
(00008, 00007, 1, 1),
(00009, 00007, 1, 2),
(00010, 00007, 1, 3),
(00011, 00007, 1, 4);

-- --------------------------------------------------------

--
-- Struttura della tabella `film`
--

CREATE TABLE `film` (
  `FKID_Film` int(5) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `film`
--

INSERT INTO `film` (`FKID_Film`) VALUES
(00001),
(00002),
(00003);

-- --------------------------------------------------------

--
-- Struttura della tabella `genere`
--

CREATE TABLE `genere` (
  `ID_Genere` int(2) UNSIGNED ZEROFILL NOT NULL,
  `nome` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `genere`
--

INSERT INTO `genere` (`ID_Genere`, `nome`) VALUES
(01, 'Horror'),
(02, 'Thriller'),
(03, 'Documentario'),
(04, 'Psicologico');

-- --------------------------------------------------------

--
-- Struttura della tabella `lista`
--

CREATE TABLE `lista` (
  `FKID_Account` int(4) UNSIGNED ZEROFILL NOT NULL,
  `FKID_Contenuto` int(5) UNSIGNED ZEROFILL NOT NULL,
  `tipo` enum('Watchlist','Preferiti') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `persona`
--

CREATE TABLE `persona` (
  `ID_Persona` int(4) UNSIGNED ZEROFILL NOT NULL,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(25) NOT NULL,
  `nFilm` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `persona`
--

INSERT INTO `persona` (`ID_Persona`, `nome`, `cognome`, `nFilm`) VALUES
(0001, 'Pascal', 'Laugier', 1),
(0002, 'Alessandro', 'Redaelli', 1),
(0003, 'Lucie', 'Joubert', 1),
(0004, 'Emma', 'Roberts', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `pontecontenutogenere`
--

CREATE TABLE `pontecontenutogenere` (
  `FKID_Contenuto` int(5) UNSIGNED ZEROFILL NOT NULL,
  `FKID_Genere` int(2) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `pontecontenutogenere`
--

INSERT INTO `pontecontenutogenere` (`FKID_Contenuto`, `FKID_Genere`) VALUES
(00001, 01),
(00002, 01),
(00003, 01),
(00004, 03),
(00005, 03),
(00006, 03),
(00007, 02);

-- --------------------------------------------------------

--
-- Struttura della tabella `pontecontenutoproduzione`
--

CREATE TABLE `pontecontenutoproduzione` (
  `FKID_Produzione` int(3) UNSIGNED ZEROFILL NOT NULL,
  `FKID_Contenuto` int(5) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `pontecontenutoproduzione`
--

INSERT INTO `pontecontenutoproduzione` (`FKID_Produzione`, `FKID_Contenuto`) VALUES
(001, 00001),
(002, 00002),
(002, 00003),
(003, 00004),
(003, 00005),
(003, 00006);

-- --------------------------------------------------------

--
-- Struttura della tabella `pontecontenutorecitatopersona`
--

CREATE TABLE `pontecontenutorecitatopersona` (
  `FKID_Persona` int(4) UNSIGNED ZEROFILL NOT NULL,
  `FKID_Contenuto` int(5) UNSIGNED ZEROFILL NOT NULL,
  `ruolo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `pontecontenutorecitatopersona`
--

INSERT INTO `pontecontenutorecitatopersona` (`FKID_Persona`, `FKID_Contenuto`, `ruolo`) VALUES
(0001, 00001, 'Regista'),
(0002, 00004, 'Regista'),
(0003, 00001, 'Protagonista'),
(0004, 00002, 'Protagonista');

-- --------------------------------------------------------

--
-- Struttura della tabella `pontevisiona`
--

CREATE TABLE `pontevisiona` (
  `FKID_Account` int(4) UNSIGNED ZEROFILL NOT NULL,
  `FKID_Contenuto` int(5) UNSIGNED ZEROFILL NOT NULL,
  `dataVisione` date NOT NULL,
  `minuto` int(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `produzione`
--

CREATE TABLE `produzione` (
  `ID_Produzione` int(3) UNSIGNED ZEROFILL NOT NULL,
  `nome` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `produzione`
--

INSERT INTO `produzione` (`ID_Produzione`, `nome`) VALUES
(001, 'ASC Distribution'),
(002, 'XYZ Films'),
(003, 'Documentary Italia');

-- --------------------------------------------------------

--
-- Struttura della tabella `recensione`
--

CREATE TABLE `recensione` (
  `ID_Recensione` int(5) UNSIGNED ZEROFILL NOT NULL,
  `FKID_Utente` int(4) UNSIGNED ZEROFILL DEFAULT NULL,
  `FKID_Contenuto` int(5) UNSIGNED ZEROFILL NOT NULL,
  `voto` int(1) NOT NULL CHECK (`voto` between 1 and 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `serie`
--

CREATE TABLE `serie` (
  `FKID_Serie` int(5) UNSIGNED ZEROFILL NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `serie`
--

INSERT INTO `serie` (`FKID_Serie`) VALUES
(00007);

-- --------------------------------------------------------

--
-- Struttura della tabella `tipo_abbonamento`
--

CREATE TABLE `tipo_abbonamento` (
  `ID_TipoAbbonamento` int(2) UNSIGNED ZEROFILL NOT NULL,
  `nome` varchar(20) NOT NULL,
  `costo` decimal(6,2) NOT NULL,
  `qualita` enum('480','720','1080','2160') NOT NULL,
  `nAcc` int(2) NOT NULL,
  `durata` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `utente`
--

CREATE TABLE `utente` (
  `ID_Utente` int(4) UNSIGNED ZEROFILL NOT NULL,
  `FKID_Abbonamento` int(4) UNSIGNED ZEROFILL DEFAULT NULL,
  `telefono` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pwd` varchar(64) NOT NULL,
  `salt` varchar(64) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(25) NOT NULL,
  `indirizzo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `utente`
--

INSERT INTO `utente` (`ID_Utente`, `FKID_Abbonamento`, `telefono`, `email`, `pwd`, `salt`, `nome`, `cognome`, `indirizzo`) VALUES
(0001, NULL, '657465468', 'ale@mail.com', '63cde35544d9a3028c75664d2c237c0dcc76b082c2a3b4225e71108fd666148f', '5619ae99d4018c6171674103b9bf0e97081be106e4dc75b89de6af88cbaec31c', 'Alessio', 'Tuscano', 'Via stocazzo'),
(0002, NULL, '3274475324', 'massimo@mail.com', '9d2b7b0b42ba867b8ed226581fbb5a5f0307a5f0b4eb9bf0e4409322beac2424', '5aced3e357691be8a40cb5fad7000c4d9c96e8bacb8422bdfe85560ffd2987dc', 'Massimo', 'Padalino', 'Via Stuppagghiara'),
(0010, NULL, '7423874692376', 'massimo@gmail.com', '170344603a319a054b3fb9f1e50f66c504a460ac1f86ef30aee2fff47b7f667c', '814ede349ae8e4fa994d2c35696dfaefa4a95ddcdda6d5fd3e878226a3cc4a77', 'Massimo', 'Padalino', 'Via Casa Mia');

-- --------------------------------------------------------

--
-- Struttura della tabella `visionabile`
--

CREATE TABLE `visionabile` (
  `FKID_Visionabile` int(5) UNSIGNED ZEROFILL NOT NULL,
  `durataMinuti` int(3) UNSIGNED DEFAULT 0,
  `download` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `visionabile`
--

INSERT INTO `visionabile` (`FKID_Visionabile`, `durataMinuti`, `download`) VALUES
(00001, 102, 1),
(00002, 86, 1),
(00003, 91, 1),
(00004, 75, 1),
(00005, 80, 1),
(00006, 70, 1),
(00008, 48, 1),
(00009, 46, 1),
(00010, 50, 1),
(00011, 47, 1);

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `abbonamento`
--
ALTER TABLE `abbonamento`
  ADD PRIMARY KEY (`ID_Abbonamento`),
  ADD KEY `FK_ABBONAMENTO_TIPO` (`FKID_TipoAbbonamento`);

--
-- Indici per le tabelle `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`ID_Account`),
  ADD KEY `FK_ACCOUNT_UTENTE` (`FKID_Utente`);

--
-- Indici per le tabelle `contenuto`
--
ALTER TABLE `contenuto`
  ADD PRIMARY KEY (`ID_Contenuto`);

--
-- Indici per le tabelle `documentario`
--
ALTER TABLE `documentario`
  ADD PRIMARY KEY (`FKID_Documentario`);

--
-- Indici per le tabelle `episodio`
--
ALTER TABLE `episodio`
  ADD PRIMARY KEY (`FKID_Episodio`),
  ADD UNIQUE KEY `FKID_SeriePadre` (`FKID_SeriePadre`,`nStag`,`nEP`);

--
-- Indici per le tabelle `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`FKID_Film`);

--
-- Indici per le tabelle `genere`
--
ALTER TABLE `genere`
  ADD PRIMARY KEY (`ID_Genere`);

--
-- Indici per le tabelle `lista`
--
ALTER TABLE `lista`
  ADD PRIMARY KEY (`FKID_Account`,`FKID_Contenuto`,`tipo`),
  ADD KEY `FK_LISTA_CONTENUTO` (`FKID_Contenuto`);

--
-- Indici per le tabelle `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`ID_Persona`);

--
-- Indici per le tabelle `pontecontenutogenere`
--
ALTER TABLE `pontecontenutogenere`
  ADD PRIMARY KEY (`FKID_Contenuto`,`FKID_Genere`),
  ADD KEY `FK_CG_GENERE` (`FKID_Genere`);

--
-- Indici per le tabelle `pontecontenutoproduzione`
--
ALTER TABLE `pontecontenutoproduzione`
  ADD PRIMARY KEY (`FKID_Produzione`,`FKID_Contenuto`),
  ADD KEY `FK_CP_CONTENUTO` (`FKID_Contenuto`);

--
-- Indici per le tabelle `pontecontenutorecitatopersona`
--
ALTER TABLE `pontecontenutorecitatopersona`
  ADD PRIMARY KEY (`FKID_Persona`,`FKID_Contenuto`),
  ADD KEY `FK_CRP_CONTENUTO` (`FKID_Contenuto`);

--
-- Indici per le tabelle `pontevisiona`
--
ALTER TABLE `pontevisiona`
  ADD PRIMARY KEY (`FKID_Account`,`FKID_Contenuto`,`dataVisione`),
  ADD KEY `FK_VISIONA_CONTENUTO` (`FKID_Contenuto`);

--
-- Indici per le tabelle `produzione`
--
ALTER TABLE `produzione`
  ADD PRIMARY KEY (`ID_Produzione`);

--
-- Indici per le tabelle `recensione`
--
ALTER TABLE `recensione`
  ADD PRIMARY KEY (`ID_Recensione`),
  ADD KEY `FK_RECENSIONE_UTENTE` (`FKID_Utente`),
  ADD KEY `FK_RECENSIONE_CONTENUTO` (`FKID_Contenuto`);

--
-- Indici per le tabelle `serie`
--
ALTER TABLE `serie`
  ADD PRIMARY KEY (`FKID_Serie`);

--
-- Indici per le tabelle `tipo_abbonamento`
--
ALTER TABLE `tipo_abbonamento`
  ADD PRIMARY KEY (`ID_TipoAbbonamento`);

--
-- Indici per le tabelle `utente`
--
ALTER TABLE `utente`
  ADD PRIMARY KEY (`ID_Utente`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `FK_UTENTE_ABBONAMENTO` (`FKID_Abbonamento`);

--
-- Indici per le tabelle `visionabile`
--
ALTER TABLE `visionabile`
  ADD PRIMARY KEY (`FKID_Visionabile`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `abbonamento`
--
ALTER TABLE `abbonamento`
  MODIFY `ID_Abbonamento` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `account`
--
ALTER TABLE `account`
  MODIFY `ID_Account` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `contenuto`
--
ALTER TABLE `contenuto`
  MODIFY `ID_Contenuto` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT per la tabella `genere`
--
ALTER TABLE `genere`
  MODIFY `ID_Genere` int(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `persona`
--
ALTER TABLE `persona`
  MODIFY `ID_Persona` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT per la tabella `produzione`
--
ALTER TABLE `produzione`
  MODIFY `ID_Produzione` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la tabella `recensione`
--
ALTER TABLE `recensione`
  MODIFY `ID_Recensione` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `tipo_abbonamento`
--
ALTER TABLE `tipo_abbonamento`
  MODIFY `ID_TipoAbbonamento` int(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `utente`
--
ALTER TABLE `utente`
  MODIFY `ID_Utente` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `abbonamento`
--
ALTER TABLE `abbonamento`
  ADD CONSTRAINT `FK_ABBONAMENTO_TIPO` FOREIGN KEY (`FKID_TipoAbbonamento`) REFERENCES `tipo_abbonamento` (`ID_TipoAbbonamento`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `FK_ACCOUNT_UTENTE` FOREIGN KEY (`FKID_Utente`) REFERENCES `utente` (`ID_Utente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `documentario`
--
ALTER TABLE `documentario`
  ADD CONSTRAINT `FK_DOCUMENTARIO_VISIONABILE` FOREIGN KEY (`FKID_Documentario`) REFERENCES `visionabile` (`FKID_Visionabile`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `episodio`
--
ALTER TABLE `episodio`
  ADD CONSTRAINT `FK_EPISODIO_SERIE` FOREIGN KEY (`FKID_SeriePadre`) REFERENCES `serie` (`FKID_Serie`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_EPISODIO_VISIONABILE` FOREIGN KEY (`FKID_Episodio`) REFERENCES `visionabile` (`FKID_Visionabile`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `film`
--
ALTER TABLE `film`
  ADD CONSTRAINT `FK_FILM_VISIONABILE` FOREIGN KEY (`FKID_Film`) REFERENCES `visionabile` (`FKID_Visionabile`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `lista`
--
ALTER TABLE `lista`
  ADD CONSTRAINT `FK_LISTA_ACCOUNT` FOREIGN KEY (`FKID_Account`) REFERENCES `account` (`ID_Account`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_LISTA_CONTENUTO` FOREIGN KEY (`FKID_Contenuto`) REFERENCES `contenuto` (`ID_Contenuto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `pontecontenutogenere`
--
ALTER TABLE `pontecontenutogenere`
  ADD CONSTRAINT `FK_CG_CONTENUTO` FOREIGN KEY (`FKID_Contenuto`) REFERENCES `contenuto` (`ID_Contenuto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CG_GENERE` FOREIGN KEY (`FKID_Genere`) REFERENCES `genere` (`ID_Genere`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `pontecontenutoproduzione`
--
ALTER TABLE `pontecontenutoproduzione`
  ADD CONSTRAINT `FK_CP_CONTENUTO` FOREIGN KEY (`FKID_Contenuto`) REFERENCES `contenuto` (`ID_Contenuto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CP_PRODUZIONE` FOREIGN KEY (`FKID_Produzione`) REFERENCES `produzione` (`ID_Produzione`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `pontecontenutorecitatopersona`
--
ALTER TABLE `pontecontenutorecitatopersona`
  ADD CONSTRAINT `FK_CRP_CONTENUTO` FOREIGN KEY (`FKID_Contenuto`) REFERENCES `contenuto` (`ID_Contenuto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_CRP_PERSONA` FOREIGN KEY (`FKID_Persona`) REFERENCES `persona` (`ID_Persona`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `pontevisiona`
--
ALTER TABLE `pontevisiona`
  ADD CONSTRAINT `FK_VISIONA_ACCOUNT` FOREIGN KEY (`FKID_Account`) REFERENCES `account` (`ID_Account`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_VISIONA_CONTENUTO` FOREIGN KEY (`FKID_Contenuto`) REFERENCES `contenuto` (`ID_Contenuto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `recensione`
--
ALTER TABLE `recensione`
  ADD CONSTRAINT `FK_RECENSIONE_CONTENUTO` FOREIGN KEY (`FKID_Contenuto`) REFERENCES `contenuto` (`ID_Contenuto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_RECENSIONE_UTENTE` FOREIGN KEY (`FKID_Utente`) REFERENCES `utente` (`ID_Utente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Limiti per la tabella `serie`
--
ALTER TABLE `serie`
  ADD CONSTRAINT `FK_SERIE_CONTENUTO` FOREIGN KEY (`FKID_Serie`) REFERENCES `contenuto` (`ID_Contenuto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `utente`
--
ALTER TABLE `utente`
  ADD CONSTRAINT `FK_UTENTE_ABBONAMENTO` FOREIGN KEY (`FKID_Abbonamento`) REFERENCES `abbonamento` (`ID_Abbonamento`) ON UPDATE CASCADE;

--
-- Limiti per la tabella `visionabile`
--
ALTER TABLE `visionabile`
  ADD CONSTRAINT `FK_VISIONABILE_CONTENUTO` FOREIGN KEY (`FKID_Visionabile`) REFERENCES `contenuto` (`ID_Contenuto`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
