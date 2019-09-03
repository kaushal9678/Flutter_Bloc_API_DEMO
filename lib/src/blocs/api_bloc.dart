import '../networking/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/api_model.dart';
import '../database/database.dart';
class APIBloc {
  final _repository = Repository();
  final _apiFetcher = PublishSubject<APIModel>();

  Observable<APIModel> get allData => _apiFetcher.stream;

  fetchApiData() async {
    APIModel itemModel = await _repository.fetchAPIList();
      var res = await DBProvider.db.deleteAll();
      await DBProvider.db.newAPIModel(itemModel);
    _apiFetcher.sink.add(itemModel);

    //var setting = await DBProvider.db.getSettings();
   // print('settings==${setting}');
  }

  dispose() {
    _apiFetcher.close();
  }
}

final bloc = APIBloc();
