import 'package:dev_quiz/challlenge/widgets/next_button/next_button_widget.dart';
import 'package:dev_quiz/challlenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:dev_quiz/challlenge/widgets/quiz/quiz_widget.dart';
import 'package:dev_quiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';
import './challenge_controller.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  const ChallengePage({Key? key, required this.questions}) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeCrontroller();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
    super.initState();
  }

  void next() {
    if (controller.currentPage < widget.questions.length)
      pageController.nextPage(
          duration: Duration(milliseconds: 100), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //BackButton(),
              //Tanto apenas o BackButton, como o IconButton abaixo, fazem o mesmo efeito
              //o que muda é o simbolo
              //obs.: o BackButton() contém o pop desempilhando a pilha de telas.
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIdicatorWidget(
                  currentPage: value,
                  length: widget.questions.length,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        //physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map((e) => QuizWidget(
                  question: e,
                  onChange: () {},
                ))
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (value < widget.questions.length)
                          Expanded(
                            child: NextButtonWidget.white(
                              label: "Pular",
                              onTap: next,
                            ),
                          ),
                        if (value == widget.questions.length)
                          Expanded(
                            child: NextButtonWidget.green(
                              label: "Confirmar",
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                      ],
                    ))),
      ),
    );
  }
}
