<?php
include_once '../inc/config.inc.php';
include_once '../inc/class.TemplatePower.inc.php';
checksession("usuario");
$errors = array();
if (!isset($_GET['ok']) && !empty($_POST)) {
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

    if (empty($errors)) {

        $_POST['user_id'] = $_SESSION['uid'];
        $fecha = time();
        $_POST['fecha'] = date("Y-m-d H:i:s", $fecha);
        if ($id = query_insert("tickets", $_POST)) {
            if(!empty($_FILES['adjunto']['name'])){
                @move_uploaded_file($_FILES["adjunto"]["tmp_name"], WWW_ROOT."soporte/".$id.'.'.$ext);
                query_update("tickets", array("adjunto" => $id.'.'.$ext),"id = ".$id);
                $adjunto = URLWEB."soporte/".$id.'.'.$ext;
            }else {$adjunto = '---';}
            
            $sector = find("tickets_sectors", null, "id = " . $_POST['sector_id']);
            $usuario = find("users", null, "id = " . $_POST['user_id']);
            $prioridades = array(1 => "Baja", 2 => "Normal", 3 => "Alta");

            $mymail = explode(",", str_replace(" ", "", $sector['emails']));  //debe mandar a los mails del sector_id
            $subject = "Nuevo ticket - (" . $prioridades[$_POST['priority']] . ")";

            $template = new TemplatePower("../webroot/template_mails/ticket_template.html");
            $template->prepare();
            $template->assignGlobal("SITE_URL", URLWEB);
            $template->assignGlobal("FECHA", date("d/m/Y H:i:s", $fecha));
            $template->assignGlobal("PRIORIDAD", $prioridades[$_POST['priority']]);
            $template->assignGlobal("SECTOR", $sector['title']);
            $template->assignGlobal("NOMBRE", $usuario['name']);
            $template->assignGlobal("EMAIL", $usuario['email']);
            $template->assignGlobal("ASUNTO", str_replace(array("'", '"', ';', "?", "\\"), "", strip_tags(nl2br($_POST['subject']), '<br>')));
            $template->assignGlobal("ADJUNTO", $adjunto);
            $template->assignGlobal("MENSAJE", str_replace(array("'", '"', ';', "?", "\\"), "", strip_tags(nl2br($_POST['description']), '<br>')));

            $template->assignGlobal("IP", $_SERVER['REMOTE_ADDR']);

            $final_template = $template->getOutputContent();
            //die($final_template);
            $header = "From:no-reply@processar.com.ar\nReply-To:no-reply@processar.com.ar\n";
            $header .= "X-Mailer:PHP/" . phpversion() . "\n";
            $header .= "Mime-Version: 1.0\n";
            $header .= "Content-Type: text/html;";
            $header .= "charset=UTF-8;";
            
            // envio de mail al sector de soporte
            //agregar envio de email al usuario con link de seguimiento
            foreach ($mymail as $mails) {
                mail($mails, $subject, $final_template, $header);
            }
            //redireccion al ok
            header("Location:nuevo-ticket.php?ok=1");
            exit();
        } else {
            $error = true;
        }
    } else{
        $error = true;
    }
}
$sectors = findList("tickets_sectors", "id,title");
$prioridades = array(""=>"Prioridad",1=>"",2=>"",3=>"");

$section = 'soporte';
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <? include_once '../common_head.inc.php'; ?>
        <title>Nuevo ticket de soporte</title>
    </head>
    <body>
        <div class="container">
            <?
            include_once '../header.inc.php';
            ?>
            <div class="row">
            <div class="col-md-4">
                <?
                include_once 'menu-usuario.php';
                ?>
            </div>
            <div class="col-md-8">
                <h1 class="title">Nuevo ticket de soporte</h1>
                <?
                if (isset($_GET['ok'])) {
                    echo showbox('ok', 'Se ha generado su ticket de soporte.', 'Su consulta ser&aacute; atendida por nuestro personal.');
                } else {
                    ?>
                    <br/>
                    <form action="" method="post" enctype="multipart/form-data">
                        <div class="col-md-6">
                            <div class="input-group width100">
                                <select type="text" name="sector_id" class="form-control" required>
                                    <option value="">Seleccione departamento*</option>
                                    <? printOptions($sectors, @$_POST['sector_id']); ?>
                                </select>
                                <? showerror($errors, 'sector_id') ?>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-group width100">
                                <select type="text" name="priority" class="form-control" required>
                                    <option value="">Prioridad</option>
                                    <option value="1">Baja</option>
                                    <option value="2">Normal</option>
                                    <option value="3">Alta</option>
                                </select>
                                <? showerror($errors, 'priority') ?>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="input-group width100">
                                <input type="text" name="subject" class="form-control" placeholder="Asunto*" required maxlength="150">
                            </div>
                            <? showerror($errors, 'subject') ?>
                        </div>
                        <div class="col-md-12">
                            <textarea name="description" class="form-control width100" placeholder="Mensaje*" required></textarea>
                            <? showerror($errors, 'description') ?><br>
                            Adjuntar archivo: <input type="file" name="adjunto" />
                            <? showerror($errors, 'adjunto') ?><br>
                            
                            
                            <button type="submit" class="button">
                                <span class="glyphicon glyphicon-send" aria-hidden="true"></span> &nbsp;&nbsp;Enviar
                              </button>
                        </div>
                        
                    </form>
                <? } ?>
                <div class="clear"></div>
            </div>
            </div>
            <div class="clear"></div>
        </div>
        <? include_once '../footer.inc.php'; ?>
    </body>
</html>