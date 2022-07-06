import 'package:dartz/dartz.dart';

import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetNumberTrivia {
  final NumberTriviaRepository repository;

  GetNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute({required int number}) async {
    return await repository.getNumberTrivia(number);
  }
}
