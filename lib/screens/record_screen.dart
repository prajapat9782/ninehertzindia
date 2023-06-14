import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:ninehertzindia/controller/record_controller.dart';
import 'package:provider/provider.dart';

class ScreenRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RecordController>(
        builder: (context, controller, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<RecordingDisposition>(
                  stream: controller.recoder.onProgress,
                  builder: (context, snapshot) {
                    final duration = snapshot.hasData
                        ? snapshot.data!.duration
                        : Duration.zero;

                    final minutes = duration.inMinutes.remainder(60);
                    final seconds = duration.inSeconds.remainder(60);
                    return Text("$minutes : $seconds");
                  },
                ),
                Text(controller.error),
                ElevatedButton(
                  onPressed: () {
                    controller.isRecording
                        ? controller.stop()
                        : controller.start();
                  },
                  child: Icon(
                    !controller.isRecording ? Icons.mic : Icons.stop,
                    size: 80,
                  ),
                ),
                controller.audioFile != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: [
                            const Text("Play Audio"),
                            IconButton(
                              onPressed: () {
                                if (controller.isPlaying) {
                                  controller.stopAudio();
                                } else {
                                  controller.playAudio();
                                }
                              },
                              icon: Icon(
                                controller.isPlaying
                                    ? Icons.stop
                                    : Icons.play_arrow,
                              ),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
