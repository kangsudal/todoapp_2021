import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Text(
                "All todos",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Divider(),
              SizedBox(height: 20),
              ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text("Todo title"),
                  );
                },
                shrinkWrap: true,
                itemCount: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
