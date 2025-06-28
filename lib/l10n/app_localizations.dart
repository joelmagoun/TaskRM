import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_af.dart';
import 'app_localizations_bg.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_cy.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_eu.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_gl.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_hy.dart';
import 'app_localizations_id.dart';
import 'app_localizations_is.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ka.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_km.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ky.dart';
import 'app_localizations_lo.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_lv.dart';
import 'app_localizations_mk.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_my.dart';
import 'app_localizations_ne.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_no.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_ps.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tl.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';
import 'app_localizations_zu.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('bg'),
    Locale('bn'),
    Locale('ca'),
    Locale('cs'),
    Locale('cy'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('et'),
    Locale('eu'),
    Locale('fa'),
    Locale('fi'),
    Locale('fr'),
    Locale('gl'),
    Locale('gu'),
    Locale('he'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('hy'),
    Locale('id'),
    Locale('is'),
    Locale('it'),
    Locale('ja'),
    Locale('ka'),
    Locale('kk'),
    Locale('km'),
    Locale('kn'),
    Locale('ko'),
    Locale('ky'),
    Locale('lo'),
    Locale('lt'),
    Locale('lv'),
    Locale('mk'),
    Locale('ms'),
    Locale('my'),
    Locale('ne'),
    Locale('nl'),
    Locale('no'),
    Locale('pa'),
    Locale('pl'),
    Locale('ps'),
    Locale('pt'),
    Locale('ro'),
    Locale('ru'),
    Locale('sk'),
    Locale('sl'),
    Locale('sv'),
    Locale('sw'),
    Locale('ta'),
    Locale('te'),
    Locale('th'),
    Locale('tl'),
    Locale('tr'),
    Locale('uk'),
    Locale('ur'),
    Locale('vi'),
    Locale('zh'),
    Locale('zu'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @goals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goals;

  /// No description provided for @moments.
  ///
  /// In en, this message translates to:
  /// **'Moments'**
  String get moments;

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journal;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @feed.
  ///
  /// In en, this message translates to:
  /// **'Feed'**
  String get feed;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @jiraconns.
  ///
  /// In en, this message translates to:
  /// **'Jira Connections'**
  String get jiraconns;

  /// No description provided for @connections.
  ///
  /// In en, this message translates to:
  /// **'Connections'**
  String get connections;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @todaystasks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Tasks'**
  String get todaystasks;

  /// No description provided for @notaskstoday.
  ///
  /// In en, this message translates to:
  /// **'No tasks for today'**
  String get notaskstoday;

  /// No description provided for @addtaskstxt.
  ///
  /// In en, this message translates to:
  /// **'Add tasks by creating new ones or selecting from the queue.'**
  String get addtaskstxt;

  /// No description provided for @addtask.
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addtask;

  /// No description provided for @selectfromqueue.
  ///
  /// In en, this message translates to:
  /// **'Select from queue'**
  String get selectfromqueue;

  /// No description provided for @taskqueue.
  ///
  /// In en, this message translates to:
  /// **'Task queue'**
  String get taskqueue;

  /// No description provided for @notasksonqueue.
  ///
  /// In en, this message translates to:
  /// **'No tasks on your queue'**
  String get notasksonqueue;

  /// No description provided for @gobacktxt.
  ///
  /// In en, this message translates to:
  /// **'Go back, then add new tasks'**
  String get gobacktxt;

  /// No description provided for @newtask.
  ///
  /// In en, this message translates to:
  /// **'New task'**
  String get newtask;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @goal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get goal;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get work;

  /// No description provided for @personalproject.
  ///
  /// In en, this message translates to:
  /// **'Personal Project'**
  String get personalproject;

  /// No description provided for @self.
  ///
  /// In en, this message translates to:
  /// **'Self'**
  String get self;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @needstobedone.
  ///
  /// In en, this message translates to:
  /// **'Needs to be done'**
  String get needstobedone;

  /// No description provided for @nicetohave.
  ///
  /// In en, this message translates to:
  /// **'Nice to have'**
  String get nicetohave;

  /// No description provided for @niceidea.
  ///
  /// In en, this message translates to:
  /// **'Nice idea'**
  String get niceidea;

  /// No description provided for @timeframe.
  ///
  /// In en, this message translates to:
  /// **'Timeframe'**
  String get timeframe;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @threedays.
  ///
  /// In en, this message translates to:
  /// **'3 days'**
  String get threedays;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @fortnight.
  ///
  /// In en, this message translates to:
  /// **'Fortnight'**
  String get fortnight;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @ninteydays.
  ///
  /// In en, this message translates to:
  /// **'90 Days'**
  String get ninteydays;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @newgoal.
  ///
  /// In en, this message translates to:
  /// **'New Goal'**
  String get newgoal;

  /// No description provided for @learnnewskill.
  ///
  /// In en, this message translates to:
  /// **'Learn new skill'**
  String get learnnewskill;

  /// No description provided for @descriptiontxt.
  ///
  /// In en, this message translates to:
  /// **'Description goes here'**
  String get descriptiontxt;

  /// No description provided for @parentgoal.
  ///
  /// In en, this message translates to:
  /// **'Parent Goal'**
  String get parentgoal;

  /// No description provided for @selectparentgoal.
  ///
  /// In en, this message translates to:
  /// **'Select Parent Goal'**
  String get selectparentgoal;

  /// No description provided for @timespent.
  ///
  /// In en, this message translates to:
  /// **'Time spent'**
  String get timespent;

  /// No description provided for @lastactivity.
  ///
  /// In en, this message translates to:
  /// **'Last activity'**
  String get lastactivity;

  /// No description provided for @addtime.
  ///
  /// In en, this message translates to:
  /// **'Add Time'**
  String get addtime;

  /// No description provided for @completegoal.
  ///
  /// In en, this message translates to:
  /// **'Complete Goal'**
  String get completegoal;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @selectgoal.
  ///
  /// In en, this message translates to:
  /// **'Select Goal'**
  String get selectgoal;

  /// No description provided for @editgoal.
  ///
  /// In en, this message translates to:
  /// **'Edit Goal'**
  String get editgoal;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @timetracking.
  ///
  /// In en, this message translates to:
  /// **'Time tracking'**
  String get timetracking;

  /// No description provided for @emptygoalstitle.
  ///
  /// In en, this message translates to:
  /// **'What do you aspire to achieve?'**
  String get emptygoalstitle;

  /// No description provided for @emptygoalssubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add your personal and work goals to begin working on them.'**
  String get emptygoalssubtitle;

  /// No description provided for @sorry.
  ///
  /// In en, this message translates to:
  /// **'Sorry!'**
  String get sorry;

  /// No description provided for @nomatchinggoals.
  ///
  /// In en, this message translates to:
  /// **'No matching goals'**
  String get nomatchinggoals;

  /// No description provided for @nomatchinggoalstt.
  ///
  /// In en, this message translates to:
  /// **'No matching goals with this task type'**
  String get nomatchinggoalstt;

  /// No description provided for @addconnection.
  ///
  /// In en, this message translates to:
  /// **'Add connection'**
  String get addconnection;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @apikey.
  ///
  /// In en, this message translates to:
  /// **'API key'**
  String get apikey;

  /// No description provided for @editconnection.
  ///
  /// In en, this message translates to:
  /// **'Edit connection'**
  String get editconnection;

  /// No description provided for @personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get personal;

  /// No description provided for @emptyjiratitle.
  ///
  /// In en, this message translates to:
  /// **'Add Jira link'**
  String get emptyjiratitle;

  /// No description provided for @emptyjirasubtitlework.
  ///
  /// In en, this message translates to:
  /// **'All tasks of the type \'Work\' will be linked to this Jira address.'**
  String get emptyjirasubtitlework;

  /// No description provided for @emptyjirasubtitlepersonal.
  ///
  /// In en, this message translates to:
  /// **'All tasks of the type \'Personal\' will be linked to this Jira address.'**
  String get emptyjirasubtitlepersonal;

  /// No description provided for @emptyjirasubtitleself.
  ///
  /// In en, this message translates to:
  /// **'All tasks of the type \'Self\' will be linked to this Jira address.'**
  String get emptyjirasubtitleself;

  /// No description provided for @deleteconnection.
  ///
  /// In en, this message translates to:
  /// **'Delete connection'**
  String get deleteconnection;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @editprofiledetails.
  ///
  /// In en, this message translates to:
  /// **'Edit profile details'**
  String get editprofiledetails;

  /// No description provided for @profilephoto.
  ///
  /// In en, this message translates to:
  /// **'Profile photo'**
  String get profilephoto;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @selectimage.
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectimage;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @deleteprofilephoto.
  ///
  /// In en, this message translates to:
  /// **'Delete profile photo'**
  String get deleteprofilephoto;

  /// No description provided for @areyousure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areyousure;

  /// No description provided for @yesdelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, delete'**
  String get yesdelete;

  /// No description provided for @logmeout.
  ///
  /// In en, this message translates to:
  /// **'Log me out'**
  String get logmeout;

  /// No description provided for @selectrequiredinfo.
  ///
  /// In en, this message translates to:
  /// **'Please select all required information.'**
  String get selectrequiredinfo;

  /// No description provided for @titlehinttxt.
  ///
  /// In en, this message translates to:
  /// **'Schedule Team Meeting'**
  String get titlehinttxt;

  /// No description provided for @taskdescriptionhint.
  ///
  /// In en, this message translates to:
  /// **'Enter the description of the task'**
  String get taskdescriptionhint;

  /// No description provided for @selecttasktype.
  ///
  /// In en, this message translates to:
  /// **'Please select task type.'**
  String get selecttasktype;

  /// No description provided for @edittask.
  ///
  /// In en, this message translates to:
  /// **'Edit task'**
  String get edittask;

  /// No description provided for @task.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get task;

  /// No description provided for @completetask.
  ///
  /// In en, this message translates to:
  /// **'Complete Task'**
  String get completetask;

  /// No description provided for @removefromtodaystasks.
  ///
  /// In en, this message translates to:
  /// **'Remove from\nToday’s Tasks'**
  String get removefromtodaystasks;

  /// No description provided for @longpresstxt.
  ///
  /// In en, this message translates to:
  /// **'Long press a task to move it to today’s list'**
  String get longpresstxt;

  /// No description provided for @nomatchingtasks.
  ///
  /// In en, this message translates to:
  /// **'No matching tasks'**
  String get nomatchingtasks;

  /// No description provided for @movetotodaystasks.
  ///
  /// In en, this message translates to:
  /// **'Move to Today’s tasks'**
  String get movetotodaystasks;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotpassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotpassword;

  /// No description provided for @donthaveacct.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get donthaveacct;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signup;

  /// No description provided for @encryptionintrotxt.
  ///
  /// In en, this message translates to:
  /// **'This pattern enables you to recall your data in case of phone loss.'**
  String get encryptionintrotxt;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @mustenterpattern.
  ///
  /// In en, this message translates to:
  /// **'You must enter a pattern password!'**
  String get mustenterpattern;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @encryptionkey.
  ///
  /// In en, this message translates to:
  /// **'Encryption key'**
  String get encryptionkey;

  /// No description provided for @pattern.
  ///
  /// In en, this message translates to:
  /// **'Pattern'**
  String get pattern;

  /// No description provided for @createaccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createaccount;

  /// No description provided for @pleaseenterall.
  ///
  /// In en, this message translates to:
  /// **'Please enter all information'**
  String get pleaseenterall;

  /// No description provided for @alreadyhaveacct.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyhaveacct;

  /// No description provided for @jirasubtitlework.
  ///
  /// In en, this message translates to:
  /// **'All tasks of the type \'Work\' are linked to this Jira address.'**
  String get jirasubtitlework;

  /// No description provided for @jirasubtitlepersonal.
  ///
  /// In en, this message translates to:
  /// **'All tasks of the type \'Personal\' are linked to this Jira address.'**
  String get jirasubtitlepersonal;

  /// No description provided for @jirasubtitleself.
  ///
  /// In en, this message translates to:
  /// **'All tasks of the type \'Self\' are linked to this Jira address.'**
  String get jirasubtitleself;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'af',
    'bg',
    'bn',
    'ca',
    'cs',
    'cy',
    'da',
    'de',
    'el',
    'en',
    'es',
    'et',
    'eu',
    'fa',
    'fi',
    'fr',
    'gl',
    'gu',
    'he',
    'hi',
    'hr',
    'hu',
    'hy',
    'id',
    'is',
    'it',
    'ja',
    'ka',
    'kk',
    'km',
    'kn',
    'ko',
    'ky',
    'lo',
    'lt',
    'lv',
    'mk',
    'ms',
    'my',
    'ne',
    'nl',
    'no',
    'pa',
    'pl',
    'ps',
    'pt',
    'ro',
    'ru',
    'sk',
    'sl',
    'sv',
    'sw',
    'ta',
    'te',
    'th',
    'tl',
    'tr',
    'uk',
    'ur',
    'vi',
    'zh',
    'zu',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return AppLocalizationsAf();
    case 'bg':
      return AppLocalizationsBg();
    case 'bn':
      return AppLocalizationsBn();
    case 'ca':
      return AppLocalizationsCa();
    case 'cs':
      return AppLocalizationsCs();
    case 'cy':
      return AppLocalizationsCy();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'eu':
      return AppLocalizationsEu();
    case 'fa':
      return AppLocalizationsFa();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'gl':
      return AppLocalizationsGl();
    case 'gu':
      return AppLocalizationsGu();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'hr':
      return AppLocalizationsHr();
    case 'hu':
      return AppLocalizationsHu();
    case 'hy':
      return AppLocalizationsHy();
    case 'id':
      return AppLocalizationsId();
    case 'is':
      return AppLocalizationsIs();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ka':
      return AppLocalizationsKa();
    case 'kk':
      return AppLocalizationsKk();
    case 'km':
      return AppLocalizationsKm();
    case 'kn':
      return AppLocalizationsKn();
    case 'ko':
      return AppLocalizationsKo();
    case 'ky':
      return AppLocalizationsKy();
    case 'lo':
      return AppLocalizationsLo();
    case 'lt':
      return AppLocalizationsLt();
    case 'lv':
      return AppLocalizationsLv();
    case 'mk':
      return AppLocalizationsMk();
    case 'ms':
      return AppLocalizationsMs();
    case 'my':
      return AppLocalizationsMy();
    case 'ne':
      return AppLocalizationsNe();
    case 'nl':
      return AppLocalizationsNl();
    case 'no':
      return AppLocalizationsNo();
    case 'pa':
      return AppLocalizationsPa();
    case 'pl':
      return AppLocalizationsPl();
    case 'ps':
      return AppLocalizationsPs();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sk':
      return AppLocalizationsSk();
    case 'sl':
      return AppLocalizationsSl();
    case 'sv':
      return AppLocalizationsSv();
    case 'sw':
      return AppLocalizationsSw();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
    case 'th':
      return AppLocalizationsTh();
    case 'tl':
      return AppLocalizationsTl();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'ur':
      return AppLocalizationsUr();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
    case 'zu':
      return AppLocalizationsZu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
