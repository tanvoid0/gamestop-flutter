import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gamestop/model/game.dart';
import 'package:gamestop/widgets/responsive.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video video;

  VideoPlayerScreen(this.video);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState(this.video);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final Video video;
  _VideoPlayerScreenState(this.video);

  VideoPlayerController _videoPlayerController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(this.video.data.max)
      ..initialize().then((_) => setState(() {}))
      ..setVolume(0)
      ..play();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause()
          : _videoPlayerController.play(),
      child: Container(),
      // Stack(alignment: Alignment.bottomLeft, children: [
      //   AspectRatio(
      //     aspectRatio: _videoPlayerController.value.isInitialized
      //         ? _videoPlayerController.value.aspectRatio
      //         : 2.344,
      //     child: _videoPlayerController.value.isInitialized
      //         ? VideoPlayer(_videoPlayerController)
      //         : BoxDecoration(
      //             shape: BoxShape.rectangle,
      //             image: new DecorationImage(
      //               fit: BoxFit.cover,
      //               image: NetworkImage(this.video.preview),
      //             ),
      //           ),
      //   ),
      // Positioned(
      //     left: 0,
      //     right: 0,
      //     bottom: -1.0,
      //     child: AspectRatio(
      //         aspectRatio: _videoPlayerController.value.isInitialized
      //             ? _videoPlayerController.value.aspectRatio
      //             : 2.344,
      //         child: Container(
      //             decoration: const BoxDecoration(
      //                 gradient: LinearGradient(
      //           colors: [Colors.black, Colors.transparent],
      //           begin: Alignment.bottomCenter,
      //           end: Alignment.topCenter,
      //         ))))),
      // Positioned(
      //   left: 60.0,
      //   right: 60.0,
      //   bottom: 150.0,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       SizedBox(
      //         width: 250.0,
      //         child: Image.asset(video.preview),
      //       ),
      //       const SizedBox(height: 15.0),
      //       const SizedBox(height: 20.0),
      //       Row(
      //         children: [
      //           _PlayButton(),
      //           const SizedBox(width: 16.0),
      //           FlatButton.icon(
      //             padding:
      //                 const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
      //             onPressed: () => print("more info"),
      //             color: Colors.white,
      //             icon: const Icon(Icons.info_outline, size: 30.0),
      //             label: const Text(
      //               'More info',
      //               style: TextStyle(
      //                 fontSize: 16.0,
      //                 fontWeight: FontWeight.w600,
      //               ),
      //             ),
      //           ),
      //           const SizedBox(width: 20.0),
      //           if (_videoPlayerController.value.isInitialized)
      //             IconButton(
      //               icon:
      //                   Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
      //               color: Colors.white,
      //               iconSize: 30.0,
      //               onPressed: () => setState(() {
      //                 _isMuted
      //                     ? _videoPlayerController.setVolume(100)
      //                     : _videoPlayerController.setVolume(0);
      //                 _isMuted = _videoPlayerController.value.volume == 0;
      //               }),
      //             )
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      // ],
      // )
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: !Responsive.isDesktop(context)
          ? const EdgeInsets.fromLTRB(15.0, 5.0, 20.0, 5.0)
          : const EdgeInsets.fromLTRB(25.0, 10.0, 30.0, 10.0),
      onPressed: () => print('play'),
      color: Colors.white,
      icon: const Icon(Icons.play_arrow, size: 30.0),
      label: const Text(
        'Play',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
