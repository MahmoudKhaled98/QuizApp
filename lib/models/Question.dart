import 'package:life_in_the_uk/models/OptionStatus.dart';
import 'Option.dart';

final String tableQuestion='Questions';
class QuestionFields{
  static final List<String> values=[
    title,options,answers,tip,id
  ];
  static final String title='title';
  static final String options='options';
  static final String answers='answers';
  static final String tip='tip';
  static final String id='id';
}

enum QuestionStatus { attempted, notAttempted, correct, incorrect, incomplete }

class Question {
  final String title;
  final List<Option> options;
  final Set<int> answers;
  final String tip;
  final String id;

  QuestionStatus status = QuestionStatus.notAttempted;
  Question({this.title, this.options,this.answers, this.tip, this.id});

  void resetStatus() {
    status = QuestionStatus.notAttempted;

    for (Option option in options) {
      option.status = OptionStatus.notSelected;
    }
  }
  static Question fromJson(Map<String,Object>json)=> Question(
      title:json[QuestionFields.title]as String,
      options:json[QuestionFields.options]as List,
      answers:json[QuestionFields.answers]as Set,
      tip:json[QuestionFields.tip]as String,
      id:json[QuestionFields.id]as String
  );

  Map<String,Object> toJson()=>{
    QuestionFields.title:title,
    QuestionFields.options:options,
    QuestionFields.answers:answers,
    QuestionFields.tip:tip,
    QuestionFields.id:id
  };
  Question copy({
    final String title,
    final List<Option> options,
    final Set<int> answers,
    final String tip,
    final String id

})=>
      Question(
      title: title?? this.title,
      options:options??this.options,
      answers:answers?? this.answers,
      tip:tip?? this.tip,
      id:id?? this.id
    );


}
