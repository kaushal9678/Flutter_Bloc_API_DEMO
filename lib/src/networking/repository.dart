import 'dart:async';
import 'api_provider.dart';
import '../models/api_model.dart';

class Repository {
  final moviesApiProvider = ApiProvider();

  Future<APIModel> fetchAPIList() => moviesApiProvider.fetchAPIList();

 
}
