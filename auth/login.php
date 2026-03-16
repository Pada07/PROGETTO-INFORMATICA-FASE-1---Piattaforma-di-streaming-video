<?php
// Avvia la sessione per poter ricordare l'utente nelle pagine successive
session_start();
// Richiama la connessione al database
require_once '../config/db.php';

// Raccoglie i dati inviati dal form. NOTA: $pwd qui è già un hash SHA-256, grazie al JS
$email = $_POST['email'];
$pwd   = $_POST['pwd']; 

// Cerca nel DB un utente che abbia la mail inserita nel form
$query = "SELECT ID_Utente, pwd, salt FROM UTENTE WHERE email = '$email'";
$risultato = $connessione->query($query);

// Se trova almeno una riga (quindi la mail esiste nel DB)
if($risultato->num_rows > 0){
    // Estrae i dati dell'utente dal risultato della query
    $row = $risultato->fetch_assoc();

    // Divide a metà la stringa del 'salt' (la parola casuale usata per sporcare l'hash)
    $salt_div = str_split($row["salt"], strlen($row["salt"])/2);
    
    // Ricrea l'hash di controllo assemblando: prima metà del salt + password del JS + seconda metà del salt
    $pass_salt = hash('sha256', $salt_div[0] . $pwd . $salt_div[1]);

    // Controlla se l'hash appena calcolato è identico a quello salvato nel database
    if($pass_salt === $row["pwd"]) {
        // Se coincidono, la password è giusta! Salva l'ID in sessione per mantenerlo loggato
        $_SESSION['id_utente_loggato'] = $row['ID_Utente'];
        // Lo reindirizza alla sua area personale
        header("Location: scegli_account.php");
        exit(); // Ferma lo script
    }
}

// Se il codice arriva qui significa che l'if ha fallito (mail inesistente o password errata).
// Lo rimanda alla pagina di login aggiungendo "?errore=1"
header("Location: auth.php?errore=1"); 
exit();
?>