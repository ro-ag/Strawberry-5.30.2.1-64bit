use strict;
use warnings;
use Data::Dumper;
use Modern::Perl;

my $VERSION = 1.0;
use constant MAX_RESULTS => 97;
use constant DEBUG => 1 ;
 

	# Convert :: to spaces so we dont crash request :)
	my $query = 'Padre';
	$query =~ s/::/ /g;

	# Create an array of query keywords that are separated by spaces
	my @query = split( /\s+/, $query );

	# The distribution we do not want in our search

	my @ROGUE_DISTRIBUTIONS = qw(kurila perl_debug perl-5.005_02+apache1.3.3+modperl pod2texi perlbench spodcxx);
    
	# Create String Search
	my $criteria = '('.join ' AND ', @query.' )' ;	
	my $exclude = 'AND NOT ('.join ' OR ', @ROGUE_DISTRIBUTIONS.' )' ;

	# The ElasticSearch query in Perl

	my %payload = (
		query => {
			query_string => {
				query  => "$criteria AND (status:latest) AND (indexed:true) $exclude",
				fields => ["distribution","documentation.camelcase", "documentation.analyzed","author" ],
				analyze_wildcard => 'true',
			}
		},
		sort => [
			{   "_score"      => {},
				author        => { order => "asc" },
				distribution  => { order => "asc" },
				documentation => { order => "asc" }
			}
		],
		track_scores => 1,
		fields => [qw(documentation release author distribution)],
		size   => MAX_RESULTS,
	);

	# Convert ElasticSearch Perl query to a JSON request
	require JSON::XS;
	my $json_request = JSON::XS::encode_json( \%payload );

	# POST the json request to api.metacpan.org
	require LWP::UserAgent;
	my $ua = LWP::UserAgent->new( agent => "Padre/$VERSION" );
	$ua->timeout(10);
	$ua->env_proxy ;

	my $response = $ua->post(
		'https://fastapi.metacpan.org/v1/file/_search',
		Content => $json_request,
	);

	#unless ( $response->is_success ) {
		printf( "Got '%s' from metacpan.org", $response->status_line ) 
			if DEBUG;
	#}

	# Decode json response then cleverly map it for the average joe :)
	my $data = JSON::XS::decode_json( $response->decoded_content );


	my @results = map { $_->{fields} } @{ $data->{hits}->{hits} || [] }; 
    
	print Dumper \@results;