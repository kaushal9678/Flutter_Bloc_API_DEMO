import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/clientModel.dart';
import 'package:sqflite/sqflite.dart';
import '../models/api_model.dart';
import '../models/settings.dart';
import '../models/fields.dart';
import '../models/thankyou.dart';
import '../models/welcome.dart';
import '../constants.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();


  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

/**
 * ****************************    Database Initialization   ****************************
 * 
 * ****************************  Tables Initialization       ****************************
 *  Here Create following tables
 * 
 * - table --------------------------- API_Data --------------------------  
 * - @param id integer
 * - @param @title  TEXT
 * 
 * @table --------------------------- Settings --------------------------  
 * - @param id integer
 * - @param language  TEXT
 * - @param showProgressBar  BIT (boolean)
 * - @param progressBar  TEXT
 * - @param apiID foreign Key
 * 
 * 
 * * @table --------------------------- Welcome --------------------------  
 * - @param id integer
 * - @param title  TEXT
 * - @param welcomeId foreign Key
 * * @table --------------------------- Client -------------------------- 
 *  * it is used to save survey form 
 * -  id integer
 * - userName  TEXT
 * - email TEXT
 * - phone TEXT
 * -  age TEXT
 * - gender TEXT
 * - ratings TEXT
 * - date TEXT
 * - revisit BIT
 */
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "AtlanDB.db");
    print(path);
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      //To save API Data
      await db
          .execute('CREATE TABLE IF NOT EXISTS  API_Data (id TEXT PRIMARY KEY, title TEXT)');

      //To save Settings
      await db.execute(
          'CREATE TABLE IF NOT EXISTS  Settings (id INTEGER PRIMARY KEY, language TEXT, progressBar TEXT, showProgressBar BIT,apiID TEXT)');

      //To Save Welcome Screen data
      await db
          .execute('CREATE TABLE IF NOT EXISTS  Welcome (id INTEGER PRIMARY KEY, title TEXT)');
//To Save Welcome Properties
      await db.execute(
          'CREATE TABLE IF NOT EXISTS  WelcomeProperties (id INTEGER PRIMARY KEY,description TEXT,buttonText TEXT,showButton BIT, welcomeId INTEGER)');

    
      //To save Thankyou data
      await db.execute(
          'CREATE TABLE IF NOT EXISTS  ThankYou (id INTEGER PRIMARY KEY, title TEXT)');

      // To save Thankyou page properties
      await db.execute(
          'CREATE TABLE IF NOT EXISTS  ThankYouProperties (id INTEGER PRIMARY KEY, buttonMode TEXT, buttonText TEXT, showButton BIT,showIcons BIT, thankYouId INTEGER)');

      //used to save thank you api attachment
      await db.execute(
          'CREATE TABLE IF NOT EXISTS  ThankYouAttachment (id INTEGER PRIMARY KEY, type TEXT, href TEXT, thankYouId INTEGER)');

      await db.execute(
          'CREATE TABLE IF NOT EXISTS  Fields (id TEXT PRIMARY KEY, title TEXT, type TEXT)');

      await db.execute(
          'CREATE TABLE IF NOT EXISTS  FieldsProperties (id INTEGER PRIMARY KEY, alphabetical_order TEXT,shape TEXT,steps INTEGER, structure TEXT, separator TEXT, fieldId TEXT)');

      await db.execute(
          'CREATE TABLE IF NOT EXISTS  Choices (id INTEGER PRIMARY KEY, label TEXT, fieldPropId INTEGER)');

      await db.execute(
          'CREATE TABLE IF NOT EXISTS  Validations (id INTEGER PRIMARY KEY, required BIT, fieldId INTEGER)');

      //Used to save user submitted form
      await db.execute(
          'CREATE TABLE IF NOT EXISTS  Client (id INTEGER PRIMARY KEY, userName TEXT, email TEXT, phone TEXT, age TEXT, gender TEXT, ratings TEXT,date TEXT,revisit BIT)');
    });

    return database;
  }

/** Function to Insert Data into Table Settings
 *
 * - @param accepts Model of Setting type and
 * - @param accepts APIModel for table relationship
 *
 *
 */
  insertDataSettings(Settings settingModel, APIModel apiModel) async {
    final db = await database;

    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Settings");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Settings (id,language,progressBar,showProgressBar,apiID)"
        " VALUES (?,?,?,?,?)",
        [
          id,
          settingModel.language,
          settingModel.progressBar,
          settingModel.showProgressBar,
          apiModel.id,
        ]);
    return raw;
  }

  /// Function to Insert Data into Table Welcome and welcome properties
  ///
  /// - @param accepts Model of Setting type and
  /// - @param accepts APIModel for table relationship
  ///
  ///
  insertWelcomeData(WelcomeScreenModel welcome, Properties properties) async {
    final db = await database;
    var table = await db.rawQuery(
        "SELECT CASE WHEN id IS NOT NULL THEN MAX(id)+1 ELSE 1 END as id FROM Welcome");
    int id = table.first["id"];
    await db.rawInsert(
        "INSERT Into Welcome (id,title)"
        " VALUES (?,?)",
        [
          id,
          welcome.title,
        ]);
    await insertWelcomeProperties(id, properties);
  }

  /// Function to Insert Data into Table WelcomeProperties
  ///
  /// - @param accepts welcomeId of type integer
  /// - @param properties of type Properties
  ///
  ///
  insertWelcomeProperties(welcomeId, Properties properties) async {
    final db = await database;
    var tableProperties = await db.rawQuery(
        "SELECT CASE WHEN id IS NOT NULL THEN MAX(id)+1 ELSE 1 END as id FROM WelcomeProperties");
    int id = tableProperties.first["id"];
    await db.rawInsert(
        "INSERT Into WelcomeProperties (id,description,buttonText,showButton,welcomeId)"
        " VALUES (?,?,?,?,?)",
        [
          id,
          properties.description,
          properties.buttonText,
          properties.showButton,
          welcomeId
        ]);
  }

  /// Function to Insert Data into Table Welcome and welcome properties
  ///
  /// - @param accepts Model of Setting type and
  /// - @param accepts APIModel for table relationship
  ///
  ///
  insertThankyouData(ThankyouScreenModel thankyou,
      ThankyouScreenModelProperties properties, Attachment attachment) async {
    final db = await database;
    var table = await db.rawQuery(
        "SELECT CASE WHEN id IS NOT NULL THEN MAX(id)+1 ELSE 1 END as id FROM ThankYou");
    int id = table.first["id"];
    await db.rawInsert(
        "INSERT Into ThankYou (id,title)"
        " VALUES (?,?)",
        [
          id,
          thankyou.title,
        ]);
    var tableProperties = await db.rawQuery(
        "SELECT CASE WHEN id IS NOT NULL THEN MAX(id)+1 ELSE 1 END as id FROM ThankYouProperties");
    int id1 = tableProperties.first["id"];

    await db.rawInsert(
        "INSERT Into ThankYouProperties (id,buttonMode,buttonText,showButton,showIcons,thankYouId)"
        " VALUES (?,?,?,?,?,?)",
        [
          id1,
          properties.buttonMode,
          properties.buttonText,
          properties.showButton,
          properties.shareIcons,
          id,
        ]);
    if (attachment != null) {
      await insertAttachment(attachment, id);
    }
  }

  /// Function to Insert Attachment data into Table Attachment
  ///
  /// - @param accepts thankYouId of type integer as Foreign key relationship
  /// - @param attachment of type Attachment
  ///
  ///
  insertAttachment(Attachment attachment, int thankYouId) async {
    final db = await database;
    var tableAttachment = await db.rawQuery(
        "SELECT CASE WHEN id IS NOT NULL THEN MAX(id)+1 ELSE 1 END as id FROM ThankYouAttachment");
    int id = tableAttachment.first["id"];

    return await db.rawInsert(
        "INSERT Into ThankYouAttachment (id,type,href,thankYouId)"
        " VALUES (?,?,?,?)",
        [
          id,
          attachment.type,
          attachment.href,
          thankYouId,
        ]);
  }

/** Function to Insert Data into API_Data
 *
 * - @param accepts Model of APIModel type
 */
  newAPIModel(APIModel apiModel) async {
    final db = await database;

    //insert to the table using the new id
    var _ = await db.rawInsert(
        "INSERT Into API_Data (id,title)"
        " VALUES (?,?)",
        [
          apiModel.id,
          apiModel.title,
        ]);
    /*Settings model = Settings(
        language: apiModel.settings.language,
        progressBar: apiModel.settings.progressBar,
        showProgressBar: apiModel.settings.showProgressBar);
*/
    await insertDataSettings(apiModel.settings, apiModel);

    int i = 0;
    for (var object in apiModel.welcomeScreens) {
      print("loop start");

      await insertWelcomeData(object, object.properties);
    }

    for (var object in apiModel.thankyouScreens) {
      await insertThankyouData(object, object.properties, object.attachment);
    }

    // insert Fields Data

    for (var object in apiModel.fields) {
      print("loop start");

      await insertField(object);
    }

    //return raw;
  }

  insertField(Field field) async {
    final db = await database;

    var _ = await db.rawInsert(
        "INSERT Into Fields (id,title,type)"
        " VALUES (?,?,?)",
        [field.id, field.title, field.type]);

    if (field.properties != null) {
      var tableProp = await db.rawQuery(
          "SELECT CASE WHEN id IS NOT NULL THEN MAX(id)+1 ELSE 1 END as id FROM FieldsProperties");
      int id = tableProp.first["id"];
      //  'CREATE TABLE FieldsProperties (id INTEGER PRIMARY KEY, alphabetical_order TEXT,shape TEXT,steps INTEGER, structure TEXT, separator TEXT, fieldId TEXT)');

      await db.rawInsert(
          "INSERT Into FieldsProperties (id,alphabetical_order,steps,shape,structure,separator,fieldId)"
          " VALUES (?,?,?,?,?,?,?)",
          [
            id,
            field.properties.alphabeticalOrder != null
                ? field.properties.alphabeticalOrder
                : "",
            field.properties.steps != null ? field.properties.steps : "",
            field.properties.shape != null ? field.properties.shape : "",
            field.properties.structure != null
                ? field.properties.structure
                : "",
            field.properties.separator != null
                ? field.properties.separator
                : "",
            field.id,
          ]);
      if(field.properties.choices != null){

        for (var object in field.properties.choices) {
          print("loop start");

          await insertChoices(id, object.label);
        }

      }
    }
  }


  insertChoices(int fieldPropId,String label)async{
    final db = await database;
    var tableChoices = await db.rawQuery(
        "SELECT CASE WHEN id IS NOT NULL THEN MAX(id)+1 ELSE 1 END as id FROM Choices");
    int idChoice = tableChoices.first["id"];

    await db.rawInsert(
        "INSERT Into Choices (id,label,fieldPropId)"
            " VALUES (?,?,?)",
        [
          idChoice,
          label ,
          fieldPropId,
        ]);
  }


/** Function to get Settings into Settings table
 *
 * - @return List of Setting
 */
 Future<APIModel> getAPIData() async {
    final db = await database;
   var res = await db.query(Constants.API_Data);
    APIModel list =
        res.isNotEmpty ? res.map((c) => APIModel.fromMap(c)) : [];
    return list;

    //return user;
  }

/** Function to get Settings into Settings table
 *
 * - @return List of Setting
 */
 Future<ThankyouScreenModel> getThankyouData() async {
    final db = await database;
   var res = await db.query(Constants.ThankYou);
    ThankyouScreenModel list =
        res.isNotEmpty ? res.map((c) => ThankyouScreenModel.fromMap(c)) : [];
    return list;

    //return user;
  }

/** Function to get Settings into Settings table
 *
 * - @return List of Setting
 */
/*  Future<Settings> getSettings() async {
    final db = await database;
   var res = await db.query(Constants.Settings);
    Settings list =
        res.isNotEmpty ? res.map((c) => Settings.fromMap(c)) : [];
    return list;

    //return user;
  } */

  getSettings(String apiId) async {
    final db = await database;
    var res = await db.query("Settings", where: "apiID = ?", whereArgs: [apiId]);
    return res.isNotEmpty ? Settings.fromMap(res.first) : null;
  }

/** Function to get Save user form into Client table
 * - @param accept parameter of type Client
 * - @return raw response;
 */
  newClient(Client newClient) async {
    final db = await database;

    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Client (id,userName,email,phone,age,gender,ratings,date,revisit)"
        " VALUES (?,?,?,?,?,?,?,?,?)",
        [
          id,
          newClient.userName,
          newClient.email,
          newClient.phone,
          newClient.age,
          newClient.gender,
          newClient.ratings,
          newClient.date,
          newClient.revisit
        ]);
    return raw;
  }

  blockOrUnblock(Client client) async {
    final db = await database;
    Client blocked = Client(
        id: client.id,
        userName: client.userName,
        email: client.email,
        phone: client.phone,
        age: client.age,
        gender: client.gender,
        ratings: client.ratings,
        date: client.date,
        revisit: !client.revisit);
    var res = await db.update("Client", blocked.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update("Client", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromMap(res.first) : null;
  }

  

  Future<List<Client>> getBlockedClients() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Client>> getAllClients() async {
    final db = await database;
    var res = await db.query("Client");
    List<Client> list =
        res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    //String table = "API_Data";
    
    final db = await database;
    var batch = db.batch();
    
   // String dropQuery = "DROP TABLE IF EXISTS " + Constants.API_Data;
    //String deleteQuery = DELETE FROM IF EXISTS API_Data
    
    await db.rawDelete("DELETE FROM API_Data");
    await db.rawDelete("DELETE FROM Choices");
    await db.rawDelete("DELETE FROM FieldsProperties");
    await db.rawDelete("DELETE FROM Fields");
    await db.rawDelete('DELETE FROM Settings');
    await db.rawDelete('DELETE FROM ThankYou');
    await db.rawDelete('DELETE FROM ThankYouAttachment');
    await db.rawDelete('DELETE FROM ThankYouProperties');
    await db.rawDelete('DELETE FROM Validations');
    await db.rawDelete('DELETE FROM Welcome');
    await db.rawDelete('DELETE FROM WelcomeProperties');
    
   //await batch.rawDelete("DELETE FROM IF EXISTS API_Data");
     /*  await batch.rawDelete("DROP TABLE IF EXISTS",[Constants.API_Data,Constants.Choices,Constants.FieldsProperties,Constants.Settings,Constants.ThankYou,Constants.ThankYouAttachment,Constants.ThankYouProperties,Constants.Validations,Constants.Welcome,Constants.WelcomeProperties]); */
  // return resp;
  }
}
