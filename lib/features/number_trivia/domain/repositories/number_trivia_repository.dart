import 'package:dartz/dartz.dart';

import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

/// Class to represent the repository of the number trivia.
abstract class NumberTriviaRepository {
  /// Method to get the number trivia.
  Future<Either<Failure, NumberTrivia>> getNumberTrivia(int number);

  /// Method to get the random number trivia.
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
