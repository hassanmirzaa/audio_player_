class Chapters {
  String? surahName;
  String? surahNameArabic;
  String? surahNameArabicLong;
  String? surahNameTranslation;
  String? revelationPlace;
  int? totalAyah;

  Chapters(
      {this.surahName,
      this.surahNameArabic,
      this.surahNameArabicLong,
      this.surahNameTranslation,
      this.revelationPlace,
      this.totalAyah});

  Chapters.fromJson(Map<String, dynamic> json) {
    surahName = json['surahName'];
    surahNameArabic = json['surahNameArabic'];
    surahNameArabicLong = json['surahNameArabicLong'];
    surahNameTranslation = json['surahNameTranslation'];
    revelationPlace = json['revelationPlace'];
    totalAyah = json['totalAyah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surahName'] = this.surahName;
    data['surahNameArabic'] = this.surahNameArabic;
    data['surahNameArabicLong'] = this.surahNameArabicLong;
    data['surahNameTranslation'] = this.surahNameTranslation;
    data['revelationPlace'] = this.revelationPlace;
    data['totalAyah'] = this.totalAyah;
    return data;
  }
}