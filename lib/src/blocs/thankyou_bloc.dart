import 'dart:async';

import '../models/thankyou.dart';
import '../database/database.dart';

class ThankyouBloc {
  final _thankyouController = StreamController<ThankyouScreenModel>.broadcast();

  get clients => _thankyouController.stream;

  dispose() {
    _thankyouController.close();
  }

  getThankYouData() async {
    _thankyouController.sink.add(await DBProvider.db.getThankyouData());
  }

  ThankyouBloc() {
    getThankYouData();
  }

  delete(int id) {
   // DBProvider.db.deleteClient(id);
    //getClients();
  }

 
}