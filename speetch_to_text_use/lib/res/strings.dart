import 'package:speetch_to_text_use/utils/language.dart';
class AppString {

  static const AppName='Речь в текст';
  static const OneScreenName = 'Автоопределение языка';
  static const TwoScreenName = 'Выбранный язык';
  static const OneScreenHint='Нажмите и начните говорить';
  static const CopiedMessage='✓   Скопировано';

  static const Listening='Прослушивание...';
  static const Listen='Слушать';
  static const Cancel='Закончить';
  static const Stop='Остановить';
}

///список поддерживаемых команд
class Command {
  static final all = [
    email,
    email1,
    sms,
    phone,
    browser1,
    browser2,
    browser3,
    browser4
  ];

  static const email = 'write email';
  static const email1 = 'письмо';
  static const sms = 'сообщение';
  static const phone = 'позвонить';

  static const browser1 = 'open';
  static const browser2 = 'открыть';
  static const browser3 = 'go to';
  static const browser4 = 'перейти';
}

///Список языков по умолчанию
List<Language> languages = [
  const Language('System', 'default'),
  const Language('Francais', 'fr_FR'),
  const Language('English', 'en_US'),
  const Language('Pусский', 'ru_RU'),
  const Language('Italiano', 'it_IT'),
  const Language('Español', 'es_ES'),
];
