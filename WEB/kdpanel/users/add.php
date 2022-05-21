<?
$errors = array();
if (!empty($_POST)) {
    if (empty($_POST['name'])) {
        $errors['name'] = 'Ingrese un nombre';
    } else {
        $_POST['name'] = sanear_string($_POST['name']);
    }
    if (!empty($_POST['city'])) {
        $_POST['city'] = sanear_string($_POST['city']);
    }
    if (!empty($_POST['address'])) {
        $_POST['address'] = sanear_string($_POST['address']);
    }
    if (empty($_POST['email'])) {
        $errors['email'] = 'Ingrese un email';
    } else {
        if (!isValidEmail($_POST['email'])) {
            $errors['email'] = 'Ingrese un email v&aacute;lido';
        } else {
            $existe = find("users", null, "email ='" . escape($_POST['email']) . "'");
            if (!empty($existe))
                $errors['email'] = 'El email ingresado ya existe';
        }
    }
    if (!empty($_POST['phone'])) {
        $telefono = str_replace(array(" ", "-", "(", ")"), '', $_POST['phone']);
        if (!is_numeric($telefono)) {
            $errors['phone'] = 'Ingrese solo n&uacute;meros, espacios, par&eacute;ntesis o guiones';
        }
    }

    if (empty($_POST['password'])) {
        $errors['password'] = 'Ingrese una contrase&ntilde;a';
    } else {
        if (!isValidPass($_POST['password']) || strlen($_POST['password']) < 5) {
            $errors['password'] = 'Ingrese m&iacute;nimo 5 caracteres o n&uacute;meros';
        } else {
            if ($_POST['password'] != $_POST['repassword']) {
                $errors['repassword'] = 'Las contrase&ntilde;as no coinciden';
            }
        }
    }
    if (empty($errors)) {
        unset($_POST['repassword']);
        if ($uid = query_insert('users', $_POST)) {
            $ok = true;
            echo '<script>location.href="/kdpanel/users/edit?id=' . $uid . '&ok=1";</script>';
            exit();
        } else {
            $error = true;
        }
    } else {
        $error = true;
    }
    $user = $_POST;
}
?>
<script type="text/javascript">
    $(function ()
    {
        $("#city").autocomplete({
            source: "search_localidades.php",
            minLength: 4
        });
    });
</script>
<div class="widget-top">
    <h3>Agregar usuario</h3>
</div>
<div class="inside">
    <?
    if (isset($ok)) {
        echo showbox("ok", "Usuario agregado correctamente.", "Puede continuar agregando usuarios.");
    }
    if (isset($error)) {
        echo showbox("error", "Error al crear el usuario.", "Verifique los campos obligatorios.");
    }
    ?>
    <form action="" method="post">
        <cite>Nota: Los campos marcados con * son obligatorios</cite>
        <div class="input">
            <label>Nombre<span class="requerido">*</span>:</label>
            <input type="text" name="name" maxlength="150" value="<?= @$user['name'] ?>" class="input-text" />
            <? showerror($errors, 'name') ?>
        </div>
        <div class="input">
            <label>Email<span class="requerido">*</span>:</label>
            <input type="text" name="email" maxlength="150" value="<?= @$user['email'] ?>" class="input-text" />
            <? showerror($errors, 'email') ?>
        </div>
        <div class="input">
            <label>Contrase&ntilde;a<span class="requerido">*</span>:</label>
            <input type="text" name="password" maxlength="15" value="<?= @$user['password'] ?>" class="input-text" />
            <? showerror($errors, 'password') ?>
        </div>
        <div class="input">
            <label>Reingrese Contrase&ntilde;a<span class="requerido">*</span>:</label>
            <input type="text" name="repassword" maxlength="15" class="input-text" />
            <? showerror($errors, 'repassword') ?>
        </div>
        <div class="input">
            <label>Estado:</label>
            <select name="activo" class="select">
                <option value="0"<?= (@$_POST['activo'] != 1) ? ' selected="selected"' : false; ?>>Inactivo</option>
                <option value="1"<?= (empty($_POST['activo']) || @$_POST['activo'] == 1) ? ' selected="selected"' : false; ?>>Activo</option>
            </select>
        </div>
        <div class="input">
            <label>Tel&eacute;fono:</label>
            <input type="text" name="phone" value="<?= @$user['phone'] ?>" class="input-text" />
            <? showerror($errors, 'phone') ?>
        </div>
        <div class="input">
            <label>Ciudad/Provincia:</label>
            <input type="text" name="city" id="city" value="<?= @$user['city'] ?>" class="input-text" />
            <? showerror($errors, 'city') ?>
        </div>
        <div class="input" style="margin-left: 350px">
            <input type="submit" value="" class="btn btn-guardar" onclick="document.getElementById('loading').style.display = 'block'" />
        </div>
        <?= loading(); ?>
    </form>
</div>