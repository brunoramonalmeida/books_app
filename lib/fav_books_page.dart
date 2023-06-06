import 'package:books_app/book_details_page.dart';
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

  toggleFavorite(BookItem book) {
    setState(() {
      _bookLocalStorageService.removeBookFromList(book);
      Fluttertoast.showToast(
          msg: "Removido dos favoritos",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    });
  }

  @override
  void initState() {
    super.initState();
    _bookLocalStorageService = BookLocalStorageService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookItem>>(
      future: _storageService.getBookList(),
      builder: (BuildContext context, AsyncSnapshot<List<BookItem>> snapshot) {
        if (snapshot.hasData) {
          List<BookItem> bookList = snapshot.data!;
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
                    onPressed: () => toggleFavorite(book),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Erro ao carregar a lista de livros favoritos.');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
