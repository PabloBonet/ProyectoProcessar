<?php
include_once '../inc/config.inc.php';
include_once '../inc/class.TemplatePower.inc.php';
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
    session_start();
    
     if (empty($_POST["g-recaptcha-response"])) {
        $errors['captchaerror'] = "Ingrese el c&oacute;digo de seguridad";
    } else {
        // check secret key
        $response = $reCaptcha->verifyResponse($_SERVER["REMOTE_ADDR"],$_POST["g-recaptcha-response"]);
        if ($response == null) {
            //set the error code so that we can display it
            $captchaerror = $response->error;
            $errors['captchaerror'] = "C&oacute;digo incorrecto";
        }
    }
    if (empty($_POST['name'])) {
        $errors['name'] = 'Ingrese un nombre';
    } else {
        $_POST['name'] = sanear_string($_POST['name']);
    }
    if (empty($_POST['city'])) {
        $errors['city'] = 'Ingrese una ciudad';
    } else {
        $_POST['city'] = sanear_string($_POST['city']);
    }

    if (empty($_POST['email'])) {
        $errors['email'] = 'Ingrese un email';
    } else {
        if (!isValidEmail($_POST['email'])) {
            $errors['email'] = 'Ingrese un email v&aacute;lido';
        } else {
            $existe = find("users", null, "email ='" . escape($_POST['email']) . "'");
            if (!empty($existe))
                $errors['email'] = 'El email ingresado ya existe';
        }
    }
    if (!empty($_POST['phone'])) {
        $telefono = str_replace(array(" ", "-", "(", ")"), '', $_POST['phone']);
        if (!is_numeric($telefono)) {
            $errors['phone'] = 'Ingrese solo n&uacute;meros, espacios, par&eacute;ntesis o guiones';
        }
    }
    if (empty($_POST['password'])) {
        $errors['password'] = 'Ingrese una contrase&ntilde;a';
    } else {
        if (!isValidPass($_POST['password']) || strlen($_POST['password']) < 5) {
            $errors['password'] = 'Ingrese m&iacute;nimo 5 caracteres o n&uacute;meros';
        } else {
            if ($_POST['password'] != $_POST['repassword']) {
                $errors['repassword'] = 'Las contrase&ntilde;as no coinciden';
            }
        }
    }
    if (!empty($_POST['promos']) && !isValidNumber($_POST['promos'])) {
        $errors['promos'] = 'Dato inv&aacute;lido';
        $promos = 1;
    }
    
    if (empty($errors)) {
        unset($_POST['repassword'],$_POST["g-recaptcha-response"],$_POST['promos']);
        $_POST['activo'] = 0;
        if (query_insert("users", $_POST)) {
            //se creo el usuario, aviso por email
            $fecha = date("d/m/Y");
            $mymail = array($GLOBALS['CONTACT_EMAIL']);
            $subject = "Nuevo usuario - " . URLWEB;

            //$grupo = find("users_groups", "title", "id = " . escape($_POST['group_id']));

            $template = new TemplatePower("../webroot/template_mails/registro_template.html");
            $template->prepare();
            $template->assignGlobal("SITE_URL", URLWEB);
            $template->assignGlobal("FECHA", $fecha);
            //$template->assignGlobal("TIPO", $grupo['title']);
            $template->assignGlobal("NOMBRE", escape($_POST['name']));
            $template->assignGlobal("EMAIL", escape($_POST['email']));
            $template->assignGlobal("PASSWORD", escape($_POST['password']));
            $template->assignGlobal("TELEFONO", escape($_POST['phone']));
            $template->assignGlobal("CIUDAD", escape($_POST['city']));
            $template->assignGlobal("IP", $_SERVER['REMOTE_ADDR']);

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
            if (!empty($promos)) {
                query_insert("newsletter_users", array("email" => escape($_POST["email"]), "name" => escape($_POST['nombre'])));
            }
            //redireccion al ok
            header("Location:registro.php?ok=1");
            exit();
        } else {
            $error = true;
        }
    } else
        $error = true;
}
$section = 'Usuarios';
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <? include_once '../common_head.inc.php'; ?>
        <title>Registro de Usuario</title>
        <link type="text/css" href="/js/jquery-ui-1.10.3.custom/css/ui-lightness/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" />
        <script type="text/javascript" src="/js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js"></script>
        <script src='https://www.google.com/recaptcha/api.js'></script>
        <script type="text/javascript">
            $(function ()
            {
                $("#city").autocomplete({
                    source: "search_localidades.php",
                    minLength: 4
                });
            });
        </script>
    </head>
    <body>
        <div class="container" id="content">
            <?
            include_once '../header.inc.php';
            include_once '../slider.inc.php';
            ?>
            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <h3 class="center">Reg&iacute;strese y acceda a contenidos exclusivos para usuarios registrados.<br>
                        Acceda a tutoriales, material para descarga, solicite soporte personalizado.</h3><br>
                    <h1 class="title2">Reg&iacute;stro de Usuario</h1>
                    <?
                    if (isset($_GET['ok'])) {
                        echo showbox('ok', 'Su registro se ha completado con &eacute;xito.', 'Su cuenta se activar&aacute; una vez que sea moderada por un administrador.');
                    } else {
                        ?>
                        <h3>Complete el siguiente formulario con sus datos:</h3>
                        <br/>
                        <form action="" method="post">
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                </span>
                                <input type="text" name="name" class="form-control" placeholder="Nombre y Apellido*" value="<?= (empty($errors['name'])) ? @ escape($_POST['name']) : false ?>" required>
                            </div>
                            <? showerror($errors, 'name') ?>
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>
                                </span>
                                <input type="email" name="email" class="form-control" placeholder="Email*" value="<?= (empty($errors['email'])) ? @ escape($_POST['email']) : false ?>" required>
                            </div>
                            <? showerror($errors, 'email') ?>
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-asterisk" aria-hidden="true"></span>
                                </span>
                                <input type="password" name="password" class="form-control" placeholder="Contrase&ntilde;a*" required>
                            </div>
                            <? showerror($errors, 'password') ?>

                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-asterisk" aria-hidden="true"></span></span>
                                <input type="password" name="repassword" class="form-control" placeholder="Reingrese la Contrase&ntilde;a*" required>
                            </div>
                            <? showerror($errors, 'repassword') ?>
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-phone" aria-hidden="true"></span></span>
                                <input type="text" name="phone" class="form-control" placeholder="Telefono*" value="<?= (empty($errors['phone'])) ? @ escape($_POST['phone']) : false ?>" required>
                            </div>
                            <? showerror($errors, 'phone') ?>
                            <div class="input-group">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-globe" aria-hidden="true"></span></span>
                                <input type="text" name="city" class="form-control" id="city" placeholder="Ciudad/Provincia*" value="<?= (empty($errors['city'])) ? @ escape($_POST['city']) : false ?>" required>
                            </div>
                            <? showerror($errors, 'city') ?>
                            <div class="clear"></div>
                            <p class="p_l">
                                <input type="checkbox" name="promos" value="1"<?= (!empty($_POST['promos']) && $_POST['promos'] == '1') ? ' checked="checked"' : false ?> style="float: left; margin: 4px 4px 0px 0" /> 
                                <cite>Deseo recibir novedades y ofertas por email</cite>
                                <? showerror($errors, 'promos') ?>
                            </p>
                            <div class="g-recaptcha" data-sitekey="<?= $publickey ?>"></div>
                            <? showerror($errors, 'captchaerror') ?>
                            <div class="clear"></div>
                            <button type="submit" class="button2">
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>Registrarse
                            </button>
                            <div class="clear"></div>
                            <br>
                        </form>
                    <? } ?>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
        <? include_once '../footer.inc.php'; ?>
    </body>
</html>