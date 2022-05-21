<?php
$errors = false;
if(!empty($_POST)) {
    foreach($_POST As $key => $value) {
        if(empty($value)) {
            $error = true;
        }
    }
    if(!$error) {
        foreach($_POST As $key => $value) {
            if(strlen($key) > 1) {
                $sql = "UPDATE
                        settings
                        SET
                        value = '" . ($value) . "'
                        WHERE
                        name = '" . $key . "'";
                query($sql);
            }
        }
        $ok = 'Datos guardados correctamente.';
    }
}
$fields = findAll("settings");
$_POST = $fields;
?>
<div class="widget-top">
    <h3>Configuraciones Generales</h3>
</div>
<div class="inside">
    <? if(isset($ok)) {echo showbox('ok','Cambios guardados correctamente.');}?>
    <? if(isset($error)) {echo showbox('error','Error al guardar.','Verifique que todos los campos esten completos.');}?>
    <form action="" method="post">
            <?php foreach($_POST as $field) {?>
            <div class="input">
                <label><?=$field['label']?>:<br /><small>(<?=($field['description'])?>)</small></label>
                
                        <?php switch($field['fieldtype']) {
                            case 'text':
                                ?>
                            <input type="text" name="<?=$field['name']?>" class="required" style="width:437px" value="<?=($field['value'])?>" />
                                <?php break;
                            case 'textarea':
                                ?>
                                <textarea name="<?=$field['name']?>" class="required" rows="5" style="width:437px"><?=($field['value'])?></textarea>
                                <?php break;
                        }?>
                <div class="clear"></div>
            </div>
                <?php }?>
        <br />
        <div class="input submit">
            <input type="submit" value="" class="btn btn-guardar" />
        </div>
    </form>
</div>