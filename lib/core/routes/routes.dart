import 'package:clean_architecture/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:flutter/material.dart';

/// Names of the pages to asociate with the routes.
enum PageName { numberTrivia }

/// Routes of each page of the application.
Map<String, Widget Function(BuildContext)> routes = {
  PageName.numberTrivia.name: (_) => const NumberTriviaPage(),
};
