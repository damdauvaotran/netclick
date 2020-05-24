import 'package:flutter/cupertino.dart';

class Episode {
  int epId;
  String name;
  String description;
  String uri;
  int epNum;

  Episode({
    this.epId,
    this.name,
    this.description,
    this.uri,
    this.epNum,
  });

  factory Episode.fromJson(json) {
    print(json);
    return Episode(
      epId: json['epId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      uri: json['uri'] as String,
      epNum: json['epNum'] as int,
    );
  }
}
