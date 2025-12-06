import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'My Localized App'**
  String get appTitle;

  /// The welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeMessage;

  /// Greeting for the user
  ///
  /// In en, this message translates to:
  /// **'Hello {userName}'**
  String helloUser(String userName);

  /// Support link/button text
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// Header text for authentication screen
  ///
  /// In en, this message translates to:
  /// **'Build Your Dream Home, \n Together'**
  String get authHeader;

  /// Placeholder for email input field
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailInput;

  /// Placeholder for password input field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordInput;

  /// Link for forgot password
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Continue button text
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// Separator text between sign-in methods
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// Button to continue with Google
  ///
  /// In en, this message translates to:
  /// **'Continue With Google'**
  String get continueWithGoogle;

  /// Button to continue with Apple
  ///
  /// In en, this message translates to:
  /// **'Continue With Apple'**
  String get continueWithApple;

  /// Button to continue with Phone
  ///
  /// In en, this message translates to:
  /// **'Continue With Phone'**
  String get continueWithPhone;

  /// Text for Terms and Conditions
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get tandc;

  /// Text for Privacy Policy
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Conjunction 'and'
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// User agreement statement with links to T&C and Privacy Policy
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our {tandc} {and} {privacyPolicy}'**
  String conditionsText(String tandc, String and, String privacyPolicy);

  /// Navigation link/tab for Dashboard
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// Navigation link/tab for Marketplace
  ///
  /// In en, this message translates to:
  /// **'Marketplace'**
  String get marketplace;

  /// Navigation link/tab for Services
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// Navigation link/tab for Projects
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// Navigation link/tab for Profile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Navigation link/tab for Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
