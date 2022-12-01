import 'dart:convert';

import 'package:http/http.dart' as http;

class TodoService {
  static Future<bool> deleteByID(String id, String userToken) async {
    // final url = 'https://mrson-routting-fastapi.onrender.com/todos/$id';
    final url = 'http://14.225.44.29/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $userToken",
    });
    return response.statusCode == 200;
  }

  static Future<List?> fetchTodos(String userToken) async {
    // const url = 'https://mrson-routting-fastapi.onrender.com/todos/user';
    const url = 'http://14.225.44.29/todos/user';
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $userToken",
    });
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<bool> updateTodo(String id, Map body, String userToken) async {
    // final url = 'https://mrson-routting-fastapi.onrender.com/todos/$id';
    final url = 'http://14.225.44.29/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $userToken",
    });
    return response.statusCode == 200;
  }

  static Future<bool> addTodo(Map body, String userToken) async {
    // const url = 'https://mrson-routting-fastapi.onrender.com/todos/';
    const url = 'http://14.225.44.29/todos/';
    final uri = Uri.parse(url);
    final response = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $userToken",
    });
    return response.statusCode == 200;
  }
}
