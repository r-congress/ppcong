
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ppcong <img src="man/figures/logo.png" width="160px" align="right" />

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/mkearney/ppcong.svg?branch=master)](https://travis-ci.org/mkearney/ppcong)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/mkearney/ppcong?branch=master&svg=true)](https://ci.appveyor.com/project/mkearney/ppcong)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/ppcong)](https://CRAN.R-project.org/package=ppcong)
[![Codecov test
coverage](https://codecov.io/gh/mkearney/ppcong/branch/master/graph/badge.svg)](https://codecov.io/gh/mkearney/ppcong?branch=master)
<!-- badges: end -->

A simple interface for interacting with [ProPublica’s Congress
API](https://projects.propublica.org/api-docs/congress-api/), which
provides data about current and former members of both chambers of the
U.S. Congress.

## Installation

You can install the released version of ppcong from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("ppcong")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("mkearney/ppcong")
```

## Members

Get “house” data from the “116”th Congress:

``` r
## get and preview house data from 116th congress
h116 <- ppc_members(congress = "116", chamber = "house")
h116
#> # A tibble: 444 x 49
#>    id    title short_title api_uri first_name middle_name last_name suffix date_of_birth
#>    <chr> <chr> <chr>       <chr>   <chr>      <chr>       <chr>     <chr>  <date>       
#>  1 A000… Repr… Rep.        https:… Ralph      <NA>        Abraham   <NA>   1954-09-16   
#>  2 A000… Repr… Rep.        https:… Alma       <NA>        Adams     <NA>   1946-05-27   
#>  3 A000… Repr… Rep.        https:… Robert     B.          Aderholt  <NA>   1965-07-22   
#>  4 A000… Repr… Rep.        https:… Pete       <NA>        Aguilar   <NA>   1979-06-19   
#>  5 A000… Repr… Rep.        https:… Rick       <NA>        Allen     <NA>   1951-11-07   
#>  6 A000… Repr… Rep.        https:… Colin      <NA>        Allred    <NA>   1983-04-15   
#>  7 A000… Repr… Rep.        https:… Justin     <NA>        Amash     <NA>   1980-04-18   
#>  8 A000… Repr… Rep.        https:… Justin     <NA>        Amash     <NA>   1980-04-18   
#>  9 A000… Repr… Rep.        https:… Mark       <NA>        Amodei    <NA>   1958-06-12   
#> 10 A000… Repr… Rep.        https:… Kelly      <NA>        Armstrong <NA>   1976-10-08   
#> # … with 434 more rows, and 40 more variables: gender <chr>, party <chr>,
#> #   leadership_role <chr>, twitter_account <chr>, facebook_account <chr>,
#> #   youtube_account <chr>, govtrack_id <chr>, cspan_id <chr>, votesmart_id <chr>,
#> #   icpsr_id <chr>, crp_id <chr>, google_entity_id <chr>, fec_candidate_id <chr>,
#> #   url <chr>, rss_url <chr>, contact_form <lgl>, in_office <lgl>, cook_pvi <chr>,
#> #   dw_nominate <dbl>, ideal_point <lgl>, seniority <chr>, next_election <chr>,
#> #   total_votes <int>, missed_votes <int>, total_present <int>, last_updated <chr>,
#> #   ocd_id <chr>, office <chr>, phone <chr>, fax <lgl>, state <chr>, district <chr>,
#> #   at_large <lgl>, geoid <chr>, missed_votes_pct <dbl>, votes_with_party_pct <dbl>,
#> #   votes_against_party_pct <dbl>, congress <chr>, chamber <chr>,
#> #   ppc_request_timestamp <dttm>
```

Get “senate” data from the “110”th Congress:

``` r
## get and preview senate data from 110th congress
s110 <- ppc_members(congress = "110", chamber = "senate")
s110
#> # A tibble: 102 x 49
#>    id    title short_title api_uri first_name middle_name last_name suffix date_of_birth
#>    <chr> <chr> <chr>       <chr>   <chr>      <chr>       <chr>     <chr>  <date>       
#>  1 A000… Sena… Sen.        https:… Daniel     K.          Akaka     <NA>   1924-09-11   
#>  2 A000… Sena… Sen.        https:… Lamar      <NA>        Alexander <NA>   1940-07-03   
#>  3 A000… Sena… Sen.        https:… Wayne      A.          Allard    <NA>   1943-12-02   
#>  4 B001… Sena… Sen.        https:… John       <NA>        Barrasso  <NA>   1952-07-21   
#>  5 B000… Sena… Sen.        https:… Max        <NA>        Baucus    <NA>   1941-12-11   
#>  6 B001… Sena… Sen.        https:… Evan       <NA>        Bayh      <NA>   1955-12-26   
#>  7 B000… Sena… Sen.        https:… Robert     F.          Bennett   <NA>   1933-09-18   
#>  8 B000… Sena… Sen.        https:… Joseph     R.          Biden     Jr.    1942-11-20   
#>  9 B000… Sena… Sen.        https:… Jeff       <NA>        Bingaman  <NA>   1943-10-03   
#> 10 B000… Sena… Sen.        https:… Christoph… S.          Bond      <NA>   1939-03-06   
#> # … with 92 more rows, and 40 more variables: gender <chr>, party <chr>,
#> #   leadership_role <lgl>, twitter_account <chr>, facebook_account <chr>,
#> #   youtube_account <chr>, govtrack_id <chr>, cspan_id <chr>, votesmart_id <chr>,
#> #   icpsr_id <chr>, crp_id <chr>, google_entity_id <chr>, fec_candidate_id <chr>,
#> #   url <chr>, rss_url <chr>, contact_form <lgl>, in_office <lgl>, cook_pvi <lgl>,
#> #   dw_nominate <lgl>, ideal_point <lgl>, seniority <chr>, next_election <chr>,
#> #   total_votes <int>, missed_votes <int>, total_present <int>, last_updated <chr>,
#> #   ocd_id <chr>, office <lgl>, phone <lgl>, fax <lgl>, state <chr>, senate_class <chr>,
#> #   state_rank <chr>, lis_id <chr>, missed_votes_pct <dbl>, votes_with_party_pct <dbl>,
#> #   votes_against_party_pct <dbl>, congress <chr>, chamber <chr>,
#> #   ppc_request_timestamp <dttm>
```

## Statements

Get statements released by members of Congress by date

``` r
## get and preview statements from congress on a given day
sts <- ppc_statements("2017-05-08")
sts
#> # A tibble: 228 x 13
#>    url   date  title statement_type member_id congress member_uri name  chamber state
#>    <chr> <chr> <chr> <chr>          <chr>        <int> <chr>      <chr> <chr>   <chr>
#>  1 http… 2017… Enge… Press Release  E000179        115 https://a… Elio… House   NY   
#>  2 http… 2017… Benn… Press Release  B001267        115 https://a… Mich… Senate  CO   
#>  3 http… 2017… Benn… Press Release  B001267        115 https://a… Mich… Senate  CO   
#>  4 http… 2017… Sull… Press Release  S001198        115 https://a… Dan … Senate  AK   
#>  5 http… 2017… Roun… Press Release  R000605        115 https://a… Mike… Senate  SD   
#>  6 http… 2017… Pete… Press Release  P000595        115 https://a… Gary… Senate  MI   
#>  7 http… 2017… Lawm… Press Release  U000039        115 https://a… Tom … Senate  NM   
#>  8 http… 2017… Van … Press Release  V000128        115 https://a… Chri… Senate  MD   
#>  9 http… 2017… Van … Press Release  V000128        115 https://a… Chri… Senate  MD   
#> 10 http… 2017… Van … Press Release  V000128        115 https://a… Chri… Senate  MD   
#> # … with 218 more rows, and 3 more variables: party <chr>, subjects <list>,
#> #   ppc_request_timestamp <dttm>
```

## Votes

Get statements released by members of Congress by date

``` r
## get and preview house data from 116th congress
vts <- ppc_votes()
vts
#> # A tibble: 20 x 29
#>    congress chamber session roll_call source url   vote_uri question question_text
#>       <int> <chr>     <int>     <int> <chr>  <chr> <chr>    <chr>    <chr>        
#>  1      116 Senate        1       347 https… http… https:/… On the … On the Clotu…
#>  2      116 Senate        1       346 https… http… https:/… On the … On the Clotu…
#>  3      116 Senate        1       345 https… http… https:/… On the … On the Clotu…
#>  4      116 Senate        1       344 https… http… https:/… On the … On the Nomin…
#>  5      116 Senate        1       343 https… http… https:/… On the … On the Clotu…
#>  6      116 Senate        1       342 https… http… https:/… On the … On the Clotu…
#>  7      116 Senate        1       341 https… http… https:/… On Pass… On Passage o…
#>  8      116 House         1       609 http:… http… https:/… On Pass… ""           
#>  9      116 House         1       608 http:… http… https:/… On Moti… ""           
#> 10      116 Senate        1       340 https… http… https:/… On the … On the Amend…
#> 11      116 House         1       607 http:… http… https:/… On Agre… ""           
#> 12      116 House         1       606 http:… http… https:/… On Agre… ""           
#> 13      116 House         1       605 http:… http… https:/… On Agre… ""           
#> 14      116 Senate        1       339 https… http… https:/… On the … On the Amend…
#> 15      116 House         1       604 http:… http… https:/… On Agre… ""           
#> 16      116 House         1       603 http:… http… https:/… On Orde… ""           
#> 17      116 House         1       602 http:… http… https:/… On Pass… ""           
#> 18      116 House         1       601 http:… http… https:/… On Moti… ""           
#> 19      116 House         1       600 http:… http… https:/… On Agre… ""           
#> 20      116 House         1       599 http:… http… https:/… On Agre… ""           
#> # … with 20 more variables: description <chr>, vote_type <chr>, date <chr>, time <chr>,
#> #   result <chr>, d_yes <int>, d_no <int>, d_present <int>, d_not_voting <int>,
#> #   d_majority_position <chr>, r_yes <int>, r_no <int>, r_present <int>,
#> #   r_not_voting <int>, r_majority_position <chr>, i_yes <int>, i_no <int>,
#> #   i_present <int>, i_not_voting <int>, ppc_request_timestamp <dttm>
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
s116 <- ppc_members(116, "senate", api_key = "as9d78f6aayd9fy2fq378a9ds876fsas89d7f")
```

Or for the duration of any given session, you can set the API key once
via the `ppc_api_key()` function

``` r
## set as environment variable for the remainder of current session
ppc_api_key("as9d78f6aayd9fy2fq378a9ds876fsas89d7f")
```

If you’d like to set the API key and store it for use in future
sessions, use `set_renv = TRUE`

``` r
## append as environment variable in user's home .Renviron file
ppc_api_key("as9d78f6aayd9fy2fq378a9ds876fsas89d7f", set_renv = TRUE)
```
