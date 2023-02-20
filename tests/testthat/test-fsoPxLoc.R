test_that("test px file can be downloaded to a default path for a px_id", {
  px_id <- "px-x-0102020207_102"
  download_path <- paste0(tempdir(), '/', 'px-x-0102020207_102.px')
  expect_equal(download_px_cube(px_id), download_path)
})

test_that("test px file can be downloaded to a local path of choice", {
  px_id <- "px-x-0102020207_102"
  local_dir <- "/tmp"
  download_path <- "/tmp/px-x-0102020207_102.px"
  expect_equal(download_px_cube(px_id, local_dir),
               download_path)
})

test_that("test fso asset url can be received for px_id", {
  px_id <- "px-x-0102020207_102"
  fso_px_download_url <- "https://www.pxweb.bfs.admin.ch/DownloadFile.aspx?file=px-x-0102020207_102"
  expect_equal(get_fso_px_download_url(px_id),
               fso_px_download_url)
})

test_that("test that valid px cube is detected from url", {
  px_download_url <- "https://www.pxweb.bfs.admin.ch/DownloadFile.aspx?file=px-x-0102020207_102"
  expect_equal(check_px_cube_url(px_download_url), TRUE)
})

test_that("test that invalid px cube is detected from url", {
  px_download_url <- "https://www.bfs.admin.ch/bfsstatic/dam/assets/24065531/master"
  expect_equal(check_px_cube_url(px_download_url), FALSE)
})

test_that("test error will be raised if px id is invalid and belongs to a non px file", {
  url <- 'https://www.pxweb.bfs.admin.ch/DownloadFile.aspx?file=a'
  expect_error(download_px_cube(url))
})
