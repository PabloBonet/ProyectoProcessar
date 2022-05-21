<?
if(!empty($_GET['id'])){
    $pic = find("contents_pictures", null, "id = ".escape($_GET['id']));
    if(!empty($pic)){
        unlink(WWW_ROOT.'img/paginas/'.$pic['src']);
        unlink(WWW_ROOT.'img/paginas/thumbs/'.$pic['src']);
        query("DELETE FROM contents_pictures WHERE id = ".escape($_GET['id']));
    }
    echo "<script>location.href = '/kdpanel/contents/edit?id=".$pic['content_id']."';</script>";
}
?>