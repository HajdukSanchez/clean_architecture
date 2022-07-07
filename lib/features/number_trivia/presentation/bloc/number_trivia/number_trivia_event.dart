part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

/// Envet to get a trivia for a concrete number user entered.
class GetTriviaForConcreteNumberEvent extends NumberTriviaEvent {
  final String numberString;

  const GetTriviaForConcreteNumberEvent({required this.numberString});
}

/// Event to get a random trivia.
class GetTriviaForRandomNumberEvent extends NumberTriviaEvent {}
