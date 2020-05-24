import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WatchRoute extends StatefulWidget {
  @override
  WatchRouteState createState() => WatchRouteState();
}

class WatchRouteState extends State<WatchRoute> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.network('http://10.0.2.2:8000/movies/GOTss1ep2.mp4')
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
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

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
