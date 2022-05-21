<?php
if (!empty($_GET['id']) && isValidNumber($_GET['id'])) {
    $id = escape($_GET['id']);
    $sector = find("tickets_sectors", null, "id = " . $id);
    if (!empty($sector)) {
        $id = $sector['id'];
        
        mysql_query("UPDATE tickets SET sector_id = 'NULL'");
        //elimino categoria padre
        mysql_query("DELETE FROM tickets_sectors WHERE id = $id");
        mysql_query("OPTIMIZE TABLE tickets_sectors");
        echo '<script>location.href="/kdpanel/tickets/sectors_index";</script>';
    }
}
?>