import 'package:shared_preferences/shared_preferences.dart';
import 'book_item.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class BookLocalStorageService {
  static const String _bookListKey = 'bookList';

  Future<void> saveBookList(List<BookItem> bookList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> bookListJson =
        bookList.map((book) => book.toJson()).toList();

    List<String> bookListString =
        bookListJson.map((json) => jsonEncode(json)).toList();

    prefs.setStringList(_bookListKey, bookListString);
  }

  Future<List<BookItem>> getBookList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? bookListJson = prefs.getStringList(_bookListKey);
    if (bookListJson != null) {
      List<BookItem> bookList = bookListJson.map((json) {
        Map<String, dynamic> decodedJson;
        try {
          decodedJson = jsonDecode(json);
        } catch (e) {
          decodedJson = {};
        }
        return BookItem.fromJson(decodedJson);
      }).toList();
      return bookList;
    } else {
      return [];
    }
  }

  Future<void> addBookToStorage(BookItem book) async {
    List<BookItem> existingList = await getBookList();

    final existingBookIndex = existingList.indexWhere((b) => b.id == book.id);
    if (existingBookIndex == -1) {
      existingList.add(book);
    }
    await saveBookList(existingList);
  }

  Future<void> removeBookFromList(BookItem book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? bookListJson = prefs.getStringList(_bookListKey);
    if (bookListJson != null) {
      List<BookItem> bookList = bookListJson.map((json) {
        Map<String, dynamic> decodedJson = jsonDecode(json);
        return BookItem.fromJson(decodedJson);
      }).toList();

      bookList.removeWhere((item) => item.id == book.id);

      List<String> updatedBookListJson =
          bookList.map((item) => jsonEncode(item.toJson())).toList();

      await prefs.setStringList(_bookListKey, updatedBookListJson);
    }
  }
}
