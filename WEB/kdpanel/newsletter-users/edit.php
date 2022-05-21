<?
$errors = array();
if(!empty($_POST)) {
    if(empty($_POST['name'])) {
        $errors['name'] = 'Campo requerido';
    }
    if(empty($_POST['email'])) {
        $errors['email'] = 'Campo requerido';
    }else {
        if (!isValidEmail($_POST['email'])) {
            $errors['email'] = 'Ingrese un email v&aacute;lido';
        }
    }
    if(empty($errors)) {
        if(query_update('newsletter_users', $_POST, 'id = '.$_POST['id'])) {
            $ok = true;
        }else
            $error = mysql_error();
    }
    $user = $_POST;
}else{
    if(!empty($_GET['id'])) {
        $user = find("newsletter_users",null,'id = '.escape($_GET['id']));
    }
}
?>
<div class="widget-top">
    <h3>Editar usuario de newsletter</h3>
</div>
<div class="inside">
    <? if(isset($ok)) {echo showbox("ok", "Cambio realizado correctamente.");}
    if(isset($error)){echo showbox("error","Error editar el usuario de newsletter.","Verifique los campos obligatorios.");}?>
    <form action="" method="post">
        <input type="hidden" name="id" value="<?=$user['id']?>" />
        <div class="input">
            <label>Nombre<span class="requerido">*</span>:</label>
            <input type="text" name="name" maxlength="150" value="<?=$user['name']?>" style="width:300px;float: left" />
            <? showerror($errors, 'name')?>
        </div>
        <div class="input">
            <label>Email<span class="requerido">*</span>:</label>
            <input type="text" name="email" maxlength="150" value="<?=$user['email']?>" style="width:300px;float: left" />
            <? showerror($errors, 'email')?>
        </div>
        <div class="input" style="margin-left: 340px">
            <input type="submit" value="" class="btn btn-guardar" onclick="$('#loading').show();" />
        </div>
        <?=loading();?>
    </form>
</div>