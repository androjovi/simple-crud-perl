#! usr/bin/perl




if (length ($ENV{'QUERY_STRING'}) > 0){
      $buffer = $ENV{'QUERY_STRING'};
      @pairs = split(/&/, $buffer);
      foreach $pair (@pairs){
           ($name, $value) = split(/=/, $pair);
           $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
           $in{$name} = $value;
      }
 }
my $id = $in{id};
print "Content-type:text-html\n\n";

use DBI;
use strict;

my $dbh = DBI->connect("DBI:mysql:database=crud_perl", "root", "");
my $sql = "SELECT * FROM user WHERE id = $id";
my $sth = $dbh->prepare($sql);
$sth->execute();


print "
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <title>Perl Tambah data</title>
  </head>
  <body>
  ";
  while ( my @row = $sth->fetchrow_array() ){
    my ($id, $nama,  $telp, $alamat) = @row;
  print "
    <form action='proses_edit.pl' method='post'>
      <input type='text' readonly value='$id' name='id' maxlength='30' placeholder='Masukkan nama anda' required><br><br>
      <input type='text' value='$nama' name='nama' maxlength='30' placeholder='Masukkan nama anda' required><br><br>
      <input type='number' value='$telp' name='telp' maxlength='12' placeholder='Masukkan nomor telepon anda' required><br><br>
      <input type='text' value='$alamat' name='alamat' maxlength='50' placeholder='Masukkan alamat anda' required><br><br>
      <button type='submit'>Submit</button>
      <button type='reset'>Reset</button>
  </body>
</html>
";
}
