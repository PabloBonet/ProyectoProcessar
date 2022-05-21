<?
$errors = array();
if (!empty($_POST)) {
    if (empty($_POST['title'])) {
        $errors['title'] = 'Campo requerido';
    }
    if (empty($errors)) {
        if (query_insert('sliders_sections', $_POST)) {
            $ok = true;
        } else {
            $error = true;
            $section = $_POST;
        }
    }else{
        $error = true;
        $section = $_POST;
    }
}
?>
<div class="widget-top">
    <h3>Agregar Nueva seccion slider</h3>
</div>
<div class="inside">
    <?
    if (isset($ok)) {
        echo showbox("ok", "Secci&oacute;n agregada correctamente.");
    }
    if (isset($error)) {
        echo showbox("error", "Error al crear la secci&oacute;n.", "Verifique los campos obligatorios.");
    }
    ?>
    <form action="" method="post">
        <div class="input">
            <label>Nombre Secci&oacute;n:</label>
            <input type="text" name="title" maxlength="300" value="<?= @$section['title'] ?>" />
            <? showerror($errors, 'title') ?>
        </div>
        <div class="input submit">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?= loading(); ?>
    </form>
</div>