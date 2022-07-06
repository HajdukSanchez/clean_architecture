import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  /// Pass the parameters to the NumberTrivia patern
  const NumberTriviaModel({
    required String text,
    required int number,
  }) : super(text: text, number: number);

  /// This method is used to convert a JSON response to a NumberTriviaModel
  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'],
      number:
          (json['number'] as num).toInt(), // We can handle the number as an int or a double value
    );
  }

  /// This method is used to convert a NumberTriviaModel to a JSON
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'number': number,
    };
  }
}
