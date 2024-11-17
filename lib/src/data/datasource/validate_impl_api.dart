import 'dart:convert';

import 'package:challenge_response/src/model/validate_response_model.dart';
import 'package:http/http.dart' as http;

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
  } else if (response.statusCode == 503) {
    throw Exception('Serviço Indisponível');
  } else if (response.statusCode == 405) {
    throw Exception('Método não permitido');
  } else if (response.statusCode == 422) {
    throw Exception('Entidade não processada');
  } else {
    throw Exception('Falha desconhecida');
  }
}
