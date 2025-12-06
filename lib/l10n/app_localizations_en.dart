// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Localized App';

  @override
  String get welcomeMessage => 'Welcome back!';

  @override
  String helloUser(String userName) {
    return 'Hello $userName';
  }

  @override
  String get support => 'Support';

  @override
  String get authHeader => 'Build Your Dream Home, \n Together';

  @override
  String get emailInput => 'Email Address';

  @override
  String get passwordInput => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get continueButton => 'Continue';

  @override
  String get or => 'or';

  @override
  String get continueWithGoogle => 'Continue With Google';

  @override
  String get continueWithApple => 'Continue With Apple';

  @override
  String get continueWithPhone => 'Continue With Phone';

  @override
  String get tandc => 'Terms and Conditions';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get and => 'and';

  @override
  String conditionsText(String tandc, String and, String privacyPolicy) {
    return 'By continuing, you agree to our $tandc $and $privacyPolicy';
  }

  @override
  String get dashboard => 'Dashboard';

  @override
  String get marketplace => 'Marketplace';

  @override
  String get services => 'Services';

  @override
  String get projects => 'Projects';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';
}
