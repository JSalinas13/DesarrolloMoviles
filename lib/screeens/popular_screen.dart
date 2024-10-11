import 'package:flutter/material.dart';
import 'package:main_app/models/popular_moviedao.dart';
import 'package:main_app/network/popular_api.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  PopularApi? popularApi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    popularApi = PopularApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: popularApi!.getPopularMovies(),
        builder: (context, AsyncSnapshot<List<PopularMovieDao>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return CardPopular(snapshot.data![index]);
                });
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something was wrong :()'),
              );
            } else {
              return CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }

  Widget CardPopular(PopularMovieDao popular) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detaill', arguments: popular),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${popular.posterPath}')),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Opacity(
                opacity: .7,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  height: 50,
                  child: Text(
                    popular.title,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
