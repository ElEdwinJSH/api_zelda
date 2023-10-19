import 'package:meta/meta.dart';
import 'dart:convert';

class AllGames {
  bool success;
  int count;
  List<Games> data;

  AllGames({
    required this.success,
    required this.count,
    required this.data,
  });

  factory AllGames.fromRawJson(String str) =>
      AllGames.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllGames.fromJson(Map<String, dynamic> json) => AllGames(
        success: json["success"],
        count: json["count"],
        data: List<Games>.from(json["data"].map((x) => Games.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Games {
  String name;
  String description;
  String developer;
  Publisher publisher;
  String releasedDate;
  String id;

  Games({
    required this.name,
    required this.description,
    required this.developer,
    required this.publisher,
    required this.releasedDate,
    required this.id,
  });

  get gameImage {
    if (id != null) {
      return 'assets/$id.png';
    }
    return 'assets/The Legend of Zelda.png';
  }

  get gameMusic {
    if (id != null) {
      return '$id.mp3';
    }
    return '$id.mp3';
  }

  get dinamicName {
    if (name != null) {
      return '${name}';
    }
    return '';
  }

  factory Games.fromRawJson(String str) => Games.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Games.fromJson(Map<String, dynamic> json) => Games(
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
