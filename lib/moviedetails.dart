import 'dart:convert';
import 'package:muvizone/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;
  MovieDetails({this.movieId});
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  var movieDetails;
  @override
  void initState() {
    super.initState();
    getMovieDetails();
  }

  getMovieDetails() async {
    String url = "https://api.themoviedb.org/3/movie/" +
        widget.movieId.toString() +
        "?api_key=a5ce1e09b056552ca4d30c679d69e75b&language=en-US";
    http.Response response = await http.get(url);
    setState(() {
      movieDetails = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0);
    final subtitleStyle = TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: movieDetails == null
          ? Loading()
          : ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500" +
                              movieDetails['poster_path'],
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                          top: 10,
                          left: 10,
                          child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              })),
                      Positioned(
                          top: 10,
                          right: 20,
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.7,
                            child: Card(
                              
                              color: Color.fromRGBO(68, 68, 68, 0.8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.4,
                                          child: AutoSizeText(
                                            movieDetails['original_title'],
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        FlatButton.icon(
                                            onPressed: null,
                                            icon: Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            label: Text(
                                              movieDetails['vote_average']
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          movieDetails['genres'][0]['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15.0),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          movieDetails['runtime'].toString() +
                                              " Minutes",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15.0),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: Color.fromRGBO(68, 68, 68, 0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Release Date",
                              style: titleStyle,
                            ),
                            subtitle: Text(
                              movieDetails['release_date'],
                              style: subtitleStyle,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ListTile(
                            title: Text(
                              "Budget",
                              style: titleStyle,
                            ),
                            subtitle: Text(
                              movieDetails['budget'].toString(),
                              style: subtitleStyle,
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Revenue",
                              style: titleStyle,
                            ),
                            subtitle: Text(
                              movieDetails['revenue'].toString(),
                              style: subtitleStyle,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ListTile(
                            title: Text(
                              "Synopsis",
                              style: titleStyle,
                            ),
                            subtitle: Text(
                              movieDetails['overview'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
