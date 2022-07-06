import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {}

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  const NumberTrivia testNumberTrivia = NumberTrivia(text: "test", number: 1);

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  test("Should get random trivia from the repository", () async {
    // Arrange
    when(() => mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => const Right(testNumberTrivia));
    // Act
    final result = await usecase(NoParams());
    // Assert
    expect(result, const Right(testNumberTrivia));
    // Verify that the method was called once
    verify(() => mockNumberTriviaRepository.getRandomNumberTrivia());
    // No more interactions with the mock
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
