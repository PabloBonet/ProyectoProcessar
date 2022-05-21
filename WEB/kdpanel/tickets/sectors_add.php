<?
$errors = array();
if(!empty($_POST)) {
    if(empty($_POST['title'])) {
        $errors['title'] = 'Campo requerido';
    }
    if(empty($_POST['emails'])) {
        $errors['emails'] = 'Campo requerido';
    }else{
        $_POST['emails'] = str_replace(" ","",$_POST['emails']);
    }
    if(empty($errors)) {
        if(query_insert('tickets_sectors', $_POST)) {
            $ok = true;
        }else
            $error = true;
    }else{
        $error = true;
        $sector = $_POST;
    }
}
?>
<div class="widget-top">
    <h3>Agregar Sector de soporte</h3>
</div>
<div class="inside">
    <?
    if(isset($ok)) {echo showbox("ok", "Sector de soporte agregado correctamente.","Puede continuar agregando.");}
    if(isset($error)){echo showbox("error","Error al guardar los datos.","Verifique los campos obligatorios.");}?>
    <form action="" method="post">
        <div class="input">
            <label>T&iacute;tulo<span class="requerido">*</span>:</label>
            <input type="text" name="title" maxlength="20" value="<?=@$sector['title']?>" />
            <? showerror($errors, 'title')?>
        </div>
        <div class="input">
            <label>Emails separados por coma<span class="requerido">*</span>:</label>
            <input type="text" name="emails" maxlength="150" value="<?=@$sector['emails']?>" />
            <? showerror($errors, 'emails')?>
        </div>
        <div class="input" style="margin-left: 348px">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?=loading();?>
    </form>
</div>