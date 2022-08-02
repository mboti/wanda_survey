import 'dart:io';

import 'package:flutter/material.dart';
import 'package:matrix_gesture_mb/ui/activity/activity_scene.dart';

class CreateProjet extends StatefulWidget {
  const CreateProjet({Key? key}) : super(key: key);
  final String title = '';

  @override
  State<CreateProjet> createState() {
    return new CreateProjetState();
  }

}

class CreateProjetState extends State<CreateProjet>{
  var txtName=TextEditingController();

  final _formKey = GlobalKey<FormState>();

  int? itemSelect;
  bool _value = false;
  int val = -1;

  Map check = {
    'API OS Android': false,
    'API Livebox': false,
    'API ESP32': false
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildForm(),
          ],
        ),
      ),
    );
  }

  //TextFiel pour saisir le nom du projet
  buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Entrer le nom de votre projet"),
      controller: txtName,
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vous devez saisir le nom de votre projet';
        }
        return null;
      },
    );
  }


  // Bouton pour valider le nom d'un nouveau projet
  buildSaveButton() {
    final FormState? formState = _formKey.currentState;
    formState?.save();
    return ElevatedButton(
      child: Text("valider"),
      onPressed: (){
        final FormState? formState = _formKey.currentState;

        if(formState!.validate()){
          formState.save();
          [addProject()];
        }
      },
    );
  }

  //Bouton pour faire un retour vers la page Home
  buildPreviousButton(){
    return FlatButton(
      child: Text("Retour"),
      onPressed: (){
        navigateToHomePage();
      },
    );
  }

  // Formulaire de creation et de validation de projets:
  buildForm(){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildNameField(), getPlatformType(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: builRowForButtons(),
          ),
        ],
      ),
    );
  }

  // une Row pour alligner les bouttons
  builRowForButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [buildPreviousButton(), buildSaveButton()],
    );
  }

  // Methode pour ajouter dans la base de donnée et aller a la page ActivityScene
   void addProject() async{
     //var result = await dbHelper.insert(Project(name: txtName.text, description: txtDescription.text));
     _navigateToActivityScene();
   }

  //Methode pour revenir sur la page Home
  void navigateToHomePage(){
    Navigator.pop(context, true);
  }



  //Cette methode renvoie à la page ActivityScene.
  void _navigateToActivityScene(){
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new ActivityScene()),
    );
  }

  buildRadioTypeSnifferForAndroid(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text('API OS Android',  style: TextStyle(color: Colors.lightBlue, fontSize: 11.0, )),
          leading: Radio(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            focusColor: MaterialStateColor.resolveWith((states) => Colors.green),
            value: 1,
            groupValue: val,
            onChanged: (int? value) {
              setState(() {
                val = value!;
              });
            },
            activeColor: Colors.green,
          ),
        ),
        ListTile(
          title: Text('API Livebox',  style: TextStyle(color: Colors.lightBlue, fontSize: 11.0, )),
          leading: Radio(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            focusColor: MaterialStateColor.resolveWith((states) => Colors.green),
            value: 2,
            groupValue: val,
            onChanged: (int? value) {
              setState(() {
                val = value!;
              });
            },
            activeColor: Colors.green,
            toggleable: true,
          ),
        ),
        ListTile(
          title: Text('API ESP32', style: TextStyle(color: Colors.lightBlue, fontSize: 11.0, )),
          leading: Radio(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            focusColor: MaterialStateColor.resolveWith((states) => Colors.green),
            value: 3,
            groupValue: val,
            onChanged: (int? value) {
              setState(() {
                val = value!;
              });
            },
            activeColor: Colors.green,
            toggleable: true,
          ),
        ),
      ],
    );
  }

  buildRadioTypeSnifferForIos(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ListTile(
          title: Text('API Livebox', style: TextStyle(color: Colors.lightBlue, fontSize: 11.0, ), ),
          leading: Radio(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            focusColor: MaterialStateColor.resolveWith((states) => Colors.green),
            value: 2,
            groupValue: val,
            onChanged: (int? value) {
              setState(() {
                val = value!;
              });
            },
            activeColor: Colors.green,
            toggleable: true,
          ),
        ),
        ListTile(
          title: Text('API ESP32', style: TextStyle(color: Colors.lightBlue, fontSize: 11.0, ), ),
          leading: Radio(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.green),
            focusColor: MaterialStateColor.resolveWith((states) => Colors.green),
            value: 3,
            groupValue: val,
            onChanged: (int? value) {
              setState(() {
                val = value!;
              });
            },
            activeColor: Colors.green,
            toggleable: true,
          ),
        ),
      ],
    );
  }

  getPlatformType(){
    if(Platform.isAndroid){
      return buildRadioTypeSnifferForAndroid();
    }else if(Platform.isIOS){
      return buildRadioTypeSnifferForIos();
    }
  }



}//Fin
