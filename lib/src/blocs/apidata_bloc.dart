import 'dart:async';

import '../models/api_model.dart';
import '../database/database.dart';

class APIDataBloc {
  final _apiDataController = StreamController<APIModel>.broadcast();

  get clients => _apiDataController.stream;

  dispose() {
    _apiDataController.close();
  }

  getAPIData() async {
    return _apiDataController.sink.add(await DBProvider.db.getAPIData());
  }

  APIDataBloc() {
    getAPIData();
  }

  delete(int id) {
   // DBProvider.db.deleteClient(id);
    //getClients();
  }

 
}