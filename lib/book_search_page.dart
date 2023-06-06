import 'package:books_app/book_details_page.dart';
import 'package:books_app/book_item.dart';
import 'package:books_app/book_local_storage_service.dart';
import 'package:books_app/book_response.dart';
import 'package:books_app/book_service.dart';
import 'package:books_app/search_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BookSearchScreen extends StatefulWidget {
  @override
  _BookSearchScreenState createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  late Dio _dio;
  late Future<BookResponse> _bookResponseFuture;
  late BookService _bookService;
  late BookLocalStorageService _bookLocalStorageService;

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    _bookResponseFuture = Future.value(BookResponse());
    _bookService = BookService(_dio);
    _bookLocalStorageService = BookLocalStorageService();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, searchProvider, _) {
        return Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    searchProvider.updateSearchQuery(value);
                  },
                  decoration: InputDecoration(
                    labelText: 'Digite o nome do livro',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          _bookResponseFuture = _bookService
                              .searchBooks(searchProvider.searchQuery);
                        });
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<BookResponse>(
                  future: _bookResponseFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      final books = snapshot.data?.items ?? [];
                      return ListView.builder(
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final book = books[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookDetailsScreen(book: book),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(book.volumeInfo?.title ?? ''),
                              subtitle: Text(
                                  book.volumeInfo?.authors?.join(', ') ?? ''),
                              trailing: IconButton(
                                icon: Icon(
                                  book.isFavorite ?? false
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: Colors.blue,
                                ),
                                onPressed: () => toggleFavorite(book),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  toggleFavorite(BookItem book) {
    setState(() {
      _bookLocalStorageService.addBookToStorage(book);
      book.isFavorite = !book.isFavorite!;
      var message = book.isFavorite ?? true
          ? "Adicionado aos favoritos"
          : "Removido aos favoritos";
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    });
  }
}
