import 'package:flutter/material.dart';
import 'package:movie/constants.dart';

class Movie {
  late String kapan;
  late String name;
  late int year;
  late double rating;

  Movie(String kapan, String name, int year, double rating) {
    this.kapan = kapan;
    this.name = name;
    this.year = year;
    this.rating = rating;
  }

  String getImagePath() {
    String formattedName =
        name.toLowerCase().replaceAll(" ", "_").replaceAll("-", "_");
    return 'assets/images/$formattedName.jpeg';
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> dataMovies = [];

  @override
  void initState() {
    super.initState();
    // name - status - year - rating
    Movie spiderman =
        Movie("Coming soon", "Spider-man beyond the spider-verse", 0, 0);
    Movie ironman = Movie("Not airing", "ironman_2", 2010, 6.9);
    Movie batman = Movie("Not airing", "BATMAN(2022)", 2022, 7.8);
    Movie drive = Movie("Not airing", "Drive", 2011, 7.8);

    dataMovies.add(spiderman);
    dataMovies.add(ironman);
    dataMovies.add(batman);
    dataMovies.add(drive);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movies Rating",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 239, 239, 239),
          ),
        ),
        backgroundColor: anotherColor,
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Added padding around the ListView
        child: Center(
          child: Container(
            child: ListView.builder(
              itemCount: dataMovies.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = dataMovies[index];
                return GestureDetector(
                  onTap: () {
                    _showToast(context, movie.name);
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          50), // Adjust the radius as needed
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: Image.asset(
                            movie.getImagePath(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(133, 0, 0, 0),
                                Colors.black,
                              ],
                            ),
                          ),
                          width: double.infinity,
                          height: 200,
                        ),
                        Positioned(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            title: Text(
                              movie.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              movie.kapan,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Year: ${movie.year}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Rating: ${movie.rating.toStringAsFixed(1)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Close',
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HomeScreen()));
}
