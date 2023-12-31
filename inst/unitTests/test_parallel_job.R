## Test functions present in the parallel_job.R file

### {{{ --- Test setup ---

if(FALSE) {
    library( "RUnit" )
    library( "metagene" )
}

### }}}

if (.Platform$OS.type == "unix") {
###################################################
## Test the Parallel_Job$new() function (initialize)
###################################################

## Invalid cores numeric values - zero
test.parallel_job_initialize_zero_core_number <- function() {
    obs <- tryCatch(metagene:::Parallel_Job$new(cores = 0),
                    error = conditionMessage)
    exp <- "cores must be positive numeric or BiocParallelParam instance."
    checkIdentical(obs, exp)
}

## Invalid cores numeric values - negative value
test.parallel_job_initialize_negative_core_number <- function() {
    obs <- tryCatch(metagene:::Parallel_Job$new(cores = -1),
                    error = conditionMessage)
    exp <- "cores must be positive numeric or BiocParallelParam instance."
    checkIdentical(obs, exp)
}

## Invalid cores non-numeric values - string
test.parallel_job_initialize_string_core_number <- function() {
    obs <- tryCatch(metagene:::Parallel_Job$new(cores = "1"),
                    error = conditionMessage)
    exp <- "cores must be positive numeric or BiocParallelParam instance."
    checkIdentical(obs, exp)
}

###################################################
## Test the Parallel_Job$launch_job() function
###################################################

### Note: launch_job is a wrapper to bplapply, so the validity checks are done
###       by the bplapply function. They won't be tested here.

## Valid case, single core
test.parallel_job_launch_job_valid_single_core <- function() {
    parallel_job <- metagene:::Parallel_Job$new(cores = 1)
    obs <- parallel_job$launch_job(1:100, median)
    exp <- lapply(1:100, median)
    checkIdentical(obs, exp)
}

## Valid case, multiple cores
test.parallel_job_launch_job_valid_multiple_core <- function() {
    parallel_job <- metagene:::Parallel_Job$new(cores = 2)
    obs <- parallel_job$launch_job(1:100, median)
    exp <- lapply(1:100, median)
    checkIdentical(obs, exp)
}

###################################################
## Test the Parallel_Job$get_core_count() function
###################################################

## Valid case, single core
test.parallel_job_get_core_count_valid_single_core <- function() {
    parallel_job <- metagene:::Parallel_Job$new(cores = 1)
    obs <- parallel_job$get_core_count()
    exp <- 1L
    checkIdentical(obs, exp)
}

## Valid case, multiple cores
test.parallel_job_get_core_count_valid_multiple_core <- function() {
    parallel_job <- metagene:::Parallel_Job$new(cores = 2)
    obs <- parallel_job$get_core_count()
    exp <- 2L
    checkIdentical(obs, exp)
}

## Valid case, multiple cores BiocParallelParam
test.parallel_job_get_core_count_valid_multiple_core_biocparallelparam <-
    function() {
    cores <- BiocParallel::SnowParam(workers = 2)
    parallel_job <- metagene:::Parallel_Job$new(cores = cores)
    obs <- parallel_job$get_core_count()
    exp <- 2L
    checkIdentical(obs, exp)
}

###################################################
## Test the Parallel_Job$set_core_count() function
###################################################

## Valid case, single core
test.parallel_job_set_core_count_valid_single_core <- function() {
    parallel_job <- metagene:::Parallel_Job$new(cores = 2)
    parallel_job$set_core_count(cores = 1)
    obs <- parallel_job$get_core_count()
    exp <- 1L
    checkIdentical(obs, exp)
}

## Valid case, multiple cores
test.parallel_job_set_core_count_valid_multiple_core <- function() {
    parallel_job <- metagene:::Parallel_Job$new(cores = 1)
    parallel_job$set_core_count(cores = 2)
    obs <- parallel_job$get_core_count()
    exp <- 2L
    checkIdentical(obs, exp)
}

## Valid case, multiple cores BiocParallelParam
test.parallel_job_set_core_count_valid_multiple_core_biocparallelparam <-
    function() {
    parallel_job <- metagene:::Parallel_Job$new(cores = 1)
    parallel_job$set_core_count(cores = BiocParallel::SnowParam(workers = 2))
    obs <- parallel_job$get_core_count()
    exp <- 2L
    checkIdentical(obs, exp)
}

## Invalid cores numeric values - zero
test.parallel_job_set_core_count_zero_core_number <- function() {
    parallel_job <- metagene:::Parallel_Job$new(cores = 1)
    obs <- tryCatch(parallel_job$set_core_count(cores = 0),
                    error = conditionMessage)
    exp <- "cores must be positive numeric or BiocParallelParam instance."
    checkIdentical(obs, exp)
}

## Invalid cores numeric values - negative value
test.parallel_job_set_core_count_negative_core_number <- function() {
    parallel_job <- metagene:::Parallel_Job$new(cores = 1)
    obs <- tryCatch(parallel_job$set_core_count(cores = -1),
                    error = conditionMessage)
    exp <- "cores must be positive numeric or BiocParallelParam instance."
    checkIdentical(obs, exp)
}

## Invalid cores non-numeric values - string
test.parallel_job_set_core_count_string_core_number <- function() {
    parallel_job <- metagene:::Parallel_Job$new(cores = 1)
    obs <- tryCatch(parallel_job$set_core_count(cores = "1"),
                    error = conditionMessage)
    exp <- "cores must be positive numeric or BiocParallelParam instance."
    checkIdentical(obs, exp)
}
}
