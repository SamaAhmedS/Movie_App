import 'package:flutter/material.dart';
import 'movies_page.dart';

class BottomNavContainer extends StatefulWidget {
  const BottomNavContainer({super.key});

  @override
  State<BottomNavContainer> createState() => _BottomNavContainerState();
}

class _BottomNavContainerState extends State<BottomNavContainer> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedPage,
        children: [
          MoviesPage(key: UniqueKey(), isLoggedIn: true, isFavoritePage: false),
          MoviesPage(key: UniqueKey(), isLoggedIn: true, isFavoritePage: true),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: selectedPage,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
        ],
        onTap: (newIndex) {
          setState(() {
            selectedPage = newIndex;
          });
        },
      ),
    );
  }
}
