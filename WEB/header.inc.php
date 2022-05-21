<?
$subservicios = findAll("contents", "title,url", "content_id=5");
?>
<!-- NAVBAR
        ================================================== -->
<div class="container">
    <div class="col-md-4 center p_t">
        <a href="<?= URLWEB ?>" id="logo" title="Ir al Inicio"><img src="/img/logo-processar.png" alt="Processar IT - Software de gestion empresarial" /></a>
    </div>
    <div class="col-md-8">
        <? 
        
        if(!strstr($_SERVER['SCRIPT_NAME'], 'login.php')){?>
        <button onclick="location.href='/usuarios/'" class="btn btn-default btnusuario" aria-label="Acceso usuarios">
            <span class="glyphicon glyphicon-user" aria-hidden="true"></span> Acceso usuarios
        </button>
        <? }?>
        <div class="clear"></div>
        <nav class="navbar" id="header">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav" id="menu">
                    <li<?= (@$section == 'inicio') ? ' class="active"' : false ?>><a href="/">Inicio</a></li>
                    <li<?= (@$section == 'quienes-somos') ? ' class="active"' : false ?>><a href="/paginas/quienes-somos.html">Quienes Somos</a></li>
                    <li<?= (@$section == 'servicios') ? ' class="active"' : false ?>>
                        <a href="/paginas/servicios.html" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false" rel="nofollow">Servicios<?= (!empty($subservicios)) ? ' <span class="caret"></span>' : false ?></a>
                        <?
                        if (!empty($subservicios)) {
                            ?>
                            <ul class="dropdown-menu" role="menu">
                                <?
                                foreach ($subservicios as $page) {
                                    ?>
                                    <li><a href="/paginas/<?= $page['url'] ?>"><?= $page['title'] ?></a></li>
                                <? }
                                ?>
                            </ul>
                        <? } ?>

                    </li>
                    <li<?= (@$section == 'contacto') ? ' class="active"' : false ?>><a href="/index.php?contacto=1"<?php if (@$section == 'inicio') { ?> onclick="$('html,body').animate({scrollTop: $('#contactform').offset().top}, 'slow');$('input.form-control:first').focus();return(false);" <?php } ?>>Contacto</a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </nav>
    </div>
</div>
<br>