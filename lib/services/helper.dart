import 'dart:convert';

import 'package:chatboot_rl_nlp/constants/constants.dart';
import 'package:http/http.dart' as http;

class Helper{


  Future<String> getResponse(String request) async{


      var headers = {"Authorization" : "Bearer $api_token"};

      http.Response result = await http.post(Uri.parse(url), headers: headers, body: request);

      print("${result.statusCode} + ${result.body}");

      return json.decode(result.body)["generated_text"].toString();
  }

}