
# fsopxRLoc

<!-- badges: start -->
<!-- badges: end -->

This repo relates to [STAT-TAB - interactive tables (FSO)](https://www.pxweb.bfs.admin.ch/pxweb/en/)
On the above page you find all interactive tables of the FSO together with their access and 
download urls. 

These tables are identified by a `px_id` and they us a 
[px file format](https://www.scb.se/en/services/statistical-programs-for-px-files/px-file-format/)

This package helps you with the flowing tasks:

- decide whether a download url belongs to a px file:

```
check_px_cube_url('https://www.pxweb.bfs.admin.ch/DownloadFile.aspx?file=px-x-0102020207_102')
```

- download a px cube from its px_id: optional include the location, where the file should be downloaded to

```
download_px_cube('px-x-0102020207_102')
download_px_cube('px-x-0102020207_102', '/tmp')
```

- get download url for a px_id

```
get_fso_px_download_url('px-x-0102020207_102')
```

## Installation

You can install the development version of fsopxRLoc from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("SDSC-ORD/fsopxRLoc")
library(fsopxRLoc)
```
