import 'package:netclick/api/common.dart';
import 'package:netclick/models/episode.dart';

class EpisodeRepository {
  static Future<Episode> getEpInfo({String epId}) async {
    Map<String, dynamic> data = await getAuth(url: 'episode/$epId');
    return Episode.fromJson(data);
  }

  static saveProgress({int progress, int epId}) async {
    void data = await postAuth(
        url: 'progress/save',
        body: {'progress': progress.toString(), 'epId': epId.toString()});
    return data;
  }
}
