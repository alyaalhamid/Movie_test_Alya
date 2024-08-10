import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/Model/GetWatchlist.dart';
import 'package:test/Service/GetWishlistMovie.dart';
import 'package:test/View/detailmovie.dart';

class wishlist extends StatefulWidget {
  @override
  State<wishlist> createState() => _wishlistState();
}

class _wishlistState extends State<wishlist> {
  /// [moviewatchlist]  merupakan variabel yang diguankana untuk mendapatkan data dari future `moviewatchlist`.
  ///
  /// [accountid] berisikan nilai static yang digunakan untuk memudahkan dalam penarikan data yang memerlukan account id
  var moviewatchlist;

  int accountid = 1;
  @override
  void initState() {
    super.initState();
    moviewatchlist = ApiWatchlistMovie().getwatchlist(accountid);
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
            child: const Icon(Icons.arrow_back)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'My Watchlist  ',
          style: TextStyle(color: Colors.blue, fontSize: 30),
        ),
      ),
      body: Container(
        child: FutureBuilder<List<WatchlistMovie>?>(
            future: moviewatchlist,
            builder: (BuildContext context,
                AsyncSnapshot<List<WatchlistMovie>?> snapshot) {
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
                              WatchlistMovie watchlistmovi = (snapshot.data
                                  as List<WatchlistMovie>)[index];
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
                                                          id: watchlistmovi
                                                              .id!)));
                                        },
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500${watchlistmovi.poster_path}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(watchlistmovi.title.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Expanded(
                                              child: Text(
                                                watchlistmovi.overview
                                                    .toString(),
                                                style: const TextStyle(
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
                  return const Text(
                    'No Data',
                    style: TextStyle(color: Colors.white),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
