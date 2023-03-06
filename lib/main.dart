import 'package:flutter/material.dart';

import 'models/AirResult.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

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
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  AirResult? _result;

  Future<AirResult> fetchData() async {
    var response = await http.get(Uri.parse('http://api.airvisual'
        '.com/v2/nearest_city?key=e0d3bdef-758b-4d13-96a9-08c0a4aba760'));

    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData().then((airResult) {
      setState(() {
        _result = airResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _result == null
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(7.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '현재 위치 미세먼지',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 16),
                      Card(
                        child: Column(
                          children: [
                            Container(
                              color:  getColor(_result),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('얼굴사진'),
                                  Text(
                                    '${_result?.data?.current?.pollution?.aqius}',
                                    style: TextStyle(fontSize: 40),
                                  ),
                                  Text(
                                    getString(_result),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),

                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Image.network('https://airvisual.com/images/${_result?.data?.current?.weather?.ic}.png', width: 32,height: 32,),

                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        '${_result?.data?.current?.weather?.tp}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                    '습도 ${_result?.data?.current?.weather?.hu}%'),
                                Text(
                                    '풍속 ${_result?.data?.current?.weather?.ws}m/s'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 50)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Color getColor(AirResult? result) {
      if(result!.data!.current!.pollution!.aqius !=null && result.data!.current!.pollution!.aqius! <= 50) {
        return Colors.greenAccent;
      }else if(result.data!.current!.pollution!.aqius !=null && result.data!.current!.pollution!.aqius! <= 100)  {
        return Colors.orange;
      }else if(result.data!.current!.pollution!.aqius !=null && result.data!.current!.pollution!.aqius! <= 150)  {
        return Colors.deepOrange;
      }else {
        return Colors.red;
      }
  }

  String getString(AirResult? result) {
    if(result!.data!.current!.pollution!.aqius !=null && result.data!.current!.pollution!.aqius! <= 50) {
      return '좋음';
    }else if(result.data!.current!.pollution!.aqius !=null && result.data!.current!.pollution!.aqius! <= 100)  {
      return '보통';
    }else if(result.data!.current!.pollution!.aqius !=null && result.data!.current!.pollution!.aqius! <= 150)  {
      return '나쁨';
    }else {
      return '아주나쁨';
    }
  }
}
