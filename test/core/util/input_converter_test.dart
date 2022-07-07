import 'package:flutter_test/flutter_test.dart';

import 'package:dartz/dartz.dart';

import 'package:clean_architecture/core/util/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group("stringToUnsignedInteger", () {
    test('Should return an integer when string represents an unsigned integer', () async {
      // arrange
      const str = "123";
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, const Right(123));
    });

    test('Should return a Failure when string is not an integer', () async {
      // arrange
      const str = "abc";
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, Left(InvalidInputFailure()));
    });

    test('Should return a Failure when string is a negative integer', () async {
      // arrange
      const str = "-123";
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
