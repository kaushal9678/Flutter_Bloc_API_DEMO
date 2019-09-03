import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import './widgets/RadioButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../database/database.dart';
import '../models/clientModel.dart';
import '../models/fields.dart';

class SurveyForm extends StatefulWidget {
  //const name({Key key}) : super(key: key);

  @override
  _SurveyFormState createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  // reference to our single class that manages the database

  final _userNameController = TextEditingController();
  final _userAgeController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  var _ratingController = TextEditingController();

  double _userRating = 0.0;

  int _radioValue1 = -1;
  int _radioAgainExplore = -1;

  bool _isVertical = false;
  IconData _selectedIcon;
  DateTime _selectedDate;
  //Client surveryForm;
  String selectedGender;

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 1)),
            lastDate: DateTime.now().add(Duration(days: 15)))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      _radioAgainExplore = value;
    });
  }

  @override
  void initState() {
    _ratingController.text = "1.0";
    super.initState();
  }

  void _submitted() {
    if (_userNameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please enter name !',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else if (_userAgeController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please enter age !', toastLength: Toast.LENGTH_SHORT);
    } else if (_emailAddressController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please enter email address !', toastLength: Toast.LENGTH_SHORT);
    } else if (_radioValue1 == -1) {
      Fluttertoast.showToast(
          msg: 'Please select gender !', toastLength: Toast.LENGTH_SHORT);
    } else if (_userRating == 0.0) {
      Fluttertoast.showToast(
          msg: 'Please provide rating !', toastLength: Toast.LENGTH_SHORT);
    } else if (_selectedDate.toString().isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please select date of visit!', toastLength: Toast.LENGTH_SHORT);
    } else if (_userRating == 0.0) {
      Fluttertoast.showToast(
          msg: 'Please provide rating !', toastLength: Toast.LENGTH_SHORT);
    } else {
      this._insert();
    }
  }

  void _insert() async {
    // row to insert

    switch (_radioValue1) {
      case 0:
        selectedGender = "M";
        break;
      case 1:
        selectedGender = "F";
        break;
      case 2:
        selectedGender = "No";
        break;
      default:
    }

    Client client = new Client(
        userName: _userNameController.text,
        email: _emailAddressController.text,
        age: _userAgeController.text,
        phone: _phoneNumberController.text,
        gender: selectedGender,
        date: _selectedDate.toString(),
        ratings: _userRating.toString(),
        revisit: _radioAgainExplore == 1 ? true : false);
    var saved = await DBProvider.db.newClient(client);
  }

  void _onPressNext(BuildContext ctx) {
    Navigator.pushNamed(ctx, '/thankyou');
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Survey Form"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _onPressNext(context),
          )
        ],
      ),
      body: Card(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Enter your name'),
                  controller: _userNameController,
                  onSubmitted: (_) => _submitted(),
                  /* onChanged: (val) {
                          titleInput = val;
                        } */
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Enter your age'),
                  keyboardType: TextInputType.number,
                  controller: _userAgeController,
                  onSubmitted: (_) => _submitted(),
                  /* onChanged: (val) {
                          amountInput = val;
                        }, */
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Enter your email'),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailAddressController,
                  onSubmitted: (_) => _submitted(),
                  /* onChanged: (val) {
                          amountInput = val;
                        }, */
                ),
                TextField(
                  decoration:
                      InputDecoration(labelText: 'Enter your phone number'),
                  keyboardType: TextInputType.phone,
                  controller: _phoneNumberController,
                  onSubmitted: (_) => _submitted(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("How was your experience at our gaming center:",
                          style: Theme.of(context).textTheme.subtitle),
                      SizedBox(
                        height: 10.0,
                      ),
                      RatingBarIndicator(
                        rating: _userRating,
                        itemBuilder: (context, index) => Icon(
                          _selectedIcon ?? Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 7,
                        itemSize: 35.0,
                        direction:
                            _isVertical ? Axis.vertical : Axis.horizontal,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: TextFormField(
                          controller: _ratingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter rating",
                            labelText: "Enter rating",
                            suffixIcon: MaterialButton(
                              onPressed: () {
                                setState(() {
                                  _userRating = double.parse(
                                      _ratingController.text ?? "0.0");
                                });
                              },
                              child: Text("Rate"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Select your Gender :',
                        style: Theme.of(context).textTheme.subtitle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: _radioValue1,
                          onChanged: _handleRadioValueChange1,
                        ),
                        Text(
                          'Male',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: _radioValue1,
                          onChanged: _handleRadioValueChange1,
                        ),
                        Text(
                          'Female',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        Radio(
                          value: 2,
                          groupValue: _radioValue1,
                          onChanged: _handleRadioValueChange1,
                        ),
                        Text(
                          'Not to say',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          child: Text(
                            _selectedDate != null
                                ? 'Date Of Visit: ${DateFormat.yMd().format(_selectedDate)}'
                                : 'No Date Chosen!',
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                      ),
                      FlatButton(
                        child: Text('Choose Date',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: () {
                          this._presentDatePicker();
                        },
                        textColor: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Would you consider exploring our center again :',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Radio(
                          value: 0,
                          groupValue: _radioAgainExplore,
                          onChanged: _handleRadioValueChange2,
                        ),
                        Text(
                          'Yes',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: 1,
                          groupValue: _radioAgainExplore,
                          onChanged: _handleRadioValueChange2,
                        ),
                        Text(
                          'No',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    this._submitted();
                  },
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                )
              ],
            ),
            padding: EdgeInsets.all(5),
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
