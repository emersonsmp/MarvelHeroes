import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map> _getHeroes() async {
    String orderBy = null;

    const String _API_PRIVATE_KEY = "4ec1042eaac4551902ef41b36100141d82400ffd";
    const String _API_PUBLIC_KEY = "cc0bf97cd028a24ef963842e9ad86f41";

    String ts = Uuid().toString();
    var hash = generateMd5(ts + _API_PRIVATE_KEY + _API_PUBLIC_KEY);

    var url =
        "https://gateway.marvel.com/v1/public/characters?apikey=$_API_PUBLIC_KEY&hash=$hash&ts=$ts";

    http.Response response;
    response = await http.get(url);
    return json.decode(response.body);
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  void initState() {
    super.initState();

    _getHeroes().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("texto aqui"),
        backgroundColor: Colors.blue,
      ),
      body: Container(),
    );
  }
}
