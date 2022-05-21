<?php
$where = '1=1';
if(!empty($_GET['section_id'])){
    $where .= ' AND s.section_id = '.escape($_GET['section_id']);
}
$sliders = query("SELECT s.*,ss.title AS section FROM sliders AS s LEFT JOIN sliders_sections AS ss ON ss.id = s.section_id WHERE $where GROUP BY s.id ORDER BY s.id DESC");
$sections = findAll("sliders_sections","id,title",null,"id");
?>
<div class="widget-top">
    <a href="add" class="link-add">Agregar nuevo Slider</a>
    <h3>Listado de Sliders</h3>
</div>
<div class="inside">
    <form action="" method="get">
        <div class="input" style="float: left;width: auto; margin: 1px 5px 10px 0">
            <label>Filtrar por secci&oacute;n:</label>
            <select name="section_id" class="select">
                <option value="">Seleccione...</option>
                <? if(!empty($sections)){
                    foreach ($sections as $father) {
                        $selected = ($father['id'] == @$_GET['section_id'])?' selected="selected"':'';
                        ?>
                        <option value="<?=$father['id']?>"<?=$selected?>><?=$father['title']?></option><?
                    }
                }?>
            </select>
        </div>
        <input type="submit" value="" class="btn btn-buscar" />
    </form>
    <table class="tabla">
        <tr>
            <th class="left">Imagen</th>
            <th class="left">T&iacute;tulo</th>
            <th class="left">Secci&oacute;n</th>
            <th>Opciones</th>
        </tr>
        <?
        if(!empty($sliders)){
            foreach ($sliders as $slider) {
                ?>
                <tr>
                    <td class="left"><img src="/img/sliders/<?=$slider['id']?>.jpg" width="200" /></td>
                    <td class="left"><?=$slider['title']?></td>
                    <td class="left"><?=$slider['section']?></td>
                    <td class="actions">
                        <a href="edit?id=<?=$slider['id']?>" title="Editar"><img src="/img/ico-edit.png" alt="Editar"/></a>
                        <a href="delete?id=<?=$slider['id']?>" title="Eliminar" onclick="return confirm('Est&aacute; seguro de eliminar el slider?')"><img src="/img/ico-delete.png" alt="Eliminar"/></a>
                    </td>
                </tr>
                <?
            }
        }else{
            ?>
            <tr>
                <td colspan="4">No se encontraron banners sliders</td>
            </tr>
        <?
        }
        ?>
    </table>
</div>