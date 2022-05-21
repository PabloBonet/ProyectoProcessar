<?php
include_once '../inc/config.inc.php';
include_once '../inc/class.TemplatePower.inc.php';
checksession("usuario");
$ticket = query("SELECT t.*,DATE_FORMAT(t.fecha,'%d/%m/%Y (%H:%i)') AS fecha,s.title AS sector,s.emails AS sector_emails FROM tickets AS t LEFT JOIN tickets_sectors AS s ON s.id = t.sector_id WHERE t.id = " . escape($_GET['id']));

$errors = array();
if (!isset($_GET['ok']) && !empty($_POST)) {
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
                    $errors['adjunto'] = 'Solo se permiten archivos txt, jpg, png, pdf, doc, xls, docx y xlsx';
                }
            }
        }
    }

    if (empty($errors)) {
        $fecha = time();
        $_POST['fecha'] = date("Y-m-d H:i", $fecha);
        $_POST['ticket_id'] = escape($_GET['id']);
        if ($id = query_insert("tickets_chats", $_POST)) {
            if(!empty($_FILES['adjunto']['name'])){
                $adjunto = $ticket[0]['id'].'_'.$id.'.'.$ext;
                move_uploaded_file($_FILES["adjunto"]["tmp_name"], WWW_ROOT."soporte/".$adjunto);
                query_update("tickets_chats", array("adjunto" => $adjunto),"id = ".$id);
                $adjunto = URLWEB."soporte/".$adjunto;
            }else {$adjunto = '---';}
            
            $usuario = find("users", null, "id = " . escape($_SESSION['uid']));
            $prioridades = array(1 => "Baja", 2 => "Normal", 3 => "Alta");
            
            $mymail = explode(",", str_replace(" ", "", $ticket[0]['sector_emails']));  //debe mandar a los mails del sector_id
            $subject = "Nueva respuesta - Ticket #" . $_POST['ticket_id'];
            
            $template = new TemplatePower("../webroot/template_mails/ticket_usuario_respond.html");
            $template->prepare();
            $template->assignGlobal("SITE_URL", URLWEB);
            $template->assignGlobal("FECHA", date("d/m/Y H:i", $fecha));
            $template->assignGlobal("SECTOR", $ticket[0]['sector']);
            $template->assignGlobal("PRIORIDAD", $prioridades[$ticket[0]['priority']]);
            $template->assignGlobal("NOMBRE", $usuario['name']);
            $template->assignGlobal("EMAIL", $usuario['email']);
            $template->assignGlobal("TICKETID", $ticket[0]['id']);
            $template->assignGlobal("ASUNTO", $ticket[0]['subject']);
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

            foreach ($mymail as $mails) {
                mail($mails, $subject, $final_template, $header);
            }
            //redireccion al ok
            header("Location:ver-ticket.php?id=" . $ticket[0]['id'] . "&ok=1");
            exit();
        } else {
            $error = true;
        }
    } else
        $error = true;
}
//$chats = findAll("tickets_chats",null,"ticket_id = ".$ticket[0]['id']);//joinear admins y formatear fecha
$chats = query("SELECT tc.*,a.name,DATE_FORMAT(tc.fecha,'%d/%m/%Y (%H:%i)') AS fecha FROM tickets_chats AS tc LEFT JOIN admin_users AS a ON a.id = tc.admin_id WHERE tc.ticket_id = " . $ticket[0]['id']); //joinear admins y formatear fecha

$section = 'soporte';
$sliders = findAll("sliders", null, "section_id = 6");
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <? include_once '../common_head.inc.php'; ?>
        <title>Ver ticket</title>
    </head>
    <body>
        <div class="container" id="content">
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
                <h2 class="title"><span>Ticket <strong>#<?= $ticket[0]['id'] ?></strong> | Dpto. <?= $ticket[0]['sector'] ?></span>
                </h2>
                <span class="float-right"><? if ($ticket[0]['status'] == 1) { ?>
                    <a href="ticket-status.php?id=<?= $ticket[0]['id'] ?>&status=2"><span class="glyphicon glyphicon-remove"></span>Cerrar Ticket</a>
                <? } else { ?>
                    <a href="ticket-status.php?id=<?= $ticket[0]['id'] ?>&status=1"><span class="glyphicon glyphicon-refresh"></span> &nbsp;Reabrir Ticket</a>
                <? } ?>
                </span>
                
                <br>
                <div style="border-bottom: 1px dashed #ccc;">
                    <div class="float-right">Estado: <strong><?= ($ticket[0]['status'] == 1) ? "Abierto" : "Cerrado" ?></strong></div>
                    Asunto: <strong><?= $ticket[0]['subject'] ?></strong>
                </div>
                <span class="fecha"><?= $ticket[0]['fecha'] ?></span>
                <p><?= nl2br($ticket[0]['description'])?></p>
                <? if(!empty($ticket[0]['adjunto'])){?>
                <div class="adjunto">
                    Archivo adjunto: <a href="/soporte/<?=$ticket[0]['adjunto']?>" target="_blank"><?=$ticket[0]['adjunto']?></a>
                </div>
                <div class="clear"></div>
                <?
                }
                if (!empty($chats)) {
                    foreach ($chats as $chat) {
                        ?>
                        <div class="respuesta<?= (!empty($chat['name'])) ? ' respuesta_admin' : false ?>">
                            <div class="respuesta_head">
                                <span class="fecha"><?= $chat['fecha'] ?></span>
                                <? if (!empty($chat['name'])) { ?>
                                    Respuesta de <strong><?= $chat['name'] ?>:</strong>
                                <? } else { ?>
                                    Usuario:
                                <? } ?>
                            </div>
                            <p><?= nl2br($chat['description']) ?></p>
                            <? if(!empty($chat['adjunto'])){?>
                                <div class="adjunto">
                                    Archivo adjunto: <a href="/soporte/<?=$chat['adjunto']?>" target="_blank"><?=$chat['adjunto']?></a>
                                </div>
                                <div class="clear"></div>
                            <? }?>
                        </div>
                        <?
                    }
                }
                ?>
                <?
                if ($ticket[0]['status'] == 1) {
                    if (!empty($_GET['ok']) && $_GET['ok'] == 1) {
                            echo showbox('ok', 'Su respuesta ha sido recibida.', 'Su consulta ser&aacute; atendida por nuestro personal.');
                    }
                        ?>
                
                        <h2 class="title2"><span>Responder:</span></h2>
                        <form action="ver-ticket.php?id=<?=$ticket[0]['id']?>" method="post" enctype="multipart/form-data">
                            <textarea name="description" class="form-control" placeholder="Mensaje*..." required></textarea>
                            <? showerror($errors, 'description') ?>
                            Adjuntar archivo: <input type="file" name="adjunto" />
                            <? showerror($errors, 'adjunto') ?>
                            <button type="submit" class="button2">
                            <span class="glyphicon glyphicon-send" aria-hidden="true"></span> &nbsp;&nbsp;Enviar
                          </button>
                            
                        </form>
                    <? 
                }else{
                    if ($ticket[0]['status'] == 2 && @$_GET['ok'] == 2) {
                        echo showbox('ok', 'El ticket se ha cerrado correctamente.', 'Estamos para ayudarlo.');
                }}?>
                <div class="clear"></div>
            </div>
            </div>
            <div class="clear"></div>
        </div>
<? include_once '../footer.inc.php'; ?>
    </body>
</html>