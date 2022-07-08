import 'package:bloc/bloc.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/util/input_converter.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cachedFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage = 'Invalid Input - The number must be positive or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetNumberTrivia getNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  /// The constructor to define the events and methods to handle each, aslo the dependencies.
  NumberTriviaBloc(
      {required this.getNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter})
      : super(NumberTriviaEmptyState()) {
    on<GetTriviaForConcreteNumberEvent>(_onGetNumberTriviaEvent);
    on<GetTriviaForRandomNumberEvent>(_onGetRandomNumberTriviaEvent);
  }

  /// This method handle the numberTrivia event by user and emnit states depending on responses.
  void _onGetNumberTriviaEvent(
      GetTriviaForConcreteNumberEvent event, Emitter<NumberTriviaState> emit) async {
    final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);
    // Get data and decide to emit error or success state
    await inputEither.fold((failure) {
      emit(const NumberTriviaErrorState(message: invalidInputFailureMessage));
    }, (integer) async {
      // Emit loading state
      emit(NumberTriviaLoadingState());
      final failureOrTrivia = await getNumberTrivia(Params(number: integer));
      // Get data and decide to emit error or success state
      _eitherFailureOrTriviaState(failureOrTrivia, emit);
    });
  }

  /// This method handle the randomNumberTriva event to emit states depending on responses and get data by random number.
  void _onGetRandomNumberTriviaEvent(
      GetTriviaForRandomNumberEvent event, Emitter<NumberTriviaState> emit) async {
    // Emit loading state
    emit(NumberTriviaLoadingState());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    // Get data and decide to emit error or success state
    _eitherFailureOrTriviaState(failureOrTrivia, emit);
  }

  /// This method handle the Either response of a failure or Trivia
  ///
  /// So we can handle multiples events deoendening on the response the Either return.
  void _eitherFailureOrTriviaState(
      Either<Failure, NumberTrivia> failureOrTrivia, Emitter<NumberTriviaState> emit) {
    failureOrTrivia.fold(
        (failure) => emit(NumberTriviaErrorState(message: _mapFailureToMessage(failure))),
        (trivia) => emit(NumberTriviaLoadedState(trivia: trivia)));
  }

  /// This method is to handle the Failure type given by the usecases.
  ///
  /// So probably we can get a different message depending on the failure type.
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cachedFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
