<?
if(!empty($_GET['id'])){
    mysql_query("DELETE FROM videos WHERE id = ".escape($_GET['id']));
    echo "<script>location.href = '/kdpanel/videos/index';</script>";
}
?>