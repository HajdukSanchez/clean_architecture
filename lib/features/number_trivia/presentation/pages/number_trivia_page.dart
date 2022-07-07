import 'package:clean_architecture/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_architecture/injection_container.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_button.dart';
import 'package:clean_architecture/features/number_trivia/presentation/widgets/trivia_information.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => sl<NumberTriviaBloc>(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (context, state) {
                      switch (state.runtimeType) {
                        case NumberTriviaLoadedState:
                          return const TriviaInformation();
                        default:
                          return const MessageDisplay(
                            message: "Start searching for a trivia !!",
                          );
                      }
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const TextField(
                          autofocus: true,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: "123"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            TriviaButton(),
                            TriviaButton(),
                          ],
                        )
                      ],
                    ),
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
