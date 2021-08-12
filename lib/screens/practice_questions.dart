import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:life_in_the_uk/models/QuestionsDatabase.dart';
import 'package:life_in_the_uk/models/Question.dart';
import'dart:convert';
import 'package:life_in_the_uk/models/JsonQuestionsGetter.dart';


class PracticeQuestions extends StatelessWidget {
    List<Question> question;

    Future<List<JsonQuestions>> readJsonData() async {
      //read json file
      final jsonData =
      await rootBundle.rootBundle.loadString('assets/questions_base.json');
      //decode json data as list
      final list = json.decode(jsonData) as List<dynamic>;
      //map json and initialize using DataModel
      return list.map((e) => JsonQuestions.fromJson(e)).toList();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Practice Questions'),
          backgroundColor: Colors.green,
        ),
        body: FutureBuilder(
            future: readJsonData(),
            builder: (context, data) {
              if (data.hasError) {
                //in case if error
                return Center(child: Text("${data.error}"));
              } else if (data.hasData) {
                var questionsData = data.data as List<JsonQuestions>;

                return SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          itemCount: questionsData.length,
                            itemBuilder: (context,index){
                            int currentQuestionNum=index+1;
                            int numOfQuestions=questionsData.length;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.center,
                                width:150,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFFF1976D2),

                                ),

                                child:
                              Text("Question $currentQuestionNum of $numOfQuestions",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,),),
                              ),
                            ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(questionsData[index].question.toString(),
                                  style: TextStyle(
                                      color:Colors.grey[150],
                                    fontSize: 40,
                                ),),
                              )
                          ],

                          );

                        }),
                      )
                    ],
                  ),
                );
                
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            ),
    );
  }
}
