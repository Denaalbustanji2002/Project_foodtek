// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get welcomeTitle => 'مرحبًا بك في سهله';

  @override
  String get welcomeSubtitle => 'استمتع بتوصيل طعام سريع وسلس إلى باب منزلك';

  @override
  String get continueText => 'متابعة';

  @override
  String get skip => 'تخطي';

  @override
  String get deliveryTitle => 'استلم الطلب في الوقت المحدد';

  @override
  String get deliverySubtitle => 'اطلب طعامك المفضل بيدك ومن مكان راحتك';

  @override
  String get chooseFoodTitle => 'اختر طعامك';

  @override
  String get chooseFoodSubtitle => 'اطلب طعامك المفضل بسهولة وراحة تامة';

  @override
  String get locationTitle => 'قم بتشغيل الموقع';

  @override
  String get locationSubtitle => 'للمتابعة، اسمح لجهازك بتشغيل الموقع، والذي يستخدم خدمة المواقع من Google';

  @override
  String get yesTurnOn => 'نعم، قم بتشغيله';

  @override
  String get cancel => 'إلغاء';

  @override
  String get locationPermissionDenied => 'تم رفض إذن الموقع';

  @override
  String get oopsPermissionDeniedForeverPleaseAllowLocationPermissionFromSettings => 'عذرًا! تم رفض الإذن نهائيًا. يرجى السماح بإذن الموقع من الإعدادات !!';

  @override
  String get ok => 'موافق';

  @override
  String get locationServiceDisabled => 'خدمة الموقع معطلة';

  @override
  String get pleaseEnableLocationServicesToContinue => 'يرجى تفعيل خدمات الموقع للإستمرار !!';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String loginSuccessful(Object displayName) {
    return 'تم تسجيل الدخول بنجاح: $displayName';
  }

  @override
  String get googleSignInFailed => 'فشل تسجيل الدخول عبر Google';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get enterYourPassword => 'أدخل كلمة المرور';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get dontHaveAnAccount => 'ليس لديك حساب؟';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get rememberMe => 'تذكرني';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get logIn => 'تسجيل الدخول';

  @override
  String get or => 'أو';

  @override
  String get continueWithGoogle => 'متابعة باستخدام Google';

  @override
  String get continueWithFacebook => 'متابعة باستخدام Facebook';

  @override
  String get continueWithApple => 'متابعة باستخدام Apple';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get alreadyHaveAnAccount => 'لديك حساب بالفعل؟';

  @override
  String get error => 'خطأ';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get enterYourFullName => 'أدخل الاسم الكامل';

  @override
  String get fullNameCanNotBeEmpty => 'لا يمكن أن يكون الاسم فارغًا';

  @override
  String get pleaseEnterValidEmail => 'يرجى إدخال بريد إلكتروني صالح';

  @override
  String get pleaseEnterYourEmail => 'يرجى إدخال بريدك الإلكتروني';

  @override
  String get passwordDoesNotMeetCriteria => 'كلمة المرور غير قوية بما يكفي. يرجى اتباع المعايير المطلوبة.';

  @override
  String get date => 'التاريخ';

  @override
  String get birthOfDate => 'تاريخ الميلاد';

  @override
  String get invalidDateOfBirth => 'تاريخ الميلاد غير صالح';

  @override
  String get phoneErrorMessage => 'أدخل 10 أرقام لرقم الهاتف';

  @override
  String get wantToTryWithMyCurrentPassword => 'هل تريد المحاولة باستخدام كلمة المرور الحالية؟';

  @override
  String get reEnterYourPassword => 'أعد إدخال كلمة المرور';

  @override
  String get pleaseEnterYourNewPassword => 'يرجى إدخال كلمة المرور الجديدة';

  @override
  String get passwordsDoesNotMatch => 'كلمة المرور غير متطابقة';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get setPassword => 'تعيين كلمة المرور';

  @override
  String get register => 'تسجيل';

  @override
  String get backToLoginPage => 'العودة إلى صفحة تسجيل الدخول؟';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get page => '';

  @override
  String get enterYourEmailOrPhone => 'أدخل بريدك الإلكتروني أو رقم هاتفك وسنرسل لك رابطًا لاستعادة حسابك';

  @override
  String get send => 'إرسال';

  @override
  String get verificationText => 'تم إرسال رمز مكون من 4 أرقام إلى بريدك الإلكتروني. يرجى إدخاله للتحقق.';

  @override
  String get enterYourCode => 'أدخل رمز التحقق';

  @override
  String get codeMustBe4Digits => 'الرمز يجب أن يتكون من 4 أرقام';

  @override
  String get invalidVerificationCode => 'رمز التحقق غير صالح';

  @override
  String get verify => 'تحقق';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get updatePassword => 'تحديث كلمة المرور';

  @override
  String get congratulations => 'تهانينا!';

  @override
  String get passwordResetSuccessfully => 'تمت إعادة تعيين كلمة المرور بنجاح';

  @override
  String get userLocation => 'موقع المستخدم';

  @override
  String get currentLocation => 'الموقع الحالي';

  @override
  String get yourLocation => 'موقعك الحالى';

  @override
  String get passwordsDoNotMatch => 'كلمة المرور غير مطابقة';

  @override
  String get pleaseEnterValidPassword => 'يرجى إدخال كلمة مرور صالحة';
}
