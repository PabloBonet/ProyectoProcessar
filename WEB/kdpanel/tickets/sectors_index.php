<?php
$sectors = findAll("tickets_sectors",null,null,"title ASC");
?>
<div class="widget-top">
    <a href="sectors_add" class="link-add">Agregar nueva</a>
    <h3>Listado de Areas de soporte</h3>
</div>
<div class="inside">
    <table class="tabla">
        <tr>
            <th class="left">T&iacute;tulo</th>
            <th width="150">Emails</th>
            <th width="100">Opciones</th>
        </tr>
        <?
        if(!empty($sectors)){
            foreach ($sectors as $key => $sector) {
                $class = ($key % 2)?' class="altrow"':'';
                ?>
                <tr<?=$class?>>
                    <td class="left" nowrap><?=$sector['title']?></td>
                    <td><?=$sector['emails']?></td>
                    <td>
                        <a href="sectors_edit?id=<?=$sector['id']?>" title="Editar"><img src="/img/ico-edit.png" alt="Editar"/></a>
                        <!--<a href="sectors_delete?id=<?=$sector['id']?>" title="Eliminar" onclick="return confirm('Est&aacute; seguro de eliminar la selecci&oacute;n?')"><img src="/img/ico-delete.png" alt="Eliminar"/></a>-->
                    </td>
                </tr>
                <?
            }
            }else{
            ?>
            <tr>
                <td colspan="3">No se encontraron sectores para listar.</td>
            </tr>
        <?
        }
        ?>
    </table>
</div>