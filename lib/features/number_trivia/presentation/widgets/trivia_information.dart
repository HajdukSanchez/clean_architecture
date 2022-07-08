import 'package:flutter/material.dart';

import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

class TriviaInformation extends StatelessWidget {
  final String searchTitle;
  final String searchInfo;
  final NumberTrivia? trivia;

  const TriviaInformation({Key? key, this.searchTitle = '', this.searchInfo = '', this.trivia})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(trivia != null ? 20 : 0),
            margin: EdgeInsets.only(bottom: trivia != null ? 30 : 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(trivia != null ? 100 : 0),
                color: trivia != null ? Colors.white : Colors.transparent,
                boxShadow: [
                  trivia != null
                      ? const BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        )
                      : const BoxShadow(
                          color: Colors.transparent,
                        ),
                ]),
            child: Text(
              trivia != null ? trivia!.number.toString() : searchTitle,
              style: TextStyle(fontSize: trivia != null ? 50 : 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              trivia != null ? trivia!.text : searchInfo,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: trivia != null ? 20 : 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
