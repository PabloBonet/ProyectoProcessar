<?
namespace Verot\Upload;
error_reporting(E_ALL);

$errors = array();
if (!empty($_POST)) {
    if (empty($_POST['title'])) {
        $errors['title'] = 'Ingrese un t&iacute;tulo';
    }
    if (empty($_POST['section_id'])) {
        $errors['section_id'] = 'Seleccione una secci&oacute;n';
    }
    if (empty($_FILES['src']['name'])) {
        $errors['src'] = 'Seleccione un archivo a subir';
    }
    if (empty($_FILES['src2']['name'])) {
        $errors['src2'] = 'Seleccione un archivo a subir';
    }
    if (empty($errors)) {
        if ($idslider = query_insert('sliders', $_POST)) {
            include_once(CONFIGPATH . 'class.upload.php');
            $handle = new Upload($_FILES['src']['tmp_name']);
            
            if ($handle->uploaded) {
                // el archivo se subio
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
            $handle = new Upload($_FILES['src2']['tmp_name']);
            
            if ($handle->uploaded) {
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
            $ok = true;
        } else {
            $error = true;
            $slider = $_POST;
        }
    } else {
        $error = true;
        $slider = $_POST;
    }
}
$sections = findAll("sliders_sections");
?>
<div class="widget-top">
    <h3>Agregar Slider</h3>
</div>
<div class="inside">
    <?
    if (isset($ok)) {
        echo showbox("ok", "Slider agregado correctamente.", "Puede continuar agregando sliders.");
    }
    if (isset($error)) {
        echo showbox("error", "Error al crear el slider.", "Verifique los campos obligatorios.");
    }
    ?>
    <form action="" method="post" enctype="multipart/form-data">
        <div class="input">
            <label>T&iacute;tulo<span class="requerido">*</span>:</label>
            <input type="text" name="title" value="<?=@$_POST['title']?>" />
        </div>
        <div class="input">
            <label>Descripci&oacute;n:</label>
            <textarea name="description"><?=@$_POST['description']?></textarea>
        </div>
        <div class="input">
            <label>Imagen grande<span class="requerido">*</span>:</label>
            <div class="float-left">
                <input type="file" name="src" /><br>
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
            <select name="section_id" class="select">
                <option value="">Seleccione...</option>
                <?
                if (!empty($sections)) {
                    foreach ($sections as $section) {
                        $selected = (@$slider['section_id'] == $section['id']) ? ' selected="selected"' : '';
                        ?>
                        <option<?= $selected ?> value="<?= $section['id'] ?>"><?= $section['title'] ?></option>
                        <?
                    }
                }
                ?>
            </select>
            <? showerror($errors, 'section_id') ?>
        </div>
        <div class="input">
            <label>Url Enlace:</label>
            <input type="text" name="url" value="<?=@$_POST['url']?>" />
        </div>
        <div class="clear"></div>
        <cite style="display: block;padding: 10px 0 10px 78px; line-height: 18px">NOTA: Si agrega m&aacute;s de una imagen por secci&oacute;n se mostrar&aacute;n con pase de sliders animado.</cite>
        <div class="clear"></div>
        <div class="input submit">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?= loading(); ?>
    </form>
</div>