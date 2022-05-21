<?php
if(!empty($_GET['id'])){
    query("DELETE FROM newsletter_users WHERE id = ".escape($_GET['id']));
    echo '<script>location.href="/kdpanel/newsletter-users/index";</script>';
}
?>
