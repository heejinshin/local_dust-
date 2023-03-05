import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  Main(),
    );
  }
}

class Main extends StatefulWidget {

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('현재 위치 미세먼지', style: TextStyle(fontSize: 30),),
          Card(
          child: Column(
            children: [
              Row(
                children: [
                  Text('얼굴사진'),
                  Text('80'),
                  Text('보통'),
                ],
              ),
              Row(
                children: [
                  Text('11'),
                  Text('습도'),
                  Text('풍속'),
                ],
              ),
            ],
          ),
      ),
          ClipRRect(  
            borderRadius: BorderRadius.circular(30),
            child: ElevatedButton(

              onPressed: (){},
              child: Icon(Icons.refresh, color: Colors.white,),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50)
              ),
            ),
          )
        ],),
      ),
    );
  }
}
