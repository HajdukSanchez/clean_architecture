import 'package:dartz/dartz.dart';

import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';

// This type def allow us to convert long names in a sepcific way like an alias.
typedef _NumberOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSouce;
  final NumberTriviaLocalDataSource localDataSouce;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.remoteDataSouce, required this.localDataSouce, required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getNumberTrivia(int number) async {
    return await _getTrivia(() => remoteDataSouce.getNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() => remoteDataSouce.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _NumberOrRandomChooser getByNumberOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getByNumberOrRandom();
        localDataSouce.cacheNumberTrivia(remoteTrivia); // Save in cache
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSouce.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
