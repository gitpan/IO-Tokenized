package IO::Tokenized::File;
use strict;
use base qw(IO::Tokenized IO::File);
use vars qw($VERSION);

use Carp;

$VERSION = '0.04';


# new has the following synopsis:
# IO::Tokenized::File->new([$tokens [,$filename]])

sub new {
  my $class = shift;
  my ($filename,@tokens) = @_;
  my $self = IO::Tokenized->new();
  bless $self,$class;
  $self->setparser(@tokens) if @tokens;
  $self->open($filename,"r") if defined $filename;
  return $self;
}

# redefine so that only opening for input is allowed
sub open {
  my $self = shift;
  my ($filename) = @_; #silently ignore other parameters
  $self->SUPER::open($filename,"r");
}

1;

__END__

=head1 NAME

IO::Tokenized::File - 

=head1 SYNOPSIS

  my $fh = IO::Tokenized::File->new();
  $fh->setparser([num => qr/\d+/],
                 [ident => qr/[a-z_][a-z0-9_]],
                 [op => qr![+*/-]!,\&opname]);

  $fh->open('tokenfile') || die "Can't open 'tokenfile': $1";
  
  while ($t = $fh->gettoken()) {
    ... do something smart...
  }

  $fh->close();


=head1 DESCRIPTION

C<IO::Tokenized::File> adds the methods provided by C<IO::Tokenized> to 
C<IO::File> objects. See L<IO::Tokenized> for details about how the tokens are 
specified and returned.


=head1 SEE ALSO

L<IO::Tokenized> and L<IO::File>.


=head1 AUTHOR

Leo Cacciari, E<lt>hobbit@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Leo Cacciari

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

