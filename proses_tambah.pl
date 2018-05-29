#! usr/bin/perl
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

my $nama    = $FORM{nama};
my $telp    = $FORM{telp};
my $alamat  = $FORM{alamat};

use DBI;
use strict;

my $dsn = "DBI:mysql:database=crud_perl";
my $user = "root";
my $passwd = "";


my $dbh = DBI->connect($dsn, $user, $passwd);
my $sth = $dbh->prepare("INSERT INTO user VALUES('', '$nama', '$telp', '$alamat')");
if ($sth->execute()){
$sth->finish();
$dbh->commit;
  print "
  <script>alert('Berhasil memasukkan data')</script>
  <meta http-equiv='refresh' content='0;url=index.pl'>
  ";
}
