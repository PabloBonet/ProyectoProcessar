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
        } else {
            $existe = find("newsletter_users", null, "email ='" . escape($_POST['email']) . "'");
            if (!empty($existe))
                $errors['email'] = 'El email ingresado ya existe';
        }
    }
    if(empty($errors)) {
        if(query_insert('newsletter_users', $_POST)) {
            $ok = true;
        }else
            $error = true;
    }else $error = true;
    $user = $_POST;
}
?>
<div class="widget-top">
    <h3>Agregar usuario de Newsletter</h3>
</div>
<div class="inside">
    <?
    if(isset($ok)) {echo showbox("ok", "Email agregado correctamente.","Puede continuar agregando contactos.");}
    if(isset($error)){echo showbox("error","Error al crear el usuario de newsletter.","Verifique los campos obligatorios.");}?>
    <form action="" method="post">
        <div class="input">
            <label>Nombre<span class="requerido">*</span>:</label>
            <input type="text" name="name" maxlength="150" value="<?=@$user['name']?>" style="width:300px;float: left" />
            <? showerror($errors, 'name')?>
        </div>
        <div class="input">
            <label>Email<span class="requerido">*</span>:</label>
            <input type="text" name="email" maxlength="150" value="<?=@$user['email']?>" style="width:300px;float: left" />
            <? showerror($errors, 'email')?>
        </div>
        <div class="input" style="margin-left: 340px">
            <input type="submit" value="" class="btn btn-guardar" onclick="$('#loading').show();" />
        </div>
        <?=loading();?>
    </form>
</div>