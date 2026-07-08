import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class EdgeCameraView extends StatefulWidget {


  final String url;


  const EdgeCameraView({
    super.key,
    required this.url,
  });


  @override
  State<EdgeCameraView> createState()
      => _EdgeCameraViewState();

}



class _EdgeCameraViewState
extends State<EdgeCameraView>{


  late VideoPlayerController controller;



  @override
  void initState(){

    super.initState();


    controller =
    VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    )
    ..initialize()
    .then((_){

      setState((){});

      controller.play();

    });


  }



  @override
  Widget build(BuildContext context){


    if(!controller.value.isInitialized){

      return const Center(
        child:CircularProgressIndicator(),
      );

    }


    return AspectRatio(

      aspectRatio:
      controller.value.aspectRatio,


      child:
      VideoPlayer(controller),

    );

  }



  @override
  void dispose(){

    controller.dispose();

    super.dispose();

  }

}