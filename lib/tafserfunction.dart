
import 'tafsertext1.dart';


class Tafserfunction {
static String getVerse( int surahNumber, int verseNumber,
    {bool verseEndSymbol = false}) {
  String verse = "";
  for (var i in tafserext) {
    if (i["number"] == surahNumber.toString() && i["aya"] == verseNumber.toString()) {
      verse = i['text'].toString();
      break;
    }
  }

  if (verse == "") {
    throw "No verse found with given surahNumber and verseNumber.\n\n";
  }

  return verse + (verseEndSymbol ? getVerseEndSymbol(verseNumber) : "");
}
static String getVerseEndSymbol(int verseNumber, {bool arabicNumeral = true}) {
  var arabicNumeric = '';
  var digits = verseNumber.toString().split("").toList();

  if (!arabicNumeral) return '${verseNumber.toString()}';

  const Map arabicNumbers = {
    "0": "٠",
    "1": "۱",
    "2": "۲",
    "3": "۳",
    "4": "٤",
    "5": "٥",
    "6": "٦",
    "7": "۷",
    "8": "۸",
    "9": "۹"
  };

  for (var e in digits) {
    arabicNumeric += arabicNumbers[e];
  }

  return '$arabicNumeric';
}

}