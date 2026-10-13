import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
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
    Locale('de'),
    Locale('en'),
    Locale('hr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Iron Progress'**
  String get appTitle;

  /// No description provided for @navTracker.
  ///
  /// In en, this message translates to:
  /// **'Tracker'**
  String get navTracker;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @localeEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get localeEnglish;

  /// No description provided for @localeGerman.
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get localeGerman;

  /// No description provided for @localeCroatian.
  ///
  /// In en, this message translates to:
  /// **'Hrvatski'**
  String get localeCroatian;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get commonCancel;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get commonDone;

  /// No description provided for @commonPreview.
  ///
  /// In en, this message translates to:
  /// **'PREVIEW'**
  String get commonPreview;

  /// No description provided for @commonRequired.
  ///
  /// In en, this message translates to:
  /// **'REQUIRED'**
  String get commonRequired;

  /// No description provided for @commonOptional.
  ///
  /// In en, this message translates to:
  /// **'OPTIONAL'**
  String get commonOptional;

  /// No description provided for @commonAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get commonAll;

  /// No description provided for @commonWorkout.
  ///
  /// In en, this message translates to:
  /// **'WORKOUT'**
  String get commonWorkout;

  /// No description provided for @commonRest.
  ///
  /// In en, this message translates to:
  /// **'REST'**
  String get commonRest;

  /// No description provided for @commonAddExercises.
  ///
  /// In en, this message translates to:
  /// **'ADD EXERCISES'**
  String get commonAddExercises;

  /// No description provided for @commonBrowseAllExercises.
  ///
  /// In en, this message translates to:
  /// **'BROWSE ALL EXERCISES'**
  String get commonBrowseAllExercises;

  /// No description provided for @commonExerciseLibrary.
  ///
  /// In en, this message translates to:
  /// **'EXERCISE LIBRARY'**
  String get commonExerciseLibrary;

  /// No description provided for @commonExerciseLibraryTooltip.
  ///
  /// In en, this message translates to:
  /// **'Exercise library'**
  String get commonExerciseLibraryTooltip;

  /// No description provided for @commonCreateProgram.
  ///
  /// In en, this message translates to:
  /// **'CREATE PROGRAM'**
  String get commonCreateProgram;

  /// No description provided for @commonStartWorkout.
  ///
  /// In en, this message translates to:
  /// **'START WORKOUT'**
  String get commonStartWorkout;

  /// No description provided for @commonUnitLbs.
  ///
  /// In en, this message translates to:
  /// **'lbs'**
  String get commonUnitLbs;

  /// No description provided for @commonWeekAbbreviation.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get commonWeekAbbreviation;

  /// No description provided for @dayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get dayMonday;

  /// No description provided for @dayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get dayTuesday;

  /// No description provided for @dayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get dayWednesday;

  /// No description provided for @dayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get dayThursday;

  /// No description provided for @dayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get dayFriday;

  /// No description provided for @daySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get daySaturday;

  /// No description provided for @daySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get daySunday;

  /// No description provided for @dayMondayShort.
  ///
  /// In en, this message translates to:
  /// **'MON'**
  String get dayMondayShort;

  /// No description provided for @dayTuesdayShort.
  ///
  /// In en, this message translates to:
  /// **'TUE'**
  String get dayTuesdayShort;

  /// No description provided for @dayWednesdayShort.
  ///
  /// In en, this message translates to:
  /// **'WED'**
  String get dayWednesdayShort;

  /// No description provided for @dayThursdayShort.
  ///
  /// In en, this message translates to:
  /// **'THU'**
  String get dayThursdayShort;

  /// No description provided for @dayFridayShort.
  ///
  /// In en, this message translates to:
  /// **'FRI'**
  String get dayFridayShort;

  /// No description provided for @daySaturdayShort.
  ///
  /// In en, this message translates to:
  /// **'SAT'**
  String get daySaturdayShort;

  /// No description provided for @daySundayShort.
  ///
  /// In en, this message translates to:
  /// **'SUN'**
  String get daySundayShort;

  /// No description provided for @stepSetup.
  ///
  /// In en, this message translates to:
  /// **'SETUP'**
  String get stepSetup;

  /// No description provided for @stepWeeklySplit.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY SPLIT'**
  String get stepWeeklySplit;

  /// No description provided for @stepBuild.
  ///
  /// In en, this message translates to:
  /// **'BUILD'**
  String get stepBuild;

  /// No description provided for @stepIndicatorSemanticLabel.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}: {label}'**
  String stepIndicatorSemanticLabel(int step, int total, String label);

  /// No description provided for @focusHypertrophy.
  ///
  /// In en, this message translates to:
  /// **'HYPERTROPHY'**
  String get focusHypertrophy;

  /// No description provided for @focusStrength.
  ///
  /// In en, this message translates to:
  /// **'STRENGTH'**
  String get focusStrength;

  /// No description provided for @focusPowerlifting.
  ///
  /// In en, this message translates to:
  /// **'POWERLIFTING'**
  String get focusPowerlifting;

  /// No description provided for @focusBodybuilding.
  ///
  /// In en, this message translates to:
  /// **'BODYBUILDING'**
  String get focusBodybuilding;

  /// No description provided for @workoutTitleChestTriceps.
  ///
  /// In en, this message translates to:
  /// **'Chest & Triceps'**
  String get workoutTitleChestTriceps;

  /// No description provided for @workoutTitleBackBiceps.
  ///
  /// In en, this message translates to:
  /// **'Back & Biceps'**
  String get workoutTitleBackBiceps;

  /// No description provided for @workoutTitleRest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get workoutTitleRest;

  /// No description provided for @workoutTitleLegsAbsQuadFocus.
  ///
  /// In en, this message translates to:
  /// **'Legs & Abs (Quad Focus)'**
  String get workoutTitleLegsAbsQuadFocus;

  /// No description provided for @workoutTitleShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get workoutTitleShoulders;

  /// No description provided for @workoutTitleFullBody.
  ///
  /// In en, this message translates to:
  /// **'Full Body'**
  String get workoutTitleFullBody;

  /// No description provided for @workoutTitleRestRecovery.
  ///
  /// In en, this message translates to:
  /// **'Rest & Recovery'**
  String get workoutTitleRestRecovery;

  /// No description provided for @workoutTitleShouldersArmsHypertrophy.
  ///
  /// In en, this message translates to:
  /// **'Shoulders & Arms Hypertrophy'**
  String get workoutTitleShouldersArmsHypertrophy;

  /// No description provided for @workoutTitleLegsAbs.
  ///
  /// In en, this message translates to:
  /// **'Legs & Abs'**
  String get workoutTitleLegsAbs;

  /// No description provided for @muscleChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get muscleChest;

  /// No description provided for @muscleBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get muscleBack;

  /// No description provided for @muscleBiceps.
  ///
  /// In en, this message translates to:
  /// **'Biceps'**
  String get muscleBiceps;

  /// No description provided for @muscleTriceps.
  ///
  /// In en, this message translates to:
  /// **'Triceps'**
  String get muscleTriceps;

  /// No description provided for @muscleQuads.
  ///
  /// In en, this message translates to:
  /// **'Quads'**
  String get muscleQuads;

  /// No description provided for @muscleAbs.
  ///
  /// In en, this message translates to:
  /// **'Abs'**
  String get muscleAbs;

  /// No description provided for @muscleShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get muscleShoulders;

  /// No description provided for @equipmentBarbell.
  ///
  /// In en, this message translates to:
  /// **'Barbell'**
  String get equipmentBarbell;

  /// No description provided for @equipmentDumbbell.
  ///
  /// In en, this message translates to:
  /// **'Dumbbell'**
  String get equipmentDumbbell;

  /// No description provided for @equipmentCable.
  ///
  /// In en, this message translates to:
  /// **'Cable'**
  String get equipmentCable;

  /// No description provided for @equipmentMachine.
  ///
  /// In en, this message translates to:
  /// **'Machine'**
  String get equipmentMachine;

  /// No description provided for @equipmentBodyweight.
  ///
  /// In en, this message translates to:
  /// **'Bodyweight'**
  String get equipmentBodyweight;

  /// No description provided for @difficultyBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get difficultyBeginner;

  /// No description provided for @difficultyIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get difficultyIntermediate;

  /// No description provided for @difficultyAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get difficultyAdvanced;

  /// No description provided for @exerciseBenchPressName.
  ///
  /// In en, this message translates to:
  /// **'Barbell Bench Press'**
  String get exerciseBenchPressName;

  /// No description provided for @exerciseBenchPressInstructions.
  ///
  /// In en, this message translates to:
  /// **'Plant your feet and brace your torso. Lower the bar to your chest with control, then press up without lifting your hips.'**
  String get exerciseBenchPressInstructions;

  /// No description provided for @exerciseInclinePressName.
  ///
  /// In en, this message translates to:
  /// **'Incline Dumbbell Press'**
  String get exerciseInclinePressName;

  /// No description provided for @exerciseInclinePressInstructions.
  ///
  /// In en, this message translates to:
  /// **'Set the bench to a modest incline. Keep your shoulder blades back and press the dumbbells above your upper chest.'**
  String get exerciseInclinePressInstructions;

  /// No description provided for @exerciseCableFlyName.
  ///
  /// In en, this message translates to:
  /// **'Cable Chest Fly'**
  String get exerciseCableFlyName;

  /// No description provided for @exerciseCableFlyInstructions.
  ///
  /// In en, this message translates to:
  /// **'Keep a soft bend in your elbows. Bring the handles together in front of your chest, then return slowly to a comfortable stretch.'**
  String get exerciseCableFlyInstructions;

  /// No description provided for @exerciseTricepsPushdownName.
  ///
  /// In en, this message translates to:
  /// **'Triceps Rope Pushdown'**
  String get exerciseTricepsPushdownName;

  /// No description provided for @exerciseTricepsPushdownInstructions.
  ///
  /// In en, this message translates to:
  /// **'Hold your elbows close to your sides. Extend your arms and separate the rope ends, then return without moving your shoulders.'**
  String get exerciseTricepsPushdownInstructions;

  /// No description provided for @exerciseLatPulldownName.
  ///
  /// In en, this message translates to:
  /// **'Lat Pulldown'**
  String get exerciseLatPulldownName;

  /// No description provided for @exerciseLatPulldownInstructions.
  ///
  /// In en, this message translates to:
  /// **'Brace your torso and pull the bar toward your upper chest. Lead with your elbows and control the return.'**
  String get exerciseLatPulldownInstructions;

  /// No description provided for @exerciseBarbellRowName.
  ///
  /// In en, this message translates to:
  /// **'Bent-Over Barbell Row'**
  String get exerciseBarbellRowName;

  /// No description provided for @exerciseBarbellRowInstructions.
  ///
  /// In en, this message translates to:
  /// **'Hinge at your hips with a neutral spine. Pull the bar toward your lower ribs without swinging your torso.'**
  String get exerciseBarbellRowInstructions;

  /// No description provided for @exerciseBicepsCurlName.
  ///
  /// In en, this message translates to:
  /// **'Dumbbell Biceps Curl'**
  String get exerciseBicepsCurlName;

  /// No description provided for @exerciseBicepsCurlInstructions.
  ///
  /// In en, this message translates to:
  /// **'Keep your upper arms still. Curl the dumbbells toward your shoulders and lower them with control.'**
  String get exerciseBicepsCurlInstructions;

  /// No description provided for @exerciseSquatName.
  ///
  /// In en, this message translates to:
  /// **'Barbell Back Squat'**
  String get exerciseSquatName;

  /// No description provided for @exerciseSquatInstructions.
  ///
  /// In en, this message translates to:
  /// **'Brace before each repetition. Bend at your hips and knees to a comfortable depth, then drive through your whole foot.'**
  String get exerciseSquatInstructions;

  /// No description provided for @exerciseLegExtensionName.
  ///
  /// In en, this message translates to:
  /// **'Leg Extension'**
  String get exerciseLegExtensionName;

  /// No description provided for @exerciseLegExtensionInstructions.
  ///
  /// In en, this message translates to:
  /// **'Align your knees with the machine pivot. Extend your legs without locking your knees forcefully, then lower slowly.'**
  String get exerciseLegExtensionInstructions;

  /// No description provided for @exercisePlankName.
  ///
  /// In en, this message translates to:
  /// **'Plank'**
  String get exercisePlankName;

  /// No description provided for @exercisePlankInstructions.
  ///
  /// In en, this message translates to:
  /// **'Keep your elbows below your shoulders and your body in a straight line. Brace and breathe steadily. For this timed exercise, the builder records seconds in the reps field.'**
  String get exercisePlankInstructions;

  /// No description provided for @exerciseOverheadPressName.
  ///
  /// In en, this message translates to:
  /// **'Barbell Overhead Press'**
  String get exerciseOverheadPressName;

  /// No description provided for @exerciseOverheadPressInstructions.
  ///
  /// In en, this message translates to:
  /// **'Brace your torso and keep your ribs down. Press the bar overhead without leaning back, then return to shoulder height.'**
  String get exerciseOverheadPressInstructions;

  /// No description provided for @exerciseLateralRaiseName.
  ///
  /// In en, this message translates to:
  /// **'Dumbbell Lateral Raise'**
  String get exerciseLateralRaiseName;

  /// No description provided for @exerciseLateralRaiseInstructions.
  ///
  /// In en, this message translates to:
  /// **'With a soft elbow bend, raise your arms to shoulder height. Use a controlled pace and avoid shrugging or swinging.'**
  String get exerciseLateralRaiseInstructions;

  /// No description provided for @exerciseFacePullName.
  ///
  /// In en, this message translates to:
  /// **'Cable Face Pull'**
  String get exerciseFacePullName;

  /// No description provided for @exerciseFacePullInstructions.
  ///
  /// In en, this message translates to:
  /// **'Pull the rope toward your forehead with your elbows high. Keep your torso still and squeeze your shoulder blades gently.'**
  String get exerciseFacePullInstructions;

  /// No description provided for @exerciseSeatedDumbbellPressName.
  ///
  /// In en, this message translates to:
  /// **'Seated Dumbbell Press'**
  String get exerciseSeatedDumbbellPressName;

  /// No description provided for @exerciseCableTricepsPushdownName.
  ///
  /// In en, this message translates to:
  /// **'Cable Triceps Pushdown'**
  String get exerciseCableTricepsPushdownName;

  /// No description provided for @exerciseCableCrunchName.
  ///
  /// In en, this message translates to:
  /// **'Cable Crunch'**
  String get exerciseCableCrunchName;

  /// No description provided for @exerciseDeadliftName.
  ///
  /// In en, this message translates to:
  /// **'Deadlift'**
  String get exerciseDeadliftName;

  /// No description provided for @exerciseBarbellSquatName.
  ///
  /// In en, this message translates to:
  /// **'Barbell Squat'**
  String get exerciseBarbellSquatName;

  /// No description provided for @exerciseLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'EXERCISE LIBRARY'**
  String get exerciseLibraryTitle;

  /// No description provided for @exercisePickerSearchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search exercises'**
  String get exercisePickerSearchLabel;

  /// No description provided for @exercisePickerClearTooltip.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get exercisePickerClearTooltip;

  /// No description provided for @exercisePickerMuscleLabel.
  ///
  /// In en, this message translates to:
  /// **'MUSCLE GROUP'**
  String get exercisePickerMuscleLabel;

  /// No description provided for @exercisePickerEquipmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get exercisePickerEquipmentLabel;

  /// No description provided for @exercisePickerDifficultyLabel.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get exercisePickerDifficultyLabel;

  /// No description provided for @exercisePickerEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No matching exercises'**
  String get exercisePickerEmptyTitle;

  /// No description provided for @exercisePickerEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Try a different search or change your filters.'**
  String get exercisePickerEmptyDescription;

  /// No description provided for @exercisePickerDetailsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Exercise details'**
  String get exercisePickerDetailsTooltip;

  /// No description provided for @exercisePickerSelectedLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{# exercise selected} other{# exercises selected}}'**
  String exercisePickerSelectedLabel(int count);

  /// No description provided for @exercisePickerConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'ADD {count} EXERCISES'**
  String exercisePickerConfirmLabel(int count);

  /// No description provided for @exerciseDetailsTechniqueLabel.
  ///
  /// In en, this message translates to:
  /// **'TECHNIQUE'**
  String get exerciseDetailsTechniqueLabel;

  /// No description provided for @exerciseDetailsInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'CONTROL EVERY REP'**
  String get exerciseDetailsInfoTitle;

  /// No description provided for @exerciseDetailsInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose a load that lets you keep good form. Stop if you feel pain and ask a qualified coach for help.'**
  String get exerciseDetailsInfoDescription;

  /// No description provided for @exercisePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'SELECT EXERCISES'**
  String get exercisePickerTitle;

  /// No description provided for @exercisePickerCancelTooltip.
  ///
  /// In en, this message translates to:
  /// **'Cancel exercise selection'**
  String get exercisePickerCancelTooltip;

  /// No description provided for @exercisePickerAddToDay.
  ///
  /// In en, this message translates to:
  /// **'Add exercises to {dayName}'**
  String exercisePickerAddToDay(String dayName);

  /// No description provided for @exercisePickerAddToDayTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Exercises to {dayName}'**
  String exercisePickerAddToDayTitle(String dayName);

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'PROGRESS'**
  String get dashboardTitle;

  /// No description provided for @dashboardTotalVolumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Volume'**
  String get dashboardTotalVolumeLabel;

  /// No description provided for @dashboardWorkoutsLabel.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get dashboardWorkoutsLabel;

  /// No description provided for @dashboardThisMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get dashboardThisMonthLabel;

  /// No description provided for @dashboardStrengthGainsTitle.
  ///
  /// In en, this message translates to:
  /// **'STRENGTH GAINS'**
  String get dashboardStrengthGainsTitle;

  /// No description provided for @dashboardTrendBarbellSquatName.
  ///
  /// In en, this message translates to:
  /// **'BARBELL SQUAT'**
  String get dashboardTrendBarbellSquatName;

  /// No description provided for @dashboardTrendBarbellSquatGain.
  ///
  /// In en, this message translates to:
  /// **'+15 lbs'**
  String get dashboardTrendBarbellSquatGain;

  /// No description provided for @dashboardTrendBenchPressName.
  ///
  /// In en, this message translates to:
  /// **'BENCH PRESS'**
  String get dashboardTrendBenchPressName;

  /// No description provided for @dashboardTrendBenchPressGain.
  ///
  /// In en, this message translates to:
  /// **'+5 lbs'**
  String get dashboardTrendBenchPressGain;

  /// No description provided for @dashboardTrendChartSemanticLabel.
  ///
  /// In en, this message translates to:
  /// **'{exercise} over five weeks'**
  String dashboardTrendChartSemanticLabel(String exercise);

  /// No description provided for @dashboardTrendChartEmptyLabel.
  ///
  /// In en, this message translates to:
  /// **'No samples'**
  String get dashboardTrendChartEmptyLabel;

  /// No description provided for @dashboardTrendPointSemanticLabel.
  ///
  /// In en, this message translates to:
  /// **'Week {week}: {value} lbs'**
  String dashboardTrendPointSemanticLabel(int week, String value);

  /// No description provided for @dashboardPersonalBestsTitle.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL BESTS'**
  String get dashboardPersonalBestsTitle;

  /// No description provided for @dashboardPersonalBestLabel.
  ///
  /// In en, this message translates to:
  /// **'1 REP MAX'**
  String get dashboardPersonalBestLabel;

  /// No description provided for @dashboardPersonalBestDeadlift.
  ///
  /// In en, this message translates to:
  /// **'DEADLIFT'**
  String get dashboardPersonalBestDeadlift;

  /// No description provided for @dashboardPersonalBestSquat.
  ///
  /// In en, this message translates to:
  /// **'SQUAT'**
  String get dashboardPersonalBestSquat;

  /// No description provided for @dashboardPersonalBestBench.
  ///
  /// In en, this message translates to:
  /// **'BENCH'**
  String get dashboardPersonalBestBench;

  /// No description provided for @dashboardPersonalBestOhp.
  ///
  /// In en, this message translates to:
  /// **'OHP'**
  String get dashboardPersonalBestOhp;

  /// No description provided for @dashboardSampleDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Sample progress data. Logged sessions stay local to this app session.'**
  String get dashboardSampleDisclaimer;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'HISTORY'**
  String get historyTitle;

  /// No description provided for @historySectionTitle.
  ///
  /// In en, this message translates to:
  /// **'WORKOUT HISTORY'**
  String get historySectionTitle;

  /// No description provided for @historySectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Local sessions · resets when the app restarts'**
  String get historySectionSubtitle;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No sessions logged'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Finish a workout in Tracker to see it here.'**
  String get historyEmptyDescription;

  /// No description provided for @historySessionSummary.
  ///
  /// In en, this message translates to:
  /// **'{sets, plural, one{# set} other{# sets}} · {volume} lbs'**
  String historySessionSummary(int sets, String volume);

  /// No description provided for @historyCompleteBadge.
  ///
  /// In en, this message translates to:
  /// **'COMPLETE'**
  String get historyCompleteBadge;

  /// No description provided for @createProgramTitle.
  ///
  /// In en, this message translates to:
  /// **'CREATE PROGRAM'**
  String get createProgramTitle;

  /// No description provided for @setupDefaultProgramName.
  ///
  /// In en, this message translates to:
  /// **'HYPERTROPHY OVERLOAD 01'**
  String get setupDefaultProgramName;

  /// No description provided for @setupPhaseLabel.
  ///
  /// In en, this message translates to:
  /// **'PHASE 01  /  ARCHITECT'**
  String get setupPhaseLabel;

  /// No description provided for @setupScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'1. PROGRAM SETUP'**
  String get setupScreenTitle;

  /// No description provided for @setupScreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Name your routine and define the training cycle parameters.'**
  String get setupScreenDescription;

  /// No description provided for @setupProgramNameSection.
  ///
  /// In en, this message translates to:
  /// **'PROGRAM NAME'**
  String get setupProgramNameSection;

  /// No description provided for @setupProgramNameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Program name'**
  String get setupProgramNameFieldLabel;

  /// No description provided for @setupProgramNameRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Enter a program name to continue.'**
  String get setupProgramNameRequiredError;

  /// No description provided for @setupProgramPhilosophySection.
  ///
  /// In en, this message translates to:
  /// **'PROGRAM PHILOSOPHY'**
  String get setupProgramPhilosophySection;

  /// No description provided for @setupProgramPhilosophyFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Program philosophy'**
  String get setupProgramPhilosophyFieldLabel;

  /// No description provided for @setupProgramPhilosophyHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 5-day push/pull/legs focusing on progressive overload and high mechanical tension...'**
  String get setupProgramPhilosophyHint;

  /// No description provided for @setupTrainingFocusSection.
  ///
  /// In en, this message translates to:
  /// **'TRAINING FOCUS'**
  String get setupTrainingFocusSection;

  /// No description provided for @setupCycleDurationSection.
  ///
  /// In en, this message translates to:
  /// **'CYCLE DURATION'**
  String get setupCycleDurationSection;

  /// No description provided for @setupCycleDurationRecommended.
  ///
  /// In en, this message translates to:
  /// **'RECOMMENDED: 10 WEEKS'**
  String get setupCycleDurationRecommended;

  /// No description provided for @setupCycleDurationOption.
  ///
  /// In en, this message translates to:
  /// **'{weeks} WEEKS'**
  String setupCycleDurationOption(int weeks);

  /// No description provided for @setupInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'CYCLE SYNCHRONIZATION'**
  String get setupInfoTitle;

  /// No description provided for @setupInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'This weekly split will repeat across all weeks in the cycle. Microcycle progressive overload and delta weights can be recalibrated per block.'**
  String get setupInfoDescription;

  /// No description provided for @setupNextButton.
  ///
  /// In en, this message translates to:
  /// **'NEXT: CONFIGURE WEEKLY SPLIT'**
  String get setupNextButton;

  /// No description provided for @weeklySplitPhaseLabel.
  ///
  /// In en, this message translates to:
  /// **'PHASE 02 / STRUCTURE'**
  String get weeklySplitPhaseLabel;

  /// No description provided for @weeklySplitScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'2. WEEKLY SPLIT'**
  String get weeklySplitScreenTitle;

  /// No description provided for @weeklySplitSummary.
  ///
  /// In en, this message translates to:
  /// **'{name} · {focus} · {weeks} weeks'**
  String weeklySplitSummary(String name, String focus, int weeks);

  /// No description provided for @weeklySplitDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose workout and recovery days. Edit a workout to build its exercise prescription.'**
  String get weeklySplitDescription;

  /// No description provided for @weeklySplitScheduleLabel.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY SCHEDULE'**
  String get weeklySplitScheduleLabel;

  /// No description provided for @weeklySplitWorkoutDaysBadge.
  ///
  /// In en, this message translates to:
  /// **'{count} WORKOUT DAYS'**
  String weeklySplitWorkoutDaysBadge(int count);

  /// No description provided for @weeklySplitEditDayTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit {dayName}'**
  String weeklySplitEditDayTooltip(String dayName);

  /// No description provided for @weeklySplitInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR REPEATING MICROCYCLE'**
  String get weeklySplitInfoTitle;

  /// No description provided for @weeklySplitInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'This seven-day schedule repeats for every week of your program. Rest days preserve their exercises if you switch them back to a workout.'**
  String get weeklySplitInfoDescription;

  /// No description provided for @weeklySplitNextButton.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE: BUILD WORKOUTS'**
  String get weeklySplitNextButton;

  /// No description provided for @dayBuilderTitle.
  ///
  /// In en, this message translates to:
  /// **'WORKOUT BUILDER'**
  String get dayBuilderTitle;

  /// No description provided for @dayBuilderPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'WORKOUT PREVIEW'**
  String get dayBuilderPreviewTitle;

  /// No description provided for @dayBuilderBackToBuilderButton.
  ///
  /// In en, this message translates to:
  /// **'BACK TO BUILDER'**
  String get dayBuilderBackToBuilderButton;

  /// No description provided for @dayBuilderPreviewRestDescription.
  ///
  /// In en, this message translates to:
  /// **'Recovery day. No exercises scheduled.'**
  String get dayBuilderPreviewRestDescription;

  /// No description provided for @dayBuilderPreviewEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Add exercises to build this workout.'**
  String get dayBuilderPreviewEmptyDescription;

  /// No description provided for @dayBuilderAddExerciseOrRestError.
  ///
  /// In en, this message translates to:
  /// **'Add an exercise or mark this day as rest.'**
  String get dayBuilderAddExerciseOrRestError;

  /// No description provided for @dayBuilderEveryWorkoutNeedsExerciseError.
  ///
  /// In en, this message translates to:
  /// **'Every workout day needs at least one exercise.'**
  String get dayBuilderEveryWorkoutNeedsExerciseError;

  /// No description provided for @dayBuilderRestRecoveryTitle.
  ///
  /// In en, this message translates to:
  /// **'Rest & recovery'**
  String get dayBuilderRestRecoveryTitle;

  /// No description provided for @dayBuilderRestRecoveryDescription.
  ///
  /// In en, this message translates to:
  /// **'No workout is scheduled. Adding an exercise turns this into a workout day.'**
  String get dayBuilderRestRecoveryDescription;

  /// No description provided for @dayBuilderBuildWorkoutButton.
  ///
  /// In en, this message translates to:
  /// **'BUILD A WORKOUT'**
  String get dayBuilderBuildWorkoutButton;

  /// No description provided for @dayBuilderWorkoutNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Workout name'**
  String get dayBuilderWorkoutNameLabel;

  /// No description provided for @dayBuilderWorkoutNameRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Enter a workout name.'**
  String get dayBuilderWorkoutNameRequiredError;

  /// No description provided for @dayBuilderExercisePrescriptionsLabel.
  ///
  /// In en, this message translates to:
  /// **'EXERCISE PRESCRIPTIONS'**
  String get dayBuilderExercisePrescriptionsLabel;

  /// No description provided for @dayBuilderExerciseCount.
  ///
  /// In en, this message translates to:
  /// **'{count} EXERCISES'**
  String dayBuilderExerciseCount(int count);

  /// No description provided for @dayBuilderEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Build your first exercise'**
  String get dayBuilderEmptyTitle;

  /// No description provided for @dayBuilderEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Add exercises below, then choose sets, reps and rest for each one.'**
  String get dayBuilderEmptyDescription;

  /// No description provided for @dayBuilderSetsLabel.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get dayBuilderSetsLabel;

  /// No description provided for @dayBuilderRepsLabel.
  ///
  /// In en, this message translates to:
  /// **'Reps'**
  String get dayBuilderRepsLabel;

  /// No description provided for @dayBuilderHoldSecondsLabel.
  ///
  /// In en, this message translates to:
  /// **'Hold (sec)'**
  String get dayBuilderHoldSecondsLabel;

  /// No description provided for @dayBuilderRestSecondsLabel.
  ///
  /// In en, this message translates to:
  /// **'Rest (sec)'**
  String get dayBuilderRestSecondsLabel;

  /// No description provided for @dayBuilderRangeError.
  ///
  /// In en, this message translates to:
  /// **'Enter {min}–{max}.'**
  String dayBuilderRangeError(int min, int max);

  /// No description provided for @dayBuilderDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete {exercise}'**
  String dayBuilderDeleteTooltip(String exercise);

  /// No description provided for @dayBuilderMoveUpTooltip.
  ///
  /// In en, this message translates to:
  /// **'Move {exercise} up'**
  String dayBuilderMoveUpTooltip(String exercise);

  /// No description provided for @dayBuilderMoveDownTooltip.
  ///
  /// In en, this message translates to:
  /// **'Move {exercise} down'**
  String dayBuilderMoveDownTooltip(String exercise);

  /// No description provided for @dayBuilderDetailsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Details: {exercise}'**
  String dayBuilderDetailsTooltip(String exercise);

  /// No description provided for @dayBuilderDragTooltip.
  ///
  /// In en, this message translates to:
  /// **'Drag to reorder'**
  String get dayBuilderDragTooltip;

  /// No description provided for @dayBuilderSaveAndReturnButton.
  ///
  /// In en, this message translates to:
  /// **'SAVE DAY & RETURN'**
  String get dayBuilderSaveAndReturnButton;

  /// No description provided for @dayBuilderContinueButton.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE: REVIEW PROGRAM'**
  String get dayBuilderContinueButton;

  /// No description provided for @programExercisePrescriptionReps.
  ///
  /// In en, this message translates to:
  /// **'{sets, plural, one{# set} other{# sets}} × {reps} reps · {restSeconds}s rest'**
  String programExercisePrescriptionReps(int sets, int reps, int restSeconds);

  /// No description provided for @programExercisePrescriptionHold.
  ///
  /// In en, this message translates to:
  /// **'{sets, plural, one{# set} other{# sets}} × {reps} sec hold · {restSeconds}s rest'**
  String programExercisePrescriptionHold(int sets, int reps, int restSeconds);

  /// No description provided for @programCreatorTitle.
  ///
  /// In en, this message translates to:
  /// **'PROGRAM CREATOR'**
  String get programCreatorTitle;

  /// No description provided for @programCreatorReadyLabel.
  ///
  /// In en, this message translates to:
  /// **'READY TO TRAIN'**
  String get programCreatorReadyLabel;

  /// No description provided for @programCreatorWeeksBadge.
  ///
  /// In en, this message translates to:
  /// **'{count} WEEKS'**
  String programCreatorWeeksBadge(int count);

  /// No description provided for @programCreatorDaysPerWeekBadge.
  ///
  /// In en, this message translates to:
  /// **'{count} DAYS / WEEK'**
  String programCreatorDaysPerWeekBadge(int count);

  /// No description provided for @programCreatorSetsPerWeekBadge.
  ///
  /// In en, this message translates to:
  /// **'{count} SETS / WEEK'**
  String programCreatorSetsPerWeekBadge(int count);

  /// No description provided for @programCreatorScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY SCHEDULE'**
  String get programCreatorScheduleTitle;

  /// No description provided for @programCreatorScheduleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Expand a day to review its exercise prescriptions.'**
  String get programCreatorScheduleSubtitle;

  /// No description provided for @programCreatorRecoveryDayDescription.
  ///
  /// In en, this message translates to:
  /// **'Recovery day. Rest, recharge and prepare for your next workout.'**
  String get programCreatorRecoveryDayDescription;

  /// No description provided for @programCreatorNoExercisesYet.
  ///
  /// In en, this message translates to:
  /// **'No exercises yet. Edit this workout.'**
  String get programCreatorNoExercisesYet;

  /// No description provided for @programCreatorEditDayButton.
  ///
  /// In en, this message translates to:
  /// **'EDIT {day}'**
  String programCreatorEditDayButton(String day);

  /// No description provided for @programCreatorInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR PROGRAM IS READY'**
  String get programCreatorInfoTitle;

  /// No description provided for @programCreatorInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Save to finish this sample program and return to your dashboard. This draft is held locally for this session only.'**
  String get programCreatorInfoDescription;

  /// No description provided for @programCreatorIncompleteWarning.
  ///
  /// In en, this message translates to:
  /// **'Add an exercise to every workout day before saving.'**
  String get programCreatorIncompleteWarning;

  /// No description provided for @programCreatorSaveButton.
  ///
  /// In en, this message translates to:
  /// **'SAVE PROGRAM'**
  String get programCreatorSaveButton;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settingsTitle;

  /// No description provided for @settingsInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'IRON PROGRESS · SAMPLE MODE'**
  String get settingsInfoTitle;

  /// No description provided for @settingsInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Programs, exercise prescriptions and workout logs use local sample data. No account or backend is connected.'**
  String get settingsInfoDescription;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGE'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how the app text is displayed.'**
  String get settingsLanguageSubtitle;

  /// No description provided for @settingsDisplayTitle.
  ///
  /// In en, this message translates to:
  /// **'DISPLAY & UNITS'**
  String get settingsDisplayTitle;

  /// No description provided for @settingsDisplaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Dark theme · pounds (lbs) · Montserrat / JetBrains Mono'**
  String get settingsDisplaySubtitle;

  /// No description provided for @templateCategoryHypertrophy.
  ///
  /// In en, this message translates to:
  /// **'Hypertrophy'**
  String get templateCategoryHypertrophy;

  /// No description provided for @templateCategoryStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get templateCategoryStrength;

  /// No description provided for @templateCategoryVolume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get templateCategoryVolume;

  /// No description provided for @templatePushPullLegsName.
  ///
  /// In en, this message translates to:
  /// **'Push Pull Legs'**
  String get templatePushPullLegsName;

  /// No description provided for @templatePushPullLegsDescription.
  ///
  /// In en, this message translates to:
  /// **'5-Day High Intensity Frequency'**
  String get templatePushPullLegsDescription;

  /// No description provided for @templateUpperLowerName.
  ///
  /// In en, this message translates to:
  /// **'Upper Lower'**
  String get templateUpperLowerName;

  /// No description provided for @templateUpperLowerDescription.
  ///
  /// In en, this message translates to:
  /// **'4-Day Pure Power Foundation'**
  String get templateUpperLowerDescription;

  /// No description provided for @templateArnoldSplitName.
  ///
  /// In en, this message translates to:
  /// **'Arnold Split'**
  String get templateArnoldSplitName;

  /// No description provided for @templateArnoldSplitDescription.
  ///
  /// In en, this message translates to:
  /// **'6-Day Antagonist Muscle Blast'**
  String get templateArnoldSplitDescription;

  /// No description provided for @templateDayPush.
  ///
  /// In en, this message translates to:
  /// **'Push'**
  String get templateDayPush;

  /// No description provided for @templateDayPull.
  ///
  /// In en, this message translates to:
  /// **'Pull'**
  String get templateDayPull;

  /// No description provided for @templateDayLegs.
  ///
  /// In en, this message translates to:
  /// **'Legs'**
  String get templateDayLegs;

  /// No description provided for @templateDayUpper.
  ///
  /// In en, this message translates to:
  /// **'Upper'**
  String get templateDayUpper;

  /// No description provided for @templateDayLower.
  ///
  /// In en, this message translates to:
  /// **'Lower'**
  String get templateDayLower;

  /// No description provided for @templateDayChestBack.
  ///
  /// In en, this message translates to:
  /// **'Chest & Back'**
  String get templateDayChestBack;

  /// No description provided for @templateDayShouldersArms.
  ///
  /// In en, this message translates to:
  /// **'Shoulders & Arms'**
  String get templateDayShouldersArms;

  /// No description provided for @templateDayArms.
  ///
  /// In en, this message translates to:
  /// **'Arms'**
  String get templateDayArms;

  /// No description provided for @trackerEmptyAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'IRON PULSE'**
  String get trackerEmptyAppBarTitle;

  /// No description provided for @trackerEmptySystemReadyBadge.
  ///
  /// In en, this message translates to:
  /// **'SYS READY'**
  String get trackerEmptySystemReadyBadge;

  /// No description provided for @trackerEmptyNoProgramTitle.
  ///
  /// In en, this message translates to:
  /// **'NO ACTIVE PROGRAM'**
  String get trackerEmptyNoProgramTitle;

  /// No description provided for @trackerEmptyNoProgramDescription.
  ///
  /// In en, this message translates to:
  /// **'You need an active routine to log workouts, track progressive overload, and build muscle. Choose a template or build your custom split from scratch.'**
  String get trackerEmptyNoProgramDescription;

  /// No description provided for @trackerEmptyCreateProgramButton.
  ///
  /// In en, this message translates to:
  /// **'CREATE WORKOUT PROGRAM'**
  String get trackerEmptyCreateProgramButton;

  /// No description provided for @trackerEmptyPresetTitle.
  ///
  /// In en, this message translates to:
  /// **'OR START FROM A PRESET'**
  String get trackerEmptyPresetTitle;

  /// No description provided for @trackerEmptyPresetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'3 PROTOCOLS'**
  String get trackerEmptyPresetSubtitle;

  /// No description provided for @trackerEmptyPreviewButton.
  ///
  /// In en, this message translates to:
  /// **'PREVIEW'**
  String get trackerEmptyPreviewButton;

  /// No description provided for @trackerEmptyStartSampleProgramButton.
  ///
  /// In en, this message translates to:
  /// **'START SAMPLE PROGRAM'**
  String get trackerEmptyStartSampleProgramButton;

  /// No description provided for @trackerEmptyTemplateDayLabel.
  ///
  /// In en, this message translates to:
  /// **'DAY {day}'**
  String trackerEmptyTemplateDayLabel(int day);

  /// No description provided for @trackerEmptyHowItWorksTitle.
  ///
  /// In en, this message translates to:
  /// **'HOW YRON WORKS'**
  String get trackerEmptyHowItWorksTitle;

  /// No description provided for @trackerEmptyHowItWorksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Build a repeatable training system.'**
  String get trackerEmptyHowItWorksSubtitle;

  /// No description provided for @trackerEmptyStepOne.
  ///
  /// In en, this message translates to:
  /// **'Set weekly muscle split'**
  String get trackerEmptyStepOne;

  /// No description provided for @trackerEmptyStepTwo.
  ///
  /// In en, this message translates to:
  /// **'Add sets & target reps'**
  String get trackerEmptyStepTwo;

  /// No description provided for @trackerEmptyStepThree.
  ///
  /// In en, this message translates to:
  /// **'Log weights & overload'**
  String get trackerEmptyStepThree;

  /// No description provided for @trackerEmptyFooter.
  ///
  /// In en, this message translates to:
  /// **'Sample mode · programs and logs are local to this session.'**
  String get trackerEmptyFooter;

  /// No description provided for @weekDaysTitle.
  ///
  /// In en, this message translates to:
  /// **'SELECT WORKOUT DAY'**
  String get weekDaysTitle;

  /// No description provided for @weekDaysSampleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'HYPERTROPHY OVERLOAD 1.0 · WEEK {week} ({start} – {end})'**
  String weekDaysSampleSubtitle(int week, String start, String end);

  /// No description provided for @weekDaysDescription.
  ///
  /// In en, this message translates to:
  /// **'Log your sets and compare against previous benchmarks to keep making progress.'**
  String get weekDaysDescription;

  /// No description provided for @weekDaysProgressSummary.
  ///
  /// In en, this message translates to:
  /// **'3 OF 5 COMPLETED · 1 SKIPPED'**
  String get weekDaysProgressSummary;

  /// No description provided for @weekDaysProgressSemanticLabel.
  ///
  /// In en, this message translates to:
  /// **'Weekly workout progress'**
  String get weekDaysProgressSemanticLabel;

  /// No description provided for @weekDaysProgressSemanticValue.
  ///
  /// In en, this message translates to:
  /// **'60 percent'**
  String get weekDaysProgressSemanticValue;

  /// No description provided for @weekDaysCompletedMetricsVolume.
  ///
  /// In en, this message translates to:
  /// **'4 Exercises · 14,200 KG Vol'**
  String get weekDaysCompletedMetricsVolume;

  /// No description provided for @weekDaysCompletedMetricsLogged.
  ///
  /// In en, this message translates to:
  /// **'4 Exercises logged'**
  String get weekDaysCompletedMetricsLogged;

  /// No description provided for @weekDaysCompletedStatus.
  ///
  /// In en, this message translates to:
  /// **'COMPLETED'**
  String get weekDaysCompletedStatus;

  /// No description provided for @weekDaysRecoveryStatus.
  ///
  /// In en, this message translates to:
  /// **'RECOVERY'**
  String get weekDaysRecoveryStatus;

  /// No description provided for @weekDaysSkippedStatus.
  ///
  /// In en, this message translates to:
  /// **'SKIPPED'**
  String get weekDaysSkippedStatus;

  /// No description provided for @weekDaysTodayReadyStatus.
  ///
  /// In en, this message translates to:
  /// **'TODAY · READY'**
  String get weekDaysTodayReadyStatus;

  /// No description provided for @weekDaysUpcomingStatus.
  ///
  /// In en, this message translates to:
  /// **'UPCOMING'**
  String get weekDaysUpcomingStatus;

  /// No description provided for @weekDaysPlannedStatus.
  ///
  /// In en, this message translates to:
  /// **'PLANNED'**
  String get weekDaysPlannedStatus;

  /// No description provided for @weekDaysRestDescription.
  ///
  /// In en, this message translates to:
  /// **'Recovery is part of the plan. Choose a workout day when you are ready to train.'**
  String get weekDaysRestDescription;

  /// No description provided for @weekDaysWorkoutDescription.
  ///
  /// In en, this message translates to:
  /// **'Review the exercises and log each set in the session logger.'**
  String get weekDaysWorkoutDescription;

  /// No description provided for @weekDaysStartSelectedWorkoutButton.
  ///
  /// In en, this message translates to:
  /// **'START SELECTED WORKOUT'**
  String get weekDaysStartSelectedWorkoutButton;

  /// No description provided for @weekDaysBackToProgramButton.
  ///
  /// In en, this message translates to:
  /// **'BACK TO PROGRAM'**
  String get weekDaysBackToProgramButton;

  /// No description provided for @weekDaysProgramFooter.
  ///
  /// In en, this message translates to:
  /// **'Workout assignments from your local program draft.'**
  String get weekDaysProgramFooter;

  /// No description provided for @activeProgramTitle.
  ///
  /// In en, this message translates to:
  /// **'TRACKER'**
  String get activeProgramTitle;

  /// No description provided for @activeProgramSampleBadge.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE PROGRAM · SAMPLE MODE'**
  String get activeProgramSampleBadge;

  /// No description provided for @activeProgramSampleName.
  ///
  /// In en, this message translates to:
  /// **'HYPERTROPHY PHASE II'**
  String get activeProgramSampleName;

  /// No description provided for @activeProgramSampleDesignerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Program designer · Iron Coaching'**
  String get activeProgramSampleDesignerSubtitle;

  /// No description provided for @activeProgramCustomDesignerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Program designer · You · {focus}'**
  String activeProgramCustomDesignerSubtitle(String focus);

  /// No description provided for @activeProgramPreviousWeekTooltip.
  ///
  /// In en, this message translates to:
  /// **'Previous week'**
  String get activeProgramPreviousWeekTooltip;

  /// No description provided for @activeProgramNextWeekTooltip.
  ///
  /// In en, this message translates to:
  /// **'Next week'**
  String get activeProgramNextWeekTooltip;

  /// No description provided for @activeProgramWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'WEEK {current} OF {total}'**
  String activeProgramWeekLabel(int current, int total);

  /// No description provided for @activeProgramTodayTitle.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S WORKOUT'**
  String get activeProgramTodayTitle;

  /// No description provided for @activeProgramTodaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Day 1 of {count}'**
  String activeProgramTodaySubtitle(int count);

  /// No description provided for @activeProgramSampleWorkoutSummary.
  ///
  /// In en, this message translates to:
  /// **'4 exercises · 12 sets · ~60 min'**
  String get activeProgramSampleWorkoutSummary;

  /// No description provided for @activeProgramWorkoutSummary.
  ///
  /// In en, this message translates to:
  /// **'{exercises} exercises · {sets} sets'**
  String activeProgramWorkoutSummary(int exercises, int sets);

  /// No description provided for @activeProgramReadyBadge.
  ///
  /// In en, this message translates to:
  /// **'READY'**
  String get activeProgramReadyBadge;

  /// No description provided for @activeProgramInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'PROGRESSIVE OVERLOAD'**
  String get activeProgramInfoTitle;

  /// No description provided for @activeProgramInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Target RPE 8.5. Review your last session before adding load. Sample progression: +2.5 lbs.'**
  String get activeProgramInfoDescription;

  /// No description provided for @activeProgramChooseDayButton.
  ///
  /// In en, this message translates to:
  /// **'VIEW WEEK & CHOOSE DAY'**
  String get activeProgramChooseDayButton;

  /// No description provided for @activeProgramCreateNewProgramButton.
  ///
  /// In en, this message translates to:
  /// **'CREATE NEW PROGRAM'**
  String get activeProgramCreateNewProgramButton;

  /// No description provided for @activeWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE WORKOUT'**
  String get activeWorkoutTitle;

  /// No description provided for @activeWorkoutSessionBadge.
  ///
  /// In en, this message translates to:
  /// **'LIVE SESSION · LOCAL SAMPLE'**
  String get activeWorkoutSessionBadge;

  /// No description provided for @activeWorkoutCompleteOneSetError.
  ///
  /// In en, this message translates to:
  /// **'Complete at least one set to finish.'**
  String get activeWorkoutCompleteOneSetError;

  /// No description provided for @activeWorkoutFinishDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish this workout?'**
  String get activeWorkoutFinishDialogTitle;

  /// No description provided for @activeWorkoutFinishDialogDescription.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} sets completed. Only completed sets will appear in your local history.'**
  String activeWorkoutFinishDialogDescription(int completed, int total);

  /// No description provided for @activeWorkoutKeepTrainingButton.
  ///
  /// In en, this message translates to:
  /// **'KEEP TRAINING'**
  String get activeWorkoutKeepTrainingButton;

  /// No description provided for @activeWorkoutFinishButton.
  ///
  /// In en, this message translates to:
  /// **'FINISH WORKOUT'**
  String get activeWorkoutFinishButton;

  /// No description provided for @activeWorkoutDiscardDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard workout?'**
  String get activeWorkoutDiscardDialogTitle;

  /// No description provided for @activeWorkoutDiscardDialogDescription.
  ///
  /// In en, this message translates to:
  /// **'Your unfinished sample session will not be saved.'**
  String get activeWorkoutDiscardDialogDescription;

  /// No description provided for @activeWorkoutDiscardButton.
  ///
  /// In en, this message translates to:
  /// **'DISCARD'**
  String get activeWorkoutDiscardButton;

  /// No description provided for @activeWorkoutVolumeLabel.
  ///
  /// In en, this message translates to:
  /// **'VOLUME'**
  String get activeWorkoutVolumeLabel;

  /// No description provided for @activeWorkoutSetProgress.
  ///
  /// In en, this message translates to:
  /// **'{completed} / {total} sets'**
  String activeWorkoutSetProgress(int completed, int total);

  /// No description provided for @activeWorkoutRestTimerLabel.
  ///
  /// In en, this message translates to:
  /// **'REST TIMER'**
  String get activeWorkoutRestTimerLabel;

  /// No description provided for @activeWorkoutPauseButton.
  ///
  /// In en, this message translates to:
  /// **'PAUSE'**
  String get activeWorkoutPauseButton;

  /// No description provided for @activeWorkoutStartButton.
  ///
  /// In en, this message translates to:
  /// **'START'**
  String get activeWorkoutStartButton;

  /// No description provided for @activeWorkoutInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'PROGRESSION · TARGET RPE 8.5'**
  String get activeWorkoutInfoTitle;

  /// No description provided for @activeWorkoutInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Sample last session: 9 sets / 10,500 lbs. Aim for controlled reps. Consider +2.5 lbs next session only when your form and effort allow it.'**
  String get activeWorkoutInfoDescription;

  /// No description provided for @activeWorkoutSessionRpeLabel.
  ///
  /// In en, this message translates to:
  /// **'SESSION RPE'**
  String get activeWorkoutSessionRpeLabel;

  /// No description provided for @activeWorkoutExerciseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{sets} sets · {reps} reps · {restSeconds}s rest'**
  String activeWorkoutExerciseSubtitle(int sets, int reps, int restSeconds);

  /// No description provided for @activeWorkoutSetCompleteLabel.
  ///
  /// In en, this message translates to:
  /// **'{exercise} set {set} complete'**
  String activeWorkoutSetCompleteLabel(String exercise, int set);

  /// No description provided for @activeWorkoutUndoExerciseButton.
  ///
  /// In en, this message translates to:
  /// **'UNDO EXERCISE'**
  String get activeWorkoutUndoExerciseButton;

  /// No description provided for @activeWorkoutCompleteExerciseButton.
  ///
  /// In en, this message translates to:
  /// **'COMPLETE EXERCISE'**
  String get activeWorkoutCompleteExerciseButton;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'hr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'hr':
      return AppLocalizationsHr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
