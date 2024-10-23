import 'app_consts.dart';
import 'classes.dart';

class Auth {

  Auth._privateConstructor();

  //The Singleton instance
  static final Auth _instance = Auth._privateConstructor();

  // Getter for the instance
  static Auth get instance => _instance;
  User? user;
  void saveLoggedInUser(User u){
    user = u;
  }
  User getUser(){
    if(user != null) print(user!.name);
    return (user == null ? User(id: 0, name: 'User', email: 'user1@gmail.com', password: '123456789', phone: '123456789')
            :user!);
  }

}
class MovieService {

  MovieService._privateConstructor();

  //The Singleton instance
  static final MovieService _instance = MovieService._privateConstructor();

  // Getter for the instance
  static MovieService get instance => _instance;

  final String baseUrl = '';

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
  void flipIsFavorite(String name)async{
    for(Movie m in movies){
      if(m.name == name){
        m.isFavorite = !m.isFavorite;
        print("\n\n hhh ${m.isFavorite}");
      }
    }
  }List<Movie> movies = [
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
    Movie(
      id: 3,
      name: 'The Lion King',
      description: 'After the death of his father, a young lion prince flees his kingdom only to learn the true meaning of responsibility and bravery.',
      categoryName: 'Children\'s Movie',
      img: '${assetsImagesPath}l.png',
      isFavorite: false,
      //trailer_path: 'assets/videos/LionKing.mp4',
        trailer_path: 'assets/videos/Batman.mp4'
    ),

    Movie(
      id: 4,
      name: 'Toy Story',
      description: 'A cowboy doll is profoundly threatened and jealous when a new spaceman figure supplants him as top toy in a boy\'s room.',
      categoryName: 'Animated',
      img: '${assetsImagesPath}toyStory.png',
      isFavorite: true,
      //trailer_path: 'assets/videos/ToyStory.mp4',
      trailer_path: 'assets/videos/Batman.mp4'
    ),

    Movie(
      id: 5,
      name: 'Finding Nemo',
      description: 'After his son is captured in the Great Barrier Reef and taken to Sydney, a timid clownfish sets out on a journey to bring him home.',
      categoryName: 'Adventure',
      img: '${assetsImagesPath}findingNemo.png',
      isFavorite: true,
      //trailer_path: 'assets/videos/FindingNemo.mp4',
        trailer_path: 'assets/videos/Batman.mp4'
    ),

    Movie(
      id: 6,
      name: 'The Incredibles',
      description: 'A family of undercover superheroes, while trying to live the quiet suburban life, are forced into action to save the world.',
      categoryName: 'Action/Adventure',
      img: '${assetsImagesPath}incredibles.png',
      isFavorite: false,
      //trailer_path: 'assets/videos/Incredibles.mp4',
        trailer_path: 'assets/videos/Batman.mp4'
    ),

    Movie(
      id: 7,
      name: 'Zootopia',
      description: 'In a city of anthropomorphic animals, a bunny cop and a cynical con artist fox must work together to uncover a conspiracy.',
      categoryName: 'Comedy/Adventure',
      img: '${assetsImagesPath}zootopia1.png',
      isFavorite: true,
      //trailer_path: 'assets/videos/Zootopia.mp4',
        trailer_path: 'assets/videos/Batman.mp4'
    ),

  ];
  List<Movie> get movesList => movies;
  List<Cinema> cinames =[
    Cinema(
      moviesName: ["Tangled", "The Lion King", "Toy Story"],
      name: 'Cinema City Stars',
      tickets: [
        Ticket(price: 100.0, start: "9 AM", end: "12 PM"),
        Ticket(price: 120.0, start: "1 PM", end: "4 PM"),
        Ticket(price: 150.0, start: "5 PM", end: "8 PM"),
      ],
    ),

    Cinema(
      moviesName: ["Finding Nemo", "Zootopia", "The Incredibles"],
      name: 'VOX Cinemas Mall of Egypt',
      tickets: [
        Ticket(price: 90.0, start: "10 AM", end: "1 PM"),
        Ticket(price: 110.0, start: "2 PM", end: "5 PM"),
        Ticket(price: 130.0, start: "6 PM", end: "9 PM"),
      ],
    ),

    Cinema(
      moviesName: ["Tangled", "The Lion King", "Finding Nemo"],
      name: 'Renaissance Cinema',
      tickets: [
        Ticket(price: 80.0, start: "11 AM", end: "2 PM"),
        Ticket(price: 100.0, start: "3 PM", end: "6 PM"),
        Ticket(price: 120.0, start: "7 PM", end: "10 PM"),
      ],
    ),

    Cinema(
      moviesName: ["Zootopia", "The Incredibles", "Toy Story"],
      name: 'Galaxy Cinemas',
      tickets: [
        Ticket(price: 75.0, start: "8 AM", end: "11 AM"),
        Ticket(price: 95.0, start: "12 PM", end: "3 PM"),
        Ticket(price: 115.0, start: "4 PM", end: "7 PM"),
      ],
    ),

    Cinema(
      moviesName: ["Tangled", "Zootopia", "Bat Man", "Cinderella"],
      name: 'Cinema Masr',
      tickets: [
        Ticket(price: 80.0, start: "5 AM", end: "7 PM"),
        Ticket(price: 40.0, start: "4 PM", end: "5 AM"),
      ],
    ),

  ];
}