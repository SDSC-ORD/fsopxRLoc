#' Get pxt download url for px id
#'
#' @param px_id identifier for px cube
#'
#' @return download_url
#' @export
#'
#' @examples get_fso_px_download_url('px-x-0102020207_102')
get_fso_px_download_url <- function(px_id) {
  fso_px_url <- 'https://www.pxweb.bfs.admin.ch/DownloadFile.aspx?file='
  download_url <- paste0(fso_px_url, px_id)
  check_px_cube_url(download_url)
  return(download_url)
}
