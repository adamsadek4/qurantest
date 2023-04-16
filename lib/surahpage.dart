import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:qurantest/arnumberconverter';
import 'package:qurantest/homepage.dart';
import 'searchpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'surahs.dart';
import 'teacherstudentpage.dart';

class SurahPage extends StatefulWidget {
  SurahPage({super.key, required this.indexs});
  int indexs;

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  static late SharedPreferences _prefs;
  static int bookmarks1 = 0;
  static int bookmarks2 = 0;
  static String surahname1 = '';
  static bool isbookmarked1 = false;
  Color b = Colors.black;
  Color bl = Colors.blue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool bookverse = false;
  Future<void> addBookmark1(int bookmark, String isbookmarked) async {
    await _prefs.setInt('bookmarks', bookmarks1);
    await _prefs.setInt('bookmarks1', bookmarks2);
    await _prefs.setString('isbookmarks', surahname1);
  }

  Future<void> _loadBookmarks() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarks1 = _prefs.getInt('bookmarks')!;
      bookmarks2 = _prefs.getInt('bookmarks1')!;
      surahname1 = _prefs.getString('isbookmarks')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    int count = surahs['chapters']![widget.indexs]['verses_count'] as int;
    int index = surahs['chapters']![widget.indexs]['id'] as int;
    int versenumber = 0;
    String surahname = '';
    int indexs = 0;

    void selectverse(BuildContext ctx) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) {
          return const TeacherPage();
        }),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const HomePage(),
                    ),
                  ),
              icon: const Icon(Icons.arrow_back)),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SearchPage(),
                      ),
                    ),
                icon: const Icon(Icons.search))
          ],
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(15),
          child: ListView(primary: true, children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: header(),
            ),
            const SizedBox(
              height: 5,
            ),
            SelectableText.rich(
              textAlign: count <= 20 ? TextAlign.center : TextAlign.justify,
              TextSpan(children: [
                TextSpan(
                  children: [
                    for (var i = 1; i <= count; i++) ...{
                      TextSpan(
                        text: ' ' +
                            quran.getVerse(index, i, verseEndSymbol: false) +
                            ' ' +
                            i.toString().toArabicNumbers +
                            ' ',
                        style: TextStyle(
                          fontFamily: 'kitab',
                          fontSize: 25,
                          color:
                              i == bookmarks1 && index == bookmarks2 ? bl : b,
                        ),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            quran.getVerseCount(index);
                            setState(() {
                              bookmarks1 = i;
                              bookmarks2 = index;
                              surahname1 = surahs['chapters']![widget.indexs]
                                      ['name_arabic']
                                  .toString();
                            });

                            addBookmark1(bookmarks1, surahname1);
                            HomePageState.addBookmark(
                                surahs['chapters']![widget.indexs]
                                        ['name_arabic']
                                    .toString());
                          },
                      ),
                    }
                  ],
                ),
              ]),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              (widget.indexs == 144) ? widget.indexs : widget.indexs++;
            });
          },
        ),
        drawer: Directionality(
          textDirection: TextDirection.ltr,
          child: Drawer(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      bookmarks1.toString().toArabicNumbers,
                      style: const TextStyle(fontFamily: 'Kitab', fontSize: 25),
                    ),
                    trailing: Text(
                      surahname1,
                      style: const TextStyle(fontFamily: 'Kitab', fontSize: 25),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ),
                itemCount: 1),
          ),
        ),
      ),
    );
  }

  Widget header() {
    int index = surahs['chapters']![widget.indexs]['id'] as int;
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
          index == 9 || index == 1
              ? const Text(
                  '',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'kitab',
                    fontSize: 24,
                  ),
                )
              : const Text(
                  ' ' + quran.basmala + ' ',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'kitab',
                    fontSize: 24,
                  ),
                ),
        ],
      ),
    );
  }
}
