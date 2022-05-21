<?php
if(!empty($_POST)) {
    $user = escape($_POST['u']);
    $pass = escape($_POST['b']);
    $result = find('admin_users', null, "(username = '$user') AND
	(password = MD5('$pass'))");

    if(!empty($result)) {
        $_SESSION['useradmin'] = $result['username'];
        $_SESSION['id'] = $result['id'];
        $_SESSION['uname'] = $result['name'];
        //si los datos son los predefinidos avisamos para que se cambie la contraseña
        if($user == 'admin' && $pass == 'admin')
        $_SESSION['default_user'] = 1;
        
        if(!empty($_GET['goto'])&& isValidAlpha(str_replace("/", "", $_GET['goto']))){$goto=escape($_GET['goto']);}
   ?><script type="text/javascript">location.href ="/kdpanel/<?=@$goto?>";</script><?php 
    }else $error = true;
}
?>
<div class="widget-top">
    <h3>Ingreso al sistema</h3>
</div>
<div class="inside">
    <? if(isset($error)){echo showbox('error','Los datos ingresados son incorrectos.','Si no recuerda sus datos contacte a un administrador.');}?>
    <form action="" method="post" autocomplete="off" id="formlogin" style="margin-left:215px ">
        <div class="input">
            <label>Usuario:</label>
            <input type="text" name="u" style="width: 177px" />
        </div>
        <div class="input">
            <label>Contrase&ntilde;a:</label>
            <input type="password" name="b" style="width: 177px" />
        </div>
        <div class="input submit" style="width: 307px; text-align: right">
            <input type="submit" value="" class="btn btn-ingresar" />
        </div>
    </form>
</div>