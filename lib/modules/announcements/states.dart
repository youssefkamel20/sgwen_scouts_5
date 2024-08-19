abstract class MoviesStates {}

class MoviesLoadingState extends MoviesStates {}

class MoviesSuccessState extends MoviesStates {}

class MoviesFailedState extends MoviesStates {}

class MoviesFromPaginationLoadingState extends MoviesStates {}

class MoviesFromPaginationFailedState extends MoviesStates {}
