import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:qurantest/arnumberconverter';
import 'surah.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var myController = TextEditingController();
  var myController1 = TextEditingController();

  List<String> searchlist = [];
  List<String> searchlist1 = [];
  bool wordchek = false;
  @override
  Widget build(BuildContext context) {
    Map result = quran.searchWords(searchlist);
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      /* Clear the search field */
                      setState(() {
                        if (myController.text.isNotEmpty) {
                          myController1 = myController;
                          searchlist.add(myController.text);
                          searchlist1.add(myController.text);
                          myController.clear();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Text is empty"),
                          ));
                        }
                        wordchek = !wordchek;
                      });
                    },
                  ),
                  hintText: 'ابحث عن الاية ...',
                  hintStyle: const TextStyle(
                      fontFamily: 'kitab', fontSize: 20, height: 0.9),
                  border: InputBorder.none),
            ),
          ),
        ),
      )),
      body: Column(
        children: [
          SizedBox(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                ' عدد الايات '+ '(${result['occurences']})',
                style: const TextStyle(fontFamily: 'kitab', fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    subtitle: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        '' +
                            quran.getVerse(result['result'][index]['surah'],
                                result['result'][index]['verse'],
                                verseEndSymbol: false) +
                            result['result'][index]['verse']
                                .toString()
                                .toArabicNumbers,
                        style: const TextStyle(
                            fontFamily: 'kitab',
                            fontSize: 20,
                            color: Colors.black87),
                      ),
                    ),
                    trailing: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        quran.getSurahNameArabic(
                          result['result'][index]['surah'],
                        ),
                        style: const TextStyle(
                            fontFamily: 'kitab',
                            fontSize: 20,
                            color: Colors.black87),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ),
                itemCount: result['occurences']),
          ),
        ],
      ),
    );
  }
}
// SafeArea(
//         minimum: const EdgeInsets.all(15),
//         child: ListView(
//           primary: true,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(5),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'الايات الموافقة' +
//                         result['occurences'].toString().toArabicNumbers +
//                         ' ',
//                     style: TextStyle(
//                       fontFamily: 'kitab',
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             RichText(
//               text: (wordchek == true)
//                   ? TextSpan(
//                       text: ' ' +
//                           quran.getVerse(result['result'][1]['surah'],
//                               result['result'][1]['verse'],
//                               verseEndSymbol: false) +
//                           ' ',
//                       style: const TextStyle(color: Colors.black))
//                   : TextSpan(text: ' '),
//             ),
//             Text(
//               searchlist.isNotEmpty ? searchlist.toString() : "---",
//               style: const TextStyle(color: Colors.black),
//             ),
//           ],
//         ),
//       )
