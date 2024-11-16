import 'dart:convert';

import 'package:challenge_response/src/sample_feature/password.dart';
import 'package:challenge_response/src/sample_feature/validate_response.dart';
import 'package:http/http.dart' as http;

Future<Password> getRadomPassword() async {
  final response = await http.get(
      Uri.parse('https://desafioflutter-api.modelviewlabs.com/random'),
      headers: {'author': 'Mirele Fernandes - mirele.mrf@gmail.com'});

  if (response.statusCode == 200) {
    return Password.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Falha ao obter senha.');
  }
}

Future<ValidateResponse> validate(String password) async {
  final response = await http.post(
      Uri.parse('https://desafioflutter-api.modelviewlabs.com/validate'),
      headers: <String, String>{
        'author': 'Mirele Fernandes - mirele.mrf@gmail.com'
      },
      body: jsonEncode(
        <String, String>{
          'password': password,
        },
      ));

  if (response.statusCode == 202 || response.statusCode == 400) {
    return ValidateResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else if (response.statusCode == 400) {
    throw Exception('Método não permitido');
  } else if (response.statusCode == 405) {
    throw Exception('Método não permitido');
  } else if (response.statusCode == 422) {
    throw Exception('Entidade não processada');
  } else {
    throw Exception('Falha desconhecida');
  }
}
