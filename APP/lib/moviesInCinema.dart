import 'package:flutter/material.dart';
import 'classes.dart';
import 'services.dart';
import 'showMovies.dart';
import 'movie_details_page.dart';

class MoviesInCinema extends StatefulWidget {
  const MoviesInCinema({super.key});

  @override
  State<MoviesInCinema> createState() => _MoviesInCinemaState();
}

class _MoviesInCinemaState extends State<MoviesInCinema> {
  late Future<List<Movie>> movies;
  List<Cinema> cinemas = [];
  List<Movie> filteredMovies = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    movies = fetchAndExtractMovies();
    movies.then((moviesList) {
      setState(() {
        filteredMovies = moviesList;
      });
    });
  }
  Future<void> fetchAndExtractCinemas(String name) async {
    var response = await MovieService1.instance.movieCinema(name);
    cinemas = response as List<Cinema>;
  }


  Future<List<Movie>> fetchAndExtractMovies() async {
    var response = await MovieService1.instance.fetchMovies();

    var res = response as List<Movie>;
    print("we are in new page mov");
    for(Movie m in res ){
      print("${m.name} f ${m.isFavorite}");
    }
    return res;
  }

  void refreshMovies() {
    setState(() {
      movies = fetchAndExtractMovies();
    });
  }

  void internal(Movie movie) async {
    MovieService1.instance.flipIsFavorite(movie.name);
    refreshMovies();
  }
  void flipIsFavorite(Movie movie){
    setState(() {
      internal(movie);
    });
  }
  /*void flipIsFavorite(Movie movie) async {
    MovieService1.instance.flipIsFavorite(movie.name);
    refreshMovies();
  }*/

  void searchMovies(String query) {
    setState(() {
      if (query.isEmpty) {
        movies.then((moviesList) {
          filteredMovies = moviesList;
        });
      } else {
        movies.then((moviesList) {
          filteredMovies = moviesList.where((movie) {
            return movie.name.toLowerCase().contains(query.toLowerCase());
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder<List<Movie>>(
            future: movies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Failed to load movies',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No movies available',
                    style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                );
              } else {
                return ListView(
                  children: [
                    const SizedBox
                      (
                        height: 10),
                    Center(
                      child: Text(
                        'Movies',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: const Offset(3.0, 3.0), // Shadow offset
                              blurRadius: 5.0, // Blur radius
                              color: Theme.of(context).primaryColor,
                            ),
                            Shadow(
                              offset: const Offset(-3.0, -3.0),
                              blurRadius: 5.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    )
                    ,
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) => searchMovies(value),
                        decoration: InputDecoration(
                          labelText: 'Search for a movie',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(), // Disable ListView scrolling
                      shrinkWrap: true, // Allow the ListView to take only as much space as it needs
                      itemCount: filteredMovies.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            fetchAndExtractCinemas(filteredMovies[index].name);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsPage(movie: filteredMovies[index], cinemas: cinemas),
                              ),
                            );
                          },
                        child: buildMovieCard1(context, filteredMovies[index], flipIsFavorite),
                        );
                      },
                    ),

                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

}
