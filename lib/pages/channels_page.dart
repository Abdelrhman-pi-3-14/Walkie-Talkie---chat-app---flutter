import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// MAIN CONTENT
          isEmpty
              ? Column(
            children: [
              Expanded(
                child: ListView(
                  children: const [
                    // messages here
                  ],
                ),
              ),
            ],
          )
              : Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/no_result.png",
                      width: 320,
                    ),
                    SizedBox(height: 16,),
                    Text("No Channels Found :( "
                      , style: TextStyle(
                        color: Color.fromARGB(103, 172, 170, 170),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),

                  ]
              )),

          /// FLOATING BUTTONS (BOTTOM RIGHT - COLUMN)
          Positioned(
            bottom: 24,
            right: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              SizedBox(
              width: 140,
              child: FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 0, 157, 255),
                  heroTag: "fab1",
                  onPressed: () {},
              child: Text("ADD CHANNEL"),
            ),)
        ],
      ),
    ),]
    ,
    )
    ,
    );
  }
}
