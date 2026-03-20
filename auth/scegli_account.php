<?php
session_start();
if (!isset($_SESSION['id_utente_loggato'])) {
    header("Location: auth.php");
    exit();
}

require_once '../config/db.php'; // copia e incolla il codice dentro al file db.php e lo esegue
$id_utente = $_SESSION['id_utente_loggato'];
?>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Chi sta guardando?</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-white text-center mt-5">
    <div class="container">
        <h1 class="mb-5">Chi sta guardando?</h1>
        <div class="row justify-content-center">
            
            <?php
            $query = "SELECT * FROM ACCOUNT WHERE FKID_Utente = $id_utente"; // creo la query per il database per prendere i profili collegati all'accout loggato in questo momento
            $risultato = $connessione->query($query); // ESEGUO la query e le righe risultanti le assegno alla variabile risultato.

            if ($risultato->num_rows > 0) { // controllo che la query abbia dato come risultato almeno una riga
                while ($profilo = $risultato->fetch_assoc()) { // fetch_assoc mi ritorna LA RIGA della query. in profilo io avrò riga per riga il risultato della mia query
                    echo "<div class='col-md-3 mb-4'>";
                    echo "  <a href='attiva_profilo.php?id_acc=" . $profilo['ID_Account'] . "&nome_acc=" . $profilo['nomeAcc'] . "' class='text-decoration-none text-white'>";
                    echo "      <div class='card bg-secondary text-white p-4'>";
                    echo "          <h3>" . $profilo['nomeAcc'] . "</h3>";
                    echo "          <small>" . $profilo['tipoAcc'] . "</small>";
                    echo "      </div>";
                    echo "  </a>";
                    echo "</div>";
                }
            } else {
                echo "<h3>Non hai ancora nessun profilo. Creane uno qui sotto!</h3>";
            }
            ?>

        </div>

        <hr class="mt-5 mb-4 border-light">

        <h3>Aggiungi un Profilo</h3>
        <form action="crea_account.php" method="POST" class="d-inline-block text-start bg-light text-dark p-3 rounded mt-2">
            Nome Profilo: <input type="text" name="nome_acc" class="form-control mb-2" required>
            Tipo: 
            <select name="tipo_acc" class="form-control mb-3">
                <option value="Adulto">Adulto</option>
                <option value="Bambino">Bambino</option>
                <option value="Famiglia">Famiglia</option>
            </select>
            <button type="submit" class="btn btn-success w-100">Crea Profilo</button>
        </form>
        <br><br>
        <a href="logout.php" class="text-danger">Disconnetti Utente</a>
    </div>
</body>
</html>