-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 29, 2026 alle 13:04
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
(0003, 0010, 'Massimo', 'Adulto'),
(0004, 0013, 'Aldo Moro', 'Adulto'),
(0005, 0013, 'Albino Moro', 'Bambino'),
(0006, 0014, 'Nathan', 'Adulto'),
(0007, 0017, 'Biagio', 'Adulto'),
(0008, 0018, 'Mich', 'Adulto'),
(0009, 0019, 'Nizzzz', 'Adulto'),
(0010, 0020, 'Eila alex', 'Adulto'),
(0011, 0021, 'Benito', 'Adulto'),
(0012, 0022, 'Hitlerino', 'Adulto'),
(0013, 0023, 'Nathan', 'Adulto');

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
  `cover` varchar(100) NOT NULL DEFAULT 'https://placehold.co/600x400?text=Cover+Film',
  `trailer` varchar(255) NOT NULL,
  `isWatchlist` tinyint(1) NOT NULL,
  `isPreferiti` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `contenuto`
--

INSERT INTO `contenuto` (`ID_Contenuto`, `titolo`, `trama`, `dataUscita`, `perBambini`, `cover`, `trailer`, `isWatchlist`, `isPreferiti`) VALUES
(00001, 'Martyrs', 'Due giovani donne, entrambe vittime di abusi subiti da bambine, intraprendono una sanguinosa ricerca di vendetta, solo per ritrovarsi immerse in un inferno di depravazione.', '2008-09-10', 0, '/Eccessolandia/img/00001.jpg', 'https://www.youtube.com/watch?v=V9xsvi8f9YI', 1, 1),
(00002, 'Inside', 'Dopo la morte di suo marito, Sarah vive sola. Alla vigilia del parto, Sarah riceve la visita di una donna misteriosa. Preoccupata, non apre la porta e decide di chiamare la polizia. Tuttavia, la sconosciuta è determinata ad entrare per parlarle.', '2007-03-15', 0, '/Eccessolandia/img/inside.jpg', 'https://www.youtube.com/watch?v=0wkrFF5j7ao', 1, 0),
(00003, 'High Tension', 'Una studentessa francese cerca di salvare un\'amica che è stata sequestrata da un assassino spietato.', '2003-06-20', 0, '/Eccessolandia/img/hightension.jpg', 'https://www.youtube.com/watch?v=ZsfqXekOvJQ', 0, 0),
(00004, 'Funeralopolis', 'La storia di due ragazzi caduti nel tunnel della droga', '2020-11-01', 0, '/Eccessolandia/img/funeralopolis.jpg', 'https://www.youtube.com/watch?v=2daoYpTHykI', 1, 0),
(00005, 'Titicut Follies', 'Tradotto dall\'inglese-Titicut Follies è un film documentario americano del 1967 prodotto, scritto e diretto da Frederick Wiseman e girato da John Marshall. Si tratta dei pazienti-detenuti del Bridgewater State Hospital for the Criminally Insane, un istituto correzionale del Massachusetts a Bridgewater, Massachusetts.', '1967-10-03', 0, '/Eccessolandia/img/titicutfollies.jpg', 'https://www.youtube.com/watch?v=w006coKAvoQ', 1, 1),
(00006, 'Faces of Death', '\"Le facce della morte\" (Faces of Death) è un controverso film \"mondo\" del 1978 che presenta una serie di sequenze, tra il reale e lo staged, sulla morte. Il Dr. Gröss introduce filmati che mostrano autopsie, sacrifici rituali, incidenti mortali, esecuzioni, scene di mattatoio e violenza animale/umana, esplorando diverse \"facce\" del decesso.', '1978-11-10', 0, '/Eccessolandia/img/facesofdeath.jpg', 'https://www.youtube.com/watch?v=WZpVAbT3tT4', 0, 1),
(00007, 'Twin Peaks', 'Twin Peaks è una serie cult creata da David Lynch e Mark Frost incentrata sull\'indagine dell\'agente FBI Dale Cooper per l\'omicidio della liceale Laura Palmer nella cittadina di montagna omonima. La trama unisce noir, soap opera e soprannaturale, esplorando l\'oscurità nascosta dietro la facciata idilliaca del paese. ', '1990-04-08', 0, '/Eccessolandia/img/lynch.jpg', '', 1, 0),
(00008, 'Twin Peaks Ep1', 'Episodio 1 della serie Twin Peaks.', '1990-04-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00009, 'Twin Peaks Ep2', 'Episodio 2 della serie Twin Peaks.', '1990-04-15', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00010, 'Twin Peaks Ep3', 'Episodio 3 della serie Twin Peaks.', '1990-04-22', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00011, 'Twin Peaks Ep4', 'Episodio 4 della serie Twin Peaks.', '1990-04-29', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00012, 'Salò o le 120 giornate di Sodoma', 'Quattro signori scelgono delle vittime per sottoporle a torture rituali.', '1975-11-22', 0, '/Eccessolandia/img/salo.jpg', 'https://www.youtube.com/watch?v=DDKj2XgkfbA', 0, 0),
(00013, 'A Serbian Film', 'Un pornodivo in pensione accetta un lavoro estremo che diventa un incubo.', '2010-06-16', 0, '/Eccessolandia/img/aserbianfilm.jpg', 'https://www.youtube.com/watch?v=RcHq2W1dXRU', 1, 1),
(00014, 'Cannibal Holocaust', 'Una spedizione scompare nella foresta amazzonica durante un documentario.', '1980-02-07', 0, '/Eccessolandia/img/cannibalholocaust.jpg', 'https://www.youtube.com/watch?v=IA--wEAbCgM', 0, 0),
(00015, 'Irréversible', 'Un uomo cerca giustizia dopo che la sua donna è stata brutalmente aggredita.', '2002-05-22', 0, '/Eccessolandia/img/irreversible.jpg', 'https://www.youtube.com/watch?v=qZOuJ5j2sv8', 1, 0),
(00016, 'Antichrist', 'Una coppia si ritira in un bosco per superare il lutto del figlio.', '2009-05-18', 0, '/Eccessolandia/img/antichrist.jpg', 'https://www.youtube.com/watch?v=LO-TNfPzh_k', 0, 1),
(00017, 'Audition', 'Un vedovo organizza falsi provini per trovare una nuova moglie.', '1999-10-06', 0, '/Eccessolandia/img/audition.jpg', 'https://www.youtube.com/watch?v=yB5yAgErL1o', 0, 0),
(00018, 'Ichi the Killer', 'Un sadico sicario si scontra con un boss della yakuza masochista.', '2001-09-14', 0, '/Eccessolandia/img/ichithekiller.jpg', 'https://www.youtube.com/watch?v=AmHxzsbAZZc', 0, 0),
(00019, 'Raw - Una cruda verità', 'Una studentessa vegetariana sviluppa una fame incontrollabile di carne.', '2016-05-14', 0, '/Eccessolandia/img/raw.jpg', 'https://www.youtube.com/watch?v=RL7wYofwi8g', 0, 0),
(00020, 'The Human Centipede', 'Uno scienziato pazzo tenta di unire chirurgicamente tre persone.', '2009-08-30', 0, '/Eccessolandia/img/thehumancentipede.jpg', 'https://www.youtube.com/watch?v=JdW1yPTBPFA', 0, 0),
(00021, 'Climax', 'Una festa di ballerini degenera nel caos dopo che il punch viene drogato.', '2018-05-13', 0, '/Eccessolandia/img/climax.jpg', 'https://www.youtube.com/watch?v=Hi69nL_VrTE', 0, 0),
(00022, 'The House That Jack Built', 'La storia di un serial killer che vede i suoi crimini come opere d’arte.', '2018-05-14', 0, '/Eccessolandia/img/jack.jpg', 'https://www.youtube.com/watch?v=c6DuLPGZIoQ', 0, 0),
(00023, 'Baskin - La porta dell\'inferno', 'Cinque poliziotti finiscono in una messa nera in un edificio abbandonato.', '2015-09-11', 0, '/Eccessolandia/img/baskin.jpg', 'https://www.youtube.com/watch?v=8HkO5Xdcs90', 0, 0),
(00024, 'Funny Games', 'Due giovani tengono in ostaggio una famiglia per puro gioco sadico.', '1997-05-14', 0, '/Eccessolandia/img/funnygames.jpg', 'https://www.youtube.com/watch?v=bH2HS6uWIhQ', 0, 0),
(00025, 'Nekromantik', 'Un uomo che lavora nella rimozione di cadaveri porta un corpo a casa.', '1987-01-29', 0, '/Eccessolandia/img/nekromantik.jpg', 'https://www.youtube.com/watch?v=JlQMhAka5BU', 0, 0),
(00026, 'The Sadness', 'Un virus trasforma la popolazione di Taiwan in maniaci ultra-violenti.', '2021-01-22', 0, '/Eccessolandia/img/thesadness.jpg', 'https://www.youtube.com/watch?v=q2lNlfQPTFg', 0, 0),
(00027, 'Titane', 'Una giovane donna con una placca di titanio in testa compie atti folli.', '2021-07-13', 0, '/Eccessolandia/img/titane.jpg', 'https://www.youtube.com/watch?v=i8WhYblLjrs', 0, 0),
(00028, 'Terrifier 2', 'Art il Clown ritorna per tormentare due fratelli la notte di Halloween.', '2022-08-29', 0, '/Eccessolandia/img/terrifier.jpg', 'https://www.youtube.com/watch?v=wD_vSiqCw_I', 0, 0),
(00029, 'Men dietro il sole', 'Resoconto delle atrocità commesse dall\'Unità 731 durante la guerra.', '1988-12-01', 0, '/Eccessolandia/img/men.jpg', '', 0, 0),
(00030, 'Frontier(s)', 'Un gruppo di criminali in fuga finisce nelle mani di una famiglia neonazista.', '2007-07-01', 0, '/Eccessolandia/img/frontiers.jpg', 'https://www.youtube.com/watch?v=HPkJCKfboRw', 0, 0),
(00031, 'Hostel', 'Tre turisti finiscono in una struttura dove i ricchi pagano per torturare.', '2005-09-17', 0, '/Eccessolandia/img/hostel.jpg', 'https://www.youtube.com/watch?v=R0ShE0EbcCA', 0, 0),
(00032, 'Twin Peaks Ep2x01', 'Il gigante appare a Cooper ferito nella sua stanza d\'albergo.', '1990-09-30', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00033, 'Twin Peaks Ep2x02', 'Donna incontra l\'inquietante Harold Smith.', '1990-10-06', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00034, 'Twin Peaks Ep2x03', 'L\'indagine sulla morte di Laura Palmer prosegue tra visioni e realtà.', '1990-10-13', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00035, 'Twin Peaks Ep2x04', 'Cooper e lo sceriffo Truman seguono nuove piste nel bosco.', '1990-10-20', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00036, 'The ABCs of Death', 'Una serie antologica dove ogni episodio è diretto da un regista diverso e dedicato a una lettera dell\'alfabeto che rappresenta un modo di morire.', '2012-03-08', 0, '/Eccessolandia/img/abc.jpg', 'https://www.youtube.com/watch?v=fS6aL6V89SA', 1, 1),
(00037, 'A is for Apocalypse', 'Un brutale omicidio domestico durante l\'inizio della fine del mondo.', '2012-03-08', 0, 'https://placehold.co/600x400?text=A+is+for+Apocalypse', '', 0, 0),
(00038, 'L is for Libido', 'Un gioco perverso di resistenza sessuale e psicologica.', '2012-03-08', 0, 'https://placehold.co/600x400?text=L+is+for+Libido', '', 0, 0),
(00039, 'A is for Amateur', 'Un killer professionista commette un errore fatale durante un colpo.', '2014-10-02', 0, 'https://placehold.co/600x400?text=A+is+for+Amateur', '', 0, 0),
(00040, 'Z is for Zygote', 'Una madre e una figlia vivono una gravidanza horror estrema.', '2014-10-02', 0, 'https://placehold.co/600x400?text=Z+is+for+Zygote', '', 0, 0),
(00041, 'B is for Bigfoot', 'Segmento B - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00042, 'C is for Cycle', 'Segmento C - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00043, 'D is for Dogfight', 'Segmento D - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00044, 'E is for Exterminate', 'Segmento E - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00045, 'F is for Fart', 'Segmento F - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00046, 'G is for Gravity', 'Segmento G - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00047, 'H is for Hydro-Electric Diffusion', 'Segmento H - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00048, 'I is for Ingrown', 'Segmento I - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00049, 'J is for Jidai-geki', 'Segmento J - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00050, 'K is for Klutz', 'Segmento K - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00051, 'M is for Miscarriage', 'Segmento M - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00052, 'N is for Nuptials', 'Segmento N - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00053, 'O is for Orgasm', 'Segmento O - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00054, 'P is for Pressure', 'Segmento P - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00055, 'Q is for Quack', 'Segmento Q - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00056, 'R is for Removed', 'Segmento R - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00057, 'S is for Speed', 'Segmento S - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00058, 'T is for Toilet', 'Segmento T - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00059, 'U is for Unearthed', 'Segmento U - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00060, 'V is for Vagitus', 'Segmento V - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00061, 'W is for WTF!', 'Segmento W - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00062, 'X is for XXL', 'Segmento X - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00063, 'Y is for Youngbuck', 'Segmento Y - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00064, 'Z is for Zetsumetsu', 'Segmento Z - Stagione 1', '2012-03-08', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00065, 'B is for Badger', 'Segmento B - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00066, 'C is for Capital Punishment', 'Segmento C - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00067, 'D is for Deloused', 'Segmento D - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00068, 'E is for Equilibrium', 'Segmento E - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00069, 'F is for Faction', 'Segmento F - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00070, 'G is for Grandad', 'Segmento G - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00071, 'H is for Headstick', 'Segmento H - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00072, 'I is for Invincible', 'Segmento I - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00073, 'J is for Jesus', 'Segmento J - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00074, 'K is for Knell', 'Segmento K - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00075, 'L is for Listen', 'Segmento L - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00076, 'M is for Masticate', 'Segmento M - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00077, 'N is for Nexus', 'Segmento N - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00078, 'O is for Ochlocracy', 'Segmento O - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00079, 'P is for P-P-P-P Scary!', 'Segmento P - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00080, 'Q is for Questionnaire', 'Segmento Q - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00081, 'R is for Roulette', 'Segmento R - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00082, 'S is for Split', 'Segmento S - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00083, 'T is for Torture Porn', 'Segmento T - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00084, 'U is for Utopia', 'Segmento U - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00085, 'V is for Vacation', 'Segmento V - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00086, 'W is for Women', 'Segmento W - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00087, 'X is for Xylophone', 'Segmento X - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0),
(00088, 'Y is for Youth', 'Segmento Y - Stagione 2', '2014-10-02', 0, 'https://placehold.co/600x400?text=Cover+Film', '', 0, 0);

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
(00011, 00007, 1, 4),
(00032, 00007, 2, 1),
(00033, 00007, 2, 2),
(00034, 00007, 2, 3),
(00035, 00007, 2, 4),
(00037, 00036, 1, 1),
(00041, 00036, 1, 2),
(00042, 00036, 1, 3),
(00043, 00036, 1, 4),
(00044, 00036, 1, 5),
(00045, 00036, 1, 6),
(00046, 00036, 1, 7),
(00047, 00036, 1, 8),
(00048, 00036, 1, 9),
(00049, 00036, 1, 10),
(00050, 00036, 1, 11),
(00038, 00036, 1, 12),
(00051, 00036, 1, 13),
(00052, 00036, 1, 14),
(00053, 00036, 1, 15),
(00054, 00036, 1, 16),
(00055, 00036, 1, 17),
(00056, 00036, 1, 18),
(00057, 00036, 1, 19),
(00058, 00036, 1, 20),
(00059, 00036, 1, 21),
(00060, 00036, 1, 22),
(00061, 00036, 1, 23),
(00062, 00036, 1, 24),
(00063, 00036, 1, 25),
(00064, 00036, 1, 26),
(00039, 00036, 2, 1),
(00065, 00036, 2, 2),
(00066, 00036, 2, 3),
(00067, 00036, 2, 4),
(00068, 00036, 2, 5),
(00069, 00036, 2, 6),
(00070, 00036, 2, 7),
(00071, 00036, 2, 8),
(00072, 00036, 2, 9),
(00073, 00036, 2, 10),
(00074, 00036, 2, 11),
(00075, 00036, 2, 12),
(00076, 00036, 2, 13),
(00077, 00036, 2, 14),
(00078, 00036, 2, 15),
(00079, 00036, 2, 16),
(00080, 00036, 2, 17),
(00081, 00036, 2, 18),
(00082, 00036, 2, 19),
(00083, 00036, 2, 20),
(00084, 00036, 2, 21),
(00085, 00036, 2, 22),
(00086, 00036, 2, 23),
(00087, 00036, 2, 24),
(00088, 00036, 2, 25),
(00040, 00036, 2, 26);

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
(00003),
(00012),
(00013),
(00014),
(00015),
(00016),
(00017),
(00018),
(00019),
(00020),
(00021),
(00022),
(00023),
(00024),
(00025),
(00026),
(00027),
(00028),
(00029),
(00030),
(00031);

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
(04, 'Psicologico'),
(06, 'Avventura'),
(07, 'Drammatico'),
(08, 'Animazione'),
(09, 'Noir'),
(10, 'Guerra'),
(11, 'Storico');

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
(0004, 'Emma', 'Roberts', 1),
(0005, 'Pier Paolo', 'Pasolini', 20),
(0006, 'Lars', 'von Trier', 15),
(0007, 'Gaspar', 'Noé', 10),
(0008, 'Takashi', 'Miike', 100),
(0009, 'Julia', 'Ducournau', 3),
(0010, 'Ruggero', 'Deodato', 25),
(0011, 'Srdjan', 'Spasojevic', 1),
(0012, 'Michael', 'Haneke', 12),
(0013, 'David', 'Cronenberg', 22),
(0014, 'Lars', 'Eidinger', 45);

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
(00007, 02),
(00012, 04),
(00012, 07),
(00013, 01),
(00013, 02),
(00013, 04),
(00014, 01),
(00014, 06),
(00015, 02),
(00015, 04),
(00015, 07),
(00016, 01),
(00016, 04),
(00016, 07),
(00017, 01),
(00017, 02),
(00017, 04),
(00018, 01),
(00018, 02),
(00018, 09),
(00019, 01),
(00019, 07),
(00020, 01),
(00020, 04),
(00021, 02),
(00021, 04),
(00021, 07),
(00022, 01),
(00022, 04),
(00022, 07),
(00023, 01),
(00023, 04),
(00024, 02),
(00024, 04),
(00024, 07),
(00025, 01),
(00025, 07),
(00026, 01),
(00026, 02),
(00027, 01),
(00027, 04),
(00027, 07),
(00028, 01),
(00028, 02),
(00029, 07),
(00029, 10),
(00029, 11),
(00030, 01),
(00030, 02),
(00031, 01),
(00031, 02),
(00036, 01),
(00036, 02),
(00037, 01),
(00038, 01),
(00039, 02),
(00040, 01);

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
(001, 00016),
(002, 00002),
(002, 00003),
(003, 00004),
(003, 00005),
(003, 00006),
(003, 00022),
(005, 00027),
(009, 00019),
(009, 00021),
(010, 00013);

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
(0001, 00012, 'Regista'),
(0002, 00004, 'Regista'),
(0002, 00016, 'Regista'),
(0002, 00022, 'Regista'),
(0003, 00001, 'Protagonista'),
(0003, 00015, 'Regista'),
(0003, 00021, 'Regista'),
(0004, 00002, 'Protagonista'),
(0004, 00017, 'Regista'),
(0004, 00018, 'Regista'),
(0005, 00019, 'Regista'),
(0005, 00027, 'Regista'),
(0006, 00014, 'Regista'),
(0007, 00013, 'Regista'),
(0008, 00024, 'Regista');

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
(003, 'Documentary Italia'),
(004, 'Warner Bros. Pictures'),
(005, 'Walt Disney Pictures'),
(006, 'Universal Pictures'),
(007, 'Paramount Pictures'),
(008, 'Sony Pictures'),
(009, '20th Century Studios'),
(010, 'Metro-Goldwyn-Mayer (MGM)'),
(011, 'Lionsgate Films'),
(012, 'A24'),
(013, 'Netflix Studios'),
(014, 'Amazon MGM Studios'),
(015, 'DreamWorks Animation'),
(016, 'Studio Ghibli'),
(017, 'Lucasfilm'),
(018, 'Marvel Studios');

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
(00007),
(00036);

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
(0010, NULL, '7423874692376', 'massimo@gmail.com', '170344603a319a054b3fb9f1e50f66c504a460ac1f86ef30aee2fff47b7f667c', '814ede349ae8e4fa994d2c35696dfaefa4a95ddcdda6d5fd3e878226a3cc4a77', 'Massimo', 'Padalino', 'Via Casa Mia'),
(0013, NULL, '3274475324', 'aldomoro@gmail.com', 'f99bcf972beffa09600abb480073fc9795966a3226733f73e590830fa70183e5', '8e98e1b710711a070c8a7b7be4cf8696f22c67280359ce7fb158c92a51fb2835', 'Aldo', 'Moro', 'Via Roma'),
(0014, NULL, '65765421357', 'nathan@gmail.com', 'c410a73e099c05dcaad4136a707c309c99bd0eb50a50beb11f05e821c1e7db30', 'a196cbb4b7fe40129e0f5ed20435447adf7d89dc552abf0520c59312ddb4e518', 'Nathan', 'Luboz', 'Via Introd'),
(0017, NULL, '32456897543', 'biagio@gmail.com', '57754d3a8262d56ab28beb57d9b42a60ca0832871e58cc7870938e43d2646844', 'e894e6ec647832393d1d2a8f331772fd6c8e366ae62183849cef8737b928984f', 'Biagio', 'Bechaz', 'Via Biagio'),
(0018, NULL, '36546843241', 'fucknigs@mail.com', '9f37154926edc92367680817d8c7bb402de611238fcb888bde453e332fd20a02', '41ecc7b2095ba6b48a5f6e5dbf39e2dc5e704c9bba18acb2d8870681a1419fd2', 'Michele', 'Facchineri', 'Via Ne'),
(0019, NULL, '65765435465', 'nizar@mail.com', '67fa6232308e93d558e7d0d04eb7ebb869e903022e5667e5285c6b17cad3efa1', '6d2ef8c0c80357dedef35e0be980a8ba06e26c4f72d9551f7d579a3a19913cb5', 'Nizar', 'Souit', 'Via dei matti n°15'),
(0020, NULL, '6354765432', 'riccardo@mail.com', '4dca3c161df03b9bf870f7c2fbffff3246d65336625d980f4ab4efaa868d772a', 'b5959be12538527806a1481e094108af4012aaa97d6057fc9985666be0ba1a08', 'Riccardo', 'Fantozzi', 'Via tu suru'),
(0021, NULL, '6576516846', 'dvx@mail.com', 'e1fbd0cb165693c2f80c4d2c3c9ccbc102814e2cfbc88a784d0e8ca9e3ae1251', 'ccaa872dd7f4e606016c4d117fac960a8d288ebb1df5a021400490322c4ce7ff', 'Benito', 'Mussolini', 'Via Roma'),
(0022, NULL, '6854354654', 'terzoreich@mail.com', '9957d5a6ad0ce78e7eb1c6dbe90d6d529616d0f0f3f649c1985d54b3eb8b72ef', 'bcf0a6520f40be4804339e068e7ead1eec9f1b68979db3327264547b821b809e', 'Aldofus', 'Hitlerino', 'Via Rastrellamento di Juden'),
(0023, NULL, '2378459237652', 'nathan@mail.com', 'a1a6285d40d3249077139a09738231ec7ba654cdc12c22bf9be8b64a298dc573', '66c8416be492b99ae4e58a08796d27b29a1259e46c45ffa9a3b4a133400a19a1', 'Nathan', 'Luboz', 'Via Introd');

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
(00011, 47, 1),
(00012, 117, 1),
(00013, 104, 0),
(00014, 95, 1),
(00015, 97, 1),
(00016, 108, 1),
(00017, 115, 1),
(00018, 129, 1),
(00019, 99, 1),
(00020, 92, 0),
(00021, 99, 1),
(00022, 152, 1),
(00023, 97, 1),
(00024, 108, 1),
(00025, 71, 0),
(00026, 99, 1),
(00027, 108, 1),
(00028, 138, 1),
(00029, 105, 0),
(00030, 108, 1),
(00031, 94, 1),
(00032, 94, 1),
(00033, 47, 1),
(00034, 48, 1),
(00035, 46, 1),
(00037, 5, 1),
(00038, 7, 1),
(00039, 4, 1),
(00040, 12, 1),
(00041, 4, 1),
(00042, 4, 1),
(00043, 8, 1),
(00044, 5, 1),
(00045, 3, 1),
(00046, 2, 1),
(00047, 4, 1),
(00048, 5, 1),
(00049, 6, 1),
(00050, 4, 1),
(00051, 5, 1),
(00052, 5, 1),
(00053, 7, 1),
(00054, 6, 1),
(00055, 5, 1),
(00056, 6, 1),
(00057, 5, 1),
(00058, 10, 1),
(00059, 6, 1),
(00060, 5, 1),
(00061, 5, 1),
(00062, 6, 1),
(00063, 4, 1),
(00064, 12, 1),
(00065, 3, 1),
(00066, 4, 1),
(00067, 9, 1),
(00068, 4, 1),
(00069, 6, 1),
(00070, 6, 1),
(00071, 6, 1),
(00072, 4, 1),
(00073, 8, 1),
(00074, 5, 1),
(00075, 6, 1),
(00076, 6, 1),
(00077, 5, 1),
(00078, 4, 1),
(00079, 5, 1),
(00080, 6, 1),
(00081, 6, 1),
(00082, 6, 1),
(00083, 7, 1),
(00084, 4, 1),
(00085, 6, 1),
(00086, 4, 1),
(00087, 4, 1),
(00088, 5, 1);

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
  MODIFY `ID_Account` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT per la tabella `contenuto`
--
ALTER TABLE `contenuto`
  MODIFY `ID_Contenuto` int(5) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT per la tabella `genere`
--
ALTER TABLE `genere`
  MODIFY `ID_Genere` int(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT per la tabella `persona`
--
ALTER TABLE `persona`
  MODIFY `ID_Persona` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT per la tabella `produzione`
--
ALTER TABLE `produzione`
  MODIFY `ID_Produzione` int(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
  MODIFY `ID_Utente` int(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

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
