import 'package:books_app/book_details_page.dart';
import 'package:books_app/favorite_provider.dart';
import 'package:books_app/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'book_local_storage_service.dart';
import 'book_item.dart';

class FavBooksPageScreen extends StatefulWidget {
  @override
  State<FavBooksPageScreen> createState() => _FavBooksPageScreenState();
}

class _FavBooksPageScreenState extends State<FavBooksPageScreen> {
  final BookLocalStorageService _storageService = BookLocalStorageService();
  late BookLocalStorageService _bookLocalStorageService;
  late FavoriteProvider _favoriteProvider;
  late SearchProvider _searchProvider;

  toggleFavorite(BookItem book) {
    _bookLocalStorageService.removeBookFromList(book);
    _searchProvider.setFavorite(book, false);
    Fluttertoast.showToast(
        msg: "Removido dos favoritos",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  @override
  void initState() {
    super.initState();
    _bookLocalStorageService = BookLocalStorageService();
    _favoriteProvider = FavoriteProvider();
    _searchProvider = SearchProvider();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookItem>>(
      future: _storageService.getBookList(),
      builder: (BuildContext context, AsyncSnapshot<List<BookItem>> snapshot) {
        if (snapshot.hasData) {
          List<BookItem> bookList = snapshot.data!;
          if (bookList.length > 0) {
            return ListView.builder(
              itemCount: bookList.length,
              itemBuilder: (BuildContext context, int index) {
                BookItem book = bookList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsScreen(book: book),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(book.volumeInfo?.title ?? ''),
                    subtitle: Text(book.volumeInfo?.authors?.join(', ') ?? ''),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.bookmark,
                          color: Colors.blue,
                        ),
                        onPressed: () => setState(() {
                              toggleFavorite(book);
                            })),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Você ainda não favoritou nenhum livro'));
          }
        } else if (snapshot.hasError) {
          return Text('Erro ao carregar a lista de livros favoritos.');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
