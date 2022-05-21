<?php
include_once '../inc/config.inc.php';
include_once '../inc/class.TemplatePower.inc.php';

checksession("usuario");

$errors = array();
if (!isset($_GET['ok']) && !empty($_POST)) {
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
            $existe = find("users", null, "email ='" . escape($_POST['email']) . "' AND id <> " . escape($_SESSION['uid']));
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
    if (!empty($_POST['cuit'])) {
        $_POST['cuit'] = str_replace(array(" ", "-"), '', $_POST['cuit']);
        if (!is_numeric($_POST['cuit'])) {
            $errors['cuit'] = 'Ingrese solo n&uacute;meros, o guiones';
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
    if (empty($errors)) {
        unset($_POST['repassword']);
        //$_POST['activo'] = 0;
        if (query_update("users", $_POST, "id=" . $_SESSION['uid'])) {
            //redireccion al ok
            header("Location:mis-datos.php?ok=1");
        } else {
            $error = true;
        }
    } else
        $error = true;
}
$usuario = find("users", null, "id=" . $_SESSION['uid']);
$section = 'soporte';
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <? include_once '../common_head.inc.php'; ?>
        <title>Actualizar datos personales</title>
        <link type="text/css" href="/js/jquery-ui-1.10.3.custom/css/ui-lightness/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" />
        <script type="text/javascript" src="/js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js"></script>

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
        <div class="container">
            <? include_once '../header.inc.php'; ?>
            <div class="row">
                <div class="col-md-4">
                    <?
                    include_once 'menu-usuario.php';
                    ?>
                </div>
                <div class="col-md-8">
                    <h2 class="title">Modificar datos de Usuario</h2>
                    <?
                    if (isset($_GET['ok'])) {
                        echo showbox('ok', 'Datos actualizados correctamente.');
                    }
                    if (isset($error)) {
                        echo showbox('error', 'Hubo un error al guardar los datos.');
                    }
                    ?>
                    <form action="" method="post">
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                            </span>
                            <input type="text" name="name" class="form-control" placeholder="Nombre y Apellido*" value="<?= (empty($errors['name']) && !empty($_POST['name'])) ? @ escape($_POST['name']) : $usuario['name'] ?>" required>
                        </div>
                        <? showerror($errors, 'name') ?>
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span></span>
                            <input type="email" name="email" class="form-control" placeholder="Email*" value="<?= (empty($errors['email']) && !empty($_POST['email'])) ? @ escape($_POST['email']) : $usuario['email'] ?>" required>
                        </div>
                        <? showerror($errors, 'email') ?>
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon3">
                                <span class="glyphicon glyphicon-asterisk" aria-hidden="true"></span>
                            </span>
                            <input type="password" name="password" class="form-control" placeholder="Contrase&ntilde;a nueva*" required>
                        </div>
                        <? showerror($errors, 'password') ?>

                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon4"><span class="glyphicon glyphicon-asterisk" aria-hidden="true"></span></span>
                            <input type="password" name="repassword" class="form-control" placeholder="Reingrese la Contrase&ntilde;a*" required>
                        </div>
                        <? showerror($errors, 'repassword') ?>
                        <div class="input-group">
                            <span class="input-group-addon" id="basic-addon5"><span class="glyphicon glyphicon-phone" aria-hidden="true"></span></span>
                            <input type="text" name="phone" class="form-control" placeholder="Tel&eacute;fono" required value="<?= (empty($errors['phone']) && !empty($_POST['phone'])) ? @ escape($_POST['phone']) : $usuario['phone'] ?>">
                        </div>
                        <? showerror($errors, 'phone') ?>
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-globe" aria-hidden="true"></span></span>
                            <input type="text" name="city" class="form-control" id="city" placeholder="Ciudad/Provincia*" value="<?= (empty($errors['city']) && !empty($_POST['city'])) ? @ escape($_POST['city']) : $usuario['city'] ?>" required>
                        </div>
                        <? showerror($errors, 'city') ?>
                        <div class="clear"></div>
                        <button type="submit" class="button">
                            <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span> &nbsp;&nbsp;Guardar
                          </button>
                        <div class="clear"></div>
                    </form>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
        <? include_once '../footer.inc.php'; ?>
    </body>
</html>