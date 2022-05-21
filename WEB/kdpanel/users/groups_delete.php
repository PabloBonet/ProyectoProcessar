<?php
if(!empty($_GET['id'])){
    $id = escape($_GET['id']);
    $group = find("users_groups","id","id = $id");
    if(!empty($group)){
        query("UPDATE users SET group_id = 'NULL' WHERE group_id = ".$group['id']);
        query("DELETE FROM users_groups WHERE id = ".$group['id']);
    }
    echo '<script>location.href="/kdpanel/users/groups_index";</script>';
}
?>