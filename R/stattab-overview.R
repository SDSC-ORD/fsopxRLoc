#' make fso overview list on px data cubes
#'
#' @param output_dir where to write the csv output file
#' @param lang language of the list
#' @param force create file even if it already exists
#'
#' @return csv file path of output file
#' @export
#'
#' @examples get_fso_px_cube_list(lang = "en", force = TRUE)
get_fso_px_cube_list <- function(output_dir=getwd(), lang="de", force=FALSE) {
  csv_file_path <- paste0(output_dir, '/', 'px_ids', '-', lang, '.csv')
  if (file.exists(csv_file_path) && !force) {
    print("file was already there: nothing to do")
    return(csv_file_path)
  }
  api_url = paste0('https://www.pxweb.bfs.admin.ch/api/v1/', lang)
  df_input <- jsonlite::fromJSON(api_url)
  df_output <- setNames(data.frame(matrix(ncol = 6, nrow = dim(df_input)[1])), c("level", "table", "title", "description", "updated", "dimensions"))
  df_output['level'] = df_input[, 'dbid']
  write.csv(df_output , file = csv_file_path,
            row.names = FALSE)
  return(csv_file_path)
}


#' enrich px data cube list by adding title and dimension metadata
#'
#' @param file_path csv file path for input and output
#' @param lang language fot the list
#' @param start index to start processing
#' @param end index to end processing
#'
#' @return csv file path of output file
#' @export
#'
#' @examples enrich_fso_px_cube_list("output.csv", lang = "en", start=1, stop=1)
enrich_fso_px_cube_list <- function(file_path, lang="de", start=1, stop=1) {
  df <- read.csv(file_path) %>% tibble::as_tibble(df)
  api_url <- paste0('https://www.pxweb.bfs.admin.ch/api/v1/', lang, '/')
  for (i in start:stop) {
    if (is.na(df[i,]['table'])) {
      print(paste("processing px cube", df[i,]['level']))
      url_table <- paste0(api_url, df[i,]['level'])
      df_table = jsonlite::fromJSON(url_table)
      # assert that the table api returns a data frame of the expected dimensions
      # this is FSO specific
      assertthat::are_equal(dim(df_table), c(1, 4))
      assertthat::are_equal(df_table[1, 'type'], 't')
      url_metadata = paste0(url_table, '/', df_table[1,]['id'])
      metadata <- jsonlite::fromJSON(url_metadata)
      df_metadata = metadata[[2]]
      dimensions <- as.vector(df_metadata['text']) %>% unlist() %>% unname() %>% paste0(collapse = ",")
      df[i,]['table'] <- df_table[1, 'id']
      df[i,]['title'] <- df_table[1, 'text']
      df[i,]['updated'] <- df_table[1, 'updated']
      df[i,]['description'] <- metadata[[1]]
      df[i,]['dimensions'] <- dimensions
    } else {
      print(paste("was already filled. nothing to do for", i))
    }
  }
  write.csv(df , file = file_path, row.names = FALSE)
  return(file_path)
}

#' enrich px data cube list in batches to prevent overloading the api
#'
#' @param file_path csv file path for input and output#'
#' @param lang language fot the list
#' @param start index to start processing
#' @param step size of batches before sleep
#'
#' @return csv file path of output file
#' @export
#'
#' @examples enrich_fso_px_cube_list(file_path = "output.csv")
enrich_fso_px_cube_list_in_batches <- function(file_path, lang='de', start=1, step=1) {
  df <- read.csv(file_path)
  count <- dim(df)[1]
  for(i in seq(start, count, by = step)) {
    enrich_fso_px_cube_list(file_path, lang=lang, start=i, stop=i+step)
    Sys.sleep(10)
  }
}
