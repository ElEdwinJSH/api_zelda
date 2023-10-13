import 'package:meta/meta.dart';
import 'dart:convert';

class Welcome {
  bool success;
  int count;
  List<Datum> data;

  Welcome({
    required this.success,
    required this.count,
    required this.data,
  });

  factory Welcome.fromRawJson(String str) => Welcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String name;
  String description;
  String developer;
  Publisher publisher;
  String releasedDate;
  String id;

  Datum({
    required this.name,
    required this.description,
    required this.developer,
    required this.publisher,
    required this.releasedDate,
    required this.id,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        description: json["description"],
        developer: json["developer"],
        publisher: publisherValues.map[json["publisher"]]!,
        releasedDate: json["released_date"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "developer": developer,
        "publisher": publisherValues.reverse[publisher],
        "released_date": releasedDate,
        "id": id,
      };
}

enum Publisher { NINTENDO, PHILIPS_MEDIA, ST_GIGA }

final publisherValues = EnumValues({
  "Nintendo": Publisher.NINTENDO,
  "Philips Media": Publisher.PHILIPS_MEDIA,
  "St. GIGA": Publisher.ST_GIGA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
