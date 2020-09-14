-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 14 Sep 2020 pada 04.57
-- Versi server: 10.1.38-MariaDB
-- Versi PHP: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `arsipsurat`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_disposisi`
--

CREATE TABLE `tbl_disposisi` (
  `id_disposisi` int(10) NOT NULL,
  `tujuan` varchar(250) NOT NULL,
  `isi_disposisi` varchar(200) NOT NULL,
  `catatand` varchar(250) NOT NULL,
  `id_surat` int(10) NOT NULL,
  `id_user` tinyint(2) NOT NULL,
  `statusd` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_instansi`
--

CREATE TABLE `tbl_instansi` (
  `id_instansi` tinyint(1) NOT NULL,
  `institusi` varchar(150) NOT NULL,
  `nama` varchar(150) NOT NULL,
  `status` varchar(150) NOT NULL,
  `alamat` varchar(150) NOT NULL,
  `kepala` varchar(50) NOT NULL,
  `nip` varchar(25) NOT NULL,
  `website` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `logo` varchar(250) NOT NULL,
  `id_user` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_instansi`
--

INSERT INTO `tbl_instansi` (`id_instansi`, `institusi`, `nama`, `status`, `alamat`, `kepala`, `nip`, `website`, `email`, `logo`, `id_user`) VALUES
(1, 'Pemerintahan Daerah Provinsi Jawa Barat', 'Dinas Perhubungan Jawa Barat', 'Kantor Dinas', 'Jl. Sukabumi No.1, Kacapiring, Kec. Batununggal, Kota Bandung, Jawa Barat 40271', ' ', '-', 'http://dishub.jabarprov.go.id/', 'dishub@jabarprov.go.id', 'logo.png', 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_klasifikasi`
--

CREATE TABLE `tbl_klasifikasi` (
  `id_klasifikasi` int(5) NOT NULL,
  `kode` varchar(30) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `uraian` mediumtext NOT NULL,
  `id_user` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_sett`
--

CREATE TABLE `tbl_sett` (
  `id_sett` tinyint(1) NOT NULL,
  `surat_masuk` tinyint(2) NOT NULL,
  `surat_keluar` tinyint(2) NOT NULL,
  `referensi` tinyint(2) NOT NULL,
  `id_user` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_sett`
--

INSERT INTO `tbl_sett` (`id_sett`, `surat_masuk`, `surat_keluar`, `referensi`, `id_user`) VALUES
(1, 100, 10, 100, 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_surat_keluar`
--

CREATE TABLE `tbl_surat_keluar` (
  `id_surat` int(10) NOT NULL,
  `no_agenda` int(10) NOT NULL,
  `tujuan` varchar(250) NOT NULL,
  `no_surat` varchar(50) NOT NULL,
  `isi` mediumtext NOT NULL,
  `kode` varchar(30) NOT NULL,
  `tgl_surat` date NOT NULL,
  `tgl_catat` date NOT NULL,
  `file` varchar(250) NOT NULL,
  `keterangan` varchar(250) NOT NULL,
  `id_user` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_surat_keluar`
--

INSERT INTO `tbl_surat_keluar` (`id_surat`, `no_agenda`, `tujuan`, `no_surat`, `isi`, `kode`, `tgl_surat`, `tgl_catat`, `file`, `keterangan`, `id_user`) VALUES
(2, 1, 'Kesbangpol', '111/21212/2121', 'Kerja Praktek', '30', '2020-08-24', '2020-08-24', '7187-Screenshot (17).png', 'Kerja Praktek', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_surat_masuk`
--

CREATE TABLE `tbl_surat_masuk` (
  `id_surat` int(10) NOT NULL,
  `no_agenda` int(10) NOT NULL,
  `no_surat` varchar(50) NOT NULL,
  `asal_surat` varchar(250) NOT NULL,
  `isi` mediumtext NOT NULL,
  `catatan` varchar(250) NOT NULL,
  `jenis` varchar(100) NOT NULL,
  `sifat` varchar(100) NOT NULL,
  `tgl_surat` date NOT NULL,
  `tgl_diterima` date NOT NULL,
  `file` varchar(250) NOT NULL,
  `disposisi` varchar(250) NOT NULL,
  `status` varchar(100) NOT NULL,
  `id_user` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_user`
--

CREATE TABLE `tbl_user` (
  `id_user` tinyint(2) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(35) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `nip` varchar(25) NOT NULL,
  `admin` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbl_user`
--

INSERT INTO `tbl_user` (`id_user`, `username`, `password`, `nama`, `nip`, `admin`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'Muhammad Shafrizal', '17111096', 1),
(4, 'superman', 'ecdfacbc0d41d495a7f7d479888bc9c7', 'Muhammad shafrizal', '122222', 2),
(8, 'BidangDarat', '21232f297a57a5a743894a0e4a801fc3', 'Bidang Transportasi Darat', '-', 3),
(9, 'BidangLaut', '21232f297a57a5a743894a0e4a801fc3', 'Bidang Transportasi Laut dan ASDP', '-', 3),
(10, 'BidangUdara', '21232f297a57a5a743894a0e4a801fc3', 'Bidang Transportasi Udara', '-', 3),
(11, 'perhubungan1', '21232f297a57a5a743894a0e4a801fc3', 'UPTD Pengelolaan Prasarana Perhubungan LLAJ Wil.I', '-', 3),
(12, 'perhubungan2', '21232f297a57a5a743894a0e4a801fc3', 'UPTD Pengelolaan Prasarana Perhubungan LLAJ Wil.II', '-', 3),
(13, 'perhubungan3', '21232f297a57a5a743894a0e4a801fc3', 'UPTD Pengelolaan Prasarana Perhubungan LLAJ Wil.II', '-', 3),
(14, 'perhubungan4', '21232f297a57a5a743894a0e4a801fc3', 'UPTD Pengelolaan Prasarana Perhubungan LLAJ Wil.IV', '-', 3),
(15, 'perhubungan5', '21232f297a57a5a743894a0e4a801fc3', 'UPTD Pengelolaan Prasarana Perhubungan Lalu Lintas', '-', 3),
(16, 'pelayanan', '21232f297a57a5a743894a0e4a801fc3', 'Pelayanan Jasa Kebandaraan Nusawiru', '-', 3),
(17, 'prasarana', '21232f297a57a5a743894a0e4a801fc3', 'UPTD Pengelolaan Prasarana Perhubungan Pelabuhan L', '-', 3),
(18, 'Sekretaris', '21232f297a57a5a743894a0e4a801fc3', 'Sekretaris', '-', 3),
(19, 'ijal221', '21232f297a57a5a743894a0e4a801fc3', 'Admin Surat Keluar', '-', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pencarian`
--

CREATE TABLE `tb_pencarian` (
  `id` int(11) NOT NULL,
  `kd_index` varchar(20) NOT NULL,
  `sub` varchar(20) NOT NULL,
  `keterangan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_pencarian`
--

INSERT INTO `tb_pencarian` (`id`, `kd_index`, `sub`, `keterangan`) VALUES
(1, 'HM', '01', 'Penerangan dan Publikasi'),
(2, 'HM', '02', 'Dengar Pendapat/Hearing'),
(3, 'HM', '03.01', 'Hubungan Antar Lembaga, Forkompimda'),
(4, 'HM', '03.02', 'Hubungan Antar Lembaga, Organisasi Kearsipan Nasional dan Internasional'),
(5, 'HM', '03.03', 'Hubungan Antar Lembaga, Instansi Vertikal'),
(6, 'HM', '03.04', 'Hubungan Antar Lembaga, Orgabisasi Kemasyarakatan'),
(7, 'HM', '03.05', 'Hubungan Antar Lembaga, Perguruan Tinggi/Sekolah'),
(8, 'HM', '03.06', 'Hubungan Antar Lembaga, Partai Politik'),
(9, 'HM', '03.07', 'Hubungan Antar Lembaga, Swasta'),
(10, 'HM', '03.08', 'Hubungan Antar Lembaga, Bakohumas'),
(11, 'HM', '04.01', 'Keprotokolan, Upacara/Acara Kedinasan'),
(12, 'HM', '04.02', 'Kunjungan'),
(13, 'HM', '04.03', 'Keprotokolan, Agenda Pimpinan'),
(14, 'HM', '05', 'Dokumentasi dan Penerbitan'),
(15, 'HM', '06', 'Penghargaan/Tanda Kenang-kenangan'),
(16, 'HM', '07', 'Ucapan'),
(17, 'HM', '08', 'Dokumen Hosting'),
(18, 'HK', '01.01', 'Program Legislasi, Perencanaan Program Legislasi Daerah'),
(19, 'HK', '01.02', 'Evaluasi Program Legislasi'),
(20, 'HK', '02.01', 'Produk Hukum, Proses Penyusunan Peraturan Daerah'),
(21, 'HK', '02.02', 'Produk Hukum, Proses Penyusunan Peraturan Gubernur'),
(22, 'HK', '02.03', 'Produk Hukum, Proses Penyusunan Keputusan Gubernur'),
(23, 'HK', '03.01', 'Perjanjian Kerjasama, Kerjasama Dalam Negri'),
(24, 'HK', '03.02', 'Perjanjian Kerjasama, Kerjasama Luar Negri'),
(25, 'HK', '04.01', 'Bantuan Hukum, Bantuan Hukum Kasus Perdata'),
(26, 'HK', '04.02', 'Bantuan Hukum, Bantuan Hukum Kasus Pidana'),
(27, 'HK', '04.03', 'Bantuan Hukum, Bantuan Hukum Kasus Peradilan Tata Usaha Negara'),
(28, 'HK', '05.01', 'Telaah Hukum, Telaah Hukum Internal'),
(29, 'HK', '05.02', 'Telaah Hukum, Telaah Hukum Eksternal'),
(30, 'HK', '06', 'Sosialisasi Hukum'),
(31, 'HK', '07.01', 'Dokumentasi Hukum, Kegiatan Pengembangan Dokumentasi Hukum'),
(32, 'HK', '07.02', 'Dokumentasi Hukum, Database Dokumentasi Hukum'),
(33, 'HK', '08', 'Hak Atas Kekayaan Intelektual'),
(34, 'HK', '09.01', 'Penegakan Hukum, Kegiatan Penegakan Peraturan Daerah'),
(35, 'HK', '09.02', 'Penegakan Hukum, Tindak Lanjut Kegiatan Penegakan Hukum'),
(36, 'HK', '10.01', 'Penyidik Pegawai Negri Sipil, Program Pengembangan PPNS'),
(37, 'HK', '10.02', 'Penyidik Pegawai Negeri Sipil, Pembinaan Personal PPNS'),
(38, 'TU', '01.01', 'Persuratan, Pengurusan Surat Masuk'),
(39, 'TU', '01.02', 'Persuratan, Pengurusan Surat Keluar'),
(40, 'TU', '01.03', 'Persuratan, Korespondensi Internal'),
(41, 'TU', '02', 'Penggandaan Surat Masuk'),
(42, 'TU', '03', 'Agenda Kegiatan'),
(43, 'TU', '04', 'Rapat/Rakor/Rakernis'),
(44, 'OT', '01.01', 'Organisasi, Struktur Organisasi'),
(45, 'OT', '01.02', 'Organisasi, Uraian Tugas'),
(46, 'OT', '01.03', 'Organisasi, Analisis Jabatan dan Beban Kerja'),
(47, 'OT', '02', 'Hubungan/Mekanisme Kerja'),
(48, 'OT', '03', 'Ketatalaksanaaan'),
(49, 'PL', '01', 'Analisa Kebutuhan'),
(50, 'PL', '02', 'Tata Ruang'),
(51, 'PL', '03', 'Daftar Perkenalan Mampu'),
(52, 'PL', '04.00', 'Penerimaan/Realisasi Pengadaan, Alat Tulis Kantor'),
(53, 'PL', '04.01', 'Penerimaan/Realisasi Pengadaan, Perlengkapan Kantor'),
(54, 'PL', '04.02', 'Penerimaan/Realisasi Pengadaan, Tanah dan Bangunan'),
(55, 'PL', '04.03', 'Penerimaan/Realisasi Pengadaan, Kendaraan'),
(56, 'PL', '04.04', 'Penerimaan/Realisasi Pengadaan, Instalasi/Jaringan'),
(57, 'PL', '04.05', 'Penerimaan/Realisasi Pengadaan, Peralatan Kearsipan'),
(58, 'PL', '05', 'Penyimpanan/Pergudangan'),
(59, 'PL', '06', 'Distribusi'),
(60, 'PL', '07', 'Pemeliharaan'),
(61, 'PL', '08', 'Inventarisasi'),
(62, 'PL', '09', 'Penghapusan');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbl_disposisi`
--
ALTER TABLE `tbl_disposisi`
  ADD PRIMARY KEY (`id_disposisi`);

--
-- Indeks untuk tabel `tbl_instansi`
--
ALTER TABLE `tbl_instansi`
  ADD PRIMARY KEY (`id_instansi`);

--
-- Indeks untuk tabel `tbl_klasifikasi`
--
ALTER TABLE `tbl_klasifikasi`
  ADD PRIMARY KEY (`id_klasifikasi`);

--
-- Indeks untuk tabel `tbl_sett`
--
ALTER TABLE `tbl_sett`
  ADD PRIMARY KEY (`id_sett`);

--
-- Indeks untuk tabel `tbl_surat_keluar`
--
ALTER TABLE `tbl_surat_keluar`
  ADD PRIMARY KEY (`id_surat`);

--
-- Indeks untuk tabel `tbl_surat_masuk`
--
ALTER TABLE `tbl_surat_masuk`
  ADD PRIMARY KEY (`id_surat`);

--
-- Indeks untuk tabel `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`id_user`);

--
-- Indeks untuk tabel `tb_pencarian`
--
ALTER TABLE `tb_pencarian`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbl_disposisi`
--
ALTER TABLE `tbl_disposisi`
  MODIFY `id_disposisi` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT untuk tabel `tbl_klasifikasi`
--
ALTER TABLE `tbl_klasifikasi`
  MODIFY `id_klasifikasi` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_surat_keluar`
--
ALTER TABLE `tbl_surat_keluar`
  MODIFY `id_surat` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `tbl_surat_masuk`
--
ALTER TABLE `tbl_surat_masuk`
  MODIFY `id_surat` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT untuk tabel `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `id_user` tinyint(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `tb_pencarian`
--
ALTER TABLE `tb_pencarian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
