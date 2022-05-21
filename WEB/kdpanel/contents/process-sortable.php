<?php
include_once '../../inc/config.inc.php';
checksession();
if(!empty ($_GET['listItem'])){
    foreach ($_GET['listItem'] as $position => $item) :
    //	$sql[] = "UPDATE `table` SET `position` = $position WHERE `id` = $item";
            mysql_query("UPDATE `contents_pictures` SET `order` = $position WHERE `id` = $item");
    endforeach;
}
echo showbox("ok", "Cambio realizado correctamente.");
?>
<script type="text/javascript">
    setTimeout(function(){$('.box-ok').hide("slow");}, 3000);
</script>