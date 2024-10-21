import 'package:flutter/material.dart';
import 'classes.dart';
import 'movie_details_page.dart';
import 'services.dart';

class MoviesPage extends StatefulWidget {
  bool isLoggedIn, isFavoritePage;

  MoviesPage({Key? key,required this.isLoggedIn, required this.isFavoritePage});

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late Future<List<Movie>> movies;
  List<Cinema> cinemas =[];
  List<Movie> favoriteMovies = [];
  final MovieService movieServices = MovieService();

  @override
  void initState() {
    super.initState();
    movies = fetchAndExtractMovies();
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
            return ListView(
              children: [
                const SizedBox(height: 10),
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
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(), // Disable ListView scrolling
                  shrinkWrap: true, // Allow the ListView to take only as much space as it needs
                  itemCount: moviesList.length,
                  itemBuilder: (context, index) {
                    return _buildMovieCard(context, moviesList[index]);
                  },
                ),
              ],
            );
          }
        },
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
          height: 200,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
              children: [


                Positioned(
                bottom: 16,
                left: 16,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      movie.img!,
                      width: 200,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 220,
                  top: 35,
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

                      const SizedBox(height: 15),
                      Container(
                        width: 200,
                        child: Text(
                          movie.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 12,
                            backgroundColor: Theme.of(context).cardColor.withOpacity(0.7),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 24,
                  child:Text(
                    movie.name,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Theme.of(context).cardColor.withOpacity(0.7),
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
                        //movieServices.Favorite(movie.name);
                        movie.isFavorite = !movie.isFavorite;
                        if (widget.isFavoritePage) {
                          //movieServices.deleteFromFavorite(movie.id!,movie.name);
                          deleteUnfavorite(movie);
                        }
                      });
                    },
                  ),
                ),/**/
              ],
            ),
          ),
        ),
      ),
    );
  }
}