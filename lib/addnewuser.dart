import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'teacherstudentpage.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({super.key});
  @override
  State<AddNewUser> createState() => AddNewUserState();
}

class AddNewUserState extends State<AddNewUser> {
  static int count = 0;
  static String count1 = '';
  String name = '';
  int age = 0;
  bool developer = false;
  int versenumber = 0;
  String surahname = '';
  bool pass = true;
  bool developer1 = true;
  var myController = TextEditingController();
  var myController1 = TextEditingController();
  var myController2 = TextEditingController();
  var myController3 = TextEditingController();
  var myController4 = TextEditingController();
  // String user = '';
  // String userage = '';
  // String userdeve = '';
  // String userversenumber = '0';
  // String usersuranumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void saveText() async {
    bool userdeve = false;
    bool userdeve1 =
        (myController2.text) == '1111' ? userdeve = true : userdeve = false;
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('Name', myController.text);
    pref.setInt('Age', int.parse(myController1.text));
    pref.setBool('developer', userdeve1);
    pref.setInt('versenumber', int.parse(myController3.text));
    pref.setInt('surahId', int.parse(myController4.text));
  }

  static void update (int versenumber, String surahname) {
    count = versenumber;
    count1 = surahname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('deve'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: DefaultTextStyle(
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Name ',
                      labelText: 'Name',
                      labelStyle: TextStyle(fontSize: 20),
                      hintStyle: TextStyle(fontSize: 15),
                      icon: Icon(Icons.person),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController1,
                    decoration: const InputDecoration(
                        hintText: 'Enter Age ',
                        labelText: 'Age',
                        labelStyle: TextStyle(fontSize: 20),
                        hintStyle: TextStyle(fontSize: 15),
                        icon: Icon(Icons.accessibility)),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController2,
                    decoration: InputDecoration(
                      hintText: 'Enter Password To be Developer ',
                      labelText: 'Developer',
                      labelStyle: const TextStyle(fontSize: 20),
                      hintStyle: const TextStyle(fontSize: 15),
                      icon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            pass = !pass;
                          });
                        },
                        icon: pass == false
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: pass,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController3,
                    decoration: const InputDecoration(
                      hintText: 'Enter versenumber of this surah',
                      labelText: 'Versenumber',
                      labelStyle: TextStyle(fontSize: 20),
                      hintStyle: TextStyle(fontSize: 15),
                      icon: CircleAvatar(
                        foregroundImage:
                            AssetImage('assets/images/original.png'),
                        radius: 14.0,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: myController4,
                    decoration: const InputDecoration(
                      hintText: 'Enter surahnumber',
                      labelText: 'Surahnumber ',
                      labelStyle: TextStyle(fontSize: 20),
                      hintStyle: TextStyle(fontSize: 15),
                      icon: CircleAvatar(
                        radius: 15.0,
                        foregroundImage: AssetImage('assets/images/kaaba.png'),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    saveText();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Apply this information to user '),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).push(
      //       MaterialPageRoute(builder: (_) {
      //         return const TeacherPage();
      //       }),
      //     );
      //   },
      // ),
    );
  }
}
