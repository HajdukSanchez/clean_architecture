import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  const String jsonFileName = "trivia_cached.json";
  late NumberTriviaLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group("getLastNumberTrivia", () {
    final testNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture(jsonFileName)));

    test('Should return NumberTrivia from shared preferences when is one in the cache', () async {
      // arrange
      when(() => mockSharedPreferences.getString(cachedKey)).thenReturn(fixture(jsonFileName));
      // act
      final result = await dataSource.getLastNumberTrivia();
      // assert
      verify(() => mockSharedPreferences.getString(cachedKey));
      expect(result, equals(testNumberTriviaModel));
    });

    test('Should throw a CacheExpection when there is not a cached value', () async {
      // arrange
      when(() => mockSharedPreferences.getString(cachedKey)).thenReturn(null);
      // act
      final call = dataSource.getLastNumberTrivia; // Other way to make the call of the function
      // assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("cacheNumberTrivia", () {
    const testNumberTriviaModel = NumberTriviaModel(number: 1, text: "test");

    test('Should call SharedPreferences to cache the data', () async {
      // arrange
      final expectedJsonString = json.encode(testNumberTriviaModel.toJson());
      when(() => mockSharedPreferences.setString(cachedKey, expectedJsonString))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheNumberTrivia(testNumberTriviaModel);
      // assert
      verify(() => mockSharedPreferences.setString(cachedKey, expectedJsonString));
    });
  });
}
