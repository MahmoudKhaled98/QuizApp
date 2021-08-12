import 'package:life_in_the_uk/models/Question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QuestionsDatabase{
  QuestionsDatabase._init();
  static final QuestionsDatabase instance=QuestionsDatabase._init();
  static Database _database;

  Future<Database> get database async{
    if(_database!=null)return _database;
    _database=await _initDatabase('Questions.db');
    return _database;
}

  Future<Database> _initDatabase(String filePath) async{
    final dbPath= await getDatabasesPath();
    final path= join(dbPath,filePath);
    return await openDatabase(path,version: 1,onCreate: _createDB);
  }
  Future _createDB(Database db, int version)async{
    final textType=' A STRING NOT NULL';
    final setType='A SET NOT NULL';
    final listType='A LIST NOT NULL';
    await db.execute('''
    CREATE TABLE$tableQuestion(
    ${QuestionFields.title} $textType,
    ${QuestionFields.options} $listType,
    ${QuestionFields.answers} $setType,
    ${QuestionFields.tip} $textType,
    ${QuestionFields.id} $textType,
    )'''
    );

Future<Question> create(Question question)async{             //adding to database
  final db =await instance.database;
  final id=await db.insert(tableQuestion, question.toJson());
  return question.copy(id:id.toString());
}
Future<Question> readOneQuestion(String title,
    List options,
    Set answers,
    String tip,
    String id)async{
  final db = await instance.database;
  final maps =await db.query(
    tableQuestion,
    columns:QuestionFields.values,
    where: '${QuestionFields.title}=$title,${QuestionFields.options}=$options,'
        '${QuestionFields.answers}=$answers,'
        '${QuestionFields.tip}=$tip,${QuestionFields.id}=$id',
    whereArgs: [title,options,answers,tip,id]
  );
  if(maps.isNotEmpty){
    return Question.fromJson(maps.first);
  }else throw Exception('DATA NOT FOUND');
}
Future<List<Question>> readAllQuestions()async{                 //read from database
  final db= await instance.database;
  final result=await db.query(tableQuestion);
  return result.map((json)=>Question.fromJson(json)).toList();
}
// notice ..int id
Future<int> update(Question question)async{                     // update database
final db= await instance.database;
return db.update(tableQuestion, question.toJson(),
    where: '${QuestionFields.id}=?',
    whereArgs: [question.id]
);
}
Future<int> delete(int id)async{                                // delete from database
 final db= await instance.database;
 return await db.delete(
   tableQuestion,
   where: '${QuestionFields.id}=?',
   whereArgs: [id]
 );
}
  }
  Future close() async {
final db=await instance.database;
db.close();
}

}

