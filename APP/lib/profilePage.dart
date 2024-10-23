import 'package:flutter/material.dart';
import 'classes.dart';
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = getUser();

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://th.bing.com/th/id/R.19fa7497013a87bd77f7adb96beaf768?rik=144XvMigWWj2bw&riu=http%3A%2F%2Fwww.pngall.com%2Fwp-content%2Fuploads%2F5%2FUser-Profile-PNG-High-Quality-Image.png&ehk=%2Bat%2BrmqQuJrWL609bAlrUPYgzj%2B%2F7L1ErXRTN6ZyxR0%3D&risl=&pid=ImgRaw&r=0'),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Text(
              user.name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              user.email,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          Divider(height: 30, thickness: 1),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.deepPurple),
            title: Text('Password'),
            subtitle: Text(user.password),
          ),
          ListTile(
            leading: Icon(Icons.security, color: Colors.deepPurple),
            title: Text('Token'),
            subtitle: Text(user.token ?? 'N/A'),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.deepPurple),
            title: Text('ID'),
            subtitle: Text(user.id.toString()),
          ),
        ],
      ),
    );
  }
}
