import 'classes.dart';

String token ='';

class AuthService {
  final String baseUrl = 'http://bloggy.runasp.net/api/Auth';

  Future<void> registerUser({required String name, required String phone, required String email, required String password, required String confirmedPassword}) async {


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
  Future<List<dynamic>> movieCinema(String name) async{
    List<Cinema> cinames =[
      Cinema(moviesName: ["Tangled","Batman"], name: 'Cinema Masr', tickets: [Ticket(price: 80.0, end: "7 pm", start: "7 AM")])
    ];
    return cinames;
  }

  Future<List<dynamic>> fetchMovies() async {
    final url = '';
    List<Movie> movies = [
      Movie(id: 0,name: 'Tangled',
          description: 'The magically long-haired Rapunzel has spent her entire life in a tower, but now that a runaway thief has stumbled upon her, she is about to discover the world for the first time, and who she really is.',
          categoryName: 'Children\'s Movie', img: 'assets/images/tangled.PNG',),
      Movie(id: 1,name: 'Cinderella',
          description: "When Cinderella's cruel stepmother prevents her from attending the Royal Ball, she gets some unexpected help from the lovable mice Gus and Jaq and from her Fairy Godmother.",
          categoryName: 'Children\'s Movie', img: 'assets/images/Cinderella.png',),
      Movie(id: 2,name: 'Bat Man',
          description: 'The Dark Knight of Gotham City begins his war on crime with his first major enemy being Jack Napier, a criminal who becomes the clownishly homicidal Joker.',
          categoryName: 'Varies', img: 'assets/images/batman.png',),
    ];
    return movies;
  }
  void deleteFromFavorite(int movieID)async{

  }
}