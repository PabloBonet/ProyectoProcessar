<?
$errors = array();
if(!empty($_POST)) {
    if(empty($_POST['title'])) {
        $errors['title'] = 'Campo requerido';
    }
    if(empty($errors)) {
        if(query_update('users_groups', $_POST, 'id = '.$_POST['id'])) {
            $ok = true;
        }
    }
    $group = $_POST;
}else{
    if(!empty($_GET['id'])) {
        $group = find("users_groups",null,'id = '.escape($_GET['id']));
    }
}
?>
<div class="widget-top">
    <h3>Editar grupo de usuarios</h3>
</div>
<div class="inside">
    <? if(isset($ok)) {echo showbox("ok", "Cambio realizado correctamente.");}
    if(isset($error)){echo showbox("error","Error al guardar los datos.","Verifique los campos obligatorios.");}?>
    <form action="" method="post">
        <cite>Nota: Los campos marcados con * son obligatorios</cite>
        <input type="hidden" name="id" value="<?=$group['id']?>" />
        <div class="input">
            <label>T&iacute;tulo<span class="requerido">*</span>:</label>
            <input type="text" name="title" maxlength="50" value="<?=$group['title']?>" style="width:300px;float: left" />
            <? showerror($errors, 'title')?>
        </div>
        <div class="input" style="margin-left: 353px">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?=loading();?>
    </form>
</div>