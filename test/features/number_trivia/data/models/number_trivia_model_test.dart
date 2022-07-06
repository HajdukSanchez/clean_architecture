import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  const NumberTriviaModel testNumberTriviaModel = NumberTriviaModel(number: 1, text: "test");

  test('Should be a subclass of NumberTrivia entity', () async {
    // assert
    expect(testNumberTriviaModel, isA<NumberTrivia>());
  });

  group("fromJson", () {
    test('Should return a valid model when JSON number is an integer', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("trivia.json"));
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      // assert
      expect(result, testNumberTriviaModel);
    });

    test('Should return a valid model when JSON number is a double', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("trivia_double.json"));
      // act
      final result = NumberTriviaModel.fromJson(jsonMap);
      // assert
      expect(result, testNumberTriviaModel);
    });
  });

  group("toJson", () {
    test('Should return a JSON map containing the proper data', () async {
      // act
      final result = testNumberTriviaModel.toJson();
      // assert
      final expectedMap = {
        "text": "test",
        "number": 1,
      };
      expect(result, expectedMap);
    });
  });
}
