#!/usr/bin/env perl
#Занесение тестовых данных для проверки задачи 21180
# Вызов:
#   perl NAME.pl 

use strict;
use warnings;
use DBI;
use Cwd;
our $dir;
BEGIN {
    $dir = getcwd;
}
#----------------------------------------------------------------------

$| = 1;

my $data_file1 = "$dir/test_countries.txt";
my $data_file2 = "$dir/test_regions.txt";
my $data_file3 = "$dir/test_cities.txt";
my $data_file4 = "$dir/test_team_address.txt";

my $sql1 = qq{COPY acc.tbl_countries (id, name) from '$data_file1' using delimiters ','};
my $sql2 = qq{COPY acc.tbl_regions (id, name, cntr_id) from '$data_file2' using delimiters ','};
my $sql3 = qq{COPY acc.tbl_cities (id, name, rgns_id) from '$data_file3' using delimiters ','};
my $sql4 = qq{COPY wsd.team_address (team_id, address_type_id, region_id, area_id, city_id, zip, value) from '$data_file4' using delimiters ';'};

my $dbh = DBI->connect('dbi:Pg:dbname=ut3;host=localhost',
		       '',
		       '',
		       {AutoCommit => 1},
		      );

my $sth1 = $dbh->prepare($sql1);
$sth1->execute() || die $sth1->errstr;
my $sth2 = $dbh->prepare($sql2);
$sth2->execute() || die $sth2->errstr;
my $sth3 = $dbh->prepare($sql3);
$sth3->execute() || die $sth3->errstr;
my $sth4 = $dbh->prepare($sql4);
$sth4->execute() || die $sth4->errstr;
$dbh->disconnect;

1;

__DATA__

