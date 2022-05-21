<?
include_once '../inc/class.TemplatePower.inc.php';
$errors = array();
if(!empty($_POST)) {
    if (empty($_POST['sector_id']) || !isValidNumber($_POST['sector_id'])) {
        $errors['sector_id'] = 'Seleccione un area de soporte.';
    }
    if (empty($_POST['priority']) || !isValidNumber($_POST['priority'])) {
        $errors['priority'] = 'Seleccione un valor.';
    }
    if (empty($_POST['subject'])) {
        $errors['subject'] = 'Ingrese un asunto.';
    }
    if (empty($_POST['description'])) {
        $errors['description'] = 'Ingrese un mensaje.';
    }
    //validar archivo adjunto. Si da el formato y si no hubo errores
    if (!empty($_FILES['adjunto']['name'])) {
        $filename = $_FILES['adjunto']['name'];
        $temp = explode(".", $filename);
        $filename = $temp[0];
        $ext = strtolower(end($temp));

        if ($_FILES["adjunto"]["error"] > 0) {
            $errors['adjunto'] = 'Error: ' . codeToMessage($_FILES["adjunto"]["error"]);
        } else {
            if (strlen($filename) > 100) {
                $errors['adjunto'] = 'El nombre del archivo no puede superar los 100 caracteres';
            } else {
                $allowedExts = array("jpg", "jpeg", "png", "txt","pdf","doc","xls","docx","xlsx");
                if (!in_array($ext, $allowedExts)) {
                    $errors['adjunto'] = 'Solo se permiten archivos txt, jpg, png, pdf, doc, xls';
                }
            }
        }
    }
    if(empty($errors)) {
        $fecha = time();
        $_POST['fecha'] = date("Y-m-d H:i:s", $fecha);
        if($id = query_insert('tickets', $_POST)) {
            
            //subo adjunto
            if(!empty($_FILES['adjunto']['name'])){
                move_uploaded_file($_FILES["adjunto"]["tmp_name"], WWW_ROOT."soporte/".$id.'.'.$ext);
                query_update("tickets", array("adjunto" => $id.'.'.$ext),"id = ".$id);
                $adjunto = URLWEB."soporte/".$id.'.'.$ext;
            }else {$adjunto = '---';}
            
            $sector = find("tickets_sectors", null, "id = " . $_POST['sector_id']);
            $usuario = find("users", null, "id = " . $_POST['user_id']);
            $prioridades = array(1 => "Baja", 2 => "Normal", 3 => "Alta");

            $subject = "Nuevo ticket de soporte";

            $template = new TemplatePower("../webroot/template_mails/ticket_desdeadmin_template.html");
            $template->prepare();
            $template->assignGlobal("SITE_URL", URLWEB);
            $template->assignGlobal("TICKETID", $id);
            $template->assignGlobal("FECHA", date("d/m/Y H:i:s", $fecha));
            $template->assignGlobal("PRIORIDAD", $prioridades[$_POST['priority']]);
            $template->assignGlobal("SECTOR", $sector['title']);
            $template->assignGlobal("ADMIN", $_SESSION['uname']);
            $template->assignGlobal("NOMBRE", $usuario['name']);
            $template->assignGlobal("EMAIL", $usuario['email']);
            $template->assignGlobal("ASUNTO", str_replace(array("'", '"', ';', "?", "\\"), "", strip_tags(nl2br($_POST['subject']), '<br>')));
            if (!empty($_FILES['adjunto']['name'])) {
                $template->newBlock( "adjunto" );
                $template->assignGlobal("ADJUNTO", $adjunto);
            }
            $template->assignGlobal("MENSAJE", str_replace(array("'", '"', ';', "?", "\\"), "", strip_tags(nl2br($_POST['description']), '<br>')));

            $template->assignGlobal("IP", $_SERVER['REMOTE_ADDR']);

            $final_template = $template->getOutputContent();
            //die($final_template);
            $header = "From:no-reply@processar.com.ar\nReply-To:no-reply@processar.com.ar\n";
            $header .= "X-Mailer:PHP/" . phpversion() . "\n";
            $header .= "Mime-Version: 1.0\n";
            $header .= "Content-Type: text/html;";
            $header .= "charset=UTF-8;";
            
            
            //agregar envio de email al usuario con link de seguimiento
            mail($usuario['email'], $subject, $final_template, $header);
            
            
            $ok = true;
        }else{
            $error = true;
        }
    }else{ 
        $error = true;
    }
    $ticket = $_POST;
}
$sectors = findList("tickets_sectors", "id,title");
$usuarios = findList("users", "id,name");
$prioridades = array(""=>"Prioridad",1=>"",2=>"",3=>"");

?>
<div class="widget-top">
    <h3>Agregar Nuevo ticket</h3>
</div>
<div class="inside">
    <?
    if(isset($ok)) {echo showbox("ok", "Ticket creado correctamente.");}
    if(isset($error)){echo showbox("error","Error al guardar los datos.","Verifique los campos obligatorios.");}?>
    <form action="" method="post" enctype="multipart/form-data">
        <div class="input">
            <label>Usuario*:</label>
            <select type="text" name="user_id" required class="select">
                <option value="">Seleccione usuario...</option>
                <? printOptions($usuarios, @$_POST['user_id']); ?>
            </select>
            <? showerror($errors, 'user_id') ?>
        </div>
        <div class="input">
            <label>Sector de soporte*:</label>
            <select type="text" name="sector_id" required class="select">
                <option value="">Seleccione sector...</option>
                <? printOptions($sectors, @$_POST['sector_id']); ?>
            </select>
            <? showerror($errors, 'sector_id') ?>
        </div>
        <div class="input">
            <label>Prioridad*:</label>
            <select type="text" name="priority" class="select" required>
                <option value="">Prioridad</option>
                <option value="1">Baja</option>
                <option value="2">Normal</option>
                <option value="3">Alta</option>
            </select>
            <? showerror($errors, 'priority') ?>
        </div>
        <div class="input">
            <label>Asunto*:</label>
            <input type="text" name="subject" required maxlength="150">
            <? showerror($errors, 'subject')?>
        </div>
        <div class="input">
            <label>Mensaje*:</label>
            <textarea name="description" class="textarea" required></textarea>
            <? showerror($errors, 'description') ?>
            <div class="clear"></div>
        </div>
        <div class="input">
            <label>Adjuntar archivo: </label>
            <input type="file" name="adjunto" />
            <? showerror($errors, 'adjunto') ?><br>
        </div>
        
        <div class="input" style="margin-left: 130px">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display='block'" />
        </div>
        <?=loading();?>
    </form>
</div>