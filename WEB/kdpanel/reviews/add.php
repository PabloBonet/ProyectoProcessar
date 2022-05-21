<?
$errors = array();
if(!empty($_POST)) {
    if(empty($_POST['name'])) {
        $errors['name'] = 'Campo requerido';
    }
    if(empty($_POST['description'])) {
        $errors['description'] = 'Campo requerido';
    }
    if(empty($errors)) {
        if(query_insert('clients_reviews', $_POST)) {
            $ok = true;
        }else{
            $error = true;
            $review = $_POST;
        }
    }else{
        $review = $_POST;
        $error = true;
    }
}
?>
<div class="widget-top">
    <h3>Agregar opini&oacute;n de cliente</h3>
</div>
<div class="inside">
    <?
    if (isset($ok)) {
        echo showbox("ok", "Opini&oacute;n agregada correctamente.");
    }
    if (isset($error)) {
        echo showbox("error", "Error al crear la opini&oacute;n.", "Verifique los campos obligatorios.");
    }
    ?>
    <form action="" method="post">
        <div class="input">
            <label>Nombre:</label>
            <input type="text" name="name" maxlength="50" value="<?=@$review['name']?>" />
            <? showerror($errors, 'name')?>
        </div>
        <div class="input">
            <label>Descripci&oacute;n:</label>
            <textarea name="description" class="textarea"><?=@$review['description']?></textarea>
            <? showerror($errors, 'description')?>
            <div class="clear"></div>
        </div>
        <div class="input submit">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?= loading(); ?>
    </form>
</div>