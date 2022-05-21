<?php
include_once '../inc/config.inc.php';
checksession("usuario");

$where = " t.user_id = ".$_SESSION['uid'];
//Paginacion
$pag = (!isset($_GET['pag'])) ? 1 : $_GET['pag']; // Por defecto, pagina 1
$result = query("SELECT COUNT(*) as cant FROM tickets AS t WHERE $where ");  //cuento los registros

if(!empty($result)){
    //pr($result);
    $total = $result[0]['cant'];
    $tampag = 10;
    $reg1 = ($pag - 1) * $tampag;

    $tickets = query("SELECT t.*,DATE_FORMAT(t.fecha,'%d/%m/%Y (%H:%i)') AS fecha,s.title AS sector,MAX(DATE_FORMAT(tc.fecha,'%d/%m/%Y (%H:%i)')) AS lastupdate FROM tickets AS t "
            . " LEFT JOIN tickets_sectors AS s ON s.id = t.sector_id "
            . " LEFT JOIN tickets_chats AS tc ON tc.ticket_id = t.id "
            . " WHERE $where GROUP BY t.id "
            . " ORDER BY MAX(tc.fecha) DESC,t.fecha DESC,t.id DESC "
            . " LIMIT $reg1,$tampag");
}

$section = 'soporte';
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <? include_once '../common_head.inc.php'; ?>
        <title>Soporte al cliente</title>
        <link type="text/css" href="/js/jquery-ui-1.10.3.custom/css/ui-lightness/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" />
        <script type="text/javascript" src="/js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.min.js"></script>
    </head>

    <body>
        <div class="container" id="content">
            <div class="row">
            <? include_once '../header.inc.php'; ?>
                <div class="col-md-4">
                    <?
                    include_once 'menu-usuario.php';
                    ?>
                </div>
                <div class="col-md-8">
                    
                    <h2 class="title">Tickets de soporte</h2>
                    <? if(!empty($tickets)){?>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead> <tr> <th>id - Asunto</th> <th>Sector</th><th>Estado</th> <th>&Uacute;ltima Actualizaci&oacute;n</th> </tr> </thead>
                            <tbody>
                                <?
                                    foreach ($tickets as $ticket) {
                                        ?>
                                            <tr>
                                                <td>#<?=$ticket['id']?> - <a href="ver-ticket.php?id=<?=$ticket['id']?>"><?=$ticket['subject']?></a></td>
                                                <td><?=$ticket['sector']?></td>
                                                <td><?=($ticket['status'] == 1)?"Abierto":"Cerrado"?></td>
                                                <td><?=(!empty($ticket['lastupdate']))?$ticket['lastupdate']:$ticket['fecha']?></td>
                                            </tr>
                                        <?
                                    }
                                ?>
                            </tbody>
                        </table>
                    </div>
                    <div class="paginacion">
                        <p>Mostrando <?=($pag*$tampag < $total )? $pag*$tampag.' de '.$total : $total.' de '.$total?> resultados</p><span>P&aacute;ginas:</span> <?= paginar($pag, $total, $tampag, '?pag='); ?>
                        <div class="clear"></div>
                    </div>
                    <? }else{?>
                    <br>No se encontraron tickets de soporte.
                    <? }?>
                    <a href="nuevo-ticket.php" class="button float-right"><span class="glyphicon glyphicon-file" aria-hidden="true"></span> &nbsp;ABRIR NUEVO TICKET</a>
                </div>
            </div>
        </div>
        <? include_once '../footer.inc.php'; ?>
    </body>

</html>