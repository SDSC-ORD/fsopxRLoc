#' Get Asset id for a px id in order to derive the asset download url
#'
#' @importFrom dplyr %>%
#' @param px_id
#'
#' @return asset_id
#' @noRd
#'
#' @examples get_asset_id('px-x-0102020204_102')
get_asset_id <- function (px_id) {
  fso_base_url <- 'https://www.bfs.admin.ch/asset/de/'
  page_url <- paste0(fso_base_url, px_id)
  asset_id_url <- RCurl::getURLContent(page_url) %>%
    rvest::read_html() %>%
    rvest::html_element(xpath="//meta[@property='og:url']") %>%
    rvest::html_attr("content")
  url_parts <- strsplit(asset_id_url, split = "/")
  asset_id <- sapply(url_parts, tail, 1)
}

#' Get Asset download url for an asset id of a px table
#'
#' @param asset_id
#'
#' @return asset_url
#' @noRd
#'
#' @examples get_asset_url('234556')
get_asset_url <- function (asset_id) {
  fso_asset_url <- 'https://www.bfs.admin.ch/bfsstatic/dam/assets/'
  asset_url <- paste0(fso_asset_url, asset_id, "/master")
}

#' Get Download Url for px id
#'
#' @importFrom dplyr %>%
#' @param px_id
#'
#' @return download_url
#' @export
#'
#' @examples get_asset_id('px-x-0102020204_102')
get_px_download_url <- function(px_id) {
  download_url <- get_asset_id(px_id) %>% get_asset_url()
  return(download_url)
}
