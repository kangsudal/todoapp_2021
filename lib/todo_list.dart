import 'package:flutter/material.dart';
import 'package:todo_app/loading.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/services/database_services.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool isComplete = false;
  TextEditingController todoTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<Todo>>(
          stream: DatabaseService().listTodos(),
          builder: (context, snapshot) {
            if (!snapshot.hasData){
              return Loading();
            }
            // print(snapshot.data[0].title);
            List<Todo> todos = snapshot.data;//Cloud Firestore 컬렉션 데이터 조회
            return Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "All todos",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Divider( color: Colors.grey[600], ),
                  SizedBox(height: 20),
                  ListView.separated(
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(todos[index].title,),
                        background: Container(
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.delete),
                          color: Colors.orangeAccent,
                        ),
                        onDismissed: (direction){
                          print("removed");
                        },
                        child: ListTile(
                          onTap: (){
                            setState(() {
                              isComplete = !isComplete;
                              // print(isComplete);
                            });
                          },
                          leading: Container(
                            padding: EdgeInsets.all(2),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: isComplete?
                            Icon(
                              Icons.check,
                              color: Colors.white,
                            ):Container(),
                          ),
                          title: Text(
                            todos[index].title, //Cloud Firestore에 저장된 title
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    itemCount: todos.length, //Cloud Firestore 에서 불러온 데이터의 길이
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.grey[800],
                      );
                    },
                  )
                ],
              ),
            );
          }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext builder) {
                return SimpleDialog(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ), //입력창 가장자리간격
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Row(
                    children: [
                      Text("Add todo"),
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.pink,
                          ),
                          onPressed: () {
                            return Navigator.pop(context);
                          })
                    ],
                  ),
                  children: [
                    Divider(),
                    TextFormField(
                      controller: todoTitleController,
                      style: TextStyle(),
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "eg. exercise",
                        // hintStyel: TextStyle(color: Colors.white70),
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50, //MediaQuery.of(context).size.height * 0.6,
                      child: TextButton(
                        onPressed: () async{
                          if(todoTitleController.text.isNotEmpty){
                            print(todoTitleController.text);
                            await DatabaseService().createNewTodo(todoTitleController.text.trim()); //핵심~!! Cloud Firestore 컬렉션에 새 데이터 저장
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          // textStyle: TextStyle(color:Colors.white,),
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
