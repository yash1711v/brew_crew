
import 'package:brew/Services/database.dartt.dart';
import 'package:brew/Shared/LoadingScren.dart';
import 'package:brew/module/module.dart';
import 'package:flutter/material.dart';
import 'package:brew/Shared/constants.dart';
import 'package:provider/provider.dart';
class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);
  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey=GlobalKey<FormState>();
  final List<String> sugars =['0','1','2','3','4'];
  late String _currentName="";
  late String _currentSugar="";
  late int _currentStrength=100;
  @override
  Widget build(BuildContext context) {
    final uuser=Provider.of<user?>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid: uuser!.uid).userDate,
      builder: (context,snapshot) {
      UserData? userD=snapshot.data;
      return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text("Update Your Brew Settings",
              style: TextStyle(fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              initialValue: userD!.name,
              decoration: InputDecoration(
                hintText: "Change name",
                labelText: "Update Your name",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Colors.brown),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              validator: (val) => val!.isEmpty ? 'Please enter name' : null,
              onChanged: (val) =>
                  setState(() {
                    _currentName = val;
                  }),
            ),
            SizedBox(height: 20.0,),
            //DropDown
            DropdownButtonFormField(
              value: _currentSugar??userD!.Sugar,//Setting up the Value Which is Updated
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: Colors.brown),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                hintStyle: TextStyle(color: Colors.black,),
                hintText: "Sugar Value",
              ),
              items: sugars.map((sugar) {
                return DropdownMenuItem(
                    value: sugar,
                    child: Text(
                        '$sugar sugars') //$means Calling the $ means That we are Calling the Abover Sugar Value,
                );
              }).toList(),
              onChanged: (val) =>
                  setState(() {
                    _currentSugar = val!;
                  }),
            ),
            //slidebar
            SizedBox(height: 20.0,),
            Slider(
              min: 100,
              max: 900,
              divisions: 8,
              value: (_currentStrength ?? userD.Strength).toDouble(),
              activeColor: Colors.brown[_currentStrength ?? userD.Strength],
              //to make the slider ColorFull
              inactiveColor: Colors.brown[_currentStrength ?? userD.Strength],
              onChanged: (double value) {
                setState(() {
                  _currentStrength = value.round();
                });
              },
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () {
                print(_currentName);
                print(_currentSugar);
                print(_currentStrength);
              },
              child: Text('Update',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.brown[300];
                  }
                  else if (states.contains(MaterialState.hovered)) {
                    return Colors.brown[800];
                  }
                  else {
                    return Colors.brown[500];
                  }
                }
                ),
              ),
            ),
          ],
        ),
      );
    }
    );
  }
}
