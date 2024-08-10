import 'package:flutter/material.dart';
import 'package:test/View/BottomNav.dart';
import 'package:test/View/Login.dart';
import 'package:test/View/Myfavorite.dart';
import 'package:test/View/home.dart';
import 'package:test/View/Watchlistview.dart';

class useraccount extends StatefulWidget {
  const useraccount({super.key});

  @override
  State<useraccount> createState() => _useraccountState();
}

class _useraccountState extends State<useraccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: BottomNavItem(
                    ImagePath: 'assets/logo.jpg',
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const homepage()));
                    })),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Column(
            children: [
              const Row(
                children: [
                  Flexible(
                    child: FractionallySizedBox(
                      widthFactor: 0.95,
                    ),
                  ),
                ],
              ),
              const Flexible(
                child: FractionallySizedBox(
                  heightFactor: 0.1,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 10),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ProfileScreen()));
                      },
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/user-3296.png'),
                        radius: 30,
                      ),
                    ),
                  ),
                  const Text(
                    'Alic',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Flexible(
                child: FractionallySizedBox(
                  heightFactor: 0.2,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyFavorite()));
                        },
                        child: const Text(
                          'My Favorite',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => wishlist()));
                        },
                        child: const Text(
                          'Watchlist',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      )),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      '______________________',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => homepage()));
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actions: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.red),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginScreen()));
                                            },
                                            child: const Text(
                                              'Out',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.blue),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        )),
                                      ],
                                    )
                                  ],
                                  title: const Center(
                                    child: Text(
                                      'Log Out?',
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              });
                        },
                        child: const Text(
                          'Log Out',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
