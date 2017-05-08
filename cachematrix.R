# We are taking advantage of lexical scoping and the fact that functions that return
# list objects also allow access to any other objects defined in the environment of the original function.



# For makeCacheMatrix, this means that subsequent code can access the values of x or m, 
# which are respectively the original and inverse matrices, through the use of "getters" and "setters". 

makeCacheMatrix <- function(x = matrix()) {
  m<-NULL
  set<-function(y){
    x<<-y
    m<<-NULL
  }
  get<-function() x
  setmatrix<-function(solve) m<<- solve
  getmatrix<-function() m
  list(set=set, get=get,
       setmatrix=setmatrix,
       getmatrix=getmatrix)
}

# The use of "getters" and "setters" is how cacheSolve is able to calculate and store the inverse for the input argument if it is of type makeCacheMatrix.
# Because list elements in makeCacheMatrix are defined with names, we can access these functions with the $ form of the extract operator.

cacheSolve <- function(x, ...) {
  m<-x$getmatrix()
  if(!is.null(m)){
    message("getting cached data")
    return(m)
  }
  matrix<-x$get()
  m<-solve(matrix, ...)
  x$setmatrix(m)
  m
}
