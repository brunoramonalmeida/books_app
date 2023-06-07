import 'package:books_app/models/book_item.dart';
import 'package:books_app/models/book_response.dart';
import 'package:books_app/services/book_service.dart';
import 'package:flutter/foundation.dart';

class SearchProvider extends ChangeNotifier {
  String _searchQuery = '';

  Future<BookResponse>? _bookResponseFuture = null;

  String get searchQuery => _searchQuery;

  Future<BookResponse>? get bookResponse => _bookResponseFuture;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void getBooks(BookService bookService,
      {int startIndex = 0, int maxResults = 40}) {
    _bookResponseFuture =
        bookService.searchBooks(searchQuery, startIndex, maxResults);
    notifyListeners();
  }

  void setFavorite(BookItem book, bool value) {
    _bookResponseFuture?.then((bookResponse) {
      if (bookResponse != null) {
        List<BookItem>? bookList = bookResponse.items;
        if (bookList != null)
          for (int i = 0; i < bookList.length; i++) {
            if (bookList[i].id == book.id) {
              if (bookList[i].isFavorite != null) {
                bookList[i].isFavorite = !bookList[i].isFavorite!;
                break;
              } else {
                bookList[i].isFavorite = value;
              }
            }
          }
      }
    });

    notifyListeners();
  }
}
