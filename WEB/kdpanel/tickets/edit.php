<?

include_once '../inc/class.TemplatePower.inc.php';
$ticket = query("SELECT t.*,DATE_FORMAT(t.fecha,'%d/%m/%Y (%H:%i)') AS fecha,s.title AS sector,s.emails AS sector_emails FROM tickets AS t LEFT JOIN tickets_sectors AS s ON s.id = t.sector_id WHERE t.id = " . escape($_GET['id']));
$usuario = find("users", null, "id = " . $ticket[0]['user_id']);

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
                    $errors['adjunto'] = 'Solo se permiten archivos txt, jpg, png, pdf, doc, xls';
                }
            }
        }
    }

    if (empty($errors)) {
        $fecha = time();
        $_POST['fecha'] = date("Y-m-d H:i", $fecha);
        $_POST['ticket_id'] = escape($_GET['id']);
        
        $_POST['admin_id'] = escape($_SESSION['id']);
        
        if ($id = query_insert("tickets_chats", $_POST)) {

            if (!empty($_FILES['adjunto']['name'])) {
                $adjunto = $ticket[0]['id'] . '_' . $id . '.' . $ext;
                move_uploaded_file($_FILES["adjunto"]["tmp_name"], WWW_ROOT . "soporte/" . $adjunto);
                query_update("tickets_chats", array("adjunto" => $adjunto), "id = " . $id);
                $adjunto = URLWEB . "soporte/" . $adjunto;
            }

            
            $admin = find("admin_users", null, "id = " . $_SESSION['id']);
            $prioridades = array(1 => "Baja", 2 => "Normal", 3 => "Alta");

            $mymail = $usuario['email'];  //enviar de email al usuario
            $subject = "Respondieron su Ticket #" . $ticket[0]['id'];

            $template = new TemplatePower("../webroot/template_mails/ticket_admin_respond.html");
            $template->prepare();
            $template->assignGlobal("SITE_URL", URLWEB);
            $template->assignGlobal("FECHA", date("d/m/Y H:i", $fecha));
            $template->assignGlobal("ADMIN", $admin['name']);
            $template->assignGlobal("NOMBRE", $usuario['name']);
            $template->assignGlobal("EMAIL", $usuario['email']);
            $template->assignGlobal("TICKETID", $ticket[0]['id']);
            $template->assignGlobal("ASUNTO", $ticket[0]['subject']);
            if (!empty($_FILES['adjunto']['name'])) {
                $template->newBlock( "adjunto" );
                $template->assignGlobal("ADJUNTO", $adjunto);
            }
            $template->assignGlobal("MENSAJE", str_replace(array("'", '"', "\\"), "", strip_tags(nl2br($_POST['description']), '<br>')));

            $template->assignGlobal("IP", $_SERVER['REMOTE_ADDR']);

            $final_template = $template->getOutputContent();
            //die($final_template);
            $header = "From:no-reply@processar.com.ar\nReply-To:no-reply@processar.com.ar\n";
            $header .= "X-Mailer:PHP/" . phpversion() . "\n";
            $header .= "Mime-Version: 1.0\n";
            $header .= "Content-Type: text/html;";
            $header .= "charset=UTF-8;";

            
                mail($mymail, $subject, $final_template, $header);
            
            //redireccion al ok
            //header("Location:edit?id=" . $ticket[0]['id'] . "&ok=1");
            $ok = true;
        } else {
            $error = true;
        }
    } else
        $error = true;
}
//$chats = findAll("tickets_chats",null,"ticket_id = ".$ticket[0]['id']);//joinear admins y formatear fecha
$chats = query("SELECT tc.*,a.name,DATE_FORMAT(tc.fecha,'%d/%m/%Y (%H:%i)') AS fecha FROM tickets_chats AS tc "
        . "LEFT JOIN admin_users AS a ON a.id = tc.admin_id "
        . "WHERE tc.ticket_id = " . $ticket[0]['id']
        . " ORDER BY tc.fecha,tc.id"
        );
?>
<div class="widget-top">
    <h3>Responder Ticket</h3>
</div>
<div class="inside">
        <div class="float-right m_t">
            <? if ($ticket[0]['status'] == 1) { ?>
                <a href="ticket-status?id=<?= $ticket[0]['id'] ?>&status=2" class="button"><span class="glyphicon glyphicon-remove"></span> &nbsp;Cerrar ticket</a>
            <? } else { ?>
                <a href="ticket-status?id=<?= $ticket[0]['id'] ?>&status=1" class="button"><span class="glyphicon glyphicon-refresh"></span> &nbsp;Reabrir Ticket</a>
            <? } ?>
        </div>
        <div class="clear"></div><br/>
        <input type="hidden" name="id" value="<?= $ticket[0]['id'] ?>" />
        <span>Ticket <strong>#<?= $ticket[0]['id'] ?></strong> | Dpto. <?= $ticket[0]['sector'] ?></span>
        <br><br>
        <div class="input">
            <label>Usuario: </label>
            <strong style="float: left; margin-top: 5px;"><?= $usuario['name'].' - '.$usuario['email']?></strong>
        </div>
        <div class="input">
            <label>Estado: </label>
            <strong style="float: left; margin-top: 5px;"><?= ($ticket[0]['status'] == 1) ? "Abierto" : "Cerrado" ?></strong>
        </div>
        <div class="input">
            <label>Asunto:</label>
            <strong style="float: left; margin-top: 5px;"><?= $ticket[0]['subject'] ?> </strong>
        </div>
        <div class="input">
            <label>Fecha:</label>
            <strong style="float: left; margin-top: 5px;"><?= $ticket[0]['fecha'] ?></strong>
        </div>
        <? if (!empty($ticket[0]['adjunto'])) { ?>
            <div class="input">
                <label>Archivo adjunto: </label>
                <a href="/soporte/<?= $ticket[0]['adjunto'] ?>" target="_blank" style="float: left; font-weight: bold; border: 2px dotted #0099cc; padding: 4px 8px"><?= $ticket[0]['adjunto'] ?></a>
            </div>
            <div class="clear"></div>
            <?
        }
        ?>
        <div class="input">
            <label>Mensaje:</label>
            <p class="textofull"><?= nl2br($ticket[0]['description']) ?></p>
        </div>
        <br>
        <?
        if (!empty($chats)) {
            foreach ($chats as $chat) {
                ?>
                <div class="respuesta<?= (!empty($chat['name'])) ? ' respuesta_admin' : false ?>">
                    <div class="respuesta_head">
                        <span class="fecha"><?= $chat['fecha'] ?></span>
                        <? if (!empty($chat['name'])) { ?>
                            Respuesta de: <strong><?= $chat['name'] ?></strong>
                        <? } else { ?>
                            Usuario:
                        <? } ?>
                    </div>
                    <p><?= nl2br($chat['description']) ?></p>
                    <? if (!empty($chat['adjunto'])) { ?>
                        <div class="adjunto">
                            Archivo adjunto: <a href="/soporte/<?= $chat['adjunto'] ?>" target="_blank"><?= $chat['adjunto'] ?></a>
                        </div>
                        <div class="clear"></div>
                    <? } ?>
                </div>
                <?
            }
        }
        ?>
        <br><br>
        <?
        if ($ticket[0]['status'] == 1) { //está abierto el ollo
            if (isset($ok)) {
                echo showbox('ok', 'Se ha ingresado su respuesta.', 'Se ha enviado un email al usuario.');
            }
            ?>
            <h2 class="titlebar"><span>Responder:</span></h2>
            <form action="" method="post" enctype="multipart/form-data">
                <div class="input">
                    <textarea name="description" placeholder="Mensaje*..." required style="width: 95%"></textarea>
                    <? showerror($errors, 'description') ?>
                </div>
                <div class="input">
                    <label>Adjuntar archivo:</label>
                    <input type="file" name="adjunto" />
                    <? showerror($errors, 'adjunto') ?>
                </div>
                <input type="submit" class="button" value="Responder" onclick="document.getElementById('loading').style.display = 'block'"/>
            </form>
            <?
        } else { //te han cerrado el ollo
            if ($ticket[0]['status'] == 2 && @$_GET['ok'] == 2) {
                echo showbox('ok', 'El ticket se ha cerrado correctamente.', 'Estamos para ayudarlo.');
            }
        }
        ?>
        <div class="clear"></div>

        <br><br><br><br>
        <?= loading(); ?>
</div>