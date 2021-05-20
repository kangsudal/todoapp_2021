import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/todo.dart';

class DatabaseService {
  CollectionReference todosCollection =
      FirebaseFirestore.instance.collection('Todos');

  Future createNewTodo(String title) async {
    return await todosCollection.add({
      'title': title,
      'isComplete': false,
    });
  }

  Future completeTask(uid) async{
    await todosCollection.doc(uid).update({'isComplete':true});
  }

  List<Todo> todoFromFirestore(QuerySnapshot<Map<String, dynamic>> snapshot){
    if(snapshot != null){
      return (snapshot.docs.map((e) => Todo(
        isComplete: e.data()['isComplete'],
        title: e.data()['title'],
        uid: e.id,
      ))).toList();
    }
    else{
      return null;
    }
  }

  Stream<List<Todo>> listTodos(){
    return todosCollection.snapshots().map((event) => todoFromFirestore(event));
  }

  Future removeTodo(uid) async{
    await todosCollection.doc(uid).delete();
  }
}
