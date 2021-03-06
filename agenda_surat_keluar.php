<?php
    //cek session
    if(empty($_SESSION['admin'])){
        $_SESSION['err'] = '<center>Anda harus login terlebih dahulu!</center>';
        header("Location: ./");
        die();
    } else {

        echo '
        <style type="text/css">
            .hidd {
                display: none
            }
            @media print{
                body {
                    font-size: 12px!important;
                    color: #212121;
                }
                .disp {
                    text-align: center;
                    margin: -.5rem 0;
                    width: 100%;
                }
                nav {
                    display: none
                }
                .hidd {
                    display: block
                }
                .logodisp {
                    position: absolute;
                    width: 80px;
                    height: 80px;
                    left: 50px;
                    margin: 0 0 0 1.2rem;
                }
                .up {
                    font-size: 17px!important;
                    font-weight: normal;
                    margin-top: 45px;
                    text-transform: uppercase
                }
                #nama {
                    font-size: 20px!important;
                    text-transform: uppercase;
                    margin-top: 5px;
                    font-weight: bold;
                }
                .status {
                    font-size: 17px!important;
                    font-weight: normal;
                    margin-top: -1.5rem;
                }
                #alamat {
                    margin-top: -15px;
                    font-size: 13px;
                }
                .separator {
                    border-bottom: 2px solid #616161;
                    margin: 1rem 0;
                }
            }
        </style>';

        if(isset($_REQUEST['submit'])){

            // $id_surat = $_REQUEST['id_surat'];
            $dari_tanggal = $_REQUEST['dari_tanggal'];
            $sampai_tanggal = $_REQUEST['sampai_tanggal'];
            $kd_jenis  = $_REQUEST['kd_jenis'];

            if($_REQUEST['dari_tanggal'] == "" || $_REQUEST['sampai_tanggal'] == ""){
                header("Location: ./admin.php?page=ask");
                die();
            } else {
                if($_REQUEST['kd_jenis'] == "Semua"){
                $query = mysqli_query($config, "SELECT * FROM tbl_surat_keluar WHERE tgl_catat BETWEEN '$dari_tanggal' AND '$sampai_tanggal' ");
            }else{
                if($_REQUEST['kd_jenis'] == "SP")
            $query = mysqli_query($config, "SELECT * FROM tbl_surat_keluar WHERE kd_jenis='SP' AND tgl_diterima BETWEEN '$dari_tanggal' AND '$sampai_tanggal'");
            }
                $query2 = mysqli_query($config, "SELECT nama FROM tbl_instansi");
                list($nama) = mysqli_fetch_array($query2);

                echo '
                    <!-- SHOW DAFTAR AGENDA -->
                    <!-- Row Start -->
                    <div class="row">
                        <!-- Secondary Nav START -->
                        <div class="col s12">
                            <div class="z-depth-1">
                                <nav class="secondary-nav">
                                    <div class="nav-wrapper blue darken-3">
                                        <div class="col 12">
                                            <ul class="left">
                                                <li class="waves-effect waves-light"><a href="?page=ask" class="judul"><i class="material-icons">print</i> Cetak Agenda Surat Keluar<a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </nav>
                            </div>
                        </div>
                        <!-- Secondary Nav END -->
                    </div>
                    <!-- Row END -->

                    <!-- Row form Start -->
                    <div class="row jarak-form black-text">
                        <form class="col s12" method="post" action="">
                            <div class="input-field col s3">
                                <i class="material-icons prefix md-prefix">date_range</i>
                                <input id="dari_tanggal" type="text" name="dari_tanggal" id="dari_tanggal" required>
                                <label for="dari_tanggal">Dari Tanggal</label>
                            </div>
                            <div class="input-field col s3">
                                <i class="material-icons prefix md-prefix">date_range</i>
                                <input id="sampai_tanggal" type="text" name="sampai_tanggal" id="sampai_tanggal" required>
                                <label for="sampai_tanggal">Sampai Tanggal</label>
                            </div>
                            <div class="input-field col s2">
                            <select class="browser-default validate" name="kd_jenis" id="kd_jenis" required>
                                    <option value="Semua">Semua</option>
                                    <option value="SP">Surat Perintah</option>
                                    <option value="ND">Nota Dinas</option>
                                    <option value="SPK">Surat Perjanjian Kerjasama (MOU)</option>
                                    <option value="SK">Surat Keterangan</option>
                                    <option value="SB">Surat Biasa</option>
                            </select>
                        </div>
                            <div class="col s3">
                                <button type="submit" name="submit" class="btn-large blue waves-effect waves-light"> TAMPILKAN <i class="material-icons">visibility</i></button>
                            </div>
                        </form>
                    </div>
                    <!-- Row form END -->

                    <div class="row agenda">
                        <div class="disp hidd">';
                            $query2 = mysqli_query($config, "SELECT institusi, nama, status, alamat, logo FROM tbl_instansi");
                            list($institusi, $nama, $status, $alamat, $logo) = mysqli_fetch_array($query2);
                                echo '<img class="logodisp" src="./upload/logo2.png"/>';

                                echo '<h6 class="up">'.$institusi.'</h6>';

                                echo '<h5 class="nama" id="nama">'.$nama.'</h5><br/>';

                                echo '<h6 class="status">'.$status.'</h6>';

                                echo '<span id="alamat">'.$alamat.'</span>

                            </div>
                            <div class="separator"></div>
                            <h5 class="hid">AGENDA SURAT KELUAR</h5>
                        <div class="col s10">
                            <p class="warna agenda">Agenda Surat Keluar dari tanggal <strong>'.indoDate($dari_tanggal).'</strong> sampai dengan tanggal <strong>'.indoDate($sampai_tanggal).'</strong></p>
                        </div>
                        <div class="col s2">
                            <button type="submit" onClick="window.print()" class="btn-large deep-orange waves-effect waves-light right">CETAK <i class="material-icons">print</i></button>
                        </div>
                    </div>
                    <div id="colres" class="warna cetak">
                        <table class="bordered" id="tbl" width="100%">
                            <thead class="blue lighten-4">
                                <tr>
                                    <th width="5%">No Agenda</th>
                                    <th width="15%">No Surat</th>
                                    <th width="25%">Kepada</th>
                                    <th width="20%">Hal</th>
                                    <th width="10%">Tanggal<br/> Surat</th>
                                    <th width="15%">Keterangan</th>
                                </tr>
                            </thead>
                            <tbody>';

                            if(mysqli_num_rows($query) > 0){
                                $no = 0;
                                while($row = mysqli_fetch_array($query)){
                                 echo '
                                    <tr>
                                        <td>'.$row['no_agenda'].'</td>
                                        <td>'.$row['no_surat'].'/'.$row['kd_jenis'].'.'.$row['bagian'].'</td>
                                        <td>'.$row['kepada'].'</td>
                                        <td>'.$row['perihal'].'</td>
                                        <td>'.indoDate($row['tgl_surat']).'</td>
            <td><a class="black-text" href="?page=gsk&act=fsk&id_surat='.$row['id_surat'].'">'.$row['keterangan'].'';
                                 echo '</a></td>
                                </tr>';
                                    }
                                } else {
                                    echo '<tr><td colspan="9"><center><p class="add">Tidak ada agenda surat</p></center></td></tr>';
                                } echo '
                            </tbody></table>
                        </div>
                    <div class="jarak2"></div>';
                }
        } else {
            echo '
                <!-- Row Start -->
                <div class="row">
                    <!-- Secondary Nav START -->
                    <div class="col s12">
                        <div class="z-depth-1">
                            <nav class="secondary-nav">
                                <div class="nav-wrapper blue darken-3">
                                    <div class="col 12">
                                        <ul class="left">
                                            <li class="waves-effect waves-light"><a href="?page=ask" class="judul"><i class="material-icons">print</i> Cetak Agenda Surat Keluar<a></li>
                                        </ul>
                                    </div>
                                </div>
                            </nav>
                        </div>
                    </div>
                    <!-- Secondary Nav END -->
                </div>
                <!-- Row END -->

                <!-- Row form Start -->
                <div class="row jarak-form black-text">
                    <form class="col s12" method="post" action="">
                        <div class="input-field col s3">
                            <i class="material-icons prefix md-prefix">date_range</i>
                            <input id="dari_tanggal" type="text" name="dari_tanggal" id="dari_tanggal" required>
                            <label for="dari_tanggal">Dari Tanggal</label>
                        </div>
                        <div class="input-field col s3">
                            <i class="material-icons prefix md-prefix">date_range</i>
                            <input id="sampai_tanggal" type="text" name="sampai_tanggal" id="sampai_tanggal" required>
                            <label for="sampai_tanggal">Sampai Tanggal</label>
                        </div>
                        <div class="input-field col s2">
                            <select class="browser-default validate" name="kd_jenis" id="kd_jenis" required>
                                    <option value="Semua">Semua</option>
                                    <option value="SP">Surat Perintah</option>
                                    <option value="ND">Nota Dinas</option>
                                    <option value="SPK">Surat Perjanjian Kerjasama (MOU)</option>
                                    <option value="SK">Surat Keterangan</option>
                                    <option value="SB">Surat Biasa</option>
                            </select>
                        </div>
                        <div class="col s3">
                            <button type="submit" name="submit" class="btn-large blue waves-effect waves-light"> TAMPILKAN <i class="material-icons">visibility</i></button>
                        </div>
                    </form>
                </div>
                <div class="jarak"></div>';
        }
    }
?>
