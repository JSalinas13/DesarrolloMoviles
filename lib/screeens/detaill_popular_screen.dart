import 'package:flutter/material.dart';
import 'package:main_app/models/popular_moviedao.dart';

class DetaillPopularScreen extends StatefulWidget {
  const DetaillPopularScreen({super.key});

  @override
  State<DetaillPopularScreen> createState() => _DetaillPopularScreenState();
}

class _DetaillPopularScreenState extends State<DetaillPopularScreen> {
  @override
  Widget build(BuildContext context) {
    final popular =
        ModalRoute.of(context)!.settings.arguments as PopularMovieDao;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: .7,
            fit: BoxFit.fill,
            image: NetworkImage(
                'https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
          ),
        ),
      ),
    );
  }
}
