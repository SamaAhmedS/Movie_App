import 'package:flutter/material.dart';
import 'classes.dart';
import 'movie_details_page.dart';
import 'services.dart';

class MoviesPage extends StatefulWidget {
  bool isLoggedIn, isFavoritePage;

  MoviesPage({Key? key, required this.isLoggedIn, required this.isFavoritePage});

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late Future<List<Movie>> movies;
  List<Cinema> cinemas = [];
  List<Movie> favoriteMovies = [];
  List<Movie> filteredMovies = [];
  TextEditingController searchController = TextEditingController();
  final MovieService movieServices = MovieService();

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
    var response = await movieServices.movieCinema(name);
    cinemas = response as List<Cinema>;
  }

  Future<List<Movie>> fetchAndExtractMovies() async {
    var response = await movieServices.fetchMovies();
    List<Movie> moviesList = response as List<Movie>;
    if (widget.isFavoritePage) {
      favoriteMovies.clear();
      for (Movie movie in moviesList) {
        if (movie.isFavorite) {
          favoriteMovies.add(movie);
        }
      }
      return favoriteMovies;
    }
    return moviesList;
  }

  void refreshMovies() {
    setState(() {
      movies = fetchAndExtractMovies();
    });
  }

  void deleteUnfavorite(Movie movie) async {
    setState(() {
      favoriteMovies.remove(movie);
      movies = Future.value(favoriteMovies);
    });
  }

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
                        return _buildMovieCard(context, filteredMovies[index]);
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

  Widget _buildMovieCard(BuildContext context, Movie movie) {
    return GestureDetector(
      onTap: () {
        fetchAndExtractCinemas(movie.name);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movie: movie, cinemas: cinemas),
          ),
        );
      },
      child: Center(
        child: Container(
          width: 500,
          height: 220,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    movie.img!,
                    width: 150,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.categoryName,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 16,
                            backgroundColor:
                            Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movie.name,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            backgroundColor:
                            Theme.of(context).cardColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie.description,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 13,
                            backgroundColor:
                            Theme.of(context).cardColor.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: Icon(
                      movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: movie.isFavorite ? Colors.indigo : Theme.of(context).iconTheme.color,
                    ),
                    onPressed: () {
                      setState(() {
                        movie.isFavorite = !movie.isFavorite;
                        if (widget.isFavoritePage) {
                          deleteUnfavorite(movie);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}