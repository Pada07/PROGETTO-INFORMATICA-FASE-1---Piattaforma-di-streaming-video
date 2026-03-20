<?php
session_start();
session_destroy(); // elimina TUTTE le variabili denro $_SESSION[]
header("Location: auth.php");
exit();
?>