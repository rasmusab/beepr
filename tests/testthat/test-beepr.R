# Most of these tests are a bit silly in that they only test that the sounds play without error.
# However, these tests are chiefly a way to play all the sounds to make sure they sound OK.
# Sys.sleep(...) is sprinkled in to give the sounds time to play.

# As these tests play sounds, they can't be run on CRAN (and many CIs), as no 
# sound systems are available there.
skip_on_cran()
skip_on_ci()

test_that("all the sounds play without error/warnings/messages", {
  expect_no_condition(beep(1))
  Sys.sleep(01.10 + 0.5)
  expect_no_condition(beep(2))
  Sys.sleep(01.44 + 0.5)
  expect_no_condition(beep(3))
  Sys.sleep(03.90 + 0.5)
  expect_no_condition(beep(4))
  Sys.sleep(01.41 + 0.5)
  expect_no_condition(beep(5))
  Sys.sleep(01.75 + 0.5)
  expect_no_condition(beep(6))
  Sys.sleep(02.43 + 0.5)
  expect_no_condition(beep(7))
  Sys.sleep(01.31 + 0.5)
  expect_no_condition(beep(8))
  Sys.sleep(05.84 + 0.5)
  expect_no_condition(beep(9))
  Sys.sleep(01.44 + 0.5)
  expect_no_condition(beep(10))
  Sys.sleep(00.74 + 0.5)
  expect_no_condition(beep(11))
  Sys.sleep(01.25 + 0.5)
})

test_that("both beep(1) and beep('ping') works equally well", {
  expect_no_condition(beep(1))
  Sys.sleep(01.10 + 0.5)
  expect_no_condition(beep("ping"))
  Sys.sleep(01.10 + 0.5)
})

test_that("random sounds play without error/warnings/messages", {
  expect_no_condition(beep(0))
  Sys.sleep(05.84 + 0.5)
  expect_no_condition(beep(99))
  Sys.sleep(05.84 + 0.5)
  expect_warning(beep("rnd"))
  Sys.sleep(05.84 + 0.5)
})

test_that("the expr argument to beeper is run", {
  x <- 1 
  expect_no_condition(beep(1, expr = x <- 2 ))
  Sys.sleep(01.10 + 0.5)
  expect_equal(x, 2)
})

test_that("the no-sound beep plays without error/warnings/messages", {
  expect_no_condition(beep(-1))
  expect_no_condition(beep("none"))
})

test_that("the beep_on_error function works", {
  expect_no_error(beep_on_error(log(1)))
  expect_error(beep_on_error(log("banana")))
  Sys.sleep(01.10 + 0.5)
})
