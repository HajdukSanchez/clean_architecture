import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_architecture/injection_container.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/widgtes.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<NumberTriviaBloc>(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _BuildBody(),
                  _NumberTriviaActions(
                    controller: controller,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case NumberTriviaEmptyState:
              return const TriviaInformation(
                searchTitle: "Start searching !!",
                searchInfo: "Type a number to see information about it.",
              );
            case NumberTriviaLoadedState:
              return TriviaInformation(
                trivia: state.trivia,
              );
            case NumberTriviaErrorState:
              return TriviaInformation(
                searchTitle: "xxx",
                searchInfo: state.message ?? 'Error searching trivia',
              );
            case NumberTriviaLoadingState:
              return const TriviaLoadingProgress();
            default:
              return const TriviaLoadingProgress();
          }
        },
      ),
    );
  }
}

class _NumberTriviaActions extends StatelessWidget {
  final TextEditingController controller;

  const _NumberTriviaActions({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberTriviaBloc = BlocProvider.of<NumberTriviaBloc>(context);

    void _searchNumberTrivia() {
      numberTriviaBloc.add(GetTriviaForConcreteNumberEvent(numberString: controller.text));
      controller.clear(); // Clear input field
    }

    void _searchRandomTrivia() {
      numberTriviaBloc.add(GetTriviaForRandomNumberEvent());
      controller.clear(); // Clear input field
    }

    return Column(
      children: [
        TriviaInputText(
          controller: controller,
          onSubmit: (_) => _searchNumberTrivia(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TriviaButton(
              icon: Icons.search_rounded,
              function: _searchNumberTrivia,
            ),
            TriviaButton(
              icon: Icons.alt_route_rounded,
              function: _searchRandomTrivia,
              bgColor: Colors.grey,
            ),
          ],
        )
      ],
    );
  }
}
