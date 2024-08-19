import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgwen_scouts_5/modules/announcements/cubit.dart';
import 'package:sgwen_scouts_5/modules/announcements/states.dart';
import 'package:sgwen_scouts_5/shared/components/class_components.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesCubit()..getData(),
      child: BlocConsumer<MoviesCubit, MoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = MoviesCubit.get(context);

          return ConditionalBuilder(
            condition: state is! MoviesLoadingState,
            builder: (context) => CustomScaffold(
              body: NotificationListener<ScrollNotification>(
                onNotification: (notification){
                  if (notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification){
                    print('loading');
                    cubit.getData(fromLoading: true);
                  }
                  return true;
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) => _Item(
                    model: cubit.list[index],
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: cubit.list.length,
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget{
  final MovieModel model;
  const _Item({Key? key , required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.brown[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Image.network(model.posterPath ,height: 200,
                fit: BoxFit.cover,
              )),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    model.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    model.overview,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.orangeAccent,),
                      SizedBox(width: 5,),
                      Text(
                        '${model.voteAverage}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.orangeAccent),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}

class MoviesData {
  late final int page, totalPages, totalResults;
  late final List<MovieModel> list;

  MoviesData.fromJson(Map<String, dynamic> json){
    page = json['page'];
    list = List.from(json['results']).map((e)=>MovieModel.fromJson(e)).toList();
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}

class MovieModel {
  late final bool adult;
  late final String backdropPath;
  late final List<int> genreIds;
  late final int id;
  late final String originalLanguage;
  late final String originalTitle;
  late final String overview;
  late final double popularity;
  late final String posterPath;
  late final String releaseDate;
  late final String title;
  late final bool video;
  late final double? voteAverage;
  late final int voteCount;

  MovieModel.fromJson(Map<String, dynamic> json){
    adult = json['adult'];
    backdropPath = "http://image.tmdb.org/t/p/original${json['backdrop_path']}" == null? "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png" : "http://image.tmdb.org/t/p/original${json['backdrop_path']}";
    //genreIds = List.castFrom<dynamic, int>(json['genre_ids']);
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = double.parse(json['popularity'].toString());
    posterPath = "http://image.tmdb.org/t/p/original${json['poster_path']}"==null? "https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png" : "http://image.tmdb.org/t/p/original${json['poster_path']}";
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteAverage = double.parse(json['vote_average'].toString());
    voteCount = json['vote_count'];
  }
}