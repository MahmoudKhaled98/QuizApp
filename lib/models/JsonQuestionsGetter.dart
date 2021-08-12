class JsonQuestions{
  String question;
  List options;
  List answers;
  String tip;
  String id;

  JsonQuestions({this.question,
    this.options,
    this.answers,
    this.tip,
    this.id});
  JsonQuestions.fromJson(Map<String,dynamic>json){
    question=json['question'];
    options=json['options'];
    answers=json['answers'];
    tip=json['tip'];
    id=json['id'];
  }
}