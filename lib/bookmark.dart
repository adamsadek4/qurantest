import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  late SharedPreferences _prefs;
  List<String> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _bookmarks = _prefs.getStringList('bookmarks') ?? [];
    });
  }

  Future<void> _addBookmark(String bookmark) async {
    _bookmarks.add(bookmark);
    await _prefs.setStringList('bookmarks', _bookmarks);
  }

  Future<void> _removeBookmark(String bookmark) async {
    _bookmarks.remove(bookmark);
    await _prefs.setStringList('bookmarks', _bookmarks);
  }

  bool _isBookmarked(String bookmark) {
    return _bookmarks.contains(bookmark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Article 1'),
            trailing: IconButton(
              icon: _isBookmarked('Article 1')
                  ? const Icon(Icons.bookmark)
                  : const Icon(Icons.bookmark_border),
              onPressed: () {
                if (_isBookmarked('Article 1')) {
                  _removeBookmark('Article 1');
                } else {
                  _addBookmark('Article 1');
                }
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: const Text('Article 2'),
            trailing: IconButton(
              icon: _isBookmarked('Article 2')
                  ? const Icon(Icons.bookmark)
                  : const Icon(Icons.bookmark_border),
              onPressed: () {
                if (_isBookmarked('Article 2')) {
                  _removeBookmark('Article 2');
                } else {
                  _addBookmark('Article 2');
                }
                setState(() {});
              },
            ),
          ),
          // add more articles here
        ],
      ),
    );
  }
}
