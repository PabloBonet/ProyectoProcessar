<?
$errors = array();
if(!empty($_POST)) {
    if(empty($_POST['title'])) {
        $errors['title'] = 'Campo requerido';
    }
    if(empty($errors)) {
        if(query_insert('users_groups', $_POST)) {
            $ok = true;
        }else
            $error = true;
    }else $error = true;
    $group = $_POST;
}
?>
<div class="widget-top">
    <h3>Agregar Grupo de usuarios</h3>
</div>
<div class="inside">
    <?
    if(isset($ok)) {echo showbox("ok", "Grupo agregado correctamente.","Puede continuar agregando grupos.");}
    if(isset($error)){echo showbox("error","Error al guardar los datos.","Verifique los campos obligatorios.");}?>
    <form action="" method="post">
        <cite>Nota: Los campos marcados con * son obligatorios</cite>
        <div class="input">
            <label>T&iacute;tulo<span class="requerido">*</span>:</label>
            <input type="text" name="title" maxlength="50" value="<?=@$group['title']?>" class="input-text" />
            <? showerror($errors, 'title')?>
        </div>
        <div class="input" style="margin-left: 353px">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?=loading();?>
    </form>
</div>