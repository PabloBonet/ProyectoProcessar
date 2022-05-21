<?php
include_once '../inc/config.inc.php';
checksession("usuario");

if (!empty($_GET['usuario']) && !isValidNumber($_GET['usuario'])) {
    header('Location:index.php');exit();
}
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <? include_once '../common_head.inc.php'; ?>
        <title>Panel Usuarios</title>
    </head>
    <body>
        <div class="container">
            <? include_once '../header.inc.php'; ?>
            <div class="row">
                <div class="col-md-4">
                    <?
                    include_once 'menu-usuario.php';
                    ?>
                </div>
                <div class="col-md-8">
                    <h1 class="title">Bienvenido a su cuenta de usuario</h1>
                    <p>&laquo;--- Seleccione una opci&oacute;n del menu</p>
                </div>
                <div class="clear"></div><br>
            </div>
        </div>
        <? include_once '../footer.inc.php'; ?>
    </body>

</html>