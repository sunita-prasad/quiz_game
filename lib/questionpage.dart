
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_questions/main.dart';
import 'package:quiz_questions/model/quiz_dao.dart';
import 'package:quiz_questions/model/quiz_model.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {

 List<quiz> listquiz = [];

 @override
  void initState() {
   quizDAO.retrieveQuiz().then((value) {
     print("DATA -> $value");
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top,),
          ElevatedButton(onPressed: (){print("mfsf:" +quizDAO.retrieveQuiz().toString());}, child: Text("fkfklwelfwe"))
        ],
      )
      /*ListView.separated(
        itemCount: listquiz.length,
        separatorBuilder: (context, index) => const SizedBox(height: 0,),
        itemBuilder: (context, position){
          return Column(
            children: [
              SizedBox(height:MediaQuery.of(context).padding.top,),
              ElevatedButton(
                child: const Text("dsksfv"),
                onPressed: (){
                  print(listquiz[position].toMap());
                },
              )
            ],
          );
        },
      )*/
    );
  }
}
