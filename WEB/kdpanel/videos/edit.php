<?
$errors = array();
@session_start();
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
        /*if (empty($_POST['highlight'])) {
            $_POST['highlight'] = 'NULL';
        }*/
        if (query_update('videos', $_POST, 'id = ' . escape($_POST['id']))) {
            $ok = true;
        }else{
            $error = true;
        }
    }
    $video[0] = $_POST;
}else{
    if(!empty($_GET['id'])) {
        $video = query("SELECT v.* FROM videos AS v WHERE v.id = ".escape($_GET['id']));
    }
}
?>
<div class="widget-top">
    <h3>Editar Video</h3>
</div>
<div class="inside">
    <? if(isset($ok)){ echo showbox("ok","Cambio guardado correctamente");}
    if(!empty($_SESSION['msj'])){echo showbox("ok","Video creado correctamente.","Puede continuar editando el video.");unset($_SESSION['msj']);}
    if(isset($error)){echo showbox("error", "Error al realizar los cambios.", "Verifique los campos obligatorios.");}?>
    <form action="" method="post">
        <input type="hidden" name="id" value="<?=$video[0]['id']?>" />
        <div class="input">
            <label>T&iacute;tulo<span class="requerido">*</span>:</label>
            <input type="text" name="title" maxlength="300" value="<?=$video[0]['title']?>" class="input-text" style="width: 365px" />
            <? showerror($errors, "title") ?>
        </div>
        <div class="input">
            <label>Video:</label>
            <div style="float:left; width: 450px">
                <object width="297" height="250"><param value="<?=$video[0]['url']?>" name="movie"><param value="true" name="allowFullScreen"><param value="always" name="allowscriptaccess"><embed width="297" height="250" allowfullscreen="true" allowscriptaccess="always" type="application/x-shockwave-flash" src="<?=$video[0]['url']?>"></object>
            </div>
        </div>
        <div class="input">
            <label>Url Video<span class="requerido">*</span>:</label>
            <div style="float: left; width: 365px">
                <input type="text" name="url" value="<?=$video[0]['url']?>" class="input-text" style="width: 365px" />
                <? showerror($errors, "url") ?>
                <div class="clear"></div>
                <cite style="float: left;margin-top: 5px">Ej: http://youtu.be/oOFv3mt4ol4</cite>
            </div>
        </div>
        <br/>
        <cite>Nota: Los campos marcados con * son obligatorios</cite>
        <div class="input submit">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?=loading();?>
    </form>
</div>