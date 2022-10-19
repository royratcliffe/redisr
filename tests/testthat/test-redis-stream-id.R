test_that("as.POSIXct.redis_stream_id works", {
  expect_equal(as.POSIXct(as.redis_stream_id.character("0"), tz = "GMT"),
               as.POSIXct("1970-01-01", tz = "GMT"))
})
