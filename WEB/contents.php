<?php
include_once 'inc/config.inc.php';
if (empty($_GET['url'])) {
    header('Location:/index.php');
    exit();
} else {
    if (!testUrl($_GET['url'])) {
        header('Location:/index.php');
        exit();
    }
}
$where = "url = '" . escape($_GET['url']) . ".html'";
$content = find("contents", null, $where);
if (empty($content))
    header("Location:/index.php");
$where = '';

$related = findAll("contents", null, "(content_id = " . $content['content_id'] . " OR content_id = " . $content['id'] . ") AND content_id > 0 AND id <>" . $content['id'], "title");

$pictures = findAll("contents_pictures", null, "content_id = " . $content['id'], "contents_pictures.order");



if ($content['id'] == 5 || $content['content_id'] == 5){
    $section = 'servicios';
    $sliders = findAll("sliders", null, "section_id = 3");
}else{
    $section = 'quienes-somos';
    $sliders = findAll("sliders", null, "section_id = 2");
}
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <? include_once 'common_head.inc.php'; ?>
        <title><?= $content['title'] ?> | <?= $GLOBALS['META_TITLE'] ?></title>
        <link rel="stylesheet" href="/js/shadowbox-3.0.3/shadowbox.css" type="text/css" />
        <script type="text/javascript" src="/js/shadowbox-3.0.3/shadowbox.js"></script>
        <script type="text/javascript">
            Shadowbox.init();
        </script>
    </head>
    <body>
        <div class="container">
            <? include_once 'header.inc.php'; ?>
            <h1 class="title"><?= $content['title'] ?></h1>
            <? include_once 'slider.inc.php'; ?>
            <div id="main">
                    <?= $content['description'] ?>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <? if (!empty($pictures)) { ?>
                        <div class="thumbs">
                            <h3 class="titlebar2">Galer&iacute;a de Fotos:</h3>
                            <div class="thumbs_inner">
                                <?
                                foreach ($pictures as $key => $pic) {
                                    ?>
                                    <a href="/img/paginas/<?= $pic['src'] ?>" title="<?= $content['title'] ?>" rel="shadowbox[galeria]"><img src="/img/paginas/thumbs/<?= $pic['src'] ?>" alt="<?= $content['title'] ?>" /></a>
                                    <?
                                    if ($key + 1 % 5 == 0)
                                        echo '<div class="clear"></div>';
                                }
                                ?>
                                <div class="clear"></div>
                            </div>
                            <p align="center"><cite>Click sobre las im&aacute;genes para ampliar</cite></p>
                        </div>
                    <? } ?>
                </div>
            </div>
            <? if (!empty($related)) { ?>
                <div class="row">
                    <div class="col-md-12" id="related_pages">
                        <h3>Tambi&eacute;n puede interesarle:</h3>
                        <?
                        foreach ($related as $key => $page) {
                            ?>
                            <a href="/paginas/<?= $page['url'] ?>">- <?= $page['title'] ?></a>
                        <? }
                        ?>
                    </div>
                </div>
            <? } ?>
            </div>
            <? include_once 'footer.inc.php'; ?>
    </body>
</html>