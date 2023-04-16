import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quran/quran.dart' as quran;
import 'package:qurantest/addnewuser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherPage extends StatefulWidget {
  const TeacherPage({super.key});

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  String name1 = '';
  int age1 = 0;
  bool developer1 = false;
  int versenumber1 = 0;
  int surahId1 = 0;
  String surahname1 = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('user'),
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
              children: [
                Text('Name=' + name1),
                Text('Age=$age1'),
                Text('developer=$developer1'),
                Text('versenumber=$versenumber1'),
                Text('surah=' + surahname1),
                Text('surahId=$surahId1'),
                ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                          getData();

                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('get User '),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      deleteData();
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('delete User '),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) {
              return const AddNewUser();
            }),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() async {
      name1 = pref.getString('Name')!;
      age1 = pref.getInt('Age')!;
      developer1 = pref.getBool('developer')!;
      versenumber1 = pref.getInt('versenumber')!;
      surahId1 = pref.getInt('surahId')!;
      surahname1 = quran.getSurahNameArabic(surahId1);
    });
  }

  deleteData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.remove('Name');
      pref.remove('Age');
      pref.remove('developer');
      pref.remove('versenumber');
      pref.remove('surahId');
      name1 = '';
      age1 = 0;
      developer1 = false;
      versenumber1 = 0;
      surahId1 = 0;
      surahname1 = '';
    });
  }
}
