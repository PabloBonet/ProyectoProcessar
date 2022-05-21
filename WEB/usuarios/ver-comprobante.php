<?php

include_once '../inc/config.inc.php';
include_once '../inc/class.TemplatePower.inc.php';

checksession("cliente");
if (!empty($_GET['id']) && isValidNumber($_GET['id'])) {

    //VALIDAR QUE SEA UN COMPROBANTE DEL USUARIO LOGUEADO
    $usuarios = query("SELECT uc.user_id FROM facturascc AS f
    LEFT JOIN clientecc AS c ON c.idregistro = f.idregistro
    LEFT JOIN users_clientecc AS uc ON uc.cliente = c.cliente
    WHERE f.idregistro = ".escape($_GET['id'])
            . " AND uc.user_id = ".escape($_SESSION['uid'])
            . " GROUP BY uc.user_id"
            );
    //Si no se encontro un usuario asignado lo devuelvo al index
    if(empty($usuarios)){
        header("Location:index.php");die;
    }
    //FIN VALIDACION DE CLIENTES DEL USUARIO LOGUEADO

    $compro = findAll("facturascc", null, 'idregistro = ' . escape($_GET['id']));
    $fecha = substr($compro[0]['fechaemit'], -2) . '/' . substr($compro[0]['fechaemit'], 4, 2) . '/' . substr($compro[0]['fechaemit'], 0, 4);
    if (!empty($_GET['pdf']))
        $template = new TemplatePower("comprobante_template-pdf.html");
    else
        $template = new TemplatePower("comprobante_template.html");

    $template->prepare();

    $template->assignGlobal("URLWEB", URLWEB);
    $template->assignGlobal("CODIGOBARRA", $compro[0]['codbarra']);
    $template->assignGlobal("TIPOCOMPRO", $compro[0]['tipo']);
    $template->assignGlobal("IDCOMPAFIP", $compro[0]['idcompafip']);
    $template->assignGlobal("COMPROBANTE", $compro[0]['comprobante']);
    $template->assignGlobal("NROCOMPRO", $compro[0]['numero']);
    $template->assignGlobal("NOMBRE", $compro[0]['nombre']);
    $template->assignGlobal("DOMICILIO", $compro[0]['domicilio']);
    $template->assignGlobal("CUIT", $compro[0]['cuit']);
    $template->assignGlobal("CATEGORIA", $compro[0]['condfiscal']);
    $template->assignGlobal("CONDICION", $compro[0]['condcomercial']);
    $template->assignGlobal("REMITOS", $compro[0]['remitos']);
    if (!empty($compro)) {
        foreach ($compro as $comp) {
            $template->newBlock("productos");
            $template->assign(array(
                'COD' => $comp['codigo'],
                'CANT' => $comp['cantidad'],
                'DESC' => $comp['descripcion'],
                'KG' => ($comp['kg']) ? $comp['kg'] : '',
                'PRECIO' => moneda($comp['precio']),
                'SUBTOTAL' => moneda($comp['subtotald'])
            ));
        }
    }


    $template->assignGlobal("SUBTOTALF", moneda($compro[0]['subtotalf']));
    if ($compro[0]['iva105']) {
        $template->newBlock("iva105");
        $template->assignGlobal("IVA105", $compro[0]['iva105']);
    }
    if ($compro[0]['iva21']) {
        $template->newBlock("iva21");
        $template->assignGlobal("IVA21", $compro[0]['iva21']);
    }
    if ($compro[0]['iva27']) {
        $template->newBlock("iva27");
        $template->assignGlobal("IVA27", $compro[0]['iva27']);
    }
    $template->assignGlobal("IB", $compro[0]['percepiibb']);
    $template->assignGlobal("TOTAL", moneda($compro[0]['total']));
    $template->assignGlobal("KGTOTAL", $compro[0]['kgtotal']);
    $template->assignGlobal("CAE", $compro[0]['cae']);
    $template->assignGlobal("VTOCAE", substr($compro[0]['fechavtocae'], -2) . '/' . substr($compro[0]['fechavtocae'], 4, 2) . '/' . substr($compro[0]['fechavtocae'], 0, 4));

    $template->assignGlobal("PIE1", $compro[0]['pie1']);
    $template->assignGlobal("PIE2", $compro[0]['pie2']);
    $template->assignGlobal("PIE3", $compro[0]['pie3']);
    $template->assignGlobal("FECHA", $fecha);


    $final_template = $template->getOutputContent();
    echo($final_template);
} else {
    header("Location:index.php");
    exit();
}
?>