import 'package:flutter/cupertino.dart';

class Episode {
  int epId;
  String name;
  String description;
  String uri;
  int epNum;
  int duration;
  int currentTime;

  Episode({
    this.epId,
    this.name,
    this.description,
    this.uri,
    this.epNum,
    this.duration,
    this.currentTime,
  });

  factory Episode.fromJson(json) {
    int tempCurrentTime;
    if (json['progresses'].length>0){
      tempCurrentTime = json['progresses'][0]['currentTime'];
    } else {
      tempCurrentTime = 0;
    }
    return Episode(
      epId: json['epId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      uri: json['uri'] as String,
      epNum: json['epNum'] as int,
      duration: json['duration'] as int,
      currentTime: tempCurrentTime,
    );
  }
}
