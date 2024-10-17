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
          description: 'rapunzel rapunzel rapunzel rapunzel rapunzel rapunzelrapunzelrapunzelrapunzelrapunzel',
          categoryName: 'Children\'s Movie', img: 'assets/images/img.png'),
      Movie(id: 1,name: 'cinderella',
          description: 'cinderella cinderella cinderella cinderella rapunzel cinderellarapunzelrapunzelrapunzelrapunzelrapunzel',
          categoryName: 'Children\'s Movie', img: 'assets/images/img.png', isFavorite: true),
      Movie(id: 2,name: 'batman',
          description: 'batman batman batman batman batman batmanrapunzelrapunzelrapunzelrapunzel',
          categoryName: 'Varies', img: 'assets/images/img.png', isFavorite: true),
    ];
    return movies;
  }
  void deleteFromFavorite(int movieID)async{

  }
}