print "Content-type:text/html\r\n\r\n";

use CGI::Carp;
use CGI;

local ($buffer, @pairs, $pair, $name, $value, %FORM);

# Read in text
$ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
if ($ENV{'REQUEST_METHOD'} eq "POST"){
   read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
} else {
   $buffer = $ENV{'QUERY_STRING'};
}

# Split information into name/value pairs

    @pairs = split(/&/, $buffer);
    foreach $pair (@pairs){
    ($name, $value) = split(/=/, $pair);
    $value =~ tr/+/ /;
    $value =~ s/%(..)/pack("C", hex($1))/eg;
    $FORM{$name} = $value;
    }

my $id = $FORM{id};
my $nama = $FORM{nama};
my $alamat = $FORM{alamat};
my $telp = $FORM{telp};

use DBI;
use strict;

my $dbh = DBI->connect("DBI:mysql:database=crud_perl", "root", "");
my $sql = "UPDATE user SET id='$id', nama='$nama', alamat='$alamat', telp='$telp' WHERE id='$id' ";
my $sth = $dbh->prepare($sql);
if ($sth->execute()){
  print "
  <script>alert('Berhasil mengubah data')</script>
  <meta http-equiv='refresh' content='0; url=index.pl'>
  ";
$sth->finish();
$dbh->commit();
}else{
  print "GAGAL";
}
