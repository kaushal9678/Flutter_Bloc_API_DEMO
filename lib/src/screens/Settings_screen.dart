import 'dart:async';
import 'package:flutter/material.dart';
import '../blocs/api_bloc.dart';
import '../models/settings.dart';
import '../models/api_model.dart';

class Settings extends StatefulWidget {
  //const Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String headerTitle = "";
  @override
  void initState() {
    super.initState();
    bloc.fetchApiData();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(headerTitle),
      ),
      body: StreamBuilder(
        stream: bloc.allData,
        builder: (context, AsyncSnapshot<APIModel> snapshot) {
          if (snapshot.hasData) {

              headerTitle = snapshot.data.title;

            //return buildLayout(snapshot);

          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Widget buildLayout(AsyncSnapshot<APIModel> snapshot) {
  // APIModel model = APIModel(title: snapshot.data.title,id: );
  // List<Field> field = snapshot.data.fields.toList();
  return Text(snapshot.data.title);
}
