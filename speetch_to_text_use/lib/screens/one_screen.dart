import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:speetch_to_text_use/api/speech_api.dart';
import 'package:speetch_to_text_use/res/res.dart';
import 'package:speetch_to_text_use/widgets/substring_highlighted.dart';

import 'file:///D:/test/_speechToText/speetch_to_text_use/lib/utils/utils.dart';

class OneScreen extends StatefulWidget {
  @override
  _OneScreenState createState() => _OneScreenState();
}

class _OneScreenState extends State<OneScreen> {
  String text = AppString.OneScreenHint;
  bool isListening = false;

  Widget _buildAppBar() {
    return AppBar(
      title: Text(AppString.AppName),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.content_copy),
            onPressed: () async {
              await FlutterClipboard.copy(text);

              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text(AppString.CopiedMessage)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      reverse: true,
      padding: const EdgeInsets.all(30).copyWith(bottom: 150),
      child: SubstringHighlight(
        text: text,
        terms: Command.all,
        textStyle: AppStyles.inputStyle,
        textStyleHighlight: AppStyles.inputCommandStyle,
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return AvatarGlow(
      animate: isListening,
      endRadius: 75,
      glowColor: Theme.of(context).primaryColor,
      child: FloatingActionButton(
        child: Icon(isListening ? Icons.mic : Icons.mic_none, size: 36),
        onPressed: toggleRecording,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _buildFloatingActionButton(),
      );

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() => this.text = text),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(seconds: 1), () {
              Utils.scanText(text);
            });
          }
        },
      );
}
