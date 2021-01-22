import 'package:flutter/material.dart';
import 'package:speetch_to_text_use/res/res.dart';
import 'package:url_launcher/url_launcher.dart';

///Для распознавания команд и выполнения соответствующих методов
class Utils {
  ///проверка наличия известной команды в переданном [text]
  static int getCommandIndex(final text) {
    for (int i = 0; i < Command.all.length; i++) {
      if (text.toString().toLowerCase().contains(Command.all[i])) {
        return i;
      }
    }
    return -1;
  }

  ///найти команду и вызвать соответствующий метод
  static void scanText(String rawText) {
    var body;
    var commandIndex;
    final text = rawText.toLowerCase();

    commandIndex = getCommandIndex(text);
    if (commandIndex >= 0) {
      switch (commandIndex) {
        case 0:
        case 1:
          body = _getTextAfterCommand(
              text: text, command: Command.all[commandIndex]);
          openEmail(body: body);
          break;
        case 2:
          body = _getTextAfterCommand(
              text: text, command: Command.all[commandIndex]);
          openSms(body: body);
          break;
        case 3:
          body = _getTextAfterCommand(
              text: text, command: Command.all[commandIndex]);
          openPhone(body: body);
          break;
        default:
          {
            final url = _getTextAfterCommand(
                text: text, command: Command.all[commandIndex]);
            openLink(url: url);
          }
      }
    }
  }

  ///получить текст после команды
  static String _getTextAfterCommand({
    @required String text,
    @required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return null;
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  ///открыть браузер
  static Future openLink({
    @required String url,
  }) async {
    if (url.trim().isEmpty) {
      await _launchUrl('https://google.com');
    } else {
      await _launchUrl('https://$url');
    }
  }

  ///открыть почтовый клиент
  static Future openEmail({
    @required String body,
  }) async {
    final url = 'mailto:?body=${Uri.encodeFull(body)}';
    await _launchUrl(url);
  }

  ///отправку СМС
  static Future openSms({
    @required String body,
  }) async {
    final url = 'sms:${Uri.encodeFull(body)}';
    await _launchUrl(url);
  }

  ///открыть телефон для вызова
  static Future openPhone({
    @required String body,
  }) async {
    final url = 'tel:${Uri.encodeFull(body)}';
    await _launchUrl(url);
  }

  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
