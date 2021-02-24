import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muvizone/loading.dart';

import 'moviedetails.dart';

class GenreMovies extends StatefulWidget {
  final String name;
  GenreMovies({this.name});
  @override
  _GenreMoviesState createState() => _GenreMoviesState();
}

class _GenreMoviesState extends State<GenreMovies> {
  int genreId;
  var genreMovies;
  @override
  void initState() {
    super.initState();
    getGenre();
  }

  getGenre() async {
    if (widget.name == "Animations") {
      genreId = 16;
    } else if (widget.name == "Comedy") {
      genreId = 35;
    } else if (widget.name == "Documentary") {
      genreId = 99;
    } else if (widget.name == "Horror") {
      genreId = 27;
    } else if (widget.name == "Romance") {
      genreId = 10749;
    } else if (widget.name == "Science Fiction") {
      genreId = 878;
    } else if (widget.name == "Thriller") {
      genreId = 53;
    }
    String url =
        "https://api.themoviedb.org/3/discover/movie?api_key=a5ce1e09b056552ca4d30c679d69e75b&with_genres=" +
            genreId.toString();
    http.Response response = await http.get(url);
    var jsondata = jsonDecode(response.body);
    setState(() {
      genreMovies = jsondata['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return genreMovies == null
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(68, 68, 68, 1),
              title: Row(
                children: <Widget>[
                  Text(
                    "MUVIZONE ",
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(widget.name)
                ],
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 20,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height * 0.78)),
                    itemBuilder: ((BuildContext context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                      movieId: genreMovies[index]['id'],
                                    ))),
                        child: MovieTile(
                          url: genreMovies[index]['poster_path'] ?? "",
                          title: genreMovies[index]['title'] ?? "",
                          rating:
                              genreMovies[index]['vote_average'].toString() ??
                                  "",
                          id: genreMovies[index]['id'] ?? "",
                        ),
                      );
                    })),
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: EdgeInsets.all(10.0),
      color: Color.fromRGBO(68, 68, 68, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.5,
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
    );
  }
}
