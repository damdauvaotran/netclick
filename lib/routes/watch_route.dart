import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netclick/api/common.dart';
import 'package:netclick/api/repo/episode_repository.dart';
import 'package:netclick/components/shared/loading_indicatior.dart';
import 'package:netclick/models/episode.dart';
import 'package:video_player/video_player.dart';

class WatchRoute extends StatefulWidget {
  final Episode episode;

  WatchRoute({this.episode});

  @override
  WatchRouteState createState() => WatchRouteState();
}

class WatchRouteState extends State<WatchRoute> {
  VideoPlayerController _controller;
  Episode _episode;
  Future _initRoute;
  Timer _timer;

  @override
  void initState() {
    _initRoute = init();
    super.initState();
  }

  @override
  void dispose() {
    _saveProgress();
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  Future<void> _saveProgress() async {
    await EpisodeRepository.saveProgress(
        epId: widget.episode.epId,
        progress: _controller.value.position.inMilliseconds);
  }

  Future init() async {
    _episode =
        await EpisodeRepository.getEpInfo(epId: widget.episode.epId.toString());
    _controller = VideoPlayerController.network(
        Uri.http(baseUrl, '/episode/watch/${_episode.epId}').toString());
    await _controller.initialize();
    // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    setState(() {});
    if (_episode.currentTime > 0) {
      _controller.seekTo(Duration(milliseconds: _episode.currentTime));
    }
    _controller.play();

    // Save progress periodic
    const saveDuration = const Duration(milliseconds: 500);
    _timer = Timer.periodic(saveDuration, (Timer t) {
      _saveProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
          body: Container(
        color: Theme.of(context).backgroundColor,
        child: RotatedBox(
          quarterTurns: 1,
          child: FutureBuilder(
              future: _initRoute,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Stack(
                    children: [
                      Center(
                        child: _controller.value.initialized
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(
                                  _controller,
                                ),
                              )
                            : Container(),
                      ),
                      Positioned(
                        bottom: 10,
                        width: MediaQuery.of(context).size.height,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.fast_rewind,
                                color: Colors.white,
                                size: 50,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    _controller.seekTo(
                                      Duration(
                                          milliseconds: _controller.value
                                                  .position.inMilliseconds -
                                              5000),
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Colors.white,
                                size: 50,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.fast_forward,
                                color: Colors.white,
                                size: 50,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.seekTo(
                                    Duration(
                                        milliseconds: _controller
                                                .value.position.inMilliseconds +
                                            5000),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 55,
                          width: MediaQuery.of(context).size.height,
                          child: Center(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.height * 0.9,
                                  child: VideoProgressIndicator(_controller,
                                      allowScrubbing: true)))),
                    ],
                  );
                }
                return LoadingIndicator();
              }),
        ),
      )),
    );
  }
}
