import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/util/input_converter.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetNumberTrivia extends Mock implements GetNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetNumberTrivia mockGetNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetNumberTrivia = MockGetNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
        getNumberTrivia: mockGetNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('Should initialState be NumberTriviaEmptyState', () async {
    // assert
    expect(bloc.state, equals(NumberTriviaEmptyState()));
  });

  group("GetNumberTriviaNumberEvent", () {
    const testNumberString = '1';
    const testNumberParsed = 1;
    const testNumberTrivia = NumberTrivia(number: 1, text: "test");

    setUp(() {
      when(() => mockInputConverter.stringToUnsignedInteger(testNumberString))
          .thenReturn(const Right(testNumberParsed));

      when(() => mockGetNumberTrivia(const Params(number: testNumberParsed)))
          .thenAnswer((_) async => const Right(testNumberTrivia));
    });

    test('Should call the inputConverter to validate and convert string to a unsigned integer',
        () async {
      // act
      bloc.add(const GetTriviaForConcreteNumberEvent(numberString: testNumberString));
      await untilCalled(() => mockInputConverter.stringToUnsignedInteger(testNumberString));
      // assert
      verify(() => mockInputConverter.stringToUnsignedInteger(testNumberString));
    });

    test('Should emit [Error] when input is invalid', () async {
      // arrange
      when(() => mockInputConverter.stringToUnsignedInteger(testNumberString))
          .thenReturn(Left(InvalidInputFailure()));
      // assert later
      final expectedList = [const NumberTriviaErrorState(message: invalidInputFailureMessage)];
      expectLater(bloc.stream.asBroadcastStream(),
          emitsInOrder(expectedList)); // Expected stream order when we call the bloc event
      // act
      bloc.add(const GetTriviaForConcreteNumberEvent(numberString: testNumberString));
    });

    test('Should get data from the GetNumberTrivia usecase', () async {
      // act
      bloc.add(const GetTriviaForConcreteNumberEvent(numberString: testNumberString));
      await untilCalled(() => mockGetNumberTrivia(const Params(number: testNumberParsed)));
      // assert
      verify(() => mockGetNumberTrivia(const Params(number: testNumberParsed)));
    });

    test('Should emit [loading, loaded] when data is gotten successfully', () async {
      // assert later
      final expectedList = [
        NumberTriviaLoadingState(),
        const NumberTriviaLoadedState(trivia: testNumberTrivia)
      ];
      expectLater(bloc.stream.asBroadcastStream(),
          emitsInOrder(expectedList)); // Expected stream order when we call the bloc event
      // act
      bloc.add(const GetTriviaForConcreteNumberEvent(numberString: testNumberString));
    });

    test('Should emit [loading, Error] when getting data fails', () async {
      // arrange
      when(() => mockGetNumberTrivia(const Params(number: testNumberParsed)))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expectedList = [
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(message: serverFailureMessage)
      ];
      expectLater(bloc.stream.asBroadcastStream(),
          emitsInOrder(expectedList)); // Expected stream order when we call the bloc event
      // act
      bloc.add(const GetTriviaForConcreteNumberEvent(numberString: testNumberString));
    });

    test('Should emit [loading, Error] with a proper message when getting data fails', () async {
      // arrange
      when(() => mockGetNumberTrivia(const Params(number: testNumberParsed)))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expectedList = [
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(message: serverFailureMessage)
      ];
      expectLater(bloc.stream.asBroadcastStream(),
          emitsInOrder(expectedList)); // Expected stream order when we call the bloc event
      // act
      bloc.add(const GetTriviaForConcreteNumberEvent(numberString: testNumberString));
    });
  });

  group("GetRandomTriviaNumberEvent", () {
    const testNumberTrivia = NumberTrivia(number: 1, text: "test");

    setUp(() {
      when(() => mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => const Right(testNumberTrivia));
    });

    test('Should get data from the GetRandomNumberTrivia usecase', () async {
      // act
      bloc.add(GetTriviaForRandomNumberEvent());
      await untilCalled(() => mockGetRandomNumberTrivia(NoParams()));
      // assert
      verify(() => mockGetRandomNumberTrivia(NoParams()));
    });

    test('Should emit [loading, loaded] when data is gotten successfully', () async {
      // assert later
      final expectedList = [
        NumberTriviaLoadingState(),
        const NumberTriviaLoadedState(trivia: testNumberTrivia)
      ];
      expectLater(bloc.stream.asBroadcastStream(),
          emitsInOrder(expectedList)); // Expected stream order when we call the bloc event
      // act
      bloc.add(GetTriviaForRandomNumberEvent());
    });

    test('Should emit [loading, Error] when getting data fails', () async {
      // arrange
      when(() => mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => Left(ServerFailure()));
      // assert later
      final expectedList = [
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(message: serverFailureMessage)
      ];
      expectLater(bloc.stream.asBroadcastStream(),
          emitsInOrder(expectedList)); // Expected stream order when we call the bloc event
      // act
      bloc.add(GetTriviaForRandomNumberEvent());
    });

    test('Should emit [loading, Error] with a proper message when getting data fails', () async {
      // arrange
      when(() => mockGetRandomNumberTrivia(NoParams()))
          .thenAnswer((_) async => Left(CacheFailure()));
      // assert later
      final expectedList = [
        NumberTriviaLoadingState(),
        const NumberTriviaErrorState(message: serverFailureMessage)
      ];
      expectLater(bloc.stream.asBroadcastStream(),
          emitsInOrder(expectedList)); // Expected stream order when we call the bloc event
      // act
      bloc.add(GetTriviaForRandomNumberEvent());
    });
  });
}
