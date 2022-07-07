import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  const String jsonFileName = "trivia.json";
  final testNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture(jsonFileName)));

  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void mockSetUpHttpClientSuccess200(String urlParam) {
    when(() => mockHttpClient
            .get(Uri(path: "$baseUrl/$urlParam"), headers: {"Content-Type": "application/json"}))
        .thenAnswer((_) async => http.Response(fixture(jsonFileName), 200));
  }

  void mockSetUpHttpClientFailure404(String urlParam) {
    when(() => mockHttpClient
            .get(Uri(path: "$baseUrl/$urlParam"), headers: {"Content-Type": "application/json"}))
        .thenAnswer((_) async => http.Response("Something went wrong", 404));
  }

  group("getNumberTrivia", () {
    const String urlParam = "$testNumber"; // Parameter for the URL Mock

    test('''Should perfom a GET request on a URL with number
    beign the endpoint with application/json header''', () async {
      //  arrange
      mockSetUpHttpClientSuccess200(urlParam);
      // act
      dataSource.getNumberTrivia(testNumber);
      // assert
      verify(() => mockHttpClient
          .get(Uri(path: "$baseUrl/$urlParam"), headers: {"Content-Type": "application/json"}));
    });

    test('Should return a NumberTrivia when response code is 200', () async {
      // arrange
      mockSetUpHttpClientSuccess200(urlParam);
      // act
      final result = await dataSource.getNumberTrivia(testNumber);
      // assert
      expect(result, equals(testNumberTriviaModel));
    });

    test('Should throw a ServerException when response code is different from 200', () async {
      // arrange
      mockSetUpHttpClientFailure404(urlParam);
      // act
      final call = dataSource.getNumberTrivia;
      // assert
      expect(() => call(testNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group("getRandomNumberTrivia", () {
    const String urlParam = "random"; // Parameter for the URL Mock

    test('''Should perfom a GET request on a URL with number
    beign the endpoint with application/json header''', () async {
      //  arrange
      mockSetUpHttpClientSuccess200(urlParam);
      // act
      dataSource.getRandomNumberTrivia();
      // assert
      verify(() => mockHttpClient
          .get(Uri(path: "$baseUrl/$urlParam"), headers: {"Content-Type": "application/json"}));
    });

    test('Should return a NumberTrivia when response code is 200', () async {
      // arrange
      mockSetUpHttpClientSuccess200(urlParam);
      // act
      final result = await dataSource.getRandomNumberTrivia();
      // assert
      expect(result, equals(testNumberTriviaModel));
    });

    test('Should throw a ServerException when response code is different from 200', () async {
      // arrange
      mockSetUpHttpClientFailure404(urlParam);
      // act
      final call = dataSource.getRandomNumberTrivia;
      // assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
