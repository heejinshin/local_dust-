// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:local_dust/main.dart';
import 'package:http/http.dart' as http;
import 'package:local_dust/models/AirResult.dart';

import 'dart:convert';

void main() {
  test('http 통신 테스트', () async{
    var response = await http.get(Uri.parse('http://api.airvisual'
        '.com/v2/nearest_city?key=e0d3bdef-758b-4d13-96a9-08c0a4aba760'));
    expect(response.statusCode, 200);

    AirResult result = AirResult.fromJson(json.decode(response.body));
    expect(result.status, 'success');
  });

}


