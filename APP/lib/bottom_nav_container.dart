import 'package:flutter/material.dart';
import 'moviesInCinema.dart';
import 'favoriteMovies.dart';
import 'profilePage.dart';

class BottomNavContainer extends StatefulWidget {
  final int selectedPage;

  const BottomNavContainer({super.key, this.selectedPage = 0});

  @override
  _BottomNavContainerState createState() => _BottomNavContainerState();
}

class _BottomNavContainerState extends State<BottomNavContainer> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedPage;
  }

  // Method to handle navigation with pushReplacement but keeping bottom nav
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return; // Prevent reloading the same page

    setState(() {
      _selectedIndex = index;
    });

    Widget page;
    switch (index) {
      case 0:
        page = MoviesInCinema();
        break;
      case 1:
        page = FavoriteMovies();
        break;
      case 2:
        page = ProfilePage();
        break;
      default:
        page = MoviesInCinema();
    }

    // Navigate to the selected page and keep bottom nav bar
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavContainer(selectedPage: index),
      ),
    );
  }

  // Method to return the persistent bottom navigation bar
  BottomNavigationBar buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ]
      ,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget selectedPage;
    switch (_selectedIndex) {
      case 0:
        selectedPage = MoviesInCinema();
        break;
      case 1:
        selectedPage = FavoriteMovies();
        break;
    case 2:
        selectedPage = ProfilePage();
        break;
      default:
        selectedPage = MoviesInCinema();
    }

    return Scaffold(
      body: selectedPage,
      bottomNavigationBar: buildBottomNavBar(), // Bottom Nav is persistent
    );
  }
}


