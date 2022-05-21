<?php
include_once '../inc/config.inc.php';
checksession("usuario");

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

//busco las subpaginas
//$subpages = findAll("contents", null, "content_id = " . $content['id'] , "title");
$subpages = query("SELECT c.title,c.url,p.src FROM contents AS c LEFT JOIN contents_pictures AS p ON p.content_id = c.id WHERE c.content_id = ".$content['id']." GROUP BY c.id ORDER BY c.title,p.order");
//pr($subpages);
$pictures = findAll("contents_pictures", null, "content_id = " . $content['id'], "contents_pictures.order");
$section = 'tutoriales';
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <? include_once '../common_head.inc.php'; ?>
        <title><?= $content['title'] ?> | <?= $GLOBALS['META_TITLE'] ?></title>
        <link rel="stylesheet" href="/js/shadowbox-3.0.3/shadowbox.css" type="text/css" />
        <script type="text/javascript" src="/js/shadowbox-3.0.3/shadowbox.js"></script>
        <script type="text/javascript">
            Shadowbox.init();
        </script>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <? include_once '../header.inc.php'; ?>

                <div class="col-md-4">
                    <?
                    include_once 'menu-usuario.php';
                    ?>
                </div>
                <div class="col-md-8">
                    <h1 class="title"><?= $content['title'] ?></h1>
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
                    <? if (!empty($subpages)) { ?>
                        <div class="row">
                                <?
                                foreach ($subpages as $key => $page) {
                                    ?>
                                    <div class="col-md-4 center">
                                    <a href="<?= $page['url'] ?>">
                                        <? if(!empty($page['src']) && file_exists(WWW_ROOT."img/paginas/thumbs/".$page['src'])){?>
                                            <img src="/img/paginas/thumbs/<?=$page['src']?>" alt="<?= $page['title'] ?>">
                                        <?}else{?>
                                            <img src="/img/no-thumb.png" alt="<?= $page['title'] ?>">
                                        <? }?><br>
                                        <?= $page['title'] ?>
                                    </a>
                                    </div>
                                <? }
                                ?>
                        </div>
                    <? } ?>
                    <br><br>
                </div>
            </div>
        </div>
        <? include_once '../footer.inc.php'; ?>
    </body>
</html>