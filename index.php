<?php
session_start();

// Se l'utente HA GIÀ fatto il login (ha l'ID in sessione)
if (isset($_SESSION['id_utente_loggato'])) {
    header("Location: auth/scegli_account.php");
    exit();
} else {
    // Altrimenti lo mandiamo a fare il login
    header("Location: auth/auth.php");
    exit();
}
?>