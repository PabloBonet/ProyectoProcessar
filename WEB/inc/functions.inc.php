<?php
function checksession($type = 'admin') {
    @session_start();
    switch ($type) {
        case 'usuario':
            if (empty($_SESSION['uid'])) {
                header('Location:/usuarios/login.php');
            }
            break;
        case 'admin':
            if (empty($_SESSION['useradmin'])&& $_GET['url'] != 'login') {
                header('Location:/kdpanel/login');
            }
            break;
            
            exit();
    }
}

/* UTILS */

function pr($arr) {
    echo '<pre>';
    print_r($arr);
    echo '</pre>';
}

function loading() {
    return '<div id="loading"><div class="loading-inner"><img src="/img/ajax-loader.gif" alt="Procesando" /><br />Procesando, por favor espere.</div></div>';
}

// convierte fecha de mysql a normal 
function mysql_a_fecha2($fecha) {
    if (isValidMysqlDate($fecha)) {
        $mifecha = explode("-", $fecha);
        $lafecha = $mifecha[3] . "/" . $mifecha[2] . "/" . $mifecha[1];
        return $lafecha;
    }else
        return false;
}

/* Validation Functions */

/**
 * Reemplaza todos los acentos por sus equivalentes sin ellos
 *
 * @param $string
 *  string la cadena a sanear
 *
 * @return $string
 *  string saneada
 */
function sanear_string($string){
    $string = trim($string);
    $string = str_replace(array('á', 'à', 'Á', 'À'),array('a', 'a', 'A', 'A'),$string);
  //  echo $valor;

    $string = str_replace(
        array('é', 'è', 'ë', 'ê', 'É', 'È', 'Ê', 'Ë'),
        array('e', 'e', 'e', 'e', 'E', 'E', 'E', 'E'),
        $string
    );

    $string = str_replace(
        array('í', 'ì', 'ï', 'î', 'Í', 'Ì', 'Ï', 'Î'),
        array('i', 'i', 'i', 'i', 'I', 'I', 'I', 'I'),
        $string
    );

    $string = str_replace(
        array('ó', 'ò', 'ö', 'ô', 'Ó', 'Ò', 'Ö', 'Ô'),
        array('o', 'o', 'o', 'o', 'O', 'O', 'O', 'O'),
        $string
    );

    $string = str_replace(
        array('ú', 'ù', 'ü', 'û', 'Ú', 'Ù', 'Û', 'Ü'),
        array('u', 'u', 'u', 'u', 'U', 'U', 'U', 'U'),
        $string
    );

    $string = str_replace(
        array('ñ', 'Ñ', 'ç', 'Ç'),
        array('n', 'N', 'c', 'C',),
        $string
    );

    //Esta parte se encarga de eliminar cualquier caracter extraño
    $string = str_replace(
        array("\\", "¨", "º", "-", "~",
             "#", "@", "|", "!", "\"",
             "·", "$", "%", "&",
             "(", ")", "?", "'", "¡",
             "¿", "[", "^", "`", "]",
             "+", "}", "{", "¨", "´",
             ">", "<","=", ";", ",", ":",
             ".","_","*"),
        '',
        $string
    );

    return $string;
}
function cleanStrict($str){
    $str = sanear_string($str);
    //reemplazo todo lo que no sea letras o numeros
    $str = preg_replace("/[^a-zA-Z0-9\s-]/", '', $str);
    
    return $str;
}

function testUrl($str = null) {
    if (empty($str) || preg_match('/^[a-zA-Z0-9_\/-]{3,350}$/', $str)) {
        return true;
    }
    return false;
}

function testFind($str = null) {
    $search = array('á', 'é', 'í', 'ó', 'ú', 'Á', 'É', 'Í', 'Ó', 'Ú', 'ü', 'Ü', 'ñ', 'Ñ', '_', '-');
    $replace = array('a', 'e', 'i', 'o', 'u', 'a', 'e', 'i', 'o', 'u', 'u', 'u', 'n', 'n', ' ', ' ');
    $str = str_replace($search, $replace, utf8_encode($str));

    if (preg_match('/^[ a-zA-Z0-9_\/\s]{3,250}$/', $str)) {
        return true;
    }
    return false;
}
function isValidAlpha($data){
    return ctype_alnum($data);
}
function isValidNumber($data) {
    return preg_match("/^[0-9]{1,20}$/", escape($data));
}

function isValidPhone($data) {
    return eregi("^([0-9-]{3,6})([0-9]{5,10})$", $data);
}

function isValidEmail($data) {
    $data = escape($data);
    return filter_var($data, FILTER_VALIDATE_EMAIL);
}
function isValidPass($data) {
    $data = escape($data);
    return ctype_alnum($data);
}

function isValidUrl($data) {
    $data = escape($data);
    return filter_var($data, FILTER_VALIDATE_URL);
}

//test valid date dd-mm-YY
function isValidDate($data) {
    $data = escape($data);
    return preg_match("/^(0[1-9]|[12][0-9]|3[01])[-](0[1-9]|1[012])[-](19|20)\d\d$/", $data);
}

//test valid mysql date YY-mm-dd
function isValidMysqlDate($data) {
    $data = escape($data);
    return preg_match("/^(19|20)\d\d[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])$/", $data);
}

/* END VALIDATION FUNCTIONS */
function codeToMessage($code) {
    switch ($code) {
        case UPLOAD_ERR_INI_SIZE:
            $message = "El archivo excede el tama&ntilde;o m&aacute;ximo permitido por el servidor.".  ini_get("upload_max_filesize");
            break;
        case UPLOAD_ERR_FORM_SIZE:
            $message = "El archivo excede el tama&ntilde;o m&aacute;ximo especificado en el formulario HTML";
            break;
        case UPLOAD_ERR_PARTIAL:
            $message = "El archivo fue s&oacute;lo parcialmente cargado";
            break;
        case UPLOAD_ERR_NO_FILE:
            $message = "No se ha subido el archivo";
            break;
        case UPLOAD_ERR_NO_TMP_DIR:
            $message = "No se encuentra la carpeta temporal";
            break;
        case UPLOAD_ERR_CANT_WRITE:
            $message = "Error al guardar el archivo en el servidor";
            break;
        case UPLOAD_ERR_EXTENSION:
            $message = "La subida fue detenida por una extensi&oacute;n";
            break;

        default:
            $message = "Error desconocido";
            break;
    }
    return $message;
}


function makeHtmlLink($value) {
    $value = str_replace(".", "", $value);
    $value = str_replace("\"", "", $value);
    $value = str_replace("'", "", $value);

    do {
        $value = str_replace("  ", " ", $value);
    } while (strpos($value, "  ") !== false);

    $value = str_replace(" ", "-", $value);
    // REMOVE MORE THAN ONE -
    do {
        $value = str_replace("--", "-", $value);
    } while (strpos($value, "--") !== false);

    return strtolower($value);
}

function amigable($str) {

    $search = array('&lt;', '&gt;', '&quot;', '&amp;');
    $str = str_replace($search, '', $str);

    $search = array('&aacute;', '&Aacute;', '&eacute;', '&Eacute;', '&iacute;', '&Iacute;', '&oacute;', '&Oacute;', '&uacute;', '&Uacute;', '&ntilde;', '&Ntilde;');
    $replace = array('a', 'a', 'e', 'e', 'i', 'i', 'o', 'o', 'u', 'u', 'n', 'n');

    $search = array('á', 'é', 'í', 'ó', 'ú', 'Á', 'É', 'Í', 'Ó', 'Ú', 'ü', 'Ü', 'ñ', 'Ñ', '_', '-');
    $replace = array('a', 'e', 'i', 'o', 'u', 'a', 'e', 'i', 'o', 'u', 'u', 'u', 'n', 'n', ' ', ' ');

    $str = str_replace($search, $replace, $str);

    $str = preg_replace('/&(?!#[0-9]+;)/s', '', $str);

    $search = array(' a ', ' ante ', ' de ', ' para ', ' con ', ' contra ', ' por ', ' entre ', ' en ', ' sobre ', ' bajo ', ' y ', ' e ', ' o ', ' u ', ' este ', 'aquel ', ' la ', ' el ', ' lo ', ' las ', ' los ');

    $str = str_replace($search, ' ', strtolower($str));

    $str = str_replace($search, $replace, strtolower(trim($str)));

    $str = preg_replace("/[^a-zA-Z0-9\s]/", '', $str);
    $str = preg_replace('/\s\s+/', ' ', $str);
    $str = str_replace(' ', '-', $str);

    return $str;
}

function makeUrl($title, $table = null, $where = '1=1') {
    //si ya existe una url igual, se guarda con la cantidad que se encontro. Ej: si ya existe remera_negra, se guarda como remera_negra_1.html, cuando se use en nuevo producto, comparar contra url para que no haya duplicados
    //$url = makeHtmlLink($title);
    $url = amigable($title);

    if ($table) {
        $existe = query("SELECT COUNT(id) as cant FROM $table WHERE $where AND url = '$url.html'");
        $cant = 0;
        while (!empty($existe) && $existe[0]['cant'] > 0) {
            $cant++;
            $existe = query("SELECT COUNT(id) as cant FROM $table WHERE url = '$url-$cant.html'");
        }
        $url .= ($cant > 0) ? '-' . $cant : '';
        $url .='.html';
        return $url;
    }
}

function cleanTags($tags) {
    $tags = str_replace(", ", ",", $tags);
    $tags = str_replace(" ,", ",", $tags);
    $tags = str_replace(",  ", ",", $tags);
    $tags = str_replace("  ,", ",", $tags);
    return $tags;
}
function moneda($valor){
    if(strstr($valor,'.'))
        return number_format($valor, 2, ',', '.');
    else
        return number_format($valor, 0, ',','.');
}
function randomText($length) {
    $pattern = "1234567890abcdefghijklmnopqrstuvwxyz%()?,.:;-_@=/!";
    $key = '';
    for ($i = 0; $i < $length; $i++) {
        $key .= $pattern[rand(0, 49)];
    }
    return $key;
}

function captcha() {
    @session_start();
    $_SESSION['tmptxt'] = randomText(3);
}

/* Crea select para ordenamientos */

function printOptionsOrder($actual) {
    for ($i = 1; $i < 20; $i++) {
        $selected = ($actual == $i) ? 'selected="selected"' : '';
        echo '<option value="' . $i . '"' . $selected . '>' . $i . '</option>';
    }
}

/*Imprime options de un array del tipo clave => valor con default para el item seleccionado*/
function printOptions($data,$default = null) {
    if(!empty($data)){
        foreach($data as $key => $val) {
            if(is_array($default) && in_array($key, $default)){
                $selected = ' selected="selected"';
            }else{
                $selected = ($default != '' && $default == $key)?' selected="selected"':'';
            }
            echo '<option value="'.$key.'"'.$selected.'>'.$val.'</option>';
        }
    }
}

/* muestra cartel de error, ok o info */

function showbox($type='error', $title, $description=null) {
    return '<div class="box-' . $type . '"><div class="ico-' . $type . '"><h4>' . $title . '</h4>' . $description . '</div></div>';
}

/* muestra el error de validacion */

function showerror($errores, $field) {
    if (!empty($errores[$field])) {
        echo '<label class="error"><span>' . utf8_encode($errores[$field]) . '</span></label>';
    }
}

/* * *************************************************** */
/* Funcion paginar
 * actual:          Pagina actual
 * total:           Total de registros
 * por_pagina:      Registros por pagina
 * enlace:          Texto del enlace
 * Devuelve un texto que representa la paginacion
 */

function paginar($actual, $total, $por_pagina, $enlace) {
    $total_paginas = ceil($total / $por_pagina);
    $anterior = $actual - 1;
    $posterior = $actual + 1;

    $mostradas = $actual * $por_pagina;
    if ($mostradas > $total)
        $mostradas = $total;

    //$texto = "Mostrando $mostradas de $total <br />";
    $texto = "";

    if ($actual > 1)
        $texto .= "<a href=\"$enlace$anterior\">&laquo;</a> ";
    if ($actual > 5) {
        $desde = $actual - 5;
        $texto .= "<a href=\"$enlace$desde\">...</a> ";
    } else {
        $desde = 1;
    };
    for ($i = $desde; $i < $actual; $i++) {
        $texto .= "<a href=\"$enlace$i\">$i</a> ";
    }
    $texto .= "<b>$actual</b> ";
    for ($i = $actual + 1; $i <= $total_paginas; $i++) {
        if ($i == $actual + 6) {
            $texto .= "<a href=\"$enlace$i\">...</a> ";
            break;
        }
        $texto .= "<a href=\"$enlace$i\">$i</a> ";
    }
    if ($actual < $total_paginas)
        $texto .= "<a href=\"$enlace$posterior\">&raquo;</a>";

    return $texto;
}

/*
 * Categories recursive
 */

function getCategories() {
    $fathers = query("SELECT * FROM products_categories WHERE category_id IS NULL");
    if (!empty($fathers)) {
        foreach ($fathers as $keycat => $father) {
            $fathers[$keycat]['categories'] = findAll("products_categories", "id,title", "category_id = " . $father['id']);
            if (!empty($fathers[$keycat]['categories'])) {
                foreach ($fathers[$keycat]['categories'] as $keycat2 => $father2) {
                    $fathers[$keycat]['categories'][$keycat2]['categories'] = findAll("products_categories", "id,title", "category_id = " . $father2['id']);
                }
            }
        }
    }
//    pr($fathers); die;
    return $fathers;
}

//elimina categorias recursivamente
function eliminarCat($id) {
    $cat = find("products_categories", "id", "id = " . $id);
    if (!empty($cat)) {
        $products = findAll("products", null, "category_id = " . $id);
        if (!empty($products)) {
            foreach ($products as $product) {
                $pictures = findAll("products_pictures", null, "product_id = " . $product['id']);
                if (!empty($pictures)) {
                    foreach ($pictures as $pic) {
                        unlink(WWW_ROOT . 'img/productos/' . $pic['src']);
                        unlink(WWW_ROOT . 'img/productos/thumbs/' . $pic['src']);
                    }
                    mysql_query("DELETE FROM products_pictures WHERE product_id = " . $product['id']);
                }
            }
            mysql_query("DELETE FROM products WHERE category_id = " . $id);
        }
        mysql_query("DELETE FROM products_categories WHERE id = " . $id);
        $cats = findAll("products_categories", "id", "category_id = " . $id);
        if (!empty($cats)) {
            foreach ($cats as $cat) {
                eliminarCat($cat['id']);
            }
        }
        if (file_exists(WWW_ROOT . 'img/marcas/' . $id . '.gif')) {
            unlink(WWW_ROOT . 'img/marcas/' . $id . '.gif');
        }
    }
}


/*
 * Muestra errores mysql, setea el nivel de errores php a ALL
 */

function debug() {
echo '<div style="background:#fff; color:#333;padding:20px;margin:20px;">';
    if (!empty($_FILES)) {
        echo '<h2>Datos FILES:</h2><br>';
        pr($_FILES);
    }
    if (!empty($_POST)) {
        echo '<br><hr><br><h2>Datos POST:</h2><br>';
        pr($_POST);
    }
    if (!empty($_GET)) {
        echo '<br><hr><br><h2>Datos GET:</h2><br>';
        pr($_GET);
    }
    if (!empty($_SESSION)) {
        echo '<br><hr><br><h2>Datos SESSION:</h2><br>';
        pr($_SESSION);
    }
    echo '</div>';
}

function generate_settings() {
    $result = findAll("settings");
    foreach ($result as $row) {
        $GLOBALS[$row['name']] = $row['value'];
    }
}
?>