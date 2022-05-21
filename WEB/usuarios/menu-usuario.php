<?
$contenidos_user = findAll("contents","title,url","section=2 AND content_id = 0");
?>
<h2 class="title">Menu Usuario</h2>
<ul id="menucliente">
    <li><a href="/usuarios/index.php">Inicio</a></li>
    <? if(!empty($contenidos_user)){
     foreach ($contenidos_user as $link) {
         ?>
        <li><a href="/usuarios/tutorial/<?=$link['url']?>"><?=$link['title']?></a></li>
         <?
     }
    }?>
    <li><a href="/usuarios/tickets.php">Soporte</a></li>
    <li><a href="/usuarios/mis-datos.php">Mis Datos</a></li>
    <li><a href="/usuarios/logout.php">Cerrar Sesi&oacute;n</a></li>
</ul>