<?php
if(!empty($_GET['id'])){
    mysql_query("DELETE FROM clients_reviews WHERE id = ".escape($_GET['id']));
    echo '<script>location.href="'.ADMINROOT.'reviews/index";</script>';
}
?>
