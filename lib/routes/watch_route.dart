import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netclick/api/common.dart';
import 'package:netclick/api/repo/episode_repository.dart';
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

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        Uri.http(baseUrl, 'movies/${widget.episode.uri}.mp4').toString())
      ..initialize().then((_) {
        EpisodeRepository.getEpInfo(epId: widget.episode.epId.toString())
            .then((Episode futureEp) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {
            if (futureEp.currentTime > 0) {
              _controller.seekTo(Duration(milliseconds: futureEp.currentTime));
            }
            _controller.play();
          });
        });
      });
  }

  @override
  void dispose() {
    EpisodeRepository.saveProgress(
        epId: widget.episode.epId,
        progress: _controller.value.position.inMilliseconds);
    _controller.dispose();
    super.dispose();
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
          child: Stack(
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
                                  milliseconds: _controller
                                          .value.position.inMilliseconds -
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
                                milliseconds:
                                    _controller.value.position.inMilliseconds +
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
                          width: MediaQuery.of(context).size.height * 0.9,
                          child: VideoProgressIndicator(_controller,
                              allowScrubbing: true)))),
            ],
          ),
        ),
      )),
    );
  }
}
