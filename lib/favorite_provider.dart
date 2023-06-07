import 'package:books_app/book_item.dart';
import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier {
  List<BookItem> _favorites = [];

  List<BookItem> get favoriteList => _favorites;

  void updateFavorites(List<BookItem> new_list) {
    _favorites = new_list;
    notifyListeners();
  }
}
