import 'package:dio/dio.dart';
import 'package:main_app/models/popular_moviedao.dart';

class PopularApi {
  final dio = Dio();

  Future<List<PopularMovieDao>> getPopularMovies() async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=40ce54d3539bf4f864da2b772feeb96a&language=es-MX&page=1');
    final res = response.data['results'] as List;

    return res.map((popular) => PopularMovieDao.fromMap(popular)).toList();
  }
}
