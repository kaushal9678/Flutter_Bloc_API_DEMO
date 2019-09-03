import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import '../models/api_model.dart';
import '../models/settings.dart';
import '../models/thankyou.dart';
import '../models/welcome.dart';
import '../models/fields.dart';

class ApiProvider {
  Client client = Client();
  //final _apiKey = 'api-key';
  final _baseUrl =
      "https://firebasestorage.googleapis.com/v0/b/collect-plus-6ccd0.appspot.com/o/mobile_tasks%2Fform_task.json?alt=media&token=d048a623-415e-41dd-ad28-8f77e6c546be";

  Future<APIModel> fetchAPIList() async {
    Response response;

    response = await client.get("$_baseUrl");

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return APIModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
