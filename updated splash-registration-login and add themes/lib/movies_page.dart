import 'package:flutter/material.dart';
import 'classes.dart';
import 'movie_details_page.dart';
import 'services.dart';

class MoviesPage extends StatefulWidget {
  bool isLoggedIn, isFavoritePage;

  MoviesPage({required this.isLoggedIn, required this.isFavoritePage});

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late Future<List<Movie>> movies;
  List<Movie> favoriteMovies = [];
  final MovieService movieServices = MovieService();

  @override
  void initState() {
    super.initState();
    movies = fetchAndExtractMovies();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: FutureBuilder<List<Movie>>(
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
            List<Movie> moviesList = snapshot.data!;
            return ListView.builder(
              itemCount: moviesList.length,
              itemBuilder: (context, index) {
                return _buildMovieCard(context, moviesList[index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildMovieCard(BuildContext context, Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movie: movie),
          ),
        );
      },
      child: Center(
        child: Container(
          width: 500,
          height: 200,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    movie.img!,
                    width: 400,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.categoryName,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 16,
                          backgroundColor: Theme.of(context).cardColor.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie.name,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Theme.of(context).cardColor.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        movie.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 14,
                          backgroundColor: Theme.of(context).cardColor.withOpacity(0.7),
                        ),
                      ),
                    ],
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
                      movieServices.deleteFromFavorite(movie.id!);
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