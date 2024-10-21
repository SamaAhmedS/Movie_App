import 'app_consts.dart';
class Cinema{
  final String name;
  List<String> moviesName;
  List<Ticket> tickets;
  Cinema({required this.moviesName, required this.name, required this.tickets});
}
class Ticket{
  double price;
  //DateTime start, end;
  String start, end;
  Ticket({required this.price, required this.end, required this.start});
}
class Movie {
  final int? id;
  final String name;
  final String description;
  final String? img;
  final String categoryName;
  final int? categoryID;
  final List<Comment>? comments;
  bool isFavorite;
   final String trailer_path;

  Movie({
    this.id,
    required this.name,
    required this.description,
    this.img,
    required this.categoryName,
    this.categoryID,
    this.comments,
    this.isFavorite = false,
    required this.trailer_path,
  });// Factory method to create a Blog object from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    var commentList = json['comments'] as List;
    List<Comment> comments = commentList.map((c) => Comment.fromJson(c)).toList();

    return Movie(
      id: json['id'],
      name: json['title'],
      description: json['content'],
      //img: json['img'] ?? '${assetsImagesPath}img.png', // Handle possible null
      img: '${assetsImagesPath}img.png', // Handle possible null
      categoryName: json['category'],
      comments: comments,
      trailer_path: 'assets/videos/Batman.mp4',
    );
  }
}

class Comment {
  final String username;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.username,
    required this.content,
    required this.createdAt,
  });

  // Factory method to create a Comment object from JSON
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      username: json['username'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}