<?php

if (!empty($_GET['id'])) {
    $id = escape($_GET['id']);
    $ticket = find("tickets", "id,adjunto", "id = " . $id);
    if (!empty($ticket)) {
        $chats = findAll("tickets_chats", "id,adjunto", "ticket_id=" . $id);
        if (!empty($chats)) {
            foreach ($chats as $chat) {
                unlink(WWW_ROOT . 'soporte/' . $chat['adjunto']);
            }
            query("DELETE FROM tickets_chats WHERE ticket_id = " . escape($_GET['id']));
        }
        unlink(WWW_ROOT . 'soporte/' . $ticket['adjunto']);
        query("DELETE FROM tickets WHERE id = " . $id);
        echo '<script>location.href="/kdpanel/tickets/index";</script>';
    }
}
?>