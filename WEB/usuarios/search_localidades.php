<?php

include_once '../inc/config.inc.php';
if (!empty($_GET['term']) && isValidAlpha(str_replace(" ", "", $_GET['term']))) {
    $term = trim(strip_tags($_GET['term'])); //
    $qstring = "SELECT c.ciudad as value,c.id,p.provincia FROM ciudad AS c LEFT JOIN provincia AS p ON p.id = c.provincia_id WHERE c.ciudad LIKE '%" . $term . "%' GROUP BY c.id ORDER BY c.ciudad";
    $result = query($qstring); //query the database for entries containing the term
    if (!empty($result)) {
        foreach ($result as $row) {
            $row['value'] = $row['value'] . ' / ' . $row['provincia'];
            $row['id'] = (int) $row['id'];
            $row_set[] = $row; //build an array
        }
    }
    echo json_encode($row_set); //format the array into json data
}
?>