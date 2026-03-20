<?php
// Questo file si occupa SOLO di creare la connessione.
$connessione = new mysqli("localhost", "root", "", "eccessolandiapadalino");

if ($connessione->connect_error) {
    die("Errore di connessione al database: " . $connessione->connect_error);
}
// Niente tag di chiusura ?> 