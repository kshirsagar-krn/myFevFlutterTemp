import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = [
    Locale('en', ''),
    Locale('hi', ''),
    Locale('es', ''),
  ];

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'login_title': 'Login to your\nAccount',
      'login_subtitle': 'Enter your phone number. We will send\nyou a confirmation code there',
      'select_country': 'SELECT COUNTRY',
      'mobile_number': 'MOBILE NUMBER',
      'enter_phone_err': 'Please enter your phone number',
      'enter_valid_phone_err': 'Please enter a valid phone number',
      'no_account_signup': 'Do not have an account? Sign up',
      'send_otp': 'Send OTP',
      'terms_agree': 'By creating an account, I agree to eSmart Queue ',
      'terms_services': 'Terms & Services ',
      'and': 'and ',
      'privacy_policy': 'Privacy Policy',
      'six_digit_code': '6-Digit Code',
      'code_sent_to': 'Code sent to {number} unless you\nalready have an account',
      'resend_otp': 'Resend Otp? {time} Sec.',
      'verify_otp': 'Verify OTP',
      'create_account': 'Create Account',
      'enter_basic_details': 'Enter your basic details. We will send you a confirmation code there',
      'first_name': 'FIRST NAME',
      'enter_first_name_err': 'Please enter your first name',
      'last_name': 'LAST NAME',
      'enter_last_name_err': 'Please enter your last name',
      'email_address': 'EMAIL ADDRESS',
      'enter_email_err': 'Please enter your email address',
      'enter_valid_email_err': 'Please enter a valid email address',
      'dob': 'DOB',
      'enter_dob_err': 'Please enter your date of birth',
      'gender': 'GENDER',
      'enter_gender_err': 'Please enter your gender',
      'profile_image': 'PROFILE IMAGE',
      'upload_doc': 'Upload supporting document',
      'address_info': 'Address Info',
      'enter_address_details': 'Enter your Address details. We will send you a confirmation code there',
      'address': 'ADDRESS',
      'enter_address_err': 'Please enter your address',
      'pincode': 'PINCODE',
      'enter_pincode_err': 'Please enter your pincode',
      'country': 'COUNTRY',
      'enter_country_err': 'Please enter your country',
      'state': 'STATE',
      'enter_state_err': 'Please enter your state',
      'city': 'CITY',
      'enter_city_err': 'Please enter your city',
      'back': 'Back',
      'next': 'Next',
      'home': 'Home',
      'attendance': 'Attendance',
      'calendar': 'Calendar',
      'profile': 'Profile',
      'language_setting': 'Language Setting',
      'select_language': 'Select Language',
      'change_language': 'Change Language',
      'english': 'English',
      'hindi': 'Hindi',
      'spanish': 'Spanish',
      'theme_mode': 'Theme Mode',
      'dark_mode': 'Dark Mode',
      'light_mode': 'Light Mode',
      'system_mode': 'System Mode',
      'logout': 'Logout',
      'sign_out_moment': 'Sign out from App',
      'logout_confirm': 'Are you sure you would like to sign out of your account?',
      'cancel': 'No, Cancel',
      'yes_signout': 'Yes, Signout',
      'welcome_back': 'Welcome Back',
      'dashboard_info': 'This is your localized dashboard overview.',
      'attendance_history': 'Attendance History',
      'calendar_schedule': 'Schedule & Events',
      'active_logs': 'Active Logs',
      'search_gender': 'Search Gender',
      'search_country': 'Search Country',
      'search_state': 'Search State',
      'search_city': 'Search City',
    },
    'hi': {
      'login_title': 'अपने खाते में\nलॉगिन करें',
      'login_subtitle': 'अपना फ़ोन नंबर दर्ज करें। हम वहां एक पुष्टिकरण कोड भेजेंगे',
      'select_country': 'देश चुनें',
      'mobile_number': 'मोबाइल नंबर',
      'enter_phone_err': 'कृपया अपना फ़ोन नंबर दर्ज करें',
      'enter_valid_phone_err': 'कृपया एक वैध फ़ोन नंबर दर्ज करें',
      'no_account_signup': 'खाता नहीं है? साइन अप करें',
      'send_otp': 'ओटीपी भेजें',
      'terms_agree': 'खाता बनाकर, मैं eSmart Queue की ',
      'terms_services': 'सेवा की शर्तों ',
      'and': 'और ',
      'privacy_policy': 'गोपनीयता नीति से सहमत हूँ',
      'six_digit_code': '6-अंकीय कोड',
      'code_sent_to': 'कोड {number} पर भेजा गया है, जब तक कि आपके पास पहले से खाता न हो',
      'resend_otp': 'ओटीपी पुनः भेजें? {time} सेकंड',
      'verify_otp': 'ओटीपी सत्यापित करें',
      'create_account': 'खाता बनाएं',
      'enter_basic_details': 'अपने बुनियादी विवरण दर्ज करें। हम वहां एक पुष्टिकरण कोड भेजेंगे',
      'first_name': 'पहला नाम',
      'enter_first_name_err': 'कृपया अपना पहला नाम दर्ज करें',
      'last_name': 'अंतिम नाम',
      'enter_last_name_err': 'कृपया अपना अंतिम नाम दर्ज करें',
      'email_address': 'ईमेल पता',
      'enter_email_err': 'कृपया अपना ईमेल पता दर्ज करें',
      'enter_valid_email_err': 'कृपया एक वैध ईमेल पता दर्ज करें',
      'dob': 'जन्म तिथि',
      'enter_dob_err': 'कृपया अपनी जन्म तिथि दर्ज करें',
      'gender': 'लिंग',
      'enter_gender_err': 'कृपया अपना लिंग दर्ज करें',
      'profile_image': 'प्रोफ़ाइल छवि',
      'upload_doc': 'सहायक दस्तावेज़ अपलोड करें',
      'address_info': 'पते की जानकारी',
      'enter_address_details': 'अपने पते के विवरण दर्ज करें। हम वहां एक पुष्टिकरण कोड भेजेंगे',
      'address': 'पता',
      'enter_address_err': 'कृपया अपना पता दर्ज करें',
      'pincode': 'पिनकोड',
      'enter_pincode_err': 'कृपया अपना पिनकोड दर्ज करें',
      'country': 'देश',
      'enter_country_err': 'कृपया अपना देश दर्ज करें',
      'state': 'राज्य',
      'enter_state_err': 'कृपया अपना राज्य दर्ज करें',
      'city': 'शहर',
      'enter_city_err': 'कृपया अपना शहर दर्ज करें',
      'back': 'पीछे',
      'next': 'आगे',
      'home': 'होम',
      'attendance': 'उपस्थिति',
      'calendar': 'कैलेंडर',
      'profile': 'प्रोफ़ाइल',
      'language_setting': 'भाषा सेटिंग',
      'select_language': 'भाषा चुनें',
      'change_language': 'भाषा बदलें',
      'english': 'English (अंग्रेज़ी)',
      'hindi': 'हिन्दी',
      'spanish': 'Español (स्पैनिश)',
      'theme_mode': 'थीम मोड',
      'dark_mode': 'डार्क मोड',
      'light_mode': 'लाइट मोड',
      'system_mode': 'सिस्टम मोड',
      'logout': 'लॉगआउट',
      'sign_out_moment': 'ऐप से साइन आउट करें',
      'logout_confirm': 'क्या आप वाकई अपने खाते से साइन आउट करना चाहते हैं?',
      'cancel': 'नहीं, रद्द करें',
      'yes_signout': 'हाँ, साइनआउट',
      'welcome_back': 'आपका स्वागत है',
      'dashboard_info': 'यह आपकी स्थानीयकृत डैशबोर्ड समीक्षा है।',
      'attendance_history': 'उपस्थिति इतिहास',
      'calendar_schedule': 'अनुसूची और घटनाएँ',
      'active_logs': 'सक्रिय लॉग',
      'search_gender': 'लिंग खोजें',
      'search_country': 'देश खोजें',
      'search_state': 'राज्य खोजें',
      'search_city': 'शहर खोजें',
    },
    'es': {
      'login_title': 'Inicie sesión en su\ncuenta',
      'login_subtitle': 'Ingrese su número de teléfono. Le enviaremos un código de confirmación allí',
      'select_country': 'SELECCIONAR PAÍS',
      'mobile_number': 'NÚMERO DE MÓVIL',
      'enter_phone_err': 'Por favor ingrese su número de teléfono',
      'enter_valid_phone_err': 'Por favor ingrese un número de teléfono válido',
      'no_account_signup': '¿No tienes una cuenta? Regístrate',
      'send_otp': 'Enviar OTP',
      'terms_agree': 'Al crear una cuenta, acepto los ',
      'terms_services': 'Términos y Servicios ',
      'and': 'y la ',
      'privacy_policy': 'Política de Privacidad de eSmart Queue',
      'six_digit_code': 'Código de 6 dígitos',
      'code_sent_to': 'Código enviado al {number} a menos que ya tenga una cuenta',
      'resend_otp': '¿Reenviar OTP? {time} seg.',
      'verify_otp': 'Verificar OTP',
      'create_account': 'Crear cuenta',
      'enter_basic_details': 'Ingrese sus datos básicos. Le enviaremos un código de confirmación allí',
      'first_name': 'PRIMER NOMBRE',
      'enter_first_name_err': 'Por favor ingrese su primer nombre',
      'last_name': 'APELLIDO',
      'enter_last_name_err': 'Por favor ingrese su apellido',
      'email_address': 'CORREO ELECTRÓNICO',
      'enter_email_err': 'Por favor ingrese su correo electrónico',
      'enter_valid_email_err': 'Por favor ingrese un correo electrónico válido',
      'dob': 'FECHA DE NACIMIENTO',
      'enter_dob_err': 'Por favor ingrese su fecha de nacimiento',
      'gender': 'GÉNERO',
      'enter_gender_err': 'Por favor ingrese su género',
      'profile_image': 'IMAGEN DE PERFIL',
      'upload_doc': 'Subir documento de respaldo',
      'address_info': 'Información de Dirección',
      'enter_address_details': 'Ingrese sus datos de dirección. Le enviaremos un código de confirmación allí',
      'address': 'DIRECCIÓN',
      'enter_address_err': 'Por favor ingrese su dirección',
      'pincode': 'CÓDIGO POSTAL',
      'enter_pincode_err': 'Por favor ingrese su código postal',
      'country': 'PAÍS',
      'enter_country_err': 'Por favor ingrese su país',
      'state': 'ESTADO',
      'enter_state_err': 'Por favor ingrese su estado',
      'city': 'CIUDAD',
      'enter_city_err': 'Por favor ingrese su ciudad',
      'back': 'Atrás',
      'next': 'Siguiente',
      'home': 'Inicio',
      'attendance': 'Asistencia',
      'calendar': 'Calendario',
      'profile': 'Perfil',
      'language_setting': 'Configuración de idioma',
      'select_language': 'Seleccionar idioma',
      'change_language': 'Cambiar idioma',
      'english': 'English (Inglés)',
      'hindi': 'Hindi (हिन्दी)',
      'spanish': 'Español',
      'theme_mode': 'Modo de tema',
      'dark_mode': 'Modo oscuro',
      'light_mode': 'Modo claro',
      'system_mode': 'Modo del sistema',
      'logout': 'Cerrar sesión',
      'sign_out_moment': 'Cerrar sesión de la aplicación',
      'logout_confirm': '¿Está seguro de que desea cerrar la sesión de su cuenta?',
      'cancel': 'No, Cancelar',
      'yes_signout': 'Sí, Cerrar sesión',
      'welcome_back': 'Bienvenido de nuevo',
      'dashboard_info': 'Esta es su vista general del panel de control traducida.',
      'attendance_history': 'Historial de asistencia',
      'calendar_schedule': 'Horarios y eventos',
      'active_logs': 'Registros activos',
      'search_gender': 'Buscar género',
      'search_country': 'Buscar país',
      'search_state': 'Buscar estado',
      'search_city': 'Buscar ciudad',
    }
  };

  String translate(String key, {Map<String, String>? args}) {
    String value = _localizedValues[locale.languageCode]?[key] ?? _localizedValues['en']?[key] ?? key;
    if (args != null) {
      args.forEach((k, v) {
        value = value.replaceAll('{$k}', v);
      });
    }
    return value;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'hi', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension LocalizationExtension on BuildContext {
  String translate(String key, {Map<String, String>? args}) {
    return AppLocalizations.of(this)?.translate(key, args: args) ?? key;
  }
}
