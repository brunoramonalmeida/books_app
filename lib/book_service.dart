import 'package:books_app/book_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'book_service.g.dart';

@RestApi(baseUrl: 'https://www.googleapis.com/books/v1/')
abstract class BookService {
  factory BookService(Dio dio, {String baseUrl}) = _BookService;

  @GET('/volumes')
  Future<BookResponse> searchBooks(@Query('q') String query);
}
