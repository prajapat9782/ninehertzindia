import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordController extends ChangeNotifier {
  bool isRecording = false;
  bool isPlaying = false;
  String error = "";
  bool permissionGrant = false;
  File? audioFile;
  final recoder = FlutterSoundRecorder();

  // for play audio files
  final player = AudioPlayer();

  RecordController() {
    initRecoder();
  }

  initRecoder() async {
    final isPermissionGrant = await Permission.microphone.request();

    if (isPermissionGrant == PermissionStatus.denied) {
      error = "Permission denied";
      permissionGrant = false;
      notifyListeners();
      throw "Permission not granted";
    } else {
      error = "";
      permissionGrant = true;
      notifyListeners();
    }
    await recoder.openRecorder();

    recoder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  start() async {
    if (!permissionGrant) {
      error = "please grant the microphone permission";
      notifyListeners();
      return;
    }
    isRecording = true;
    await initRecoder();
    await recoder.startRecorder(toFile: 'audio');
    notifyListeners();
  }

  stop() async {
    isRecording = false;
    final path = await recoder.stopRecorder();
    audioFile = File(path!);
    log("Audio file $audioFile");

    notifyListeners();
  }

  playAudio() {
    isPlaying = true;
    player.play(
      DeviceFileSource(audioFile!.path),
    );
    notifyListeners();
  }

  stopAudio() {
    isPlaying = false;
    player.stop();
    notifyListeners();
  }
}
