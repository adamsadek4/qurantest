import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart' as quran;
import 'package:qurantest/tafserpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bookmark.dart';
import 'searchpage.dart';
import 'surahpage.dart';
import 'surahs.dart';
import 'teacherstudentpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static int ids = 0;
  static List<Map<String, Object>> surahbook = [];
  static int versenumberss = 1;
  static late SharedPreferences _prefs;
  static List<String> bookmarks1 = [];

  int selectedIndex = 0;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarks1 = _prefs.getStringList('bookmarks') ?? [];
    });
  }

  static Future<void> addBookmark(String bookmark) async {
    bookmarks1.add(bookmark);
    await _prefs.setStringList('bookmarks', bookmarks1);
  }

  Future<void> _removeBookmark(String bookmark) async {
    bookmarks1.remove(bookmark);
    await _prefs.setStringList('bookmarks', bookmarks1);
  }

  bool _isBookmarked(String bookmark) {
    return bookmarks1.contains(bookmark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search))
        ],
        shadowColor: const Color.fromARGB(255, 91, 130, 199),
      ),
      body: chaptersList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return TeacherPage();
            },
          ),
        ),
      ),
    );
  }

  Widget chaptersList() {
    return ListView.separated(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: surahs['chapters']![index]['revelation_place'].toString() ==
                  'madinah'
              ? const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/MADINA.png'),
                  radius: 20,
                )
              : const CircleAvatar(
                  foregroundImage: AssetImage('assets/images/kaaba.png'),
                  radius: 20,
                  backgroundColor: Color.fromARGB(0, 255, 255, 255),
                ),
          title: Text(surahs['chapters']![index]['name_simple'].toString()),
          subtitle: Text(
            surahs['chapters']![index]['verses_count'].toString(),
          ),
          trailing: Directionality(
            textDirection: TextDirection.rtl,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: surahs['chapters']![index]['name_arabic'].toString() +
                        '  ',
                    style: const TextStyle(
                        fontFamily: 'kitab', fontSize: 30, color: Colors.black),
                  ),
                  WidgetSpan(
                    child: IconButton(
                      icon: _isBookmarked(surahs['chapters']![index]
                                  ['name_arabic']
                              .toString())
                          ? const Icon(Icons.bookmark)
                          : const Icon(Icons.bookmark_border),
                      onPressed: () {
                        if (_isBookmarked(surahs['chapters']![index]
                                ['name_arabic']
                            .toString())) {
                          _removeBookmark(surahs['chapters']![index]
                                  ['name_arabic']
                              .toString());
                        } else {
                          addBookmark(surahs['chapters']![index]['name_arabic']
                              .toString());
                        }
                        setState(() {});
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SurahPage(
                  indexs: index,
                ),
              ),
            );
          },
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => Tafserpage(
                  indexs: index,
                ),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(
        height: 1,
      ),
      itemCount: surahs['chapters']!.length,
    );
  }
}
