<?php
session_start();
$_SESSION['id_account_attivo'] = $_GET['id_acc']; // prendo il valore dell'ID Account usando la GET. il valore mi è stato passato utilizzando la sintassi "?id_acc=IDACCOUT"
$_SESSION['nome_account_attivo'] = $_GET['nome_acc'];

// Usciamo da auth/ ed entriamo in catalogo/
header("Location: ../catalogo/home.php");
exit();
?>