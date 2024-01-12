import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/utils/question_summary.dart';
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key,required this.chooseAnswers , required this.restartButtonPress });
  final List<String> chooseAnswers;
  final void Function() restartButtonPress;
  List<Map<String,Object>> getSummaryData(){
    final List<Map<String,Object>> summary  = [];

    for( var i = 0 ; i < chooseAnswers.length ; i++ ){
      summary.add({
        "question_index":i,
        "question":questions[i].text,
        "correct_answer":questions[i].answers[0],
        "user_answer":chooseAnswers[i]
      });
    }

    return summary;
  }
  @override
  Widget build(BuildContext context) {
    final totalQuestion = questions.length;
    final summary = getSummaryData();
    final correctCount = summary.where((element){ 
      return element["correct_answer"] == element["user_answer"];
    }).length;
    return  SizedBox(
      width: double.infinity,
      child: Container(
        padding:const EdgeInsets.all(40),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'You answered $correctCount out of $totalQuestion questions-',
                 style:GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 22
                 )
              ),
            ),
            const SizedBox(height: 30,),
            QuestionsSummary(getSummaryData())  ,
            const SizedBox(height: 30,),
            TextButton(
              onPressed: restartButtonPress ,
              style: ElevatedButton.styleFrom( textStyle: const TextStyle(
                color: Color.fromARGB(230, 255, 255, 255)
              )),
              child:const Text("RestartQuiz"),
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}