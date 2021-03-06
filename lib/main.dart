import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff2E2D2E),
          body: QuizBody(),
        ),
      ),
    );
  }
}

class QuizBody extends StatefulWidget {
  const QuizBody({Key? key}) : super(key: key);

  @override
  _QuizBodyState createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  Widget trueIcon() {
    return SvgPicture.asset(
      'images/check.svg',
      color: Colors.green,
      width: 15,
    );
  }

  Widget falseIcon() {
    return const Icon(
      Icons.close,
      color: Colors.red,
    );
  }

  List questionsList = quizBrain.questionsList;

  List<Widget> scoreList = [];

  int i = 0;

  String showQuestion() {
    return questionsList[i][0];
  }

  void responseQuestion(answer) {
    if (answer == questionsList[i][1]) {
      scoreList.add(trueIcon());
    } else {
      scoreList.add(falseIcon());
    }
    if (i < questionsList.length - 1) {
      i++;
    } else {
      Alert(
        context: context,
        title: "Game Over",
        desc: "Thank you for using my app.",
        buttons: [
          DialogButton(
            child: const Text(
              "Replay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();

      i = 0;
      scoreList = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              showQuestion(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 60,
              padding: EdgeInsets.all(5),
              // margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    responseQuestion(true);
                  });
                },
                child: const Text(
                  'True',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(primary: Color(0xff5AA556)),
              ),
            ), //true button
            Container(
              height: 60,
              padding: EdgeInsets.all(5),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    responseQuestion(false);
                  });
                },
                child: const Text(
                  'False',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(primary: Color(0xffD24437)),
              ),
            ), //false button
          ],
        ),
        Container(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: scoreList,
          ),
        )
      ],
    );
  }
}
