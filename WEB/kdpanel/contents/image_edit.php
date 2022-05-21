<?php

namespace Verot\Upload;

error_reporting(E_ALL);

$errors = array();
if(!empty($_POST)) {
    if(empty($errors)) {
        //recorro y guardo las imagenes
        if(!empty($_FILES['fotos']['name'][0])) {
            include_once(CONFIGPATH . 'class.upload.php');
            foreach ($_FILES['fotos']['name'] as $key => $file) {
                    if (!empty($file)) {
                    $handle = new Upload($_FILES['fotos']['tmp_name'][$key]);
                    
                    if ($handle->uploaded) {
                        $pic = find("contents_pictures",'src,content_id','id = '.escape($_GET['id']));
                        //elimino la imagen
                        @unlink(WWW_ROOT."img/paginas/".$pic['src']);
                        @unlink(WWW_ROOT."img/paginas/thumbs/".$pic['src']);

                        // el archivo se subio, seteo el resize en varias versiones y reemplazo la imagen
                        $handle->image_resize = true;
                        $handle->image_ratio_x = true;
                        $handle->image_x = 640;
                        $handle->image_y = 480;
                        $handle->process(WWW_ROOT."img/tmp/");
                        if ($handle->processed) {
                            copy(WWW_ROOT."img/tmp/".$handle->file_dst_name,WWW_ROOT.'img/paginas/'.$pic['src']);
                            unlink(WWW_ROOT."img/tmp/".$handle->file_dst_name);
                        } else {
                            $errors['fotos'] = "Error: ".$handle->error;
                        }
                        

                        $handle->image_resize = true;
                        $handle->image_ratio_x = true;
                        $handle->image_ratio_crop = true;
                        $handle->image_x = 220;
                        $handle->image_y = 170;
                        $handle->process(WWW_ROOT."img/tmp/");
                        if ($handle->processed) {
                            copy(WWW_ROOT."img/tmp/".$handle->file_dst_name,WWW_ROOT.'img/paginas/thumbs/'.$pic['src']);
                            unlink(WWW_ROOT."img/tmp/".$handle->file_dst_name);
                        } else {
                            $errors['fotos'] = "Error: ".$handle->error;
                        }
                        
                        echo '<script>location.href="/kdpanel/contents/edit?id='.$pic['content_id'].'";</script>';
                        exit;
                    }else {
                        die("error al subir ".$handle->error);
                    }
                    $numfoto++;
                }
            }//end while
            $ok = true;
        }//end if no empty
    }
}
$pic = find("contents_pictures",null,"id = ".escape($_GET['id']));
?>
<div class="widget-top">
    <h3>Editar Imagen</h3>
</div>
<div class="inside">
    <?
    if(isset($ok)){?>
    <div class="box_success">
        Imagen editada correctamente
    </div>
    <? }?>
    <form action="" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<?=$_GET['id']?>" />
        <div class="input">
            <label>Imagen actual:</label>
            <img src="/img/paginas/thumbs/<?=$pic['src']?>?rand=<?=rand(0, 999)?>" />
        </div>
        <div class="input">
            <label>Nueva Imagen:</label>
            <input type="file" name="fotos[]" /><br>
            <? showerror($errors, 'fotos')?>
        </div>
        <div class="input submit">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?=loading();?>
    </form>
</div>