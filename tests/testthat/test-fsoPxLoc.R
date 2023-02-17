test_that("test that an asset id can be derived form a valid pxid", {
  expect_equal(get_asset_id("px-x-0102020204_102"), "22724379")
})

test_that("test that an asset url can be derived form a valid asset id", {
  expect_equal(get_asset_url("22724379"),
               "https://www.bfs.admin.ch/bfsstatic/dam/assets/22724379/master")
})

test_that("get error if pxid is not valid", {
  expect_error(get_px_download_url("a"))
})

test_that("get download url for valid px id", {
  expect_equal(get_px_download_url("px-x-0102020204_102"),
               "https://www.bfs.admin.ch/bfsstatic/dam/assets/22724379/master")
})
