<?

namespace Verot\Upload;

error_reporting(E_ALL);

$errors = array();
if (!empty($_POST)) {
    if (empty($_POST['title'])) {
        $errors['title'] = 'Campo requerido';
    }
    if (empty($_POST['description'])) {
        $errors['description'] = 'Campo requerido';
    }
    if (empty($_POST['section'])) {
        $errors['section'] = 'Campo requerido';
    }
    if (empty($_POST['content_id'])) {
        $_POST['content_id'] = 0;
    }
    if (empty($errors)) {
        $_POST['url'] = (!empty($_POST['url'])) ? $_POST['url'] : makeUrl($_POST['title'], 'contents');
        if ($content_id = query_insert('contents', $_POST)) {
            if (!empty($_FILES['fotos']['name'][0])) {
                include_once(CONFIGPATH . 'class.upload.php');
                $numfoto = 0;

                foreach ($_FILES['fotos']['name'] as $key => $file) {
                    if (!empty($file)) {
                        $filename = $content_id . '_' . $numfoto . '.jpg';
                        $handle = new Upload($_FILES['fotos']['tmp_name'][$key]);

                        if ($handle->uploaded) {
                            // el archivo se subio, seteo el resize en varias versiones
                            $handle->image_resize = true;
                            $handle->image_ratio_x = true;
                            $handle->image_x = 640;
                            $handle->image_y = 480;

                            $handle->process(WWW_ROOT . "img/tmp/");
                            if ($handle->processed) {
                                // everything was fine !
                                copy(WWW_ROOT . "img/tmp/" . $handle->file_dst_name, WWW_ROOT . 'img/paginas/' . $filename);
                                unlink(WWW_ROOT . "img/tmp/" . $handle->file_dst_name);
                            } else {
                                $errors['fotos'] = "Error: " . $handle->error;
                            }

                            $handle->image_resize = true;
                            $handle->image_ratio_x = true;
                            $handle->image_ratio_crop = true;
                            $handle->image_x = 220;
                            $handle->image_y = 170;
                            $handle->process(WWW_ROOT . "img/tmp/");

                            if ($handle->processed) {
                                // everything was fine !
                                copy(WWW_ROOT . "img/tmp/" . $handle->file_dst_name, WWW_ROOT . 'img/paginas/thumbs/' . $filename);
                                unlink(WWW_ROOT . "img/tmp/" . $handle->file_dst_name);
                            } else {
                                $errors['fotos'] = "Error: " . $handle->error;
                            }

                            query("INSERT INTO contents_pictures (src,content_id) VALUES ('$filename',$content_id)");
                        } else {
                            $error = true;
                        }
                        $numfoto++;
                    }
                }//end while
            }
            $ok = true;
        } else {
            $error = true;
            $content = $_POST;
        }
    } else {
        $content = $_POST;
        $error = true;
    }
}
$contents = findAll("contents", null, "content_id =0", "title");
?>
<script src="/js/tinymce/js/tinymce/tinymce.min.js"></script>
<script type="text/javascript">
    tinymce.init({
        selector: "textarea#text_editor", theme: "modern",
        menubar: false,
        language: "es",
        plugins: [
            "advlist autolink link image lists charmap hr anchor",
            "wordcount visualblocks visualchars media nonbreaking",
            "table contextmenu paste textcolor responsivefilemanager fullscreen code"
        ],
        toolbar1: "undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist | styleselect",
        toolbar2: "link unlink anchor | image media | forecolor backcolor | hr | fullscreen code ",
        image_advtab: true,
        external_filemanager_path: "/filemanager/",
        filemanager_title: "Responsive Filemanager",
        filemanager_access_key: "123654",
        external_plugins: {"filemanager": "/filemanager/plugin.min.js"},
        content_css: "/css/editor.css"
    });
</script>
<div class="widget-top">
    <h3>Agregar P&aacute;gina de contenido</h3>
</div>
<div class="inside">
    <?
    if (isset($ok)) {
        echo showbox("ok", "P&aacute;gina de contenido agregada correctamente.");
    }
    if (isset($error)) {
        echo showbox("error", "Error al crear la p&aacute;gina.", "Verifique los campos obligatorios.");
    }
    ?>
    <form action="" method="post" enctype="multipart/form-data">
        <div class="input">
            <label>T&iacute;tulo:</label>
            <input type="text" name="title" maxlength="250" value="<?= @$content['title'] ?>" />
<? showerror($errors, 'title') ?>
        </div>
        <div class="input">
            <label>Ubicaci&oacute;n:</label>
            <div style="margin-top: 4px">
                <input type="radio" name="section" value="1" <?= (!empty($_POST['section']) && $_POST['section'] == 1) ? 'checked' : false; ?>> Menu superior&nbsp;
                <input type="radio" name="section" value="2" <?= (!empty($_POST['section']) && $_POST['section'] == 2) ? 'checked' : false; ?>> Menu clientes&nbsp;
                <input type="radio" name="section" value="3" <?= (!empty($_POST['section']) && $_POST['section'] == 3) ? 'checked' : false; ?>> Pie de p&aacute;ginas
                <input type="radio" name="section" value="4" <?= (!empty($content['section']) && $content['section'] == 4) ? 'checked' : false; ?>> Otro
                <br>
                <? showerror($errors, 'section') ?>
            </div>
        </div>
        <div class="input">
            <label>Agregar en:</label>
            <select name="content_id" class="select">
                <option value=""></option>
                <?
                if (!empty($contents)) {
                    foreach ($contents as $father) {
                        $selected = ($father['id'] == @$_POST['content_id']) ? ' selected="selected"' : '';
                        ?>
                        <option value="<?= $father['id'] ?>"<?= $selected ?>><?= $father['title'] ?></option>
                        <?
                    }
                }
                ?>
            </select>
        </div>
        <div class="input">
            <label>Descripci&oacute;n:</label>
            <div class="float-left">
                <textarea name="description" id="text_editor" style="width: 493px;height: 300px"><?= @$content['description'] ?></textarea>
<? showerror($errors, 'description') ?>
            </div>
            <div class="clear"></div>
        </div>
        <div class="input" style="margin: 10px 0">
            <label>Im&aacute;genes:</label>
            <div class="float-left">
                <input type="file" name="fotos[]" multiple /><br/>                
<? showerror($errors, 'fotos') ?>
            </div>
        </div>
        <div class="input submit">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display = 'block'" />
        </div>
<?= loading(); ?>
    </form>
</div>