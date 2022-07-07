part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

/// Initial and empty state
class NumberTriviaEmptyState extends NumberTriviaState {}

/// Loading Number trivia state
class NumberTriviaLoadingState extends NumberTriviaState {}

/// Error on getting number trivia state
class NumberTriviaErrorState extends NumberTriviaState {
  final String message;

  const NumberTriviaErrorState({required this.message});
}

/// Loaded state with number trivia
class NumberTriviaLoadedState extends NumberTriviaState {
  final NumberTrivia trivia;

  const NumberTriviaLoadedState({required this.trivia});
}
