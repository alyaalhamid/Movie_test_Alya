import 'package:flutter/material.dart';
import 'package:test/Model/DiscoverMovie.dart';
import 'package:test/Model/Popular.dart';
import 'package:test/Service/GetDiscoMovie.dart';
import 'package:test/Service/GetPopularMovie.dart';
import 'package:test/View/BottomNav.dart';
import 'package:test/View/detailmovie.dart';
import 'package:test/View/useracc.dart';
import 'package:carousel_slider/carousel_slider.dart';

///halaman homepage dimana terdapat beberapa poster movie mulai dari Now Play sampai Popular
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  /// *[listNowPlay] adalah variabel yang diguankan untuk mendapatkan nilai Now Play melalu future dari Future Builder `listNowPlay`.
  ///
  /// *[listpopular] adalah variabel yang digunakan untuk mendapatkan nilai Popular melaui future dari Future Builder `listpopular`.
  ///
  var listNowPlay;
  var listpopular;
  @override
  void initState() {
    super.initState();
    listNowPlay = ApiDiscoMovie().getNowPlay();
    listpopular = ApiPopularMovie().getPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      ///selain dari tampilan Now Play dan Popular , terdapat juga Navigation Bar yang berisi button Home dan user informasi.
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
        height: 80,
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100), topRight: Radius.circular(50))),
        child: Row(
          children: [
            Expanded(
                child:
                    BottomNavItem(ImagePath: 'assets/logo.jpg', press: () {})),
            Expanded(
                child: BottomNavItem(
                    ImagePath: 'assets/user-3296.png',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const useraccount()));
                    }))
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 50, top: 50),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(100),
                    topRight: Radius.circular(100)),
              ),
              child: const Center(
                child: Text(
                  'Hello, \nAlic',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Now Playing',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    ///penggunaan Future Builder yang digunakan untuk menarik data dari API
                    child: FutureBuilder(
                        future: listNowPlay,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Tidak kesalahan :${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data.length == 0) {
                            return const Center(
                              child: Text('Tidak ada data ditemukan'),
                            );
                          } else {
                            List<DiscovMovie> displaymovie =
                                (snapshot.data as List<DiscovMovie>)
                                    .take(6)
                                    .toList();
                            return CarouselSlider.builder(
                                itemCount: displaymovie.length,
                                itemBuilder: (context, index, reallindex) {
                                  final NowPlaying = displaymovie[index];
                                  String path =
                                      'https://image.tmdb.org/t/p/w500${NowPlaying.poster_path}';
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailMovie(
                                              id: NowPlaying.id!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 100,
                                        child: Column(
                                          children: [
                                            Image.network(
                                              path,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              NowPlaying.title.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                                options: CarouselOptions(
                                    height: 300,
                                    viewportFraction: 2,
                                    enableInfiniteScroll: false,
                                    autoPlay: true,
                                    enlargeCenterPage: false,
                                    scrollDirection: Axis.horizontal));
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Popular',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: FutureBuilder(
                        future: listpopular,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Tidak kesalahan :${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data.length == 0) {
                            return const Center(
                              child: Text('Tidak ada data ditemukan'),
                            );
                          } else {
                            return CarouselSlider.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index, reallindex) {
                                  final Popular = (snapshot.data
                                      as List<PopularMovie>)[index];
                                  String path =
                                      'https://image.tmdb.org/t/p/w500${Popular.poster_path}';
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            (MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailMovie(
                                                        id: Popular.id!))));
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 150,
                                        child: Column(
                                          children: [
                                            Image.network(
                                              path,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              Popular.title.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ));
                                },
                                options: CarouselOptions(
                                    height: 300,
                                    viewportFraction: 2,
                                    enableInfiniteScroll: false,
                                    autoPlay: true,
                                    enlargeCenterPage: false,
                                    scrollDirection: Axis.horizontal));
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildowPlay(Map<String, dynamic> data, int index) {
  final imageUrl = data['image'];
  final title = data['title'];

  return Column(
    children: [
      Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        height: 120,
      ),
      const SizedBox(height: 8),
      Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    ],
  );
}
