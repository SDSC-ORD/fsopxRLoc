#' Check download url whether it is a px cube
#'
#' @importFrom dplyr %>%
#' @param px_download_url url to download a px cube
#'
#' @return file_is_px_axis_file
#' @export
#'
#' @examples check_px_cube_url('https://www.pxweb.bfs.admin.ch/DownloadFile.aspx?file=px-x-0102020207_102')
check_px_cube_url <- function(px_download_url) {
  tryCatch(
    {
      lines <- readr::read_lines(px_download_url,  n_max =5)
      keywords <- strsplit(lines, split='\\=') %>%
        sapply(getElement, 1)
      file_is_px_axis_file <- ('AXIS-VERSION' %in% keywords)
      return(file_is_px_axis_file)
    },
    error = function(error_message) {
      stop(error_message)
    },
    warning = function(warning_message) {
      stop(warning_message)
    }
  )
}
