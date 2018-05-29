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
print "Content-type:text-html\n\n";

my $id = $in{id};

use DBI;
use strict;

my $dbh = DBI->connect("DBI:mysql:database=crud_perl", "root", "");
my $sql = "DELETE FROM user WHERE id='$id' ";
my $sth = $dbh->prepare($sql);
if ($sth->execute()){
  $sth->finish();
  $dbh->commit;
    print "
    <script>alert('Berhasil menghapus data')</script>
    <meta http-equiv='refresh' content='0;url=index.pl'>
    ";
}
