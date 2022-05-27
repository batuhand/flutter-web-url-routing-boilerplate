import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:webroutingtest/model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiData extends ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> get users => _users;
  Future<List<UserModel>> fetchData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body) as List;
        _users = data.map((e) => UserModel.fromJson(e)).toList();

        notifyListeners();

        return _users;
      } catch (e) {
        Exception(e.toString());
      }
    }

    return [];
  }
}
