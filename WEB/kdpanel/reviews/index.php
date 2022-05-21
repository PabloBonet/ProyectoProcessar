<?php
$reviews = findAll("clients_reviews");
?>
<div class="widget-top">
    <h3>Listado de Opiniones de clientes</h3>
</div>
<div class="inside">
    <table class="tabla">
        <tr>
            <th class="left">Nombre</th>
            <th>Opciones</th>
        </tr>
        <?
        if(!empty($reviews)){
            foreach ($reviews as $review) {
                ?>
                <tr>
                    <td class="left"><?=$review['name']?></td>
                    <td class="actions">
                        <a href="<?=ADMINROOT?>reviews/edit?id=<?=$review['id']?>" title="Editar"><img src="/img/ico-edit.png" alt="Editar"/></a>
                        <a href="<?=ADMINROOT?>reviews/delete?id=<?=$review['id']?>" title="Eliminar" onclick="return confirm('Est&aacute; seguro de eliminar el contenido?')"><img src="/img/ico-delete.png" alt="Eliminar"/></a>
                    </td>
                </tr>
                <?
            }
        }else{
            ?>
            <tr>
                <td colspan="2">No se encontraron opiniones</td>
            </tr>
        <?
        }
        ?>
    </table>
</div>