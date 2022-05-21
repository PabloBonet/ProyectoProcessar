<?php
$where = "1 = 1";
    if(!empty($_POST['status'])) $where .= ' AND t.status = '.escape($_POST['status']);
    if(!empty($_POST['user_id'])) $where .= ' AND t.user_id = '.escape($_POST['user_id']);
    

$tickets = query("SELECT t.*,u.email,u.name FROM tickets AS t LEFT JOIN users AS u ON u.id = t.user_id WHERE $where");
$usuarios = findList("users", "id,name",null,"name");
?>
<div class="widget-top">
    <a href="add" style="float: right; margin: 12px"><img src="/img/ico-add.png" alt="Agregar" style="float: left; margin-top: -3px" /> Abrir nuevo ticket</a>
    <h3>Listado de Tickets de clientes</h3>
</div>
<div class="inside">
    <form action="" method="post" class="m_a">
        <strong>Filtrar por:</strong> <br>
        <strong>Estado:</strong>         <input type="radio" name="status" value="0" <?=(empty($_POST['status']))?' checked':false?> /> Todos 
        <input type="radio" name="status" value="1" <?=(@$_POST['status'] == 1) ?' checked':false?> /> Abiertos 
        <input type="radio" name="status" value="2" <?=(@$_POST['status'] == 2) ?' checked':false?> /> Cerrados 
        &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;<strong>Usuario:</strong> <select type="text" name="user_id" class="select" style="width: 150px; float: none">
                <option value="">Usuario...</option>
                <? printOptions($usuarios, @$_POST['user_id']); ?>
            </select>
        <input type="submit" value="Filtrar" class="button" />
    </form>
    <table class="tabla">
        <tr>
            <th class="left">T&iacute;tulo</th>
            <th>Usuario</th>
            <th>Estado</th>
            <th width="100">Opciones</th>
        </tr>
        <?
        if(!empty($tickets)){
            foreach ($tickets as $key => $ticket) {
                $class = ($key % 2)?' class="altrow"':'';
                ?>
                <tr<?=$class?>>
                    <td class="left">#<?=$ticket['id'].' - '.$ticket['subject']?></td>
                    <td><?=$ticket['name'].'<br>'.$ticket['email']?></td>
                    <td><?=($ticket['status']==1)?'Abierto':'Cerrado'?></td>
                    <td>
                        <a href="<?=ADMINROOT?>tickets/edit?id=<?=$ticket['id']?>" title="Editar"><img src="/img/ico-edit.png" alt="Editar"/></a>
                        <a href="<?=ADMINROOT?>tickets/delete?id=<?=$ticket['id']?>" title="Eliminar" onclick="return confirm('Est&aacute; seguro de eliminar el ticket?')"><img src="/img/ico-delete.png" alt="Eliminar"/></a>
                    </td>
                </tr>
                <?
            }
        }else{
            ?>
            <tr>
                <td colspan="3">No se encontraron tickets para listar.</td>
            </tr>
        <?
        }
        ?>
    </table>
</div>