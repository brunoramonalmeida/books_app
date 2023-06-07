import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/book_item.dart';

class BookDetailsScreen extends StatelessWidget {
  final BookItem book;

  BookDetailsScreen({required this.book});

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Livro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.volumeInfo?.title ?? '',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Autor(es): ${book.volumeInfo?.authors?.join(', ') ?? ''}',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Data de Publicação: ${book.volumeInfo?.publishedDate ?? ''}',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Descrição: ${book.volumeInfo?.description ?? ''}',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Link para compra:',
                  style: TextStyle(fontSize: 16.0),
                ),
                book.saleInfo?.buyLink != null
                    ? ElevatedButton(
                        onPressed: () =>
                            _launchUrl(book.saleInfo?.buyLink ?? ''),
                        child: Text('Comprar livro'),
                      )
                    : Text(
                        'Não disponível para compra',
                        style: TextStyle(fontSize: 16.0),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
