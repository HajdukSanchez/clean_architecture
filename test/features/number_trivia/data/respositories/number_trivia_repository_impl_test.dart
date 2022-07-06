import 'package:flutter_test/flutter_test.dart';

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture/core/platform/network_info.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';

class MockRemoteDataSource extends Mock implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  const int testNumber = 1;
  const NumberTriviaModel testNumberTriviaModel =
      NumberTriviaModel(number: testNumber, text: 'test');
  const NumberTrivia testNumberTrivia = testNumberTriviaModel;

  late NumberTriviaRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSouce;
  late MockLocalDataSource mockLocalDataSouce;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSouce = MockRemoteDataSource();
    mockLocalDataSouce = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      localDataSouce: mockLocalDataSouce,
      remoteDataSouce: mockRemoteDataSouce,
      networkInfo: mockNetworkInfo,
    );

    when(() => mockRemoteDataSouce.getNumberTrivia(testNumber))
        .thenAnswer((_) async => testNumberTriviaModel);

    when(() => mockRemoteDataSouce.getRandomNumberTrivia())
        .thenAnswer((_) async => testNumberTriviaModel);

    when(() => mockLocalDataSouce.cacheNumberTrivia(testNumberTriviaModel))
        .thenAnswer((_) async => any);
  });

  void runTestOnline(Function body) {
    group("device is online", () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestOffline(Function body) {
    group("device is offline", () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group("getNumberTrivia", () {
    test('Should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      await repository.getNumberTrivia(testNumber);
      // assert
      verify(() =>
          mockNetworkInfo.isConnected); // Verify the method was called when run the last statement
    });

    runTestOnline(() {
      test('Should return remote data when the call to remote data source is succesfull', () async {
        // act
        final result = await repository.getNumberTrivia(testNumber);
        // assert
        verify(() => mockRemoteDataSouce.getNumberTrivia(testNumber));
        expect(result, equals(const Right(testNumberTrivia)));
      });

      test('Should cache the data locally when the call to remote data source is succesfull',
          () async {
        // act
        await repository.getNumberTrivia(testNumber);
        // assert
        verify(() => mockRemoteDataSouce.getNumberTrivia(testNumber));
        verify(() => mockLocalDataSouce.cacheNumberTrivia(testNumberTriviaModel));
      });

      test('Should return server failure when the call to remote data source is unsuccesfull',
          () async {
        // arrange
        when(() => mockRemoteDataSouce.getNumberTrivia(testNumber)).thenThrow(ServerException());
        // act
        final result = await repository.getNumberTrivia(testNumber);
        // assert
        verify(() => mockRemoteDataSouce.getNumberTrivia(testNumber));
        verifyZeroInteractions(
            mockLocalDataSouce); // No interaction with local data source beacuse it wolud be a server failure
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('Should return last locally cached data when cached data is present', () async {
        // arrange
        when(() => mockLocalDataSouce.getLastNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);
        // act
        final result = await repository.getNumberTrivia(testNumber);
        // assert
        verifyZeroInteractions(mockRemoteDataSouce);
        verify(() => mockLocalDataSouce.getLastNumberTrivia());
        expect(result, equals(const Right(testNumberTrivia)));
      });

      test('Should return CacheFailure when there is no cached data present', () async {
        // arrange
        when(() => mockLocalDataSouce.getLastNumberTrivia()).thenThrow(CacheException());
        // act
        final result = await repository.getNumberTrivia(testNumber);
        // assert
        verifyZeroInteractions(mockRemoteDataSouce);
        verify(() => mockLocalDataSouce.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });

  group("getRandomNumberTrivia", () {
    test('Should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      await repository.getRandomNumberTrivia();
      // assert
      verify(() =>
          mockNetworkInfo.isConnected); // Verify the method was called when run the last statement
    });

    runTestOnline(() {
      test('Should return remote data when the call to remote data source is succesfull', () async {
        // act
        final result = await repository.getRandomNumberTrivia();
        // assert
        verify(() => mockRemoteDataSouce.getRandomNumberTrivia());
        expect(result, equals(const Right(testNumberTrivia)));
      });

      test('Should cache the data locally when the call to remote data source is succesfull',
          () async {
        // act
        await repository.getRandomNumberTrivia();
        // assert
        verify(() => mockRemoteDataSouce.getRandomNumberTrivia());
        verify(() => mockLocalDataSouce.cacheNumberTrivia(testNumberTriviaModel));
      });

      test('Should return server failure when the call to remote data source is unsuccesfull',
          () async {
        // arrange
        when(() => mockRemoteDataSouce.getRandomNumberTrivia()).thenThrow(ServerException());
        // act
        final result = await repository.getRandomNumberTrivia();
        // assert
        verify(() => mockRemoteDataSouce.getRandomNumberTrivia());
        verifyZeroInteractions(
            mockLocalDataSouce); // No interaction with local data source beacuse it wolud be a server failure
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('Should return last locally cached data when cached data is present', () async {
        // arrange
        when(() => mockLocalDataSouce.getLastNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);
        // act
        final result = await repository.getRandomNumberTrivia();
        // assert
        verifyZeroInteractions(mockRemoteDataSouce);
        verify(() => mockLocalDataSouce.getLastNumberTrivia());
        expect(result, equals(const Right(testNumberTrivia)));
      });

      test('Should return CacheFailure when there is no cached data present', () async {
        // arrange
        when(() => mockLocalDataSouce.getLastNumberTrivia()).thenThrow(CacheException());
        // act
        final result = await repository.getRandomNumberTrivia();
        // assert
        verifyZeroInteractions(mockRemoteDataSouce);
        verify(() => mockLocalDataSouce.getLastNumberTrivia());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}
