<?php
include_once '../inc/config.inc.php';
$errors = array();
if (!isset($_GET['ok']) && !empty($_POST)) {
    session_start();
    if ($_SESSION['tmptxt'] != $_POST['tmptxt']) {
        $errors['tmptxt'] = 'C&oacute;digo incorrecto.';
    }else {
        unset($_POST['tmptxt']);
    }
    if (empty($_POST['email'])) {
        $errors['email'] = 'Ingrese un email';
    } else {
        if (!isValidEmail($_POST['email'])) {
            $errors['email'] = 'Ingrese un email v&aacute;lido.';
        }
    }
    if (empty($errors)) {
        unset($_POST['x'],$_POST['y']);
        $user = find("users","id","email = '".escape($_POST['email'])."'");
        if(!empty($user))
        {
            query("DELETE FROM users WHERE id = ".$user['id']);
            header("Location:registro_baja.php?ok=1");
            exit();
        }else
            $errors['email'] = 'El email no se encuentra en nuestra lista.';
    }else
        $error = true;
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
    <head>
        <? include_once '../common-head.inc.php';?>
        <title>Baja de suscripci&oacute;n | <?=$GLOBALS['META_TITLE']?></title>
    </head>
    <body>
        <div id="container">
            <? include_once '../header.inc.php';?>
            <div id="content">
                <div id="main">
                    <h1 class="title">Baja de usuarios</h1>
                    <div class="p_l">
                        <? if (isset($_GET['ok'])) {
                                echo showbox('ok','Su baja se ha completado con &eacute;xito.','Gracias por utilizar nuestros servicios.');
                            }else{?>
                            <h4>Ingrese su email para desuscribirse de nuestro newsletter:</h4>
                            <br/>
                            <form action="" method="post">
                                <div class="input">
                                    <label>Email<span class="requerido">*</span>:</label>
                                    <input type="text" name="email" value="<?= @escape($_POST['email']) ?>" class="textinput" />
                                    <? showerror($errors, 'email') ?>
                                </div>
                                <div class="clear"></div>
                                <div class="input">
                                    <label>Seguridad<span class="requerido">*</span>:</label>
                                    <div class="float-left">
                                        <img src="../inc/captcha.php" width="80" height="20" style="float: left; margin: 5px 5px 0 0" alt="captcha" />
                                        <input type="text" name="tmptxt" class="textinput" style="width: 70px" />
                                    </div>
                                    <? showerror($errors, 'tmptxt') ?>
                                    <div class="clear"></div>
                                </div>
                                <div class="clear"></div>
                                <div style="float: left; margin-left: 126px"><input type="submit" value="Darse de baja" class="btn" /></div>
                                <div class="clear"></div>
                            </form>
                        <? }?>
                    </div>
                    <div class="clear"></div>
                </div>
                <? include_once '../sidebar.inc.php';?>
                <div class="clear"></div>
            </div>
        </div>
        <? include_once '../footer.inc.php';?>
    </body>
</html>