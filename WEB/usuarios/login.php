<?php
include_once '../inc/config.inc.php';
require_once('../inc/recaptchalib.php');

$publickey = "6Lf5AqIaAAAAAJOOB0QVmXFPKGWY_P39muW86Dwf"; // you got this from the signup page
$privatekey = "6Lf5AqIaAAAAAEf3aIkNjY6M-ylrcXbzJw8LnfcN";
# the response from reCAPTCHA
$response = null;
# the error code from reCAPTCHA, if any
$captchaerror = null;

$reCaptcha = new ReCaptcha($privatekey);

$errors = array();
if (!isset($_GET['ok']) && !empty($_POST)) {
    if (empty($_POST["g-recaptcha-response"])) {
        $errors['captchaerror'] = "Ingrese el c&oacute;digo de seguridad";
    } else {
        // check secret key
        $response = $reCaptcha->verifyResponse($_SERVER["REMOTE_ADDR"],$_POST["g-recaptcha-response"]);
        if ($response == null) {
            # set the error code so that we can display it
            $captchaerror = $response->error;
            $errors['captchaerror'] = "C&oacute;digo incorrecto";
        }
    }
    if (empty($_POST['email'])) {
        $errors['email'] = 'Ingrese un email';
    } else {
        if (!isValidEmail($_POST['email'])) {
            $errors['email'] = 'Ingrese un email v&aacute;lido';
        }
    }
    if (empty($_POST['password'])) {
        $errors['password'] = 'Ingrese una contrase&ntilde;a';
    } else {
        if (!isValidPass($_POST['password']) || strlen($_POST['password']) < 4) {
            $errors['password'] = 'Contrase&ntilde;a inv&aacute;lida';
        }
    }
    if (empty($errors)) {
        $email = $_POST['email'];
        $pass = $_POST['password'];
        $result = find('users', null, "email = '$email' AND password = '$pass'");
        if (!empty($result)) {
            //si esta activo, redirijo al inicio
            if ($result['activo'] == '1') {
                @session_start();
                $_SESSION['uid'] = $result['id'];
                   header("Location:/usuarios/");
                   exit(); 
            } else {
                $error = 2;
            }
        } else{
            $error = 1;
        }
    }
}
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <? include_once '../common_head.inc.php'; ?>
        <title>Iniciar sesi&oacute;n</title>
        <script src='https://www.google.com/recaptcha/api.js'></script>
    </head>

    <body>
        <? include_once '../header.inc.php'; ?>
        <div class="container" id="content">
            <br>
            <div>
                <br/>
                <?
                if (!empty($error)) {
                    if($error == 2)
                        echo showbox("warning", "Su cuenta todav&iacute;a no ha sido verificada.", "Vuelva a intentarlo m&aacute;s tarde o escriba a <a href='mailto:".$GLOBALS['CONTACT_EMAIL']."'>".$GLOBALS['CONTACT_EMAIL']."</a>.");
                    else
                        echo showbox("error", "Ocurrio un error al acceder.", "Si piensa que es un error comun&iacute;quese a <a href='mailto:".$GLOBALS['CONTACT_EMAIL']."'>".$GLOBALS['CONTACT_EMAIL']."</a>.");
                    
                    echo '<br/>';
                }
                ?>
                <div class="col-md-6">
                    <h1 class="title">Iniciar Sesi&oacute;n</h1>
                    <form action="" method="post" id="form-login" autocomplete="autocomplete">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></span>
                            <input type="email" name="email" class="form-control" placeholder="Email*" value="<?= (empty($errors['email'])) ? @ escape($_POST['email']) : false ?>" aria-describedby="basic-addon2" required>
                        </div>
                        <? showerror($errors, 'email') ?>
                        <div class="clear"></div>
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-asterisk" aria-hidden="true"></span></span>
                            <input type="password" name="password" class="form-control" placeholder="Contrase&ntilde;a" value="" aria-describedby="basic-addon2" required>
                        </div>
                        <? showerror($errors, 'password') ?>
                        <div class="clear"></div>
                        <div class="g-recaptcha" data-sitekey="<?= $publickey ?>"></div>
                        <? showerror($errors, 'captchaerror') ?>

                        <div class="clear"></div>
                        <button class="button"><span class="glyphicon glyphicon-log-in"></span> &nbsp;Ingresar</button>&nbsp;&nbsp;&nbsp;
                        <? /*<a href="recordar.php">Olvido sus datos?</a><? */?>
                        <div class="clear"></div>
                    </form>
                </div>
                <div class="col-md-6">
                    <h1 class="title2">Registrarse</h1>
                    <h2 class="frase">Cree una cuenta de usuario y acceda a contenidos especiales para usuarios registrados, como manuales,
panel de soporte, demos, descargas, ayuda.</h2>
                    <p class="center">Si todav&iacute;a no posee cuenta de usuario puede <br><br>
                        <a href="registro.php" class="button2"><span class="glyphicon glyphicon-user"></span> &nbsp;Registrarse aqu&iacute;</a>
                    </p>
                </div>
                <div class="clear"></div><br>
            </div>
        </div>
        <? include_once '../footer.inc.php'; ?>
    </body>

</html>