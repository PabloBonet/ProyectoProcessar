<?php
if(!empty($_GET['id'])){
    $pictures = findAll("contents_pictures","src","content_id = ".escape($_GET['id']));
    if(!empty($pictures)){
        foreach ($pictures as $pic) {
            unlink(WWW_ROOT.'img/paginas/'.$pic['src']);
            unlink(WWW_ROOT.'img/paginas/thumbs/'.$pic['src']);
        }
        query("DELETE FROM contents_pictures WHERE content_id = ".escape($_GET['id']));
    }
    query("DELETE FROM contents WHERE id = ".escape($_GET['id'])." OR content_id = ".escape($_GET['id']));
    echo '<script>location.href="'.ADMINROOT.'contents/index";</script>';
}
?>
