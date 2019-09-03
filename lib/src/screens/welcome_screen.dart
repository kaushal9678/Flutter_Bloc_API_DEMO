import 'package:flutter/material.dart';
import '../blocs/api_bloc.dart';
import '../models/welcome.dart';
import '../models/api_model.dart';
import '../models/fields.dart';
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  
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

  
  onPressStart(BuildContext ctx,List<Field> field) {
    Navigator.pushNamed(ctx, "/survey-form",arguments: {field:field});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information Survey'),
      ),
      body: StreamBuilder(
        stream: bloc.allData,
        builder: (context, AsyncSnapshot<APIModel> snapshot) {
          if (snapshot.hasData) {
            return buildLayout(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildLayout(AsyncSnapshot<APIModel>snapshot){
    WelcomeScreenModel model = WelcomeScreenModel(title: snapshot.data.welcomeScreens[0].title,properties: snapshot.data.welcomeScreens[0].properties);
    List<Field> field = snapshot.data.fields.toList();
    return Container(
        child: Card(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
                child: Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                model.title,
                style: Theme.of(context).textTheme.title,
              ),
            )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.bottomRight,
              child: model.properties.showButton == true ?  RaisedButton(
                child: Text(model.properties.buttonText),
                onPressed: () {
                  this.onPressStart(context,field);
                },
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              ): null,
            ),
          ],
        )),
      );
  }
}
  /*@override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final title = "Welcome to Survey"; //routeArgs['title'];
    //final properties = routeArgs['properties'];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Card(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
                child: Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(
                "Welcome to personal information survey. Let's Begin!!",
                style: Theme.of(context).textTheme.title,
              ),
            )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                child: Text('Start'),
                onPressed: () {
                  this.onPressStart(context);
                },
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ),
          ],
        )),
      ),
    );
  }
}*/
