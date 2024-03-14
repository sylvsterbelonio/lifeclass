class modelBibleVerse{
  late int book_number;
  late int chapter;
  late int verse;
  late String text;
  modelBibleVerse({
    required this.book_number,
    required this.chapter,
    required this.verse,
    required this.text});

  modelBibleVerse.fromMap(Map<String,dynamic> map) {
    book_number = map['book_number'];
    chapter = map['chapter'];
    verse = map['verse'];
    text = map['text'].replaceAll("'", "\\'");
  }

  Map<String,dynamic> toJson() => {
    'book_number':book_number,
    'chapter': chapter,
    'verse': verse,
    'text': text,
  };
}