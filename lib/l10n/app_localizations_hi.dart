// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'मेरा स्थानीयकृत ऐप';

  @override
  String get welcomeMessage => 'वापस स्वागत है!';

  @override
  String helloUser(String userName) {
    return 'नमस्ते $userName';
  }

  @override
  String get support => 'समर्थन';

  @override
  String get authHeader => 'अपना सपनों का घर, \n मिलकर बनाएं';

  @override
  String get emailInput => 'ईमेल पता';

  @override
  String get passwordInput => 'पासवर्ड';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get continueButton => 'जारी रखें';

  @override
  String get or => 'या';

  @override
  String get continueWithGoogle => 'Google के साथ जारी रखें';

  @override
  String get continueWithApple => 'Apple के साथ जारी रखें';

  @override
  String get continueWithPhone => 'फ़ोन के साथ जारी रखें';

  @override
  String get tandc => 'नियम और शर्तें';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get and => 'और';

  @override
  String conditionsText(String tandc, String and, String privacyPolicy) {
    return 'जारी रखकर, आप हमारे $tandc $and $privacyPolicy से सहमत होते हैं';
  }

  @override
  String get dashboard => 'डैशबोर्ड';

  @override
  String get marketplace => 'मार्केटप्लेस';

  @override
  String get services => 'सेवाएँ';

  @override
  String get projects => 'परियोजनाएँ';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get logout => 'लॉग आउट';
}
