import 'package:netclick/models/episode.dart';

class Film{
  List<Episode> _listEpisode;

  Film(){
    _listEpisode = [];
  }

  List<Episode> getListEpisode(){
    return _listEpisode;
  }
}