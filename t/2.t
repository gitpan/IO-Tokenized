# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

my @expected;
BEGIN {
  @expected = ([ident => 'abc'],
	       [op => 'plus'],
	       [num => 123],
	       [ident => 'azt123']);
};
use Test::More;
use IO::Tokenized::File;
plan tests=> 1 + 2 * @expected + 1;


my %opnames = qw(* times + plus - minus / divide);
sub opname {
  $opnames{$_[0]};
}


ok($FH = IO::Tokenized::File->new('t/t2.txt',
				  [num => qr/\d+/],
				  [ident => qr/[a-z_]\w*/i],
				  [op => qr![*/+-]!,\&opname]
				 ),
   'creation');

foreach my $r (@expected) {
  my $t = $FH->gettoken();
  is ($t->[0],$r->[0],'token equality');
  my $op = $r->[0] eq 'num' ? '==' : 'eq';
  cmp_ok($t->[1],$op,$r->[1],'value equalty');
}
ok($FH->eof(),'eof');
