<?php
session_start();

// Controllo di sicurezza: se non sei loggato, fuori di qui
if (!isset($_SESSION['id_utente_loggato'])) {
    header("Location: ../auth/auth.php");
    exit();
}

require_once '../config/db.php';

// Prendiamo l'ID dalla sessione e i nuovi dati dal form
$id_utente = $_SESSION['id_utente_loggato'];
$nome      = $_POST['nome'];
$cognome   = $_POST['cognome'];
$telefono  = $_POST['telefono'];
$indirizzo = $_POST['indirizzo'];

// Scriviamo la query per aggiornare SOLO la riga di questo utente specifico
$query = "UPDATE UTENTE 
          SET nome = '$nome', 
              cognome = '$cognome', 
              telefono = '$telefono', 
              indirizzo = '$indirizzo' 
          WHERE ID_Utente = $id_utente";

// Usiamo il try-catch per intercettare eventuali errori 
try {
    if ($connessione->query($query) === TRUE) {
        // Aggiornamento perfetto! Rimandiamo al profilo con il flag di successo
        header("Location: profilo.php?successo=1");
        exit();
    } else {
        // Errore generico (raro, ma gestito)
        header("Location: profilo.php?errore=1");
        exit();
    }
} catch (mysqli_sql_exception $e) {
    //
    // catturiamo l'errore e rimandiamo l'utente al profilo
    header("Location: profilo.php?errore=1");
    exit();
}
?>