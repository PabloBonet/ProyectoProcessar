<?
namespace Verot\Upload;
error_reporting(E_ALL);
include_once(CONFIGPATH . 'class.upload.php');
$menu_section = 'Sliders';
$errors = array();
if (!empty($_POST)) {
    if (empty($_POST['title'])) {
        $errors['title'] = 'Ingrese un t&iacute;tulo';
    }
    if (empty($_POST['section_id'])) {
        $errors['section_id'] = 'Seleccione una secci&oacute;n';
    }
    if (empty($errors)) {
        if (query_update("sliders", $_POST, "id = " . $_POST['id'])) {
            $slider = find("sliders", null, "id = " . escape($_POST['id']));
            $idslider = $slider['id'];
            
            if (!empty($_FILES['src']['name'])) {
                $handle = new Upload($_FILES['src']['tmp_name']);
                if ($handle->uploaded) {
                    // el archivo se subio
                    //elimino cualquier archivo existente
                    unlink(WWW_ROOT . 'img/sliders/' . $idslider . '.jpg');

                    $filename = $idslider . '.jpg';
                    //seteo el resize cuando es imagen
                    $handle->image_resize = true;
                    $handle->image_ratio_crop = true;
                    $handle->image_x = 1140;
                    $handle->image_y = 300;
                    $handle->process(WWW_ROOT . "img/tmp/");
                    if ($handle->processed) {
                        copy(WWW_ROOT . "img/tmp/" . $handle->file_dst_name, WWW_ROOT . 'img/sliders/' . $filename);
                        unlink(WWW_ROOT . "img/tmp/" . $handle->file_dst_name);
                    } else {
                        $errors['src'] = "Error: ".$handle->error;
                    }
                } else {
                    $error = true;
                    $errors['src'] = "Error: ".$handle->error;
                }
            }
            if (!empty($_FILES['src2']['name'])) {
                $handle = new Upload($_FILES['src2']['tmp_name']);
                if ($handle->uploaded) {
                    //elimino cualquier archivo existente
                    unlink(WWW_ROOT . 'img/sliders/' . $idslider . '_small.jpg');
                    // el archivo se subio
                    $filename = $idslider . '_small.jpg';
                    //seteo el resize chico
                    $handle->image_resize = true;
                    $handle->image_ratio_crop = true;
                    $handle->image_x = 400;
                    $handle->image_y = 300;

                    $handle->process(WWW_ROOT . "img/tmp/");
                    if ($handle->processed) {
                        copy(WWW_ROOT . "img/tmp/" . $handle->file_dst_name, WWW_ROOT . 'img/sliders/' . $filename);
                        unlink(WWW_ROOT . "img/tmp/" . $handle->file_dst_name);
                    } else {
                        $errors['src2'] = "Error: ".$handle->error;
                    }
                } else {
                    $error = true;
                    $errors['src2'] = "Error: ".$handle->error;
                }
            }
            $ok = true;
        } else {
            $error = true;
        }
    } else {
        $slider = $_POST;
    }
} else {
    if (!empty($_GET['id'])) {
        $slider = find("sliders", null, 'id = ' . escape($_GET['id']));
    }
}
$sections = findAll("sliders_sections");
?>
<div class="widget-top">
    <h3>Editar Slider</h3>
</div>
<div class="inside">
    <?
    if (isset($ok)) {
        echo showbox("ok", "Cambios realizados correctamente.");
    }
    if (isset($error)) {
        echo showbox("error", "Error al guardar los cambios.", "Verifique los campos obligatorios.");
    }
    ?>
    <form action="" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<?= $slider['id'] ?>" />
        <div class="input">
            <label>T&iacute;tulo<span class="requerido">*</span>:</label>
            <input type="text" name="title" value="<?=$slider['title']?>" />
        </div>
        <div class="input">
            <label>Descripci&oacute;n:</label>
            <textarea name="description"><?=$slider['description']?></textarea>
        </div>
        <div class="input">
            <label>Imagen Actual:</label>
            <img src="/img/sliders/<?=$slider['id']?>.jpg?rand=<?=rand(0,99)?>" width="350" class="float-left" />
        </div>
        <div class="input">
            <label>Imagen Actual:</label>
            <img src="/img/sliders/<?=$slider['id']?>_small.jpg?rand=<?=rand(0,99)?>" width="350" class="float-left" />
        </div>
        <div class="input">
            <label>Reemplazar Imagen:</label>
            <div class="float-left" >
                <input type="file" name="src" />
                Las medidas de recorte son 1140 x 300 pixeles<br>
                <? showerror($errors, 'src') ?>
            </div>
        </div>
        <div class="input">
            <label>Imagen peque&ntilde;a<span class="requerido">*</span>:</label>
            <div class="float-left">
                <input type="file" name="src2" /><br>
                Las medidas de recorte son 360 x 300 pixeles<br>
                <? showerror($errors, 'src2') ?>
            </div>
        </div>
        
        <div class="input">
            <label>Secci&oacute;n<span class="requerido">*</span>:</label>
            <select name="section_id" class="float-left">
                <?
                if (!empty($sections)) {
                    foreach ($sections as $section) {
                        $selected = ($slider['section_id'] == $section['id']) ? ' selected="selected"' : '';
                        ?>
                        <option value="<?= $section['id'] ?>"<?= $selected ?>><?= $section['title'] ?></option>
                        <?
                    }
                }
                ?>
            </select>
            <? showerror($errors, 'section_id') ?>
        </div>
        <div class="input">
            <label>Url Enlace:</label>
            <input type="text" name="url" value="<?=$slider['url']?>" />
        </div>
        <div class="clear"></div>
        <cite style="display: block;padding: 10px 0 10px 78px; line-height: 18px">NOTA: Si agrega m&aacute;s de una imagen por secci&oacute;n se mostrar&aacute;n con pase de sliders animado.<br/> Las medidas de recorte son 1140 x 300 pixeles</cite>
        <div class="clear"></div>
        <div class="input submit">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?= loading(); ?>
    </form>
</div>