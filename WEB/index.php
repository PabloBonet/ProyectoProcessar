<?php
include_once 'inc/config.inc.php';
$sliders = findAll("sliders", null, "section_id = 1");
$inicio = find("contents", "description", "id = 4");
$reviews = findAll("clients_reviews");
$section = 'inicio';
?>
<!DOCTYPE html>
<html lang="es">
    <head>
        <? include_once 'common_head.inc.php'; ?>
        <title>
            <?= $GLOBALS['META_TITLE'] ?>
        </title>
        <script>
                function scrollToContact(){
                    $('html,body').animate({
                        scrollTop: $("#contactform").offset().top},
                            'slow');
                    $('input.form-control:first').focus();
                    return(false);
                }
            <? if ((!empty($_GET['contacto']) && $_GET['contacto'] == 1) || (!empty($_POST) && !isset($_GET['ok']))) { ?>
                $(document).ready(function () {
                    scrollToContact();
                });
            <? } ?>
        </script>
    </head>
    <body>
        <div class="container">
            <? include_once 'header.inc.php'; ?>
            <? include_once 'slider.inc.php'; ?>
            <br>
            <!--lista de modulos del sistema Processar-->
            <div class="row">
                <div class="col-sm-12">
                    <h2 class="title">Modulos del sistema</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 col-xs-6 modulo">
                    <a href="/paginas/processar-software-gestion.html#facturacion">
                        <div class="ico"><img src="/img/uploaded/ico-facturacion.png" alt="M&oacute;dulo facturaci&oacute;n" /></div>
                        <h2>Facturaci&oacute;n y<br>Cuentas Corrientes</h2>
                        <p>Generaci&oacute;n comprobantes de facturaci&oacute;n electr&oacute;nica y no electr&oacute;nica, puntos de ventas, cuentas corrientes de clientes</p>
                    </a>
                </div>
                <div class="col-md-3 col-xs-6 modulo">
                    <a href="/paginas/processar-software-gestion.html#clientes">
                        <div class="ico"><img src="/img/uploaded/ico-clientes.png" alt="Clientes y contactos" /></div>
                        <h2>Clientes y contactos</h2>
                        <p>Carga de clientes y proveedores. Administraci&oacute;n de contactos.</p>
                    </a>
                </div>
                <div class="clear2"></div>
                <div class="col-md-3 col-xs-6 modulo">
                    <a href="/paginas/processar-software-gestion.html#articulos">
                        <div class="ico"><img src="/img/uploaded/ico-stock.png" alt="Stock articulos"/></div>
                        <h2>Dep&oacute;sitos y Stock Art&iacute;culos</h2>
                        <p>Definici&oacute;n de dep&oacute;sitos, carga de art&iacute;culos, ingresos y egresos por dep&oacute;sitos</p>
                    </a>
                </div>
                <div class="col-md-3 col-xs-6 modulo">
                    <a href="/paginas/processar-software-gestion.html#proveedores">
                        <div class="ico"><img src="/img/uploaded/ico-proveedores.png" alt="Proveedores y compras" /></div>
                        <h2>Proveedores y Compras</h2>
                        <p>Registros de facturas de compras, cuentas corrientes de proveedores, pagos.</p>
                    </a>
                </div>
                <div class="clear2 clear4"></div>
                <div class="col-md-3 col-xs-6 modulo">
                    <a href="/paginas/processar-software-gestion.html#presupuestos">
                        <div class="ico"><img src="/img/uploaded/ico-presupuestos.png" alt="Presupuestos y pedidos" /></div>
                        <h2>Presupuestos<br>y Pedidos</h2>
                        <p>Generaci&oacute;n de presupuestos y registros de pedidos de clientes.</p>
                    </a>
                </div>
                <div class="col-md-3 col-xs-6 modulo">
                    <a href="/paginas/processar-software-gestion.html#cajaybancos">
                        <div class="ico"><img src="/img/uploaded/ico-banco.png" alt="Cajas y bancos" /></div>
                        <h2>Caja y Bancos</h2>
                        <p>Cobros a clientes, pagos a proveedores, definici&oacute;n de cuentas, cajas recaudadoras, planillas de movimientos.</p>
                    </a>
                </div>
                <div class="clear2"></div>
                <div class="col-md-3 col-xs-6 modulo">
                    <a href="/paginas/processar-software-gestion.html#contabilidad">
                        <div class="ico"><img src="/img/uploaded/ico-contabilidad.png" alt="Contabilidad" /></div>
                        <h2>Contabilidad</h2>
                        <p>Plan de Cuentas, Minutas, Carga de Asientos, Libro Diario, Balance de Sumas y Saldos.</p>
                    </a>
                </div>
                <div class="col-md-3 col-xs-6 modulo">
                    <a href="/paginas/processar-software-gestion.html#stocketiquetas">
                        <div class="ico"><img src="/img/uploaded/ico-etiquetas.png" alt="Stock por etiquetas" /></div>
                        <h2>Stock por Etiquetas</h2>
                        <p>Impresi&oacute;n de Etiquetas, b&uacute;squeda de art&iacute;culos y materiales por c&oacute;digo y etiqueta, lectura por lotes.</p>
                    </a>
                </div>
            </div>
            <div class="row m_t">
                <div class="center">
                    <p>
                        <a href="/paginas/processar-software-gestion.html" class="button">VER TODOS LOS M&Oacute;DULOS...</a>
                        <a href="#" onclick="scrollToContact();void(0);" class="button2">SOLICITAR UNA DEMO</a>
                    </p>
                </div><br>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <?= $inicio['description'] ?>
                    <br>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1">
                    <?
                    //opiniones de los clientes
                    if (!empty($reviews)) {
                        $cual = rand(0, count($reviews) - 1);
                        ?>
                        <div class="opinion">
                            <em>OPINION DE CLIENTES:</em>
                            <p><strong><?= $reviews[$cual]['name'] ?>:</strong> <?= $reviews[$cual]['description'] ?></p>
                        </div>
                        <?
                    }
                    ?>
                </div>
            </div>
            <div class="clear"></div>
            <? //formulario de contacto
            include_once 'formu.php';
            ?>
        </div>
<? include_once 'footer.inc.php'; ?>
    </body>

</html>