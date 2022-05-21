<?php
session_start();
function randomText($length) {
    $pattern = "1234567890abcdefghijklmnopqrstuvwxyz";
    $key = '';
    for($i=0;$i<$length;$i++) {
      $key .= $pattern{rand(0,35)};
    }
    return $key;
}
$_SESSION['tmptxt'] = randomText(3);
$captcha = imagecreatefromgif("../webroot/img/bgcaptcha.gif");
$colText = imagecolorallocate($captcha, 0, 0, 0);
imagestring($captcha, 5, 26, 2, $_SESSION['tmptxt'], $colText);

header("Content-type: image/gif");
imagegif($captcha);
?>