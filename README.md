
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
#>   id    title short_title api_uri first_name middle_name last_name suffix date_of_birth
#>   <chr> <chr> <chr>       <chr>   <chr>      <chr>       <chr>     <chr>  <date>       
#> 1 A000… Repr… Rep.        https:… Ralph      <NA>        Abraham   <NA>   1954-09-16   
#> 2 A000… Repr… Rep.        https:… Alma       <NA>        Adams     <NA>   1946-05-27   
#> 3 A000… Repr… Rep.        https:… Robert     B.          Aderholt  <NA>   1965-07-22   
#> 4 A000… Repr… Rep.        https:… Pete       <NA>        Aguilar   <NA>   1979-06-19   
#> 5 A000… Repr… Rep.        https:… Rick       <NA>        Allen     <NA>   1951-11-07   
#> # … with 439 more rows, and 40 more variables: gender <chr>, party <chr>,
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
#>   id    title short_title api_uri first_name middle_name last_name suffix date_of_birth
#>   <chr> <chr> <chr>       <chr>   <chr>      <chr>       <chr>     <chr>  <date>       
#> 1 A000… Sena… Sen.        https:… Daniel     K.          Akaka     <NA>   1924-09-11   
#> 2 A000… Sena… Sen.        https:… Lamar      <NA>        Alexander <NA>   1940-07-03   
#> 3 A000… Sena… Sen.        https:… Wayne      A.          Allard    <NA>   1943-12-02   
#> 4 B001… Sena… Sen.        https:… John       <NA>        Barrasso  <NA>   1952-07-21   
#> 5 B000… Sena… Sen.        https:… Max        <NA>        Baucus    <NA>   1941-12-11   
#> # … with 97 more rows, and 40 more variables: gender <chr>, party <chr>,
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
#>   url   date  title statement_type member_id congress member_uri name  chamber state party
#>   <chr> <chr> <chr> <chr>          <chr>        <int> <chr>      <chr> <chr>   <chr> <chr>
#> 1 http… 2017… Enge… Press Release  E000179        115 https://a… Elio… House   NY    D    
#> 2 http… 2017… Benn… Press Release  B001267        115 https://a… Mich… Senate  CO    D    
#> 3 http… 2017… Benn… Press Release  B001267        115 https://a… Mich… Senate  CO    D    
#> 4 http… 2017… Sull… Press Release  S001198        115 https://a… Dan … Senate  AK    R    
#> 5 http… 2017… Roun… Press Release  R000605        115 https://a… Mike… Senate  SD    R    
#> # … with 223 more rows, and 2 more variables: subjects <list>,
#> #   ppc_request_timestamp <dttm>
```

## Votes

Get statements released by members of Congress by date

``` r
## get and preview congressional votes information
vts <- ppc_votes("both")
vts
#> # A tibble: 20 x 29
#>   congress chamber session roll_call source url   vote_uri question question_text
#>      <int> <chr>     <int>     <int> <chr>  <chr> <chr>    <chr>    <chr>        
#> 1      116 House         1       624 http:… http… https:/… On Pass… ""           
#> 2      116 House         1       623 http:… http… https:/… On Moti… ""           
#> 3      116 House         1       622 http:… http… https:/… On Agre… ""           
#> 4      116 House         1       621 http:… http… https:/… On Agre… ""           
#> 5      116 House         1       620 http:… http… https:/… On Agre… ""           
#> # … with 15 more rows, and 20 more variables: description <chr>, vote_type <chr>,
#> #   date <chr>, time <chr>, result <chr>, d_yes <int>, d_no <int>, d_present <int>,
#> #   d_not_voting <int>, d_majority_position <chr>, r_yes <int>, r_no <int>,
#> #   r_present <int>, r_not_voting <int>, r_majority_position <chr>, i_yes <int>,
#> #   i_no <int>, i_present <int>, i_not_voting <int>, ppc_request_timestamp <dttm>
```

## Bills

Search for bills in Congress

``` r
## get and preview congressional bills information
hc_bls <- ppc_bills("health care")
hc_bls
#> # A tibble: 20 x 34
#>   bill_id bill_slug bill_type number bill_uri title short_title sponsor_title sponsor_id
#>   <chr>   <chr>     <chr>     <chr>  <chr>    <chr> <chr>       <chr>         <chr>     
#> 1 hr4863… hr4863    hr        H.R.4… https:/… To p… United Sta… Rep.          W000187   
#> 2 s2860-… s2860     s         S.2860 https:/… A bi… A bill to … Sen.          L000575   
#> 3 hres70… hres703   hres      H.RES… https:/… "Sup… "Supportin… Rep.          R000602   
#> 4 hres70… hres704   hres      H.RES… https:/… Expr… "Expressin… Rep.          S001206   
#> 5 sres41… sres415   sres      S.RES… https:/… A re… A resoluti… Sen.          W000817   
#> # … with 15 more rows, and 26 more variables: sponsor_name <chr>, sponsor_state <chr>,
#> #   sponsor_party <chr>, sponsor_uri <chr>, gpo_pdf_uri <lgl>, congressdotgov_url <chr>,
#> #   govtrack_url <chr>, introduced_date <chr>, active <lgl>, last_vote <chr>,
#> #   house_passage <lgl>, senate_passage <lgl>, enacted <lgl>, vetoed <lgl>,
#> #   cosponsors <int>, cosponsors_by_party$D <int>, $R <int>, committees <chr>,
#> #   committee_codes <list>, subcommittee_codes <list>, primary_subject <chr>,
#> #   summary <chr>, summary_short <chr>, latest_major_action_date <chr>,
#> #   latest_major_action <chr>, ppc_request_timestamp <dttm>
```

## Committees

Get lists of congressional committees

``` r
## get and preview committees information for Senators in 115th Congress
cmt <- ppc_committees("115", chamber = "senate")
cmt
#> # A tibble: 21 x 13
#>   id    name  chamber url   api_uri chair chair_id chair_party chair_state chair_uri
#>   <chr> <chr> <chr>   <chr> <chr>   <chr> <chr>    <chr>       <chr>       <chr>    
#> 1 SSAF  Comm… Senate  http… https:… Pat … R000307  R           KS          https://…
#> 2 SSAP  Comm… Senate  http… https:… Thad… C000567  R           MS          https://…
#> 3 SSAS  Comm… Senate  http… https:… John… M000303  R           AZ          https://…
#> 4 SSBK  Comm… Senate  http… https:… Mich… C000880  R           ID          https://…
#> 5 SSCM  Comm… Senate  http… https:… John… T000250  R           SD          https://…
#> # … with 16 more rows, and 3 more variables: ranking_member_id <chr>,
#> #   subcommittees <list>, ppc_request_timestamp <dttm>
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
