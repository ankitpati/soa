package Student;

use strict;
use warnings;

use base 'Class::DBI';

__PACKAGE__->connection (qw( dbi:mysql:soa soa eihu2Ahh7xaeKoow9RoeGh9e ));
__PACKAGE__->table      ('student');
__PACKAGE__->columns    (All => qw( prn fname lname dob branch ));

1;
