import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muvizone/genremovies.dart';
import 'package:muvizone/loading.dart';
import 'package:muvizone/moviedetails.dart';
import 'package:muvizone/search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var playing, top, popular;
  @override
  void initState() {
    super.initState();
    getNowPlaying();
    getPopularMovies();
    getTopRatedMovies();
  }

  getNowPlaying() async {
    String url =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=a5ce1e09b056552ca4d30c679d69e75b&language=en-US&page=1";
    http.Response response = await http.post(url);
    setState(() {
      var playingDecoded = jsonDecode(response.body);
      playing = playingDecoded['results'];
    });
  }

  getPopularMovies() async {
    String url =
        "https://api.themoviedb.org/3/movie/popular?api_key=a5ce1e09b056552ca4d30c679d69e75b&language=en-US&page=1";
    http.Response response = await http.post(url);
    setState(() {
      var playingDecoded = jsonDecode(response.body);
      popular = playingDecoded['results'];
    });
  }

  getTopRatedMovies() async {
    String url =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=a5ce1e09b056552ca4d30c679d69e75b&language=en-US&page=1";
    http.Response response = await http.post(url);
    setState(() {
      var playingDecoded = jsonDecode(response.body);
      top = playingDecoded['results'];
    });
  }


  @override
  Widget build(BuildContext context) {
    List categories = [
      "Animations",
      "Comedy",
      "Documentary",
      "Horror",
      "Romance",
      "Science Fiction",
      "Thriller"
    ];

    return playing == null
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(68, 68, 68, 1),
              title: Text(
                "MUVIZONE",
                style: TextStyle(color: Colors.red),
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search()));
                    }),
                SizedBox(
                  width: 20.0,
                )
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(10.0),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 60.0,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              GenreMovies(
                                                name: categories[index],
                                              )));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Color.fromRGBO(68, 68, 68, 1),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: 70,
                                  child: Center(
                                    child: Text(categories[index]),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Title(
                          color: Colors.white,
                          child: Text(
                            "Now Playing in Theatres",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      Container(
                        height: 280,
                        child: ListView.builder(
                            itemCount: 15,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MovieDetails(
                                                movieId: playing[index]['id'],
                                              )));
                                },
                                child: MovieTile(
                                  url: playing[index]['poster_path'],
                                  title: playing[index]['title'],
                                  rating:
                                      playing[index]['vote_average'].toString(),
                                  id: playing[index]['id'],
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Title(
                          color: Colors.white,
                          child: Text(
                            "Popular Movies Currently",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      Container(
                        height: 280,
                        child: ListView.builder(
                            itemCount: 15,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MovieDetails(movieId: popular[index]['id'],)));
                                },
                                child: MovieTile(
                                  url: popular[index]['poster_path'],
                                  title: popular[index]['title'],
                                  rating:
                                      popular[index]['vote_average'].toString(),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Title(
                          color: Colors.white,
                          child: Text(
                            "Top Rated Movies of All Time",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                      Container(
                        height: 290,
                        child: ListView.builder(
                            itemCount: 15,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetails(movieId:top[index]['id'] ,))),
                                                              child: MovieTile(
                                  url: top[index]['poster_path'],
                                  title: top[index]['title'],
                                  rating: top[index]['vote_average'].toString(),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 30.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class MovieTile extends StatelessWidget {
  final String url;
  final String title;
  final String rating;
  final int id;
  MovieTile({this.url, this.title, this.rating, this.id});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      child: Card(
        margin: EdgeInsets.only(top: 10.0, right: 10.0),
        color: Color.fromRGBO(68, 68, 68, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.35,
              child: Image.network(
                "https://image.tmdb.org/t/p/w500" + url,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Center(
                child: Text(
              title,
              maxLines: 2,
            )),
            SizedBox(
              height: 5.0,
            ),
            FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                label: Text(
                  rating,
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
