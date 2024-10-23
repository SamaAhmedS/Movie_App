import 'package:flutter/material.dart';
import 'moviesInCinema.dart';
import 'favoriteMovies.dart';
import 'profilePage.dart';
import 'loginPage.dart';

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

    // If "Logout" is tapped (we'll use index 3 for logout)
    if (index == 3) {
      _logout(); // Handle logout
    } else {
      // Navigate to the selected page and keep bottom nav bar
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavContainer(selectedPage: index),
        ),
      );
    }
  }

  // Method to handle logout and navigate to LoginPage without BottomNavigationBar
  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
          (Route<dynamic> route) => false, // Remove all previous routes
    );
  }

  // Method to return the persistent bottom navigation bar
  BottomNavigationBar buildBottomNavBar() {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: false,
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
        BottomNavigationBarItem( // Add Logout Icon
          icon: Icon(Icons.logout),
          label: 'Logout',
        ),
      ],
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
