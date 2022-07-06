import 'package:equatable/equatable.dart';

/// A number trivia entity.
class NumberTrivia extends Equatable {
  /// Text of the response.
  final String text;

  /// Number asociated with the trivia.
  final int number;

  const NumberTrivia({
    required this.text,
    required this.number,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
