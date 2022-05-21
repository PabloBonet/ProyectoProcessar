<?php
$groups = findAll("users_groups");
?>
<div class="widget-top">
    <a href="add" class="link-add">Agregar nuevo</a>
    <h3>Listado de Grupos de usuarios</h3>
</div>
<div class="inside">
    <table class="tabla">
        <tr>
            <th class="left">T&iacute;tulo</th>
            <th width="100">Opciones</th>
        </tr>
        <?
        if(!empty($groups)){
            foreach ($groups as $key => $group) {
                $class = ($key % 2)?' class="altrow"':'';
                ?>
                <tr<?=$class?>>
                    <td class="left"><?=$group['title']?></td>
                    <td>
                        <a href="/kdpanel/users/groups_edit?id=<?=$group['id']?>" title="Editar"><img src="/img/ico-edit.png" alt="Editar"/></a>
                        <a href="/kdpanel/users/groups_delete?id=<?=$group['id']?>" title="Eliminar" onclick="return confirm('Est&aacute; seguro de eliminar el grupo de usuarios?')"><img src="/img/ico-delete.png" alt="Eliminar"/></a>
                    </td>
                </tr>
                <?
            }
        }else{
            ?>
            <tr>
                <td colspan="2">No se encontraron grupos de usuarios para listar.</td>
            </tr>
        <?
        }
        ?>
    </table>
</div>