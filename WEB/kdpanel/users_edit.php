<?php
$errors = array();
if(!empty($_POST)) {
    if(empty($_POST['username'])) {
        $errors['username'] = 'Campo requerido';
    }
    if(empty($_POST['password'])) {
        $errors['password'] = 'Campo requerido';
    }
    if(empty($_POST['email'])) {
        $errors['email'] = 'Campo requerido';
    }
    if(empty($errors)){
        if(!empty($_POST['username']) && !empty($_POST['password'])) {
            $user = escape($_POST['username']);
            $pass = escape($_POST['password']);
            query("
                    UPDATE admin_users SET
                    username = '$user',
                    password =  MD5('$pass')
                    WHERE admin_users.id = {$_POST['id']} LIMIT 1
                    ");
            if(mysqli_errno())
                echo "Ocurri&oacute; un error.";
            else $ok = 'Datos actualizados correctamente';
        }
    }
}
$usuario = find("admin_users",null,"id = {$_SESSION['id']}");
?>
<script type="text/javascript">
    function valida(){
        if(document.getElementById('pass').value == document.getElementById('retype').value && document.getElementById('pass').value != '')
            return true;
        else
        {
            document.getElementById('errorform').style.display = 'block';
            return false;
        }
    }

</script>
<div class="widget-top">
    <h3>Editar datos de acceso</h3>
</div>
<div class="inside">
    <? if(isset($ok)){
        echo showbox('ok','Cambios guardados correctamente.');
        }?>
    <div id="errorform" class="box-error hidden"><div class="ico-error"><h4>Se ha producido un error al completar el formulario.</h4>Las contrase&ntilde;as deben coincidir y no ser vac&iacute;as.</div></div>
    <form name="form1" method="post" action="" onsubmit="return valida()">
        <input type="hidden" name="id" value="<?=$usuario['id']?>" />
        <div class="input">
            <label>Usuario:</label>
            <input type="text" name="username" value="<?=(!empty($_POST['username']))?$_POST['username']:$usuario['username']?>" />
            <? showerror($errors, 'username')?>
        </div>
        <div class="input">
            <label>Contrase&ntilde;a: </label>
            <input type="password" name="password" id="pass" />
            <? showerror($errors, 'password')?>
        </div>
        <div class="input">
            <label>Repetir Contrase&ntilde;a: </label>
            <input type="password" id="retype" />
        </div>
        <div class="input">
            <label>Email: </label>
            <input type="text" name="email" value="<?=$usuario['email']?>" />
            <? showerror($errors, 'email')?>
        </div>
        
        
        <div class="input submit" style="width:220px">
            <input type="submit" value="" class="btn btn-guardar" />
        </div>
    </form>
</div>