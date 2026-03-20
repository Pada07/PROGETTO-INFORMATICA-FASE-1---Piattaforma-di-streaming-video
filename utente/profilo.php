<?php
// Avviamo la sessione per controllare se l'utente è loggato
session_start();

// Se l'utente NON è loggato (la variabile di sessione non esiste), lo cacciamo alla pagina di login
if (!isset($_SESSION['id_utente_loggato'])) {
    header("Location: ../auth/auth.php");
    exit();
}

require_once '../config/db.php';
// Recuperiamo l'ID dell'utente dalla sessione
$id_utente = $_SESSION['id_utente_loggato'];

// Recuperiamo tutti i suoi dati attuali dal database per riempire il form
$query = "SELECT * FROM UTENTE WHERE ID_Utente = $id_utente";
$risultato = $connessione->query($query);
$dati = $risultato->fetch_assoc();
?>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Utente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="../catalogo/home.php">Eccessolandia</a>
            <div>
                <a class="text-white text-decoration-none me-3" href="../catalogo/home.php">Torna al Catalogo</a>
                <a class="text-danger text-decoration-none" href="../auth/logout.php">Esci (Logout)</a>
            </div>
        </div>
    </nav>

    <div class="container" style="max-width: 600px;">
        <div class="card shadow-sm p-4">
            <h2 class="mb-4">I tuoi Dati Personali</h2>
            
            <?php
            //  Gestione dei messaggi di feedback!
            // Se l'aggiornamento va a buon fine, mostra un avviso verde
            if (isset($_GET['successo'])) {
                echo "<div class='alert alert-success'>Profilo aggiornato con successo!</div>";
            }
            // Se c'è un errore nel database, mostra un avviso rosso
            if (isset($_GET['errore'])) {
                echo "<div class='alert alert-danger'>Si è verificato un errore durante il salvataggio. Riprova!</div>";
            }
            ?>
            
            <form action="aggiorna_profilo.php" method="POST">
                
                <label>Nome:</label>
                <input type="text" name="nome" class="form-control mb-3" value="<?php echo $dati['nome']; ?>" required>
                
                <label>Cognome:</label>
                <input type="text" name="cognome" class="form-control mb-3" value="<?php echo $dati['cognome']; ?>" required>
                
                <label>Telefono:</label>
                <input type="text" name="telefono" class="form-control mb-3" value="<?php echo $dati['telefono']; ?>" required>
                
                <label>Indirizzo:</label>
                <input type="text" name="indirizzo" class="form-control mb-3" value="<?php echo $dati['indirizzo']; ?>" required>
                
                <button type="submit" class="btn btn-primary w-100">Salva Modifiche</button>
            </form>
        </div>
    </div>
</body>
</html>