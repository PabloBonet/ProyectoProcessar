<?php
$users = findAll("users");
?>
<div class="widget-top">
    <a href="add" class="link-add">Agregar nuevo</a>
    <h3>Listado de Usuarios</h3>
</div>
<div class="inside">
    <table class="tabla">
        <tr>
            <th class="left">Nombre</th>
            <th class="left">Email</th>
            <th>Estado</th>
            <th width="100">Opciones</th>
        </tr>
        <?
        if(!empty($users)){
            foreach ($users as $key => $user) {
                $class = ($key % 2)?' class="altrow"':'';
                ?>
                <tr<?=$class?>>
                    <td class="left"><?=$user['name']?></td>
                    <td class="left"><?=$user['email']?></td>
                    <td>
                        <select name="activo" onchange="location.href='changestatus?id=<?=$user['id']?>&v='+this.value" style="width: 70px">
                            <option value="0"<?=($user['activo'] == '0')?' selected="selected"':false?>>Inactivo</option>
                            <option value="1"<?=($user['activo'] == '1')?' selected="selected"':false?>>Activo</option>
                        </select>
                    </td>
                    <td>
                        <a href="/kdpanel/users/edit?id=<?=$user['id']?>" title="Editar"><img src="/img/ico-edit.png" alt="Editar"/></a>
                        <? if(in_array($_SESSION['useradmin'],array('kdstudios','tulio'))){?>
                            <a href="/kdpanel/users/delete?id=<?=$user['id']?>" title="Eliminar" onclick="return confirm('Est&aacute; seguro de eliminar el usuario?')"><img src="/img/ico-delete.png" alt="Eliminar"/></a>
                        <? }?>
                    </td>
                </tr>
                <?
            }
        }else{
            ?>
            <tr>
                <td colspan="4">No se encontraron usuarios para listar.</td>
            </tr>
        <?
        }
        ?>
    </table>
    <? if(!empty($users)){?><br/><div align="center"><a href="exportar"><img src="/img/ico-excel.png" alt="Excel" align="absmiddle" /> Exportar lista en excel</a></div><?}?>
</div>