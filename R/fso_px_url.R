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
  is_px_cube_url <- check_px_cube_url(download_url)
  if (!is_px_cube_url) {
    stop("This id does not belong to a px cube file, check https://www.bfs.admin.ch/bfs/en/home/services/recherche/stat-tab-online-data-search.html for
         valid px cube ids.")
  }
  return(download_url)
}
