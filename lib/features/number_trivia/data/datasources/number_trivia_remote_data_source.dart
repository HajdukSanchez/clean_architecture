import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getNumberTrivia(int number);

  ///  Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

const baseUrl = "numbersapi.com";

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getNumberTrivia(int number) {
    return _getNumberTriviaFromUrl(
      Uri.http(
        baseUrl,
        "$number",
      ),
    );
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getNumberTriviaFromUrl(
      Uri.http(
        baseUrl,
        "random",
      ),
    );
  }

  Future<NumberTriviaModel> _getNumberTriviaFromUrl(Uri url) async {
    final response = await client.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
