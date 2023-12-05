class Alldata {
  int chapter_number;
  String chapter_summary;
  String chapter_summary_hindi;
  int  id;
  String image_name;
  String name;
  String name_meaning;
  String name_translation;
  String name_transliterated;
  int verses_count;
  String image_url;

  Alldata(
      {required this.chapter_number,
        required this.chapter_summary,
        required this.chapter_summary_hindi,
        required this.id,
        required this.image_name,
        required this.name_meaning,
        required this.name_translation,
        required this.name_transliterated,
        required this.verses_count,
        required this.name,
      required this.image_url});

}