<?php
include_once 'inc/config.inc.php';
include_once 'inc/class.TemplatePower.inc.php';

require_once('inc/recaptchalib.php');

$publickey = "6Lf5AqIaAAAAAJOOB0QVmXFPKGWY_P39muW86Dwf"; // you got this from the signup page
$privatekey = "6Lf5AqIaAAAAAEf3aIkNjY6M-ylrcXbzJw8LnfcN";
# the response from reCAPTCHA
$response = null;
# the error code from reCAPTCHA, if any
$captchaerror = null;

$reCaptcha = new ReCaptcha($privatekey);

$errors = array();
if (!isset($_GET['ok']) && !empty($_POST)) {
# was there a reCAPTCHA response?

    if (empty($_POST["g-recaptcha-response"])) {
        $errors['captchaerror'] = "Ingrese el c&oacute;digo de seguridad";
    } else {
        // check secret key
        //$resp = recaptcha_check_answer($privatekey, $_SERVER["REMOTE_ADDR"], $_POST["recaptcha_challenge_field"], $_POST["recaptcha_response_field"]);

        $response = $reCaptcha->verifyResponse($_SERVER["REMOTE_ADDR"], $_POST["g-recaptcha-response"]);
        if ($response == null) {
            # set the error code so that we can display it
            $captchaerror = $response->error;
            $errors['captchaerror'] = "C&oacute;digo incorrecto";
        }
    }

    if (empty($_POST['nombre'])) {
        $errors['nombre'] = 'Ingrese un nombre';
    } else {
        $_POST['nombre'] = cleanStrict($_POST['nombre']);
    }
    if (empty($_POST['mensaje'])) {
        $errors['mensaje'] = 'Ingrese un mensaje';
    }
    if (empty($_POST['telefono'])) {
        $errors['telefono'] = 'Ingrese un tel&eacute;fono';
    } else {
        if (!isValidNumber(str_replace(array(" ", "-", "(", ")"), '', $_POST['telefono']))) {
            $errors['telefono'] = 'Ingrese solo n&uacute;meros, espacios, par&eacute;ntesis o guiones';
        }
    }
    if (empty($_POST['email'])) {
        $errors['email'] = 'Ingrese un email';
    } else {
        if (!isValidEmail($_POST['email'])) {
            $errors['email'] = 'Ingrese un email v&aacute;lido';
        }
    }
    if (!empty($_POST['promos']) && !isValidNumber($_POST['promos'])) {
        $errors['promos'] = 'Dato inv&aacute;lido';
    }
    if (empty($errors)) {
        $fecha = date("d/m/Y");
        $mymail = array($GLOBALS['CONTACT_EMAIL']);
        $subject = "Nuevo contacto - " . URLWEB;

        $template = new TemplatePower("webroot/template_mails/contact_template.html");
        $template->prepare();
        $template->assignGlobal("SITE_URL", URLWEB);
        $template->assignGlobal("FECHA", $fecha);
        $template->assignGlobal("NOMBRE", escape($_POST['nombre']));
        $template->assignGlobal("EMAIL", escape($_POST['email']));
        if (!empty($_POST['ciudad']))
            $template->assignGlobal("CIUDAD", escape($_POST['ciudad']));
        $template->assignGlobal("TELEFONO", escape($_POST['telefono']));
        $template->assignGlobal("IP", $_SERVER['REMOTE_ADDR']);
        $template->assignGlobal("MENSAJE", str_replace(array("'", '"', ';', "?", "\\"), "", strip_tags(nl2br($_POST['mensaje']), '<br>')));

        $final_template = $template->getOutputContent();
        //die($final_template);
        $header = "From:" . escape($_POST["email"]) . "\nReply-To:" . escape($_POST["email"]) . "\n";
        $header .= "X-Mailer:PHP/" . phpversion() . "\n";
        $header .= "Mime-Version: 1.0\n";
        $header .= "Content-Type: text/html;";
        $header .= "charset=UTF-8;";

        foreach ($mymail as $mails) {
            mail($mails, $subject, $final_template, $header);
        }
        if (!empty($_POST['promos'])) {
            query_insert("newsletters_users", array("email" => escape($_POST["email"]), "name" => escape($_POST['nombre'])));
        }
        echo "<script>location.href='index.php?contacto=1&ok=1';</script>";
        exit();
    } else {
        $error = true;
    }
}
?>
<script src='https://www.google.com/recaptcha/api.js'></script>
<div class="row">
    <br>
    <div class="col-sm-10 col-sm-offset-1">
        <h2 class="frase">Comun&iacute;quese o complete el formulario web y nos pondremos en contacto a la brevedad.</h2>
        <div id="contactform" name="contactform">
            <h1 class="title">Cont&aacute;ctenos:</h1>
            <?
            if (isset($_GET['ok'])) {
                echo showbox('ok', 'Mensaje enviado correctamente.', 'Nos contactaremos a la brevedad.');
            } else {
                ?>
                <form action="?contacto=1" method="post">
                    <div class="col-sm-6">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-user" aria-hidden="true"></span></span>
                            <input type="text" name="nombre" class="form-control" placeholder="Nombre y Apellido*" value="<?= (empty($errors['nombre'])) ? @cleanStrict($_POST['nombre']) : false ?>" aria-describedby="basic-addon1" required>
                        </div><? showerror($errors, 'nombre') ?>
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></span>
                            <input type="email" name="email" class="form-control" placeholder="Email*" value="<?= (empty($errors['email'])) ? @ escape($_POST['email']) : false ?>" aria-describedby="basic-addon2" required>
                        </div><? showerror($errors, 'email') ?>
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon3"><span class="glyphicon glyphicon-earphone" aria-hidden="true"></span></span>
                            <input type="text" inputmode="tel" name="telefono" class="form-control" placeholder="Tel&eacute;fono*" value="<?= (empty($errors['telefono'])) ? @cleanStrict($_POST['telefono']) : false ?>" aria-describedby="basic-addon3" required>
                        </div><? showerror($errors, 'telefono') ?>
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon4"><span class="glyphicon glyphicon-globe" aria-hidden="true"></span></span>
                            <input type="text" name="ciudad" class="form-control" placeholder="Ciudad*" value="<?= (empty($errors['ciudad'])) ? @cleanStrict($_POST['ciudad']) : false ?>" aria-describedby="basic-addon4">
                        </div>
                    </div>

                    <div class="col-sm-6">
                        <textarea name="mensaje" rows="4" class="form-control" placeholder="Ingrese su mensaje*..."><?= (!empty($_POST['mensaje'])) ? str_replace(array("'", '"', "{"), "", strip_tags($_POST['mensaje'])) : false ?></textarea>
                        <? showerror($errors, 'mensaje') ?>

                        <div class="clear"></div>
                        <div class="g-recaptcha" data-sitekey="<?= $publickey ?>"></div>
                        <? showerror($errors, 'captchaerror') ?>
                        <p>
                            <input type="checkbox" name="promos" value="1"<?= (empty($_POST['promos']) || @$_POST['promos'] == '1') ? ' checked="checked"' : false ?> style="float: left; margin: 4px 4px 0px 0" /> 
                            <cite>Deseo recibir novedades y ofertas por email</cite>
                            <? showerror($errors, 'promos') ?>
                        </p>

                        <div class="clear"></div>
                        <button type="submit" class="button">
                            <span class="glyphicon glyphicon-send" aria-hidden="true"></span>Enviar Mensaje
                        </button>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                    <br>
                </form>
            <? } ?>
        </div>
    </div>
</div>
</div>

<? include_once("footer.inc.php"); ?>
</body>
</html>