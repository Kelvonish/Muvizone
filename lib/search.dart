import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muvizone/loading.dart';
import 'package:muvizone/moviedetails.dart';
import 'genremovies.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
    //getSearchMovies();
  }
   String query;
    var results;
    bool loading=false;
    final _formkey = GlobalKey<FormState>();
  getSearchMovies() async{
   String url ="https://api.themoviedb.org/3/search/movie?api_key=a5ce1e09b056552ca4d30c679d69e75b&language=en-US&query="
   +query+
   "&page=1&include_adult=false";
    http.Response response = await http.get(url);
     var movieDetails = jsonDecode(response.body);
    setState(() {
     results=movieDetails['results'];
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return loading? Loading() :Scaffold(
      backgroundColor: Colors.black,
       appBar: AppBar(
        backgroundColor:  Color.fromRGBO(68, 68, 68, 1),
        title: Row(children: <Widget>[ Text("MUVIZONE ",
        style: TextStyle(
          color: Colors.red
        ),
        ),Text("Search") ],),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
              child: Container(
                 width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
                child: Column(
          children: <Widget>[
            Form(
                key: _formkey,
                child: Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (val)=>val.isEmpty? "Enter Movie title":null,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0
                  ),
                  initialValue: query,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(icon: Icon(Icons.search,color: Colors.red,size:30), onPressed: (){
                      if(_formkey.currentState.validate()){
                        setState(() {
                          loading=true;
                        });
                        getSearchMovies();
                      }
                    }),
                    fillColor: Color.fromRGBO(68, 68, 68, 1),
                    filled: true,
                    //border: InputBorder(borderSide: BorderRadius.circular(10)),
                    hoverColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    hintText: "Enter Movie title",
                    hintStyle: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                  //autofocus: true,
                  onChanged: (val){
                    query=val;               
                  },
                  ),
            )),
            results==null ? Center(child: Text("No results")):GridView.builder(
            itemCount: results.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            childAspectRatio:MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height*0.78)
            ),
             itemBuilder: (
                 (BuildContext context,index){
                 return GestureDetector(
                   onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetails(movieId: results[index]['id'],))),
                  child: MovieTile(
                     url: results[index]['poster_path']??"",
            title: results[index]['title']??"",
            rating: results[index]['vote_average'].toString()??"",
            id: results[index]['id']??"",
                   ),
                 );
                        })),
          ],
        ),
              ),
      ),
    );
  }
}