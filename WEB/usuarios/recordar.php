<?php
include_once '../inc/config.inc.php';
$errors = array();
if (!isset($_GET['ok']) && !empty($_POST)) {

    if (empty($_POST['email'])) {
        $errors['email'] = 'Ingrese un email';
    } else {
        if (!isValidEmail($_POST['email'])) {
            $errors['email'] = 'Ingrese un email v&aacute;lido';
        }
    }
    if (empty($errors)) {
        $email = $_POST['email'];
        $result = find('users', null, "email = '$email'");
        if (!empty($result)) {
            //Enviar email con la contraseña del usuario
            var_dump($result);
        } else
            $error = true;
    }
}
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <? include_once '../common_head.inc.php'; ?>
        <title>Recordar datos de acceso</title>
    </head>

    <body>
        <? include_once '../header.inc.php'; ?>
        <div class="container" id="content">
            <br>
            <div>
                <br/>
                <?
                if (!empty($error)) {
                    echo showbox("error", "La cuenta ingresada no existe.", "Si piensa que es un error comun&iacute;quese a <a href='mailto:".$GLOBALS['CONTACT_EMAIL']."'>".$GLOBALS['CONTACT_EMAIL']."</a>.<br>");
                }
                ?>
                <div class="col-md-6">
                    <h1 class="title">Recordar datos de acceso</h1>
                    <form action="" method="post" id="form-login">
                        <p><strong>Ingrese el email con el que se registr&oacute; y le enviaremos un email con sus datos de acceso.</strong><br></p>
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></span>
                            <input type="email" name="email" class="form-control" placeholder="Email*" value="<?= (empty($errors['email'])) ? @ escape($_POST['email']) : false ?>" aria-describedby="basic-addon2" required>
                        </div>
                        <? showerror($errors, 'email') ?>
                        <button class="button"><span class="glyphicon glyphicon-user"></span> &nbsp;Recordar</button>&nbsp;&nbsp;&nbsp;
                        <div class="clear"></div>
                    </form>
                </div>
                <div class="clear"></div><br>
            </div>
        </div>
        <? include_once '../footer.inc.php'; ?>
    </body>

</html>