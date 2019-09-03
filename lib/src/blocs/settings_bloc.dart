import 'dart:async';
import '../models/settings.dart';
import '../database/database.dart';
import '../blocs/apidata_bloc.dart';
import '../models/api_model.dart';
class SettingsBloc {
  SettingsBloc() {
    getSettings();
  }
  final _settingsController = StreamController<Settings>.broadcast();
  
  get settings => _settingsController.stream;

  dispose() {
    _settingsController.close();
  }

  getSettings() async {
    APIModel model =  APIDataBloc().getAPIData();

    _settingsController.sink.add(await DBProvider.db.getSettings(model.id));
  }
  
}
