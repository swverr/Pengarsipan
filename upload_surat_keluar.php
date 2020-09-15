<?php
    //cek session
    if(empty($_SESSION['admin'])){
        $_SESSION['err'] = '<center>Anda harus login terlebih dahulu!</center>';
        header("Location: ./");
        die();
    } else {

        if(isset($_REQUEST['submit'])){

            //validasi form kosong
            if($_REQUEST['no_agenda'] == "" || $_REQUEST['files'] == ""){
            $_SESSION['errEmpty'] = 'ERROR! Semua form wajib diisi';
            echo '<script language="javascript">window.history.back();</script>';
            } else {

                $id_surat = $_REQUEST['id_surat'];
                $no_agenda = $_REQUEST['no_agenda'];
                $files = $_REQUEST['files'];
                // $id_user = $_SESSION['id_user'];

                //validasi input data
                if(!preg_match("/^[a-zA-Z0-9.,()\/ -]*$/", $no_agenda)){
                    $_SESSION['filek'] = 'Form file hanya boleh mengandung karakter huruf, angka, spasi, titik(.), koma(,), minus(-), garis miring(/), dan kurung()';
                    echo '<script language="javascript">window.history.back();</script>';
                } else {

                        $ekstensi = array('jpg','png','jpeg','doc','docx','pdf');
                        $file = $_FILES['file']['name'];
                        $x = explode('.', $file);
                        $eks = strtolower(end($x));
                        $ukuran = $_FILES['file']['size'];
                        $target_dir = "upload/surat_keluar/";

                        if (! is_dir($target_dir)) {
                            mkdir($target_dir, 0755, true);
                        }

                        //jika form file tidak kosong akan mengeksekusi script dibawah ini
                        if($file != ""){

                        $rand = rand(1,10000);
                        $nfile = $rand."-".$file;

                        //validasi file
                        if(in_array($eks, $ekstensi) == true){
                            if($ukuran < 2500000){
                                $id_surat = $_REQUEST['id_surat'];
                                $query = mysqli_query($config, "SELECT file FROM tbl_surat_keluar WHERE id_surat='$id_surat'");
                                list($file) = mysqli_fetch_array($query);

                                //jika file sudah ada akan mengeksekusi script dibawah ini
                                    if(!empty($file)){
                                        unlink($target_dir.$file);

                                        move_uploaded_file($_FILES['file']['tmp_name'], $target_dir.$nfile);

                                        $query = mysqli_query($config, "UPDATE tbl_surat_keluar SET no_agenda='$no_agenda',file='$nfile',keterangan='Dokumen Sudah Lengkap' WHERE id_surat='$id_surat'");

                                            if($query == true){
                                                $_SESSION['succEdit'] = 'SUKSES! Data berhasil diupdate';
                                                header("Location: ./admin.php?page=tsk");
                                                die();
                                            } else {
                                                $_SESSION['errQ'] = 'ERROR! Ada masalah dengan query';
                                                echo '<script language="javascript">window.history.back();</script>';
                                                }
                                        } else {

                                        //jika file kosong akan mengeksekusi script dibawah ini
                                        move_uploaded_file($_FILES['file']['tmp_name'], $target_dir.$nfile);

                                        $query = mysqli_query($config, "UPDATE tbl_surat_keluar SET no_agenda='$no_agenda',file='$nfile',keterangan='Dokumen Sudah Lengkap' WHERE id_surat='$id_surat'");

                                            if($query == true){
                                                $_SESSION['succEdit'] = 'SUKSES! Data berhasil diupdate';
                                                header("Location: ./admin.php?page=tsk");
                                                die();
                                            } else {
                                                $_SESSION['errQ'] = 'ERROR! Ada masalah dengan query';
                                                echo '<script language="javascript">window.history.back();</script>';
                                                }
                                        }
                                    } else {
                                        $_SESSION['errSize'] = 'Ukuran file yang diupload terlalu besar!';
                                        echo '<script language="javascript">window.history.back();</script>';
                                        }
                                } else {
                                    $_SESSION['errFormat'] = 'Format file yang diperbolehkan hanya *.PDF!';
                                    echo '<script language="javascript">window.history.back();</script>';
                        } 
                    }
                }
            }
        }else {

            $id_surat = mysqli_real_escape_string($config, $_REQUEST['id_surat']);
            $query = mysqli_query($config, "SELECT id_surat, no_agenda, file, id_user FROM tbl_surat_keluar WHERE id_surat='$id_surat'");
            list($id_surat, $no_agenda, $file, $id_user) = mysqli_fetch_array($query);
            if($_SESSION['id_user'] != $id_user AND $_SESSION['id_user'] != 1 AND $_SESSION['admin'] !=2){
                echo '<script language="javascript">
                        window.alert("ERROR! Anda tidak memiliki hak akses untuk mengedit data ini");
                        window.location.href="./admin.php?page=tsk";
                      </script>';
            } else {?>

                <!-- Row Start -->
                <div class="row">
                    <!-- Secondary Nav START -->
                    <div class="col s12">
                        <nav class="secondary-nav">
                            <div class="nav-wrapper blue darken-3">
                                <ul class="left">
                                    <li class="waves-effect waves-light"><a href="#" class="judul"><i class="material-icons">edit</i> Upload File Surat Keluar</a></li>
                                </ul>
                            </div>
                        </nav>
                    </div>
                    <!-- Secondary Nav END -->
                </div>
                <!-- Row END -->

                <?php
                    if(isset($_SESSION['errQ'])){
                        $errQ = $_SESSION['errQ'];
                        echo '<div id="alert-message" class="row">
                                <div class="col m12">
                                    <div class="card red lighten-5">
                                        <div class="card-content notif">
                                            <span class="card-title red-text"><i class="material-icons md-36">clear</i> '.$errQ.'</span>
                                        </div>
                                    </div>
                                </div>
                            </div>';
                        unset($_SESSION['errQ']);
                    }
                    if(isset($_SESSION['errEmpty'])){
                        $errEmpty = $_SESSION['errEmpty'];
                        echo '<div id="alert-message" class="row">
                                <div class="col m12">
                                    <div class="card red lighten-5">
                                        <div class="card-content notif">
                                            <span class="card-title red-text"><i class="material-icons md-36">clear</i> '.$errEmpty.'</span>
                                        </div>
                                    </div>
                                </div>
                            </div>';
                        unset($_SESSION['errEmpty']);
                    }
                ?>

                <!-- Row form Start -->
                <div class="row jarak-form">

                    <!-- Form START -->
                    <form class="col s12" method="POST" action="?page=tsk&act=upload" enctype="multipart/form-data">

                        <!-- Row in form START -->
                        <div class="row">
                            <div class="input-field col s6" hidden>
                                <input type="hidden" name="id_surat" value="<?php echo $id_surat ;?>">
                                <i class="material-icons prefix md-prefix">looks_one</i>
                                <input id="no_agenda" type="number" class="validate" name="no_agenda" value="<?php echo $no_agenda ;?>" required>
                                    <?php
                                        if(isset($_SESSION['no_agendak'])){
                                            $no_agendak = $_SESSION['no_agendak'];
                                            echo '<div id="alert-message" class="callout bottom z-depth-1 red lighten-4 red-text">'.$no_agendak.'</div>';
                                            unset($_SESSION['no_agendak']);
                                        }
                                    ?>
                                <label for="no_agenda">Nomor Agenda</label>
                            </div>   
                            <div class="input-field col s6">
                                <div class="file-field input-field">
                                    <div class="btn light-green darken-1">
                                        <span>File</span>
                                        <input type="file" id="file" name="file">
                                    </div>
                                    <div class="file-path-wrapper">
                                        <input name="files" class="file-path validate" type="text" value="<?php echo $file ;?>" placeholder="Upload file/scan surat keluar">
                                            <?php
                                                if(isset($_SESSION['errSize'])){
                                                    $errSize = $_SESSION['errSize'];
                                                    echo '<div id="alert-message" class="callout bottom z-depth-1 red lighten-4 red-text">'.$errSize.'</div>';
                                                    unset($_SESSION['errSize']);
                                                }
                                                if(isset($_SESSION['errFormat'])){
                                                    $errFormat = $_SESSION['errFormat'];
                                                    echo '<div id="alert-message" class="callout bottom z-depth-1 red lighten-4 red-text">'.$errFormat.'</div>';
                                                    unset($_SESSION['errFormat']);
                                                }
                                            ?>
                                        <small class="red-text">*Format file yang diperbolehkan *.PDF dan ukuran maksimal file 2 MB!</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Row in form END -->

                        <div class="row">
                            <div class="col 6">
                                <button type="submit" name="submit" class="btn-large blue waves-effect waves-light">SIMPAN <i class="material-icons">done</i></button>
                            </div>
                            <div class="col 6">
                                <a onclick="history.back()" class="btn-large deep-orange waves-effect waves-light">BATAL <i class="material-icons">clear</i></a>
                            </div>
                        </div>

                    </form>
                    <!-- Form END -->

                </div>
                <!-- Row form END -->

<?php
            }
        }
    }
?>
