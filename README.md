
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ppc

<!-- badges: start -->

<!-- badges: end -->

A simple interface for interacting with [ProPublica’s Congress
API](https://projects.propublica.org/api-docs/congress-api/), which
provides data about current and former members of both chambers of the
U.S. Congress.

## Installation

You can install the released version of ppc from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("ppc")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
remotes::install_github("mkearney/ppc")
```

## Examples

Get “house” data from the “116”th Congress:

``` r
## get and preview house data from 116th congress
h116 <- pp_congress(congress = "116", chamber = "house")
h116
#> # A tibble: 444 x 49
#>    id    title short_title api_uri first_name middle_name last_name suffix
#>    <chr> <chr> <chr>       <chr>   <chr>      <chr>       <chr>     <chr> 
#>  1 A000… Repr… Rep.        https:… Ralph      <NA>        Abraham   <NA>  
#>  2 A000… Repr… Rep.        https:… Alma       <NA>        Adams     <NA>  
#>  3 A000… Repr… Rep.        https:… Robert     B.          Aderholt  <NA>  
#>  4 A000… Repr… Rep.        https:… Pete       <NA>        Aguilar   <NA>  
#>  5 A000… Repr… Rep.        https:… Rick       <NA>        Allen     <NA>  
#>  6 A000… Repr… Rep.        https:… Colin      <NA>        Allred    <NA>  
#>  7 A000… Repr… Rep.        https:… Justin     <NA>        Amash     <NA>  
#>  8 A000… Repr… Rep.        https:… Justin     <NA>        Amash     <NA>  
#>  9 A000… Repr… Rep.        https:… Mark       <NA>        Amodei    <NA>  
#> 10 A000… Repr… Rep.        https:… Kelly      <NA>        Armstrong <NA>  
#> # … with 434 more rows, and 41 more variables: date_of_birth <date>,
#> #   gender <chr>, party <chr>, leadership_role <chr>,
#> #   twitter_account <chr>, facebook_account <chr>, youtube_account <chr>,
#> #   govtrack_id <chr>, cspan_id <chr>, votesmart_id <chr>, icpsr_id <chr>,
#> #   crp_id <chr>, google_entity_id <chr>, fec_candidate_id <chr>,
#> #   url <chr>, rss_url <chr>, contact_form <lgl>, in_office <lgl>,
#> #   cook_pvi <chr>, dw_nominate <dbl>, ideal_point <lgl>, seniority <chr>,
#> #   next_election <chr>, total_votes <int>, missed_votes <int>,
#> #   total_present <int>, last_updated <chr>, ocd_id <chr>, office <chr>,
#> #   phone <chr>, fax <lgl>, state <chr>, district <chr>, at_large <lgl>,
#> #   geoid <chr>, missed_votes_pct <dbl>, votes_with_party_pct <dbl>,
#> #   votes_against_party_pct <dbl>, congress <chr>, chamber <chr>,
#> #   pp_request_timestamp <dttm>
```

Get “senate” data from the “110”th Congress:

``` r
## get and preview senate data from 110th congress
s110 <- pp_congress(congress = "110", chamber = "senate")
s110
#> # A tibble: 102 x 49
#>    id    title short_title api_uri first_name middle_name last_name suffix
#>    <chr> <chr> <chr>       <chr>   <chr>      <chr>       <chr>     <chr> 
#>  1 A000… Sena… Sen.        https:… Daniel     K.          Akaka     <NA>  
#>  2 A000… Sena… Sen.        https:… Lamar      <NA>        Alexander <NA>  
#>  3 A000… Sena… Sen.        https:… Wayne      A.          Allard    <NA>  
#>  4 B001… Sena… Sen.        https:… John       <NA>        Barrasso  <NA>  
#>  5 B000… Sena… Sen.        https:… Max        <NA>        Baucus    <NA>  
#>  6 B001… Sena… Sen.        https:… Evan       <NA>        Bayh      <NA>  
#>  7 B000… Sena… Sen.        https:… Robert     F.          Bennett   <NA>  
#>  8 B000… Sena… Sen.        https:… Joseph     R.          Biden     Jr.   
#>  9 B000… Sena… Sen.        https:… Jeff       <NA>        Bingaman  <NA>  
#> 10 B000… Sena… Sen.        https:… Christoph… S.          Bond      <NA>  
#> # … with 92 more rows, and 41 more variables: date_of_birth <date>,
#> #   gender <chr>, party <chr>, leadership_role <lgl>,
#> #   twitter_account <chr>, facebook_account <chr>, youtube_account <chr>,
#> #   govtrack_id <chr>, cspan_id <chr>, votesmart_id <chr>, icpsr_id <chr>,
#> #   crp_id <chr>, google_entity_id <chr>, fec_candidate_id <chr>,
#> #   url <chr>, rss_url <chr>, contact_form <lgl>, in_office <lgl>,
#> #   cook_pvi <lgl>, dw_nominate <lgl>, ideal_point <lgl>, seniority <chr>,
#> #   next_election <chr>, total_votes <int>, missed_votes <int>,
#> #   total_present <int>, last_updated <chr>, ocd_id <chr>, office <lgl>,
#> #   phone <lgl>, fax <lgl>, state <chr>, senate_class <chr>,
#> #   state_rank <chr>, lis_id <chr>, missed_votes_pct <dbl>,
#> #   votes_with_party_pct <dbl>, votes_against_party_pct <dbl>,
#> #   congress <chr>, chamber <chr>, pp_request_timestamp <dttm>
```

## API Key

Use of the [ProPublica
API](https://projects.propublica.org/api-docs/congress-api/) requires a
valid key, which you can obtain by completing the form found at the
following URL:
<https://www.propublica.org/datastore/api/propublica-congress-api>

Once you’ve obtained an API key, you can either include it in every
request, e.g.,

``` r
## include API key in request
s116 <- pp_congress(116, "senate", api_key = "as9d78f6aayd9fy2fq378a9ds876fsas89d7f")
```

Or for the duration of any given session, you can set the API key once
via the `pp_api_key()` function

``` r
## set as environment variable for the remainder of current session
pp_api_key("as9d78f6aayd9fy2fq378a9ds876fsas89d7f")
```

If you’d like to set the API key and store it for use in future
sessions, use `set_renv = TRUE`

``` r
## append as environment variable in user's home .Renviron file
pp_api_key("as9d78f6aayd9fy2fq378a9ds876fsas89d7f", set_renv = TRUE)
```
