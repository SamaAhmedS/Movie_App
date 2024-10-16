
import 'app_consts.dart';
class User {
  int id;
  String? image;
  String name;
  String email;
  String password;
  String? token;


  User(
      {
        required this.id,
        this.image,
        required this.name,
        required this.email,
        required this.password,
        this.token
      });
}
User usersDB(){
  List<User> users = [
    User(
      id: 1,
      image: 'https://example.com/image1.jpg',
      name: 'Alice Johnson',
      email: '123 Elm Street, Springfield',
      password: "kg5322d6g",
    )
  ];

  /*for (var user in users) {
    print('${user.name} (${user.name.initials})');
    print('Address: ${user.address}');
    print('Followers: ${user.followers}');
    print('Following: ${user.following}\n');
  }*/
  return users[1];
}


extension StringsExt on String {
  String get initials {
    // Split the string by spaces
    List<String> words = trim().split(' ');

    // Check if there are any words in the list
    if (words.isEmpty) return '';

    // Take the first letter of each word and capitalize it
    String initials = words.map((word) => word[0].toUpperCase()).join('.');

    // Return initials with dots
    return initials;
  }
}