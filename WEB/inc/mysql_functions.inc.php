<?php

/*MYSQL FUNCTIONS*/
/**********************************************
 * desc: connect and select database using config vars
 */
global $db;

function dbconnect() {
    global $db;
// Create connection
$db = new mysqli(SERVER, USER, PASS,DBNAME);

// Check connection
if (mysqli_connect_errno()) {
  die("Connection failed: " . mysqli_connect_error());
}
//echo "Connected successfully";

    $db->query("SET NAMES 'utf8'");
    // unset the data so it can't be dumped
    unset($GLOBALS['SERVER']);
    unset($GLOBALS['USER']);
    unset($GLOBALS['PASS']);
    unset($GLOBALS['DBNAME']);
}

/**********************************************
 * desc: Returns a safe escaped string
 * @param string $string
 * @return string $string
 */
function escape($string) {
    global $db;
    $string = stripslashes($string);
    return mysqli_real_escape_string($db,$string);
}

/**********************************************
 * desc: frees the resultset
 * @param query_id for mysql run.
 */
function free_result($query_id=-1) {
    if ($query_id!=-1) {
        @mysqli_free_result($query_id);
    }
}

/**********************************************
 * desc: returns all the results of a given query
 * @param (MySQL query)
 * @returns: assoc array of ALL fetched results
 */
function query($sql) {
    global $db;
    $query_id = $db->query($sql);
    //echo mysqli_error($db);
    $out = array();
    while ($row = @mysqli_fetch_assoc($query_id)) {
        $out[] = $row;
    }
    if(!empty($out))
        return $out;
    else return false;
}

/**********************************************
 * desc: does an insert query with an array
 * @param: table, assoc array with data
 * @returns: id of inserted record, false if error
 */
function query_insert($table, $data) {
    global $db;
    $sql="INSERT INTO `".$table."` ";
    $v='';
    $n='';

    foreach($data as $key=>$val) {
        $n.="`$key`, ";
        if(strtolower($val)=='null') $v.="NULL, ";
        elseif(strtolower($val)=='now()') $v.="NOW(), ";
        else $v.= "'".escape($val)."', ";
    }
    $sql .= "(". rtrim($n, ', ') .") VALUES (". rtrim($v, ', ') .");";
    if($db->query($sql)) {
        return mysqli_insert_id($db);
    }
    else{return false;}
}

/**********************************************
 * desc: does an update query with an array
 * @param: table, assoc array with data (doesn't need escaped), where condition
 * @returns: (query_id) for fetching results etc
 */
function query_update($table, $data, $where='1') {
    global $db;
    $sql="UPDATE `".$table."` SET ";
    foreach($data as $key=>$val) {
        if(strtolower($val)=='null') $sql.= "`$key` = NULL, ";
        elseif(strtolower($val)=='now()') $sql.= "`$key` = NOW(), ";
        else $sql.= "`$key`='".escape($val)."', ";
    }
    $sql = rtrim($sql, ', ') . ' WHERE '.$where.';';
    return $db->query($sql);
}

/**********************************************
 * desc: find single row and return an associative array
 * @param: table, assoc array with data (doesn't need escaped), where condition
 * @returns: (query_id) for fetching results etc
 */
function find($table, $fields = null, $where = '1', $order = null) {
    global $db;
    $fields = ($fields)?escape($fields):'*';
    $order = ($order)?' ORDER BY '.escape($order):'';
    $sql = "SELECT ".$fields." FROM ".$table.' WHERE '.$where.$order;
    $out = $db->query($sql);
    return mysqli_fetch_assoc($out);
}

/**********************************************
 * desc: find list of rows and return an associative array
 * @param: table, assoc array with data (doesn't need escaped), where condition
 * @returns: (query_id) for fetching results etc
 */
function findAll($table, $fields = null, $where = null, $order = null, $limit = null) {
    $fields = ($fields)?escape($fields):"*";
    $where = ($where)?" WHERE ".$where:"";
    $order = ($order)?" ORDER BY ".escape($order):"";
    $limit = ($limit)?" LIMIT $limit":"";
    $sql = "SELECT ".$fields." FROM ".$table.$where.$order.$limit;
    return query($sql);
}

/**********************************************
 * desc: find list of rows and return an associative array for select input. Style id => field
 * @param: table, assoc array with data (doesn't need escaped), where condition
 * @returns: (query_id) for fetching results etc
 */
function findList($table, $fields = null, $where = null, $order = null, $limit = null) {
    $fields = ($fields)?escape($fields):"*";
    $where = ($where)?" WHERE ".$where:"";
    $order = ($order)?" ORDER BY ".escape($order):"";
    $limit = ($limit)?" LIMIT $limit":"";
    $sql = "SELECT ".$fields." FROM ".$table.$where.$order.$limit;
    $aux = query($sql);
    if(!empty($aux)){
        //si vienen dos campos, utilizo el primero como clave y el segundo como valor del array result. Si viene uno, uso el mismo campo
        if(substr_count($fields, ','))
            list($arrkey,$arrval) = explode(',',$fields);
        else
            $arrkey = $arrval = $fields;
        $result = array();
        foreach ($aux as $val) {
            $result[$val[$arrkey]] = $val[$arrval];
        }
        return $result;
    }else
        return false;
}
?>