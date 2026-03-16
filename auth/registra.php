<?php
session_start();
require_once '../config/db.php';

// Raccoglie i dati dal form (la password arriva già in SHA-256)
$telefono  = $_POST['telefono'];
$email     = $_POST['email'];
$pwd       = $_POST['pwd']; 
$nome      = $_POST['nome'];
$cognome   = $_POST['cognome'];
$indirizzo = $_POST['indirizzo'];

// Controllo di base sulla password
if(strlen($pwd) != 64 || $pwd === hash('sha256', '')){
    die("Hash password non valido"); 
}

// Genera il salt e crea la password definitiva
$salt = hash('sha256', rand());
$salt_div = str_split($salt, strlen($salt)/2);
$saved_pwd = hash('sha256', $salt_div[0] . $pwd . $salt_div[1]);

// Query di inserimento
$query = "INSERT INTO UTENTE (FKID_Abbonamento, telefono, email, pwd, nome, cognome, indirizzo, salt)
          VALUES (NULL, '$telefono', '$email', '$saved_pwd', '$nome', '$cognome', '$indirizzo', '$salt')";
// Proviamo a eseguire la query
try {
    if ($connessione->query($query) === TRUE) {
        $_SESSION['id_utente_loggato'] = $connessione->insert_id;
        header("Location: scegli_account.php");
        exit();
    }
} catch (mysqli_sql_exception $e) {
    // Se c'è un errore (es. email duplicata), catturiamo l'eccezione
    // e rimandiamo l'utente alla pagina iniziale con il messaggio di errore!
    header("Location: auth.php?errore_reg=1");
    exit();
}
?>