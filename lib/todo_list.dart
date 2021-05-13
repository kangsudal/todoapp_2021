import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                  return ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(2),
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "Todo title",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: 5,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.grey[800],
                  );
                },
              )
            ],
          ),
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
                        onPressed: () {},
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
