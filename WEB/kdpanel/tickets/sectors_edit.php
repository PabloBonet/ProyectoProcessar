<?
$menu_section = "tickets";
$errors = array();
if (!empty($_POST)) {
    if (empty($_POST['title'])) {
        $errors['title'] = 'Campo requerido';
    }
    if(empty($_POST['emails'])) {
        $errors['emails'] = 'Campo requerido';
    }else{
        $_POST['emails'] = str_replace(" ","",$_POST['emails']);
    }
    if (empty($errors)) {
        if (query_update('tickets_sectors', $_POST, 'id = ' . $_POST['id'])) {
            $ok = true;
        }
    }
    $sector = $_POST;
} else {
    if (!empty($_GET['id'])) {
        $sector = find("tickets_sectors", null, 'id = ' . escape($_GET['id']));
    }
}
//$categories = findAll("downloads_categories",null,"category_id = 0 OR category_id IS NULL");
?>
<div class="widget-top">
    <h3>Editar Area de soporte</h3>
</div>
<div class="inside">
    <? if (isset($ok)) {
        echo showbox("ok", "Cambio realizado correctamente.");
    }
    if (isset($error)) {
        echo showbox("error", "Error al guardar los datos.", "Verifique los campos obligatorios.");
    }
    ?>
    <form action="" method="post">
        <input type="hidden" name="id" value="<?= $sector['id'] ?>" />
        <div class="input">
            <label>T&iacute;tulo<span class="requerido">*</span>:</label>
            <input type="text" name="title" maxlength="20" value="<?= $sector['title'] ?>" />
                <? showerror($errors, 'title') ?>
        </div>
        <div class="input">
            <label>Emails separados por coma<span class="requerido">*</span>:</label>
            <input type="text" name="emails" maxlength="150" value="<?= $sector['emails'] ?>" />
                <? showerror($errors, 'emails') ?>
        </div>
        <div class="input" style="margin-left: 348px">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display = 'block'" />
        </div>
<?= loading(); ?>
    </form>
</div>