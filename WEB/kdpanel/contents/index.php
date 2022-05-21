<?php
$contents = findAll("contents",null,"content_id = 0","title");
?>
<div class="widget-top">
    <a href="add" class="link-add">Agregar nueva</a>
    <h3>Listado de P&aacute;ginas de contenido</h3>
</div>
<div class="inside">
    <table class="tabla">
        <tr>
            <th class="left">T&iacute;tulo</th>
            <th>Opciones</th>
        </tr>
        <?
        if(!empty($contents)){
            foreach ($contents as $content) {
                ?>
                <tr>
                    <td class="left"><?=$content['title']?></td>
                    <td class="actions">
                        <a href="<?=ADMINROOT?>contents/edit?id=<?=$content['id']?>" title="Editar"><img src="/img/ico-edit.png" alt="Editar"/></a>
                        <a href="<?=ADMINROOT?>contents/delete?id=<?=$content['id']?>" title="Eliminar" onclick="return confirm('Est&aacute; seguro de eliminar el contenido?')"><img src="/img/ico-delete.png" alt="Eliminar"/></a>
                    </td>
                </tr>
                <?
                $subpages = findAll("contents",null,"content_id = ".$content['id'],"title");
                if(!empty($subpages)){
                    foreach ($subpages as $subpage) {
                    ?>
                    <tr>
                        <td class="left" style="padding-left: 20px">...<?=$subpage['title']?></td>
                        <td class="actions">
                            <a href="<?=ADMINROOT?>contents/edit?id=<?=$subpage['id']?>" title="Editar"><img src="/img/ico-edit.png" alt="Editar"/></a>
                            <a href="<?=ADMINROOT?>contents/delete?id=<?=$subpage['id']?>" title="Eliminar" onclick="return confirm('Est&aacute; seguro de eliminar el contenido?')"><img src="/img/ico-delete.png" alt="Eliminar"/></a>
                        </td>
                    </tr>
                <?
                }}
            }
        }else{
            ?>
            <tr>
                <td colspan="2">No se encontraron contenidos editables</td>
            </tr>
        <?
        }
        ?>
    </table>
</div>