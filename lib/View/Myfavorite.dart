import 'package:flutter/material.dart';
import 'package:test/Model/GetFavorit.dart';
import 'package:test/Service/GetFavoriteMovie.dart';
import 'package:test/View/detailmovie.dart';

class MyFavorite extends StatefulWidget {
  @override
  State<MyFavorite> createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> {
  var moviefavorite;
  int accountid = 1;

  @override
  void initState() {
    moviefavorite = ApiFavoriteMovie().getfavorite(accountid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'My Favorite ',
          style: TextStyle(color: Colors.blue, fontSize: 30),
        ),
      ),
      body: Container(
        child: FutureBuilder<List<FavoriteMovie>?>(
            future: moviefavorite,
            builder: (BuildContext context,
                AsyncSnapshot<List<FavoriteMovie>?> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child:
                      Text('Something wen worng: ${snapshot.error.toString()}'),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              FavoriteMovie favoritemovi =
                                  (snapshot.data as List<FavoriteMovie>)[index];
                              return Container(
                                height: 200,
                                width: 100,
                                child: SizedBox(
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailMovie(
                                                          id: favoritemovi
                                                              .id!)));
                                        },
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500${favoritemovi.poster_path}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(favoritemovi.title.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Expanded(
                                              child: Text(
                                                favoritemovi.overview
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  );
                } else {
                  return Text(
                    'No Data',
                    style: TextStyle(color: Colors.white),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
