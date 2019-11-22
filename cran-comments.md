## Test environments
* local R installation, R 3.6.1
* ubuntu 16.04 (on travis-ci), R 3.6.1
* win-builder (devel)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

------

## Previous submission #1

> Thanks, please write package names, software names and API names
> ('Congress') in single quotes in Title and Description.

This has been fixed in DESCRIPTION

## Previous submission #2

>Please add small executable examples in your Rd-files to illustrate the
>use of the exported function but also enable automatic testing.

Examples have been added for all exported functions, but since these calls require
API keys, they are wrapped with dontrun{}. Automated testing has been configured
however via Travis-CI and AppVeyor. 

>Please add \value to .Rd files that are not data files and explain the
>functions results in the documentation.

Basic descriptions of return values have been added to all exported functions

## Previous submission #3

> Thanks, please write package names, software names and API names
> ('Congress') in single quotes in Title and Description.

This has now been fixed in both DESCRIPTION and title
