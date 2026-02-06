import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
class fetchMeme{

  fetchNewMeme() async {

    Response response = await get(Uri.parse("API Key"));


    Map body_data = jsonDecode(response.body);
    // print(body_data["url"]);
    return body_data["url"];

  }
}