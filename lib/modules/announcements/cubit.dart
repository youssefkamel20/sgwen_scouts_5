import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgwen_scouts_5/modules/announcements/states.dart';

import 'movies_screen.dart';

class MoviesCubit extends Cubit<MoviesStates>{
  MoviesCubit() : super(MoviesLoadingState());

  static MoviesCubit get(context) => BlocProvider.of(context);


  List<MovieModel> list =[
  ];
  int pageNumber = 1;
  void getData({bool fromLoading = false}) async {
    if(fromLoading){
      emit(MoviesFromPaginationLoadingState());
    } else{
      emit(MoviesLoadingState());
    }
    try{
      var response = await Dio().get('https://api.themoviedb.org/3/discover/movie?api_key=2001486a0f63e9e4ef9c4da157ef37cd&page=$pageNumber');
      var model = MoviesData.fromJson(response.data);
      if(model.list.isNotEmpty){
        pageNumber++;
        list.addAll(model.list);
      }
      emit(MoviesSuccessState());
    } on DioException catch (e){
      emit(MoviesFailedState());
    }

  }
}