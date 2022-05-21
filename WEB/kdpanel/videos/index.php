<?php

$videos = query("SELECT v.* FROM videos AS v ORDER BY v.id DESC");
?>
<div class="widget-top">
    <a href="add" class="link-add">Agregar nuevo video</a>
    <h3>Listado de Videos</h3>
</div>
<div class="inside">
    <table class="tabla">
        <tr>
            <th class="left">T&iacute;tulo</th>
            <th>Opciones</th>
        </tr>
        <?
        if(!empty($videos)){
            foreach ($videos as $key => $video) {
                $class =($key % 2)?' class="altrow"':'';
               ?>
                <tr<?=$class?>>
                    <td class="left"><?=str_replace('"','&quot;',$video['title'])?></td>
                    <td class="actions">
                        <a href="<?=$video['url']?>" title="Ver" target="_blank"><img src="/img/ico-view.png" alt="Ver video"/></a>
                        <a href="/kdpanel/videos/edit?id=<?=$video['id']?>" title="Editar"><img src="/img/ico-edit.png" alt="Editar"/></a>
                        <a href="/kdpanel/videos/delete?id=<?=$video['id']?>" title="Eliminar" onclick="return confirm('Est&aacute; seguro que desea eliminar el video seleccionado?')"><img src="/img/ico-delete.png" alt="Eliminar"/></a>
                    </td>
                </tr>
                <?
            }
        }else{
            ?>
            <tr>
                <td colspan="4">No se encontraron videos</td>
            </tr>
        <?
        }
        ?>
    </table>
</div>