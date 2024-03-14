class modelBibleBook{
  late int book_number;
  late String short_name;
  late String long_name;
  late String book_color;
  late int sorting_order;
  modelBibleBook({required this.book_number,required this.short_name,required long_name , required this.book_color, required this.sorting_order});

  modelBibleBook.fromMap(Map<String,dynamic> map) {
    book_number = map['book_number'];
    short_name = map['short_name'];
    long_name = map['long_name'];
    book_color = map['book_color'];
    sorting_order = map['sorting_order'];
  }

  Map<String,dynamic> toJson() => {
    'book_number':book_number,
    'short_name': short_name,
    'long_name': long_name,
    'book_color': book_color,
    'sorting_order': sorting_order,
  };
}