<?php
$users = findAll("newsletter_users",null,"active = 1");
if (!empty($users)) {
    $file = fopen(WWW_ROOT."lista.csv", "w");
    foreach ($users as $user) {
        fwrite($file, $user['name'].';'.$user['email'].'
');
    }
    fclose($file);
}
?>
<div class="widget-top">
    <h3>Listado de Usuarios de Newsletter</h3>
</div>
<div class="inside">
    <br />
    <br />
    <h4>Archivo exportado correctamente.</h4>
    <br />
    <br />
</div>
<script type="text/javascript">location.href='/lista.csv';</script>