<?php
include_once '../inc/config.inc.php';
include_once '../inc/class.TemplatePower.inc.php';
checksession("usuario");
//$errors = array();
    if (!empty($_GET['id']) && isValidNumber($_GET['id'])&& isValidNumber($_GET['status'])) {
        $ticket = find("tickets","id","id = ".escape($_GET['id']));
            if(!empty($ticket['id'])){
                $status = $_GET['status'];
                if(query_update("tickets", array("status" => $status),"id = ".$ticket['id']))
                    //redireccion al ok
                    header("Location:ver-ticket.php?id=".$ticket['id']."&ok=2");
                    exit();
            }
    }
    //Enviar Email avisando que se cerro el ticket?
    
    /*
    if (empty($errors)) {
        
        session_start();
        $fecha = time();
        $_POST['fecha'] = date("Y-m-d H:i", $fecha);
        $_POST['ticket_id'] = escape($_GET['id']);
        if (query_insert("tickets_chats", $_POST)) {
            $usuario = find("users",null,"id = ".escape($_SESSION['uid']));
            $mymail = explode(",", str_replace(" ","",$sector['emails']));  //debe mandar a los mails del sector_id
            $subject = "Nueva respuesta - Ticket #".$_POST['ticket_id'];

            $template = new TemplatePower("../webroot/template_mails/ticket_client_respond.html");
            $template->prepare();
            $template->assignGlobal("SITE_URL", URLWEB);
            $template->assignGlobal("FECHA", date("d/m/Y H:i", $fecha));
            $template->assignGlobal("NOMBRE", $usuario['name']);
            $template->assignGlobal("EMAIL", $usuario['email']);
            $template->assignGlobal("TICKETID", $ticket[0]['id']);
            $template->assignGlobal("ASUNTO", $ticket[0]['subject']);
            $template->assignGlobal("PRIORITY", $ticket[0]['priority']);
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
            header("Location:ver-ticket.php?id=".$ticket[0]['id']."&ok=1");
            exit();
        } else {
            $error = true;
        }
    } else
        $error = true;*/
