import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:test/Model/DetailMovie.dart';
import 'package:test/Model/Favorite.dart';
import 'package:test/Model/Similar.dart';
import 'package:test/Model/Watchlist.dart';
import 'package:test/Service/GetDetailDiscMovie.dart';
import 'package:test/Service/GetSimilar.dart';
import 'package:test/Service/PostFavorite.dart';
import 'package:test/Service/PostWatchlist.dart';
import 'package:http/http.dart' as http;

class DetailMovie extends StatefulWidget {
  DetailMovie({super.key, required this.id});

  int id;

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  /// [detailmovie]  merupakan variabel yang diguankana untuk mendapatkan data dari future `detailmovie`.
  ///
  /// [similarmovie] merupakan variabel yang diguanakan untuk mendapatkan data dari future.
  ///
  /// [accountid] berisikan nilai static yang digunakan untuk memudahkan dalam penarikan data yang memerlukan account id
  var detailmovie;
  var similarmovie;
  int accountid = 1;
  @override
  void initState() {
    super.initState();
    detailmovie = ApiDetailMovie().getdetailmovie(widget.id);
    similarmovie = ApiSimilarMovie().getSimilar(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                FutureBuilder<detaildiscmovie?>(
                    future: detailmovie,
                    builder: (BuildContext context,
                        AsyncSnapshot<detaildiscmovie?> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Terjadi kesalahan: ${snapshot.error}'),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.data != null) {
                          detaildiscmovie data = detaildiscmovie();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: data.posterPath != null &&
                                          data.posterPath!.isNotEmpty
                                      ? Image.network(
                                          'https://image.tmdb.org/t/p/w500${snapshot.data!.posterPath.toString()}')
                                      : Image.asset(
                                          'assets/tidakditemukan.jpg')),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      var response = await http.get(
                                        Uri.parse(
                                            'https://image.tmdb.org/t/p/w500${snapshot.data!.posterPath.toString()}'),
                                      );
                                      if (response.statusCode == 200) {
                                        final result =
                                            await ImageGallerySaver.saveImage(
                                                Uint8List.fromList(
                                                    response.bodyBytes),
                                                quality: 60,
                                                name: 'My Movie');
                                        print(result);
                                      } else {
                                        print('Failed');
                                      }
                                      // if(snapshot.data !=null){
                                      //   String? path = 'https://image.tmdb.org/t/p/w500${snapshot.data!.posterPath.toString()}';
                                      //   if(path !=null){
                                      //     bool success = (await ImageGallerySaver.)??
                                      //   }
                                      // }
                                    },
                                    child: Image.asset(
                                      'assets/download-3785.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      var data = PostWatchlist(
                                          media_id: snapshot.data!.id,
                                          media_type: 'movie',
                                          watchlist: true);
                                      try {
                                        final mywatchlist =
                                            await ApiPostwatchlist()
                                                .postmywatchlist(
                                                    accountid, data);
                                      } catch (e) {
                                        print('Error: $e');
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/plus-13233.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      var data = PostFavorite(
                                          media_id: snapshot.data!.id,
                                          media_type: 'movie',
                                          favorite: true);
                                      try {
                                        final myfavorite =
                                            await ApiPostFavorite()
                                                .postmyfavorite(
                                                    accountid, data);
                                      } catch (e) {
                                        print('Error: $e');
                                      }
                                    },
                                    child: Image.asset(
                                      'assets/heart-5797.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.title.toString(),
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Descripstion',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data!.overview.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Smilar',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      child: FutureBuilder(
                                          future: similarmovie,
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Center(
                                                child: Text(
                                                    'Tidak kesalahan :${snapshot.error}'),
                                              );
                                            } else if (!snapshot.hasData ||
                                                snapshot.data.length == 0) {
                                              return const Center(
                                                child: Text(
                                                    'Tidak ada data ditemukan'),
                                              );
                                            } else {
                                              return CarouselSlider.builder(
                                                  itemCount:
                                                      snapshot.data.length,
                                                  itemBuilder: (context, index,
                                                      reallindex) {
                                                    final Similar =
                                                        (snapshot.data as List<
                                                                SimilarMovie>)[
                                                            index];
                                                    String path =
                                                        'https://image.tmdb.org/t/p/w500${Similar.poster_path}';
                                                    return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      DetailMovie(
                                                                          id: Similar
                                                                              .id!)));
                                                        },
                                                        child: Image.network(
                                                            path));
                                                  },
                                                  options: CarouselOptions(
                                                      height: 300,
                                                      viewportFraction: 2,
                                                      enableInfiniteScroll:
                                                          false,
                                                      autoPlay: true,
                                                      enlargeCenterPage: false,
                                                      scrollDirection:
                                                          Axis.horizontal));
                                            }
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        } else {
                          return const Text('Tidak ada data');
                        }
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ],
            )),
      ),
    );
  }
}
