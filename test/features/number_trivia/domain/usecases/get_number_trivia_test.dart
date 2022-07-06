import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  late GetNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  const int testNumber = 1;
  const NumberTrivia testNumberTrivia = NumberTrivia(text: "test", number: testNumber);

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetNumberTrivia(mockNumberTriviaRepository);
  });

  test("Should get trivia for the number from the repository", () async {
    // Arrange
    // When we call this function, it will return what we tell it to return.
    when(() => mockNumberTriviaRepository.getNumberTrivia(testNumber))
        .thenAnswer((_) async => const Right(testNumberTrivia));
    // Act
    // This one is the fuction to test.
    final result = await usecase.execute(number: testNumber);
    // Assert
    expect(result, const Right(testNumberTrivia));
    // Verify that the method was called once
    verify(() => mockNumberTriviaRepository.getNumberTrivia(testNumber));
    // No more interactions with the mock
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
