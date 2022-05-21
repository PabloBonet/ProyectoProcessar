<?php
$pathSearch = empty($_GET['url']) ? '' : $_GET['url'];

$links = array(
    "P&aacute;ginas de contenido" => array(
        "ico" => "/img/ico-contents.png",
        "url" => ADMINROOT . "contents/index",
        "Listar P&aacute;ginas" => ADMINROOT . "contents/index",
        "Agregar P&aacute;gina" => ADMINROOT . "contents/add"
    ),
    "Sliders" => array(
        "ico" => "/img/ico-banners.png",
        "url" => ADMINROOT . "sliders/index",
        "Listar/Modificar" => ADMINROOT . "sliders/index",
        "Agregar Nuevo" => ADMINROOT . "sliders/add",
        "Agregar Seccion" => ADMINROOT . "sliders/section_add"
    ),
    "Opiniones de clientes" => array(
        "ico" => "/img/ico-opinion.png",
        "url" => ADMINROOT . "reviews/index",
        "Listar Opiniones" => ADMINROOT . "reviews/index",
        "Agregar Opini&oacute;n" => ADMINROOT . "reviews/add"
    ),
    "Usuarios de newsletter" => array(
        "ico" => "/img/ico-newsletter-users.png",
        "url" => ADMINROOT . "newsletter-users/index",
        "Listar/Modificar" => ADMINROOT . "newsletter-users/index",
        "Agregar Nuevo" => ADMINROOT . "newsletter-users/add"
    ),
    "Usuarios" => array(
        "ico" => "/img/ico-users.png",
        "url" => ADMINROOT . "users/index",
        "Listar/Modificar" => ADMINROOT . "users/index",
        "Agregar Nuevo" => ADMINROOT . "users/add"
    ),
    "Tickets Soporte" => array(
        "ico" => "/img/ico-soporte.png",
        "url" => ADMINROOT . "tickets/index",
        "Listar tickets" => ADMINROOT . "tickets/index",
        "Nuevo ticket" => ADMINROOT . "tickets/add",
        "-" => "-",
        "Listar Sectores" => ADMINROOT . "tickets/sectors_index",
        "Agregar Sector" => ADMINROOT . "tickets/sectors_add"
    ),
    "Opciones" => array(
        "ico" => "/img/ico-config.png",
        "url" => ADMINROOT . "settings",
        "Configuraci&oacute;n" => ADMINROOT . "settings",
        "Mis datos" => ADMINROOT . "users_edit",
        "Cerrar Sessi&oacute;n" => ADMINROOT . "logout"
    )
);
?>
        <?
        foreach ($links as $categ => $options) {
            $ico = $options['ico'];
            $url = $options['url'];
            unset($options['ico']);
            unset($options['url']);
            ?>
        <div class="widget">
            <div class="widget-top">
                <span class="arrow" title="+ Opciones"></span>
                <a href="<?=$url?>" class="index"><img src="<?=$ico?>" alt="<?=$categ?>"/><?=$categ?></a>
            </div>
            <ul class="sections">
            <?
            foreach ($options as $title => $url) {
                if (is_array($url)) {
                    ?><li style="background-color: #ccc; padding:5px;font-weight: bold; margin-top:3px"><?= $title ?></li>
                    <?
                    foreach ($url as $title2 => $url2) {
                        $suburl = str_replace("/kdpanel/", "", $url2);
                        $class = ($pathSearch == $suburl) ? ' class="selected"' : '';
                        ?>
                        <div class="p_l"><a href="<?= $url2 ?>" <?= $class ?>><?= $title2 ?></a></div>
                        <?
                    }
                } else {
                    if ($url == '-') {
                        echo '<li><div class="separator"></div></li>';
                    } else {
                        
                        $suburl = str_replace("/kdpanel/", "", $url);
                        $class = ($pathSearch == $suburl) ? ' class="selected"' : '';
                    ?>
                        <li><a href="<?= $url ?>" <?= $class ?>><?= $title ?></a></li>
                    <?
                    }
                }
            }
            ?>
            </ul>
    </div>
<? } ?>
<script type="text/javascript">
    $().ready(function(){
        $('.arrow').click(function(){
            $(this).parent().next().slideToggle();
            $(this).parent().parent().toggleClass("wg-active");
        });
        $('a.selected').parent().parent().slideDown();
        $('a.selected').parent().parent().parent().addClass("wg-active");
    }); 
</script>