<?php
$users = findAll("newsletter_users");
?>
<div class="widget-top">
    <h3>Listado de Usuarios de Newsletter</h3>
</div>
<div class="inside">
    <table class="tabla">
        <tr>
            <th class="left">Nombre</th>
            <th class="left">Email</th>
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
                        <a href="/kdpanel/newsletter-users/edit?id=<?=$user['id']?>" title="Editar"><img src="/img/ico-edit.png" alt="Editar"/></a>
                        <a href="/kdpanel/newsletter-users/delete?id=<?=$user['id']?>" title="Eliminar" onclick="return confirm('Est&aacute; seguro de eliminar el usuario?')"><img src="/img/ico-delete.png" alt="Eliminar"/></a>
                    </td>
                </tr>
                <?
            }
        }else{
            ?>
            <tr>
                <td colspan="3">No se encontraron usuarios para listar.</td>
            </tr>
        <?
        }
        ?>
    </table>
    <? if(!empty($users)){?><br/><div align="center"><a href="exportar"><img src="/img/ico-excel.png" alt="Excel" align="absmiddle" /> Exportar lista en excel</a></div><?}?>
</div>