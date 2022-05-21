<?php

if (!empty($_GET['id']) && isValidNumber($_GET['id'])) {
    $id = escape($_GET['id']);

    //busqueda y elimina tickets y chats del usuario
    $tickets = findAll("tickets", "id,adjunto", "user_id = " . $id);
    if (!empty($tickets)) {
        foreach ($tickets as $ticket) {
            $chats = findAll("tickets_chats", "id,adjunto", "ticket_id=" . $ticket['id']);
            if (!empty($chats)) {
                foreach ($chats as $chat) {
                    unlink(WWW_ROOT . 'soporte/' . $chat['adjunto']);
                }
                query("DELETE FROM tickets_chats WHERE ticket_id = " . $ticket['id']);
            }
            //elimina adjunto del ticket
            unlink(WWW_ROOT . 'soporte/' . $ticket['adjunto']);
        }
        query("DELETE FROM tickets WHERE user_id = " . $id);
    }
    query("DELETE FROM users WHERE id = " . $id);
    echo '<script>location.href="/kdpanel/users/index";</script>';
}
?>