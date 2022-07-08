part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  final NumberTrivia? trivia;
  final String? message;

  const NumberTriviaState({this.trivia, this.message});

  @override
  List<Object> get props => [];
}

/// Initial and empty state
class NumberTriviaEmptyState extends NumberTriviaState {}

/// Loading Number trivia state
class NumberTriviaLoadingState extends NumberTriviaState {}

/// Error on getting number trivia state
class NumberTriviaErrorState extends NumberTriviaState {
  const NumberTriviaErrorState({required message}) : super(message: message);
}

/// Loaded state with number trivia
class NumberTriviaLoadedState extends NumberTriviaState {
  const NumberTriviaLoadedState({required trivia}) : super(trivia: trivia);
}
