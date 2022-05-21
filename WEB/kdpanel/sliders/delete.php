<?php
if(!empty($_GET['id']) && isValidNumber($_GET['id'])){
    $slider = find("sliders","id","id = ".escape($_GET['id']));
    query("DELETE FROM sliders WHERE id = ".$slider['id']);
    @unlink(WWW_ROOT.'img/sliders/'.$slider['id'].'.jpg');
    @unlink(WWW_ROOT.'img/sliders/'.$slider['id'].'_small.jpg');
    echo '<script>location.href="'.ADMINROOT.'sliders/index";</script>';
}
?>
