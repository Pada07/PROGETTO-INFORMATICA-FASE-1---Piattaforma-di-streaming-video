<?php
session_start();
require_once '../config/db.php';

$id_utente = $_SESSION['id_utente_loggato']; 
$nome_acc  = $_POST['nome_acc']; 
$tipo_acc  = $_POST['tipo_acc']; 

$query = "INSERT INTO ACCOUNT (FKID_Utente, nomeAcc, tipoAcc) VALUES ($id_utente, '$nome_acc', '$tipo_acc')";

if ($connessione->query($query) === TRUE) {
    header("Location: scegli_account.php");
    exit();
} else {
    echo "Errore: " . $connessione->error;
}
?>