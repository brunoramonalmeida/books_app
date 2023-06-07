import 'package:books_app/about_page.dart';
import 'package:books_app/book_search_page.dart';
import 'package:books_app/fav_books_page.dart';
import 'package:books_app/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const BooksApp());

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (_) => AppNavigationState(),
          child: BottomNavigationBarWidget()),
    );
  }
}

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    final navigationState = Provider.of<AppNavigationState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscador de livros'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => SearchProvider(),
        child: IndexedStack(
          index: navigationState.selectedIndex,
          children: [BookSearchScreen(), FavBooksPageScreen(), AboutScreen()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Livros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Sobre',
          ),
        ],
        currentIndex: navigationState.selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: navigationState.updateSelectedIndex,
      ),
    );
  }
}

class AppNavigationState with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
