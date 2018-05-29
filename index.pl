#! /usr/bin/perl
use DBI;
use strict;

my $driver = "mysql";
my $database = "crud_perl";
my $dsn = "DBI:$driver:database=$database";
my $userid = "root";
my $passwd = "";

my $dbh = DBI->connect($dsn, $userid, $passwd); # Buat koneksi ke database

print "Content-type:text-html\n\n";
print "
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <title>Learn perl from zero</title>
  </head>
  <body>
  <table border='1'>
    <thead>
      <tr>
        <td>NO</td>
        <td>Nama</td>
        <td>Telepon</td>
        <td>Alamat</td>
        <td>Aksi</td>
      </tr>
    </thead>
    <tbody>
  ";
my $sql = "SELECT * FROM user";
my $sth = $dbh->prepare($sql);
$sth->execute(); #Jalankan query
while (my @row = $sth->fetchrow_array()){ #buat looping row dari database
  my ($id, $nama, $telp, $alamat) = @row;
print "
        <tr>
          <td>$id</td>
          <td>$nama</td>
          <td>$telp</td>
          <td>$alamat</td>
          <td>  <a href='form_edit.pl?id=$id'>Edit</a>&nbsp;&nbsp;<a href='hapus_data.pl?id=$id' onclick='return hapus_confirm()'>Hapus</a>
        </tr>
     ";
  }
print "
      </tbody>
    </table>
    </br>
    <a href='form_tambah.html'>Tambah data</a>
  </body>
  <script>
  function hapus_confirm(){
    msg = 'Apa anda yakin untuk menghapus data ?'
    agree = confirm(msg)
    if (agree){
      return true
    }else{
      return false
    }
  }
  </script>
</html>
";
