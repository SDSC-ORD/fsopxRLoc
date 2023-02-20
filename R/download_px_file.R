#' Download px cube file for px id into a local directory
#'
#' @import httr
#' @importFrom utils download.file
#'
#' @param download_url url to download from
#' @param destfile file path to download the file to
#'
#' @return downloaded_file
#' @noRd
#'
#' @examples download_file_from_url('https://www.pxweb.bfs.admin.ch/DownloadFile.aspx?file=px-x-0102020207_102', '/tmp/')
download_file_from_url <- function(download_url, destfile) {
  tryCatch(
    {
      file <- GET(download_url)
      file_size <- headers(file)$`content-length`
      rc <- download.file(download_url, destfile=destfile)
      if (rc != 0) {
        stop("File could not be downloaded")
      }
      if (file.size(destfile) != file_size) {
        stop("Downloaded file has not the expected size")
      }
      downloaded_file <- destfile
      return(downloaded_file)
    },
    error = function(error_message) {
      stop(error_message)
    },
    warning = function(warning_message) {
      stop(warning_message)
    }
  )
}


#' Download px cube file for px id into a local directory
#'
#' @param px_id px identification number on the fso website
#' @param local_dir optional defaults to tempdir()
#'
#' @return download_path
#' @export
#'
#' @examples download_px_cube('px-x-0102020207_102', '/tmp')
#'           download_px_cube('px-x-0102020207_102')
download_px_cube <- function(px_id, local_dir=tempdir()) {
  download_path <- paste0(local_dir, '/', px_id, '.px')
  download_url <- get_fso_px_download_url(px_id)
  tryCatch(
    {
      is_px_cube_url <- check_px_cube_url(download_url)
      if (!is_px_cube_url) {
        stop("Not a px cube. Therefore download was not executed.")
      }
      download_path <- download_file_from_url(download_url, download_path)
      return(download_path)
    },
    error = function(error_message) {
      stop(error_message)
    },
    warning = function(warning_message) {
      stop(warning_message)
    }
  )
}


