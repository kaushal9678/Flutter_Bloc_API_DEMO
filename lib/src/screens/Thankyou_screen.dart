import 'package:flutter/material.dart';

class ThankyouScreen extends StatelessWidget {
  //const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thank You"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "Thank you for your feedback, we really appreciate your efforts for filling this response.",
              style: Theme.of(context).textTheme.subtitle,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Again'),
              onPressed: () {
                // this._submitted();
              },
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Thanks for completing this form Now create your own — it's free, easy, & beautiful",
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Create a form'),
              onPressed: () {
                // this._submitted();
              // Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (Route<dynamic> route) => false);
              Navigator.of(context).pushNamedAndRemoveUntil('/survey-form', ModalRoute.withName('/welcome'));
              },
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            ),
            InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://placeimg.com/640/480/any}',
                fit: BoxFit.cover,
              ),
              
            )
          ],
        )),
      ),
    );
  }
}
