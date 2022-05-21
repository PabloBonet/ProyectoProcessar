<?
$errors = array();
if (!empty($_POST)) {
    if (empty($_POST['title'])) {
        $errors['title'] = 'Campo requerido';
    }
    if (empty($_POST['url'])) {
        $errors['url'] = 'Campo requerido';
    }else{
        $_POST['url'] = str_replace(array("http://youtu.be/","http://www.youtube.com/watch?v=","http://www.youtube.com/v/"), "", $_POST['url']);        
        $_POST['url'] = "http://www.youtube.com/v/".$_POST['url'];
    }
    if (empty($errors)) {
        if($idvideo = query_insert('videos', $_POST)){
            @session_start();
            $_SESSION['msj'] = true;
            echo "<script>location.href='edit?id=$idvideo'</script>";
            exit();
            $ok = true;
        }
    }else
            $error = true;
}
?>
    <div class="widget-top">
        <h3>Agregar Video</h3>
    </div>
    <div class="inside">
    <?
    if (!empty($ok)) {
        echo showbox("ok", "Video creado correctamente.");
    }
    if (!empty($error)) {
        echo showbox("error", "Error al guardar los cambios.", "Verifique los campos obligatorios.");
    }
    ?>
    <form action="" method="post">
        <cite>Nota: Los campos marcados con * son obligatorios</cite>
        <div class="input">
            <label>T&iacute;tulo<span class="requerido">*</span>:</label>
            <input type="text" name="title" maxlength="300" value="<?=@escape($_POST['title'])?>" class="input-text" style="width: 350px" />
            <? showerror($errors, "title") ?>
        </div>
        <div class="input">
            <label>Url Video<span class="requerido">*</span>:</label>
            <div style="float: left; width: 365px">
                <input type="text" name="url" value="<?=@escape($_POST['url'])?>" class="input-text" style="width: 365px" />
                <? showerror($errors, "url") ?>
                <div class="clear"></div>
                <cite style="float: left;margin-top: 5px">Ej: http://youtu.be/oOFv3mt4ol4</cite>
            </div>
        </div>
        <div class="input submit">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?= loading(); ?>
    </form>
</div>