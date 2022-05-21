<?php

include_once '../inc/class.TemplatePower.inc.php';
if (!empty($_GET['id']) && isValidNumber($_GET['v'])) {
    query_update("users", array('activo' => $_GET['v']), 'id = ' . escape($_GET['id']));
    $user = find("users", null, 'id = ' . escape($_GET['id']));
    if (!empty($user['id']) && $_GET['v']==1) {
        //Avisar al usuario que se activo la cuenta
        $template = new TemplatePower("../webroot/template_mails/activado_template.html");
        $template->prepare();
        $template->assignGlobal("SITE_URL", URLWEB);
        $template->assignGlobal("NOMBRE", $user['name']);
        $template->assignGlobal("EMAIL", $user['email']);

        $final_template = $template->getOutputContent();
        //die($final_template);
        $header = "From:no-reply@processar.com.ar\nReply-To:no-reply@processar.com.ar\n";
        $header .= "X-Mailer:PHP/" . phpversion() . "\n";
        $header .= "Mime-Version: 1.0\n";
        $header .= "Content-Type: text/html;";
        $header .= "charset=UTF-8;";
        $subject = "Su cuenta ha sido activada";
        mail($user['email'], $subject, $final_template, $header);
        
    }
    //avisar por email al usuario que se activo correctamente su cuenta
    echo '<script>location.href="/kdpanel/users/index";</script>';
}
?>