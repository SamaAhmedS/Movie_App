import 'app_consts.dart';
import 'classes.dart';
String token ='';

class AuthService {
  final String baseUrl = 'http://bloggy.runasp.net/api/Auth';

  Future<void> registerUser({required String name, required String email, required String password, required String confirmedPassword}) async {


  }
  Future<void> loginUser(String email, String password) async {

    // Future<http.Response>
    // return response;
  }

  Future<void> logoutUser() async {

  }

}
class MovieService{
  final String baseUrl = '';
  List<Movie> movies = [
    Movie(id: 0,name: 'Tangled',
        description: 'The magically long-haired Rapunzel has spent her entire life in a tower, but now that a runaway thief has stumbled upon her, she is about to discover the world for the first time, and who she really is.',
        categoryName: 'Children\'s Movie', img: '${assetsImagesPath}tangled.PNG', isFavorite: true,
        trailer_path: 'assets/videos/Tangled.mp4'),
    Movie(id: 1,name: 'Cinderella',
        description: "When Cinderella's cruel stepmother prevents her from attending the Royal Ball, she gets some unexpected help from the lovable mice Gus and Jaq and from her Fairy Godmother.",
        categoryName: 'Children\'s Movie', img: '${assetsImagesPath}Cinderella.png', isFavorite: true,
        trailer_path: 'assets/videos/Cinderella.mp4'),
    Movie(id: 2,name: 'Bat Man',
        description: 'The Dark Knight of Gotham City begins his war on crime with his first major enemy being Jack Napier, a criminal who becomes the clownishly homicidal Joker.',
        categoryName: 'Varies', img: '${assetsImagesPath}batman.png', isFavorite: false,
        trailer_path: 'assets/videos/Batman.mp4'),
    Movie(id: 3,name: 'kkk',
        description: 'The Dark Knight of Gotham City begins his war on crime with his first major enemy being Jack Napier, a criminal who becomes the clownishly homicidal Joker.',
        categoryName: 'Varies', img: '${assetsImagesPath}batman.png', isFavorite: false,
        trailer_path: 'assets/videos/Batman.mp4'),

  ];
  List<Cinema> cinames =[
    Cinema(moviesName: ["Tangled","Bat Man"], name: 'Cinema Masr', tickets: [Ticket(price: 80.0, end: "7 pm", start: "7 AM")]),
    Cinema(moviesName: ["Bat Man"], name: 'Cinema 1', tickets: [Ticket(price: 80.0, end: "7 pm", start: "7 AM")]),
    Cinema(moviesName: ["Tangled","Bat Man"], name: 'Cinema 2', tickets: [Ticket(price: 80.0, end: "7 pm", start: "7 AM")]),
  ];
  Future<List<dynamic>> movieCinema(String name) async{

    List<Cinema> cOfMovie =[];
    for(Cinema c in cinames){
      for(String m in c.moviesName){
        if(m == name){
          cOfMovie.add(c);
        }
      }

    }
    return cOfMovie;
  }

  Future<List<dynamic>> fetchMovies() async {
    final url = '';

    return movies;
  }
  Future<List<dynamic>> fetchFavoriteMovies() async {
    final url = '';
    List<Movie> favorites = [];
    for (Movie movie in movies) {
      if (movie.isFavorite) {
        favorites.add(movie);
      }
    }

    return favorites;
  }
  void deleteFromFavorite(int movieID,String name)async{
    for(Movie m in movies){
      if(m.name == name){
        m.isFavorite = false;
      }
    }
  }
  void flipIsFavorite(String name)async{
    for(Movie m in movies){
      if(m.name == name){
        m.isFavorite = !m.isFavorite;
        print("\n\n hhh ${m.isFavorite}");
      }
    }
  }
}class MovieService1 {
  // Step 1: Private constructor
  MovieService1._privateConstructor();

  // Step 2: The Singleton instance
  static final MovieService1 _instance = MovieService1._privateConstructor();

  // Step 3: Getter for the instance
  static MovieService1 get instance => _instance;
  // Getter to access the list

  final String baseUrl = '';
  List<Movie> movies = [
    Movie(id: 0,name: 'Tangled',
        description: 'The magically long-haired Rapunzel has spent her entire life in a tower, but now that a runaway thief has stumbled upon her, she is about to discover the world for the first time, and who she really is.',
        categoryName: 'Children\'s Movie', img: '${assetsImagesPath}tangled.PNG', isFavorite: true,
        trailer_path: 'assets/videos/Tangled.mp4'),
    Movie(id: 1,name: 'Cinderella',
        description: "When Cinderella's cruel stepmother prevents her from attending the Royal Ball, she gets some unexpected help from the lovable mice Gus and Jaq and from her Fairy Godmother.",
        categoryName: 'Children\'s Movie', img: '${assetsImagesPath}Cinderella.png', isFavorite: true,
        trailer_path: 'assets/videos/Cinderella.mp4'),
    Movie(id: 2,name: 'Bat Man',
        description: 'The Dark Knight of Gotham City begins his war on crime with his first major enemy being Jack Napier, a criminal who becomes the clownishly homicidal Joker.',
        categoryName: 'Varies', img: '${assetsImagesPath}batman.png', isFavorite: false,
        trailer_path: 'assets/videos/Batman.mp4'),

  ];
  List<Movie> get movesList => movies;
  List<Cinema> cinames =[
    Cinema(moviesName: ["Tangled","Bat Man"], name: 'Cinema Masr', tickets: [Ticket(price: 80.0, end: "7 pm", start: "7 AM")]),
    Cinema(moviesName: ["Bat Man"], name: 'Cinema 1', tickets: [Ticket(price: 80.0, end: "7 pm", start: "7 AM")]),
    Cinema(moviesName: ["Tangled","Bat Man"], name: 'Cinema 2', tickets: [Ticket(price: 80.0, end: "7 pm", start: "7 AM")]),
  ];
  Future<List<dynamic>> movieCinema(String name) async{

    List<Cinema> cOfMovie =[];
    for(Cinema c in cinames){
      for(String m in c.moviesName){
        if(m == name){
          cOfMovie.add(c);
        }
      }

    }
    return cOfMovie;
  }

  Future<List<dynamic>> fetchMovies() async {
    final url = '';

    print("\n\n hhh mov");
    return movies;
  }
  Future<List<dynamic>> fetchFavoriteMovies() async {
    final url = '';
    List<Movie> favorites = [];
    for (Movie movie in movies) {
      if (movie.isFavorite) {
        favorites.add(movie);
      }
    }

    print("\n\n hhh isFavorite");
    return favorites;
  }
  void deleteFromFavorite(int movieID,String name)async{
    for(Movie m in movies){
      if(m.name == name){
        m.isFavorite = false;
      }
    }
  }
  void flipIsFavorite(String name)async{
    for(Movie m in movies){
      if(m.name == name){
        m.isFavorite = !m.isFavorite;
        print("\n\n hhh ${m.isFavorite}");
      }
    }
  }
}