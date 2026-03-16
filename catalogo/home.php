<?php
session_start();
if (!isset($_SESSION['id_account_attivo'])) {
    header("Location: ../auth/scegli_account.php");
    exit();
}
require_once '../config/db.php'; // require_once è l'equivalente automatico del copia e incolla.
?>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Home - EccessoLandia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="home.php">EccessoLandia</a>
            <div>
                <span class="text-warning me-3">In visione: <?php echo $_SESSION['nome_account_attivo']; ?></span>
                <a class="text-white text-decoration-none me-3" href="../auth/scegli_account.php">Cambia Profilo</a>
                <a class="text-white text-decoration-none" href="../utente/profilo.php">Il mio Account</a>
            </div>
        </div>
    </nav>

    <div class="container">
        <h2 class="mb-4">Catalogo di <?php echo $_SESSION['nome_account_attivo']; ?></h2>

        <h3 class="mt-4 border-bottom pb-2">Film</h3>
        <div class="row">

            <?php
            $query_film = "SELECT C.ID_Contenuto, C.titolo, C.trama
                            FROM CONTENUTO C
                            JOIN VISIONABILE V ON C.ID_Contenuto = V.FKID_Visionabile
                            JOIN FILM F ON C.ID_Contenuto = F.FKID_Film"; // query per selezionare TUTTI i film nel catalogo            
            $risultato_film = $connessione->query($query_film);

            if ($risultato_film->num_rows > 0) {
                while($film = $risultato_film->fetch_assoc()) {
                    $id_cont = $film['ID_Contenuto'];
                    echo "<div class='col-md-3 mb-3'>";
                    echo "  <div class='card shadow-sm h-100'>";
                    echo "      <div class='card-body'>";
                    echo "          <h5 class='card-title'>" . $film['titolo'] . "</h5>";
                    
                    // --- RECUPERO I GENERI PER QUESTO FILM ---
                    $query_generi = "SELECT G.nome FROM GENERE G JOIN PONTECONTENUTOGENERE PCG ON G.ID_Genere = PCG.FKID_Genere WHERE PCG.FKID_Contenuto = $id_cont"; // query per selezionare i generi del fill
                    $risultato_generi = $connessione->query($query_generi);
                    echo "<div class='mb-2'>"; // Contenitore per le etichette colorate carine
                    while($genere = $risultato_generi->fetch_assoc()) {
                        echo "<span class='badge bg-secondary me-1'>" . $genere['nome'] . "</span>";
                    }
                    echo "</div>";
                    // -----------------------------------------

                    echo "          <p class='card-text text-truncate'>" . $film['trama'] . "</p>";
                    echo "          <a href='dettaglio.php?id=$id_cont' class='btn btn-primary btn-sm w-100'>Dettagli</a>";
                    echo "      </div>";
                    echo "  </div>";
                    echo "</div>";
                }
            } 
            ?>
            
        </div>

        <h3 class="mt-5 border-bottom pb-2">Serie TV</h3>
        <div class="row">
            <?php
            $query_serie = "SELECT C.ID_Contenuto, C.titolo, C.trama FROM CONTENUTO C JOIN SERIE S ON C.ID_Contenuto = S.FKID_Serie";
            $risultato_serie = $connessione->query($query_serie);

            if ($risultato_serie->num_rows > 0) {
                while($serie = $risultato_serie->fetch_assoc()) {
                    $id_cont = $serie['ID_Contenuto'];
                    echo "<div class='col-md-3 mb-3'>";
                    echo "  <div class='card shadow-sm h-100 border-primary'>";
                    echo "      <div class='card-body'>";
                    echo "          <h5 class='card-title'>" . $serie['titolo'] . "</h5>";
                    
                    // --- RECUPERO I GENERI PER QUESTA SERIE ---
                    $query_generi = "SELECT G.nome FROM GENERE G JOIN PONTECONTENUTOGENERE PCG ON G.ID_Genere = PCG.FKID_Genere WHERE PCG.FKID_Contenuto = $id_cont";
                    $risultato_generi = $connessione->query($query_generi);
                    echo "<div class='mb-2'>";
                    while($genere = $risultato_generi->fetch_assoc()) {
                        echo "<span class='badge bg-primary me-1'>" . $genere['nome'] . "</span>";
                    }
                    echo "</div>";
                    // -----------------------------------------

                    echo "          <p class='card-text text-truncate'>" . $serie['trama'] . "</p>";
                    echo "          <a href='dettaglio.php?id=$id_cont' class='btn btn-outline-primary btn-sm w-100'>Esplora Episodi</a>";
                    echo "      </div>";
                    echo "  </div>";
                    echo "</div>";
                }
            }
            ?>
        </div>

        <h3 class="mt-5 border-bottom pb-2">Documentari</h3>
        <div class="row mb-5">
            <?php
                $query_doc = "SELECT C.ID_Contenuto, C.titolo, C.trama, D.categoria
                            FROM CONTENUTO C
                            JOIN VISIONABILE V ON C.ID_Contenuto = V.FKID_Visionabile
                            JOIN DOCUMENTARIO D ON C.ID_Contenuto = D.FKID_Documentario";  
            $risultato_doc = $connessione->query($query_doc);

            if ($risultato_doc->num_rows > 0) {
                while($doc = $risultato_doc->fetch_assoc()) {
                    echo "<div class='col-md-3 mb-3'>";
                    echo "  <div class='card shadow-sm h-100 border-success'>";
                    echo "      <div class='card-body'>";
                    echo "          <h5 class='card-title'>" . $doc['titolo'] . "</h5>";
                    echo "          <span class='badge bg-success mb-2'>" . $doc['categoria'] . "</span>";
                    echo "          <p class='card-text text-truncate'>" . $doc['trama'] . "</p>";
                    echo "          <a href='dettaglio.php?id=" . $doc['ID_Contenuto'] . "' class='btn btn-success btn-sm w-100'>Dettagli</a>";
                    echo "      </div>";
                    echo "  </div>";
                    echo "</div>";
                }
            } 
            ?>
        </div>
    </div>
</body>
</html>