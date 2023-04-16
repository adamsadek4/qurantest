import 'package:qurantest/arnumberconverter';

import 'package:flutter/material.dart';
import 'package:qurantest/tafserfunction.dart';

import 'surahs.dart';

class Tafserpage extends StatefulWidget {
  const Tafserpage({super.key, required this.indexs});
  final int indexs;

  @override
  State<Tafserpage> createState() => _TafserpageState();
}

class _TafserpageState extends State<Tafserpage> {
  @override
  Widget build(BuildContext context) {
    int count = surahs['chapters']![widget.indexs]['verses_count'] as int ;
    int index = surahs['chapters']![widget.indexs]['id'] as int ;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          minimum: const EdgeInsets.all(15),
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: header(),
            ),
            const SizedBox(
              height: 5,
            ),
            RichText(
              textAlign: count <= 20 ? TextAlign.center : TextAlign.justify,
              text: TextSpan(
                children: [
                  for (var i = 1; i <= count; i++) ...{
                    TextSpan(
                      text: ' ' +
                          Tafserfunction.getVerse(index, i) +
                          i.toString().toArabicNumbers +
                          ' ',
                      style: const TextStyle(
                        fontFamily: 'kitab',
                        fontSize: 25,
                        color: Colors.black87,
                      ),
                    ),
                  }
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget header() {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
         surahs['chapters']![widget.indexs]['name_arabic'].toString(),
          style: const TextStyle(
            fontFamily: 'kitab',
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ));
  }
}
