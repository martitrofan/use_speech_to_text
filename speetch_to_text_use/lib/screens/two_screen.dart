import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speetch_to_text_use/res/res.dart';
import 'package:speetch_to_text_use/utils/language.dart';

class TwoScreen extends StatefulWidget {
  @override
  _TwoScreenState createState() => _TwoScreenState();
}

class _TwoScreenState extends State<TwoScreen> {
  SpeechToText _speech;
  bool _speechRecognitionAvailable = false;
  bool _isListening = false;
  String transcription = '';
  Language selectedLang = languages.first;

  @override
  initState() {
    super.initState();
    activateSpeechRecognizer();
  }

  Future<void> activateSpeechRecognizer() async {
    _speech = SpeechToText();
    _speechRecognitionAvailable = await _speech.initialize(
        onError: errorHandler, onStatus: onSpeechAvailability);
    List<LocaleName> localeNames = await _speech.locales();
    languages.clear();
    localeNames.forEach((localeName) =>
        languages.add(Language(localeName.name, localeName.localeId)));
    var currentLocale = await _speech.systemLocale();
    if (null != currentLocale) {
      selectedLang =
          languages.firstWhere((lang) => lang.code == currentLocale.localeId);
    }
    setState(() {});
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(AppString.AppName),
      actions: [
        PopupMenuButton<Language>(
          onSelected: _selectLangHandler,
          itemBuilder: (BuildContext context) => _buildLanguagesWidgets,
        ),
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.content_copy),
            onPressed: () async {
              await FlutterClipboard.copy(transcription);
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
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      transcription,
                      style: AppStyles.inputStyle,
                    ))),
            _buildButton(
              onPressed: _speechRecognitionAvailable && !_isListening
                  ? () => start()
                  : null,
              label: _isListening
                  ? AppString.Listening
                  : '${AppString.Listen} (${selectedLang.code})',
            ),
            _buildButton(
              onPressed: _isListening ? () => stop() : null,
              label: AppString.Stop,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
      .map((l) => CheckedPopupMenuItem<Language>(
            value: l,
            checked: selectedLang == l,
            child: Text(l.name),
          ))
      .toList();

  void _selectLangHandler(Language lang) {
    setState(() => selectedLang = lang);
  }

  Widget _buildButton({String label, VoidCallback onPressed}) => Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: AppStyles.buttonStyle,
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(color: AppColors.white),
        ),
      ));

  void start() {
    _speech.listen(onResult: onRecognitionResult, localeId: selectedLang.code);
    setState(() => _isListening = true);
  }

  void stop() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void onSpeechAvailability(String status) {
    setState(() {
      _speechRecognitionAvailable = _speech.isAvailable;
      _isListening = _speech.isListening;
    });
  }

  void onCurrentLocale(String locale) {
    setState(
        () => selectedLang = languages.firstWhere((l) => l.code == locale));
  }

  void onRecognitionResult(SpeechRecognitionResult result) =>
      setState(() => transcription = result.recognizedWords);

  void errorHandler(SpeechRecognitionError error) => print(error);
}
