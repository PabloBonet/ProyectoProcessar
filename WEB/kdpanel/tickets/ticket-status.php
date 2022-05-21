<?php
//include_once '../../inc/config.inc.php';
//include_once '../inc/class.TemplatePower.inc.php';

//$errors = array();
    if (!empty($_GET['id']) && isValidNumber($_GET['id'])&& isValidNumber($_GET['status'])) {
        $ticket = find("tickets","id","id = ".escape($_GET['id']));
            if(!empty($ticket['id'])){
                $status = $_GET['status'];
                if(query_update("tickets", array("status" => $status),"id = ".$ticket['id']))
                    //redireccion al ok
                    echo '<script>location.href="edit?id='.$ticket['id'].'&ok=2";</script>';
                    //header("Location:edit?id=".$ticket['id']."&ok=2");
                    exit();
            }
    }else{
        header("Location:edit?id=".$ticket['id']);
        exit();
    }
    ?>