<?php
session_start();
if (!isset($_SESSION['id_account_attivo'])) {
    header("Location: ../auth/scegli_account.php");
    exit();
}
require_once '../config/db.php';

if (!isset($_GET['id'])) { die("Nessun contenuto selezionato."); }
$id_contenuto = $_GET['id'];

// 1. Dati base
$query_base = "SELECT * FROM CONTENUTO WHERE ID_Contenuto = $id_contenuto";
$risultato_base = $connessione->query($query_base);
if ($risultato_base->num_rows == 0) { die("Contenuto non trovato."); }
$contenuto = $risultato_base->fetch_assoc();

$query_is_serie = "SELECT * FROM SERIE WHERE FKID_Serie = $id_contenuto"; // query per trovare il contenuto dentro la tabella SERIE
$is_serie = ($connessione->query($query_is_serie)->num_rows > 0); // se la query non dà risultati, significa che il contenuto NON è una serie
?>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title><?php echo $contenuto['titolo']; ?> - Eccessolandia</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-dark text-white">

    <nav class="navbar navbar-dark bg-black mb-4">
        <div class="container">
            <a class="navbar-brand" href="home.php">Eccessolandia</a>
            <a class="text-white text-decoration-none" href="home.php">Torna al Catalogo</a>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8">

                <h1 class="display-4 font-weight-bold">
                    <?php echo $contenuto['titolo']; ?>
                    <?php if($contenuto['perBambini']) echo "<span class='badge bg-info fs-6 align-middle'> Kids </span>"; ?>
                </h1>
                
                <div class="mt-2 mb-3">
                    <?php // stampo i generi del contenuto 
                    $query_gen = "SELECT G.nome FROM GENERE G JOIN PONTECONTENUTOGENERE PCG ON G.ID_Genere = PCG.FKID_Genere WHERE PCG.FKID_Contenuto = $id_contenuto";
                    $res_gen = $connessione->query($query_gen);
                    while($g = $res_gen->fetch_assoc()) {
                        echo "<span class='badge bg-secondary fs-6 me-2'>" . $g['nome'] . "</span>";
                    }
                    ?>
                </div>

                <p class="text">Data di Uscita: <?php echo $contenuto['dataUscita']; ?></p>
                <p class="lead mt-4"><?php echo $contenuto['trama']; ?></p>
                
                <?php if(!$is_serie): // se  NON è una serie visualizzo il bottone per riprodutte il FILM o DOCUMENTARIO?>
                    <button class="btn btn-danger btn-lg mt-3 px-5">RIPRODUCI</button>
                    <?php endif; 
                 ?>

                
                <img src="/img/<?php echo $contenuto['id_contenuto'] . '.' . $contenuto['ext']; ?>" alt="Locandina" class="img-fluid rounded mt-4">
                
            </div>

            <div class="col-md-4">
                <div class="card bg-secondary text-white mb-3">
                    <div class="card-body">
                        <h5 class="card-title text-warning">Cast & Troupe</h5>
                        <ul class="list-unstyled">
                            <?php
                            // CAST (Tabella PERSONA + PONTECONTENUTORECITATOPERSONA)
                            $query_cast = "SELECT P.nome, P.cognome, PCRP.ruolo 
                                           FROM PERSONA P 
                                           JOIN PONTECONTENUTORECITATOPERSONA PCRP ON P.ID_Persona = PCRP.FKID_Persona 
                                           WHERE PCRP.FKID_Contenuto = $id_contenuto";
                            $res_cast = $connessione->query($query_cast);
                            
                            if($res_cast->num_rows > 0){
                                while($persona = $res_cast->fetch_assoc()) {
                                    echo "<li><strong>" . $persona['nome'] . " " . $persona['cognome'] . "</strong><br>";
                                    echo "<small class='text-light'>Ruolo: " . $persona['ruolo'] . "</small></li><hr class='my-2 opacity-25'>";
                                }
                            } else { echo "<li><small>Nessun attore inserito.</small></li><hr class='my-2 opacity-25'>"; }
                            ?>
                        </ul>

                        <h5 class="card-title text-warning mt-4">Produzione</h5>
                        <ul class="list-unstyled">
                            <?php
                            // PRODUZIONE (Tabella PRODUZIONE + PONTECONTENUTOPRODUZIONE)
                            $query_prod = "SELECT PR.nome 
                                           FROM PRODUZIONE PR 
                                           JOIN PONTECONTENUTOPRODUZIONE PCP ON PR.ID_Produzione = PCP.FKID_Produzione 
                                           WHERE PCP.FKID_Contenuto = $id_contenuto";
                            $res_prod = $connessione->query($query_prod);
                            
                            if($res_prod->num_rows > 0){
                                while($prod = $res_prod->fetch_assoc()) {
                                    echo "<li>" . $prod['nome'] . "</li>";
                                }
                            } else { echo "<li><small>Nessuna casa di produzione inserita.</small></li>"; }
                            ?>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <?php if($is_serie): ?>
        <div class="mt-5 mb-5">
            <h3>Episodi</h3>
            <hr class="border-secondary">
            <div class="list-group">
            <?php
            $query_episodi = "
                SELECT 
                    E.nStag,
                    E.nEP,
                    C.titolo,
                    V.durataMinuti,
                    C.ID_Contenuto
                FROM EPISODIO E
                JOIN CONTENUTO C 
                    ON E.FKID_Episodio = C.ID_Contenuto
                JOIN VISIONABILE V 
                    ON E.FKID_Episodio = V.FKID_Visionabile
                WHERE E.FKID_SeriePadre = $id_contenuto
                ORDER BY E.nStag ASC, E.nEP ASC
            ";

            $risultato_episodi = $connessione->query($query_episodi);

            if ($risultato_episodi && $risultato_episodi->num_rows > 0) {
                while($ep = $risultato_episodi->fetch_assoc()) {
            ?>
                <div class="list-group-item bg-secondary text-white border-dark d-flex justify-content-between align-items-center mb-2 rounded">

                    <div>
                        <span class="text-warning me-3">
                            S<?php echo $ep['nStag']; ?> E<?php echo $ep['nEP']; ?>
                        </span>
                        <strong><?php echo $ep['titolo']; ?></strong>
                    </div>
                    <div>
                        <span class="text-light me-4">
                            <?php echo $ep['durataMinuti']; ?> min
                        </span>
                        <a class="btn btn-outline-light btn-sm">
                        ▶ Riproduci
                        </a>
                    </div>
                </div>
            <?php
                }
            } else {
                echo "<p class='text-muted'>Nessun episodio ancora caricato.</p>";
            }
            ?>

                </div>
            </div>
            <?php endif; ?>

        
        <?php  //img

            
        ?>
</html>