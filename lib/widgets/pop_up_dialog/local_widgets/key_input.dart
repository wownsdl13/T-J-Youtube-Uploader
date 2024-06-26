import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_translation/provider/screen_provider/screen_provider.dart';
import 'package:youtube_translation/screens/translator_screen/translator_provider/translator_provider.dart';

class KeyInput extends ConsumerStatefulWidget {
  const KeyInput({Key? key, required this.onClose}) : super(key: key);
  final GestureTapCallback onClose;

  @override
  _KeyInputState createState() => _KeyInputState();
}

class _KeyInputState extends ConsumerState<KeyInput> {
  final openAiController = TextEditingController();
  final youtubeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    var ts = ref.read(translatorProvider);
    ts.getYoutubeApiKey.then((key) {
      var t = ref.read(translatorProvider.notifier);
      t.setYoutubeApiKey(key);
    });
    youtubeController.addListener(() async {
      if (youtubeController.text.isNotEmpty) {
        var t = ref.read(translatorProvider.notifier);
        t.setYoutubeApiKey(youtubeController.text);
      }
    });
    ref.read(screenProvider).getOpenAiApiKey.then((value) {
      openAiController.text = value;
    });
    openAiController.addListener(() async {
      if (openAiController.text.isNotEmpty) {
        var t = ref.read(translatorProvider.notifier);
        t.setOpenAiApiKey(openAiController.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey.shade900,
          border: Border.all(width: 1, color: Colors.white),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Icon(Icons.key, color: Colors.white, size: 30),
              ),
              Expanded(
                child: TextField(
                  maxLines: 1,
                  controller: openAiController,
                  cursorColor: Colors.grey.shade600,
                  onSubmitted: (str) {
                    widget.onClose();
                  },
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Input openAi api key',
                      hintStyle: TextStyle(color: Colors.grey.shade700)),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Icon(Icons.video_call_rounded,
                    color: Colors.white, size: 30),
              ),
              Expanded(
                child: TextField(
                  maxLines: 1,
                  controller: youtubeController,
                  cursorColor: Colors.grey.shade600,
                  onSubmitted: (str) {
                    widget.onClose();
                  },
                  obscureText: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Input youtube data api key',
                      hintStyle: TextStyle(color: Colors.grey.shade700)),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          )
        ],
      ),
    );
  }
}
