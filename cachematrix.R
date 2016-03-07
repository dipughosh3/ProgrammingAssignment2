## MakeCacheMatrix does the following:
## 1. set the values of the matrix & define the setMatrix function
## 2. Get the values of the matrix & define the getMatrix function
## 3. sets the values of the Inverse Matrix & define setInverse function
## 4. get the values of the Inverse Matrix & define getInverse function

makeCacheMatrix <- function(x = matrix()) {
  IM <- NULL
  setMatrix <- function(y) {
    x <<- y
    IM <<- NULL
  }
  getMatrix <- function() x
  setInverse <- function(InvMat) IM <<- InvMat
  getInverse <- function() IM
  list(setMatrix = setMatrix, getMatrix = getMatrix, setInverse = setInverse, getInverse = getInverse)
}


## If the matrix has not changed, this will get the Inverse from Cache
## For a new matrix, it will save the Inverse to Cache once the makeCacheMatrix functions set it up
## The input to this function is the output from the makeCacheMatrix function.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  IM <- x$getInverse()
  if (!is.null(IM))  {
    message("getting cached data")
    return(IM)
  }
  data <- x$getMatrix()
  IM <- solve(data)
  x$setInverse(IM)
  IM
}
