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
        if(query_update('clients_reviews', $_POST, 'id = '.$_POST['id'])) {
            $ok = true;
            $review = find("clients_reviews",null,'id = '.$_POST['id']);
        }else{
            $error = mysql_error();
        }
    }else{
        $review = $_POST;
    }
}else{
    if(!empty($_GET['id'])) {
        $review = find("clients_reviews",null,'id = '.escape($_GET['id']));
    }
}
?>
<div class="widget-top">
    <h3>Editar opini&oacute;n de cliente</h3>
</div>
<div class="inside">
    <?
    if (isset($ok)) {
        echo showbox("ok", "Cambios guardados correctamente.");
    }
    if (isset($error)) {
        echo showbox("error", "Error al realizar los cambios.", "Verifique los campos obligatorios.");
    }
    ?>
    <form action="" method="post">
        <input type="hidden" name="id" value="<?=$review['id']?>" />
        <div class="input">
            <label>T&iacute;tulo:</label>
            <input type="text" name="name" maxlength="50" value="<?=$review['name']?>" />
            <? showerror($errors, 'name')?>
        </div>
        <div class="input">
            <label>Descripci&oacute;n:</label>
            <textarea name="description" class="textarea"><?=$review['description']?></textarea>
            <? showerror($errors, 'description')?>
        </div>
        <div class="input submit">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?= loading(); ?>
    </form>
</div>