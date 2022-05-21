<?php
include_once ('../inc/config.inc.php');
@session_start();
if(!empty($_GET['url']) && !testUrl($_GET['url'])){die();}
if(@$_GET['url'] != 'login')
{
    $sidebar = true;
    checksession();
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" xml:lang="es">

    <head>
        <title>KD PANEL - Sistema de Administraci&oacute;n Web</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="/css/admin.css" rel="stylesheet" type="text/css" />
        
        <script src="/js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <link type="text/css" href="/js/jquery-ui-1.10.3.custom/css/ui-lightness/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" />
        <script type="text/javascript" src="/js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js"></script>
    </head>
    <body>
        <div align="center">
        <div id="container">
            <div class="header-l">
                <div class="header-r">
                    <div class="header">
                        <?
                        if(!empty($_SESSION['useradmin'])){?>
                        <div id="user_options">
                            Bienvenido <a href="/kdpanel/users_edit"><strong><?=$_SESSION['useradmin']?></strong></a><br/>
                            <a href="/" class="ico-web">Ver Sitio Web</a><br/>
                            <a href="/kdpanel/logout" class="ico-cerrar">Cerrar Sesi&oacute;n</a>
                        </div>
                        <? }?>
                        <a href="<?=ADMINROOT?>" id="adminlogo"><img src="<?=WEBROOT?>img/admin-logo.gif" alt="KD Admin Panel v3.2" /></a>
                    </div>
                </div>
            </div>
            <? if(isset($sidebar)):?>
            <div id="sidebar"><? include_once ('sidebar.php');?></div>
            <div id="main">
            <? endif;?>
                <div id="content">
                    <? if(!empty($_SESSION['default_user'])){
                        echo showbox('warning','Usted esta usando una contrase&ntilde;a por defecto.','Por favor modifique sus datos desde <a href="/kdpanel/users_edit">aqu&iacute;</a>.');
                        }?>
                    <div class="widget">
                        <?
                        $urlget = @escape($_GET['url']);
                        if(!empty($urlget) && $urlget != 'index'){
                            if(file_exists($urlget.'.php'))
                                include_once($urlget.'.php');
                            else
                                include_once('error.php');
                        }
                        else
                            include_once('home.php');
                        ?>
                    </div>
                </div>
                <? if(isset($sidebar)):?>
            </div>
            <? endif;?>
            <div class="clear"></div>
            <div id="footer">
                <div id="footer-inner">
                    <a href="mailto:contacto@kdstudios.com.ar" class="ayuda">Ayuda del sistema</a>
                    <a href="mailto:contacto@kdstudios.com.ar">
                        <img src="<?=WEBROOT?>img/ico-kd.gif" alt="KD Studios Web Solutions" />
                    </a>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
        </div>
    </body>
</html>