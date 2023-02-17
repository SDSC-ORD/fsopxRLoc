
# fsopxRLoc

<!-- badges: start -->
<!-- badges: end -->

This repo relates to [STAT-TAB - interactive tables (FSO)](https://www.pxweb.bfs.admin.ch/pxweb/en/)
On the above page you find all interactive tables of the FSO together with their access and 
download urls. 

These tables are identified by a `px_id` and they us a 
[px file format](https://www.scb.se/en/services/statistical-programs-for-px-files/px-file-format/)

In many cases you know the `px_id` such as when you find that dataset on 
[opendata.swiss](https://opendata.swiss/de/dataset/monatlicher-bruttolohn-nach-ausbildung/resource/ec658e42-315b-4174-a560-2b9dfaf6c38e)
It is then of interest to derive the download url for that px file in a computational way from its `px_id`.

This R package can help you with this task.

## Installation

You can install the development version of fsopxRLoc from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("SDSC-ORD/fsopxRLoc")
```

## Example

You derive the download url by providing the `px_id`:

``` r
library(fsopxRLoc)
get_px_download_url("px-x-0102020204_102")
```
