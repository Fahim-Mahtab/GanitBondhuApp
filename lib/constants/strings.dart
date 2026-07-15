class AppStrings {
  AppStrings._();

  static const appTitle = 'গণিতবন্ধু';
  static const developedBy = 'Developed by Data & Design Lab';

  static const loginTitle = 'গণিতবন্ধু';
  static const loginTagline = 'স্মার্ট গণিত সহচর';
  static const loginCardTitle = 'স্বাগতম! 👋';
  static const loginCardSubtitle = 'তোমার অ্যাকাউন্টে লগইন করো';
  static const loginUsernameHint = 'ব্যবহারকারীর নাম';
  static const loginPasswordHint = 'পাসওয়ার্ড';
  static const loginButton = '🚀 চলো শুরু করি';
  static const loginDivider = 'অথবা';
  static const loginSignupButton = 'নতুন অ্যাকাউন্ট তৈরি করো';
  static const loginErrorUsername = 'ব্যবহারকারীর নাম দাও!';
  static const loginErrorPassword = 'পাসওয়ার্ড দাও!';
  static const loginWarningEmoji = '⚠️';

  static const signupTitle = 'গণিতবন্ধু';
  static const signupCardTitle = 'নতুন অ্যাকাউন্ট তৈরি করো';
  static const signupCardSubtitle = 'তোমার তথ্য দিয়ে শুরু করো';
  static const signupNameHint = 'তোমার নাম';
  static const signupPasswordHint = 'পাসওয়ার্ড';
  static const signupCheckboxLabel = 'আমি রোবট নই';
  static const signupCaptchaText = 'rC';
  static const signupButton = 'সাইন আপ করো';
  static const signupBackToLogin = '← লগইনে ফিরে যাও';
  static const signupDefaultUsername = 'শিক্ষার্থী';
  static String signupClassLabel(int grade) => 'শ্রেণি $grade';

  static const dashboardTitle = 'গণিতবন্ধু';
  static const dashboardModeHeading = 'মোড বেছে নাও';
  static const dashboardProgressHeading = 'তোমার অগ্রগতি';
  static const dashboardLearningTitle = 'Learning Mode 🧠';
  static const dashboardLearningSub = 'AI টিচারের সাথে নতুন টপিক শেখো';
  static const dashboardPracticeTitle = 'Practice Mode 🏋️';
  static const dashboardPracticeSub = 'সমস্যা সমাধান করে দক্ষতা বাড়াও';
  static const dashboardStatTotalPoints = 'মোট পয়েন্ট';
  static const dashboardStatTodayPoints = 'আজকের পয়েন্ট';
  static const dashboardStatStreak = 'সেরা ধারা';
  static const dashboardStatBadges = 'ব্যাজ';
  static String dashboardWelcome(String username) => '🎉 ফিরে আসার জন্য ধন্যবাদ, $username!';
  static String dashboardGradeInfo(String grade) => 'তুমি শ্রেণি $grade-এ আছো। আজকে কোন মোডে শিখবে?';

  static const topicsBackLabel = 'ড্যাশবোর্ড';
  static const topicsTitle = 'টপিক বেছে নাও';
  static const topicsPrompt = '📖 আজকে কোন টপিক শিখবে?';
  static String topicsSubtitle(String grade) => 'শ্রেণি $grade';

  static const subtopicsBackLabel = 'সব টপিক';
  static const subtopicsSubtitle = 'সাবটপিক বেছে নাও';

  static const chatBackLabel = 'পেছনে';
  static const chatLearningMode = '🧠 শিক্ষা মোড';
  static const chatPracticeMode = '🏋️ অনুশীলন মোড';
  static const chatWelcomeHeading = 'গণিতবন্ধু';
  static const chatWelcomeLearning = 'শেখার মোড';
  static const chatWelcomePractice = 'অনুশীলন মোড';
  static const chatStartButton = 'চলো, শুরু করি! 😊';
  static const chatMasteryTitle = 'এই সাবটপিকটা মাস্টার্ড! 🎉';
  static const chatMasteryPrompt = 'একই কঠিনতার আরও সাবটপিক দেখতে চাও?';
  static const chatMasteryButton = 'দেখাও →';
  static const chatMasteryFootnote = 'একই সাবটপিকে থাকতে চাইলে নিচের চ্যাটে প্রশ্ন করো।';
  static const chatInputHint = 'প্রশ্ন বা উত্তর এখানে লিখ...';
  static const chatAiName = 'গণিতবন্ধু';
  static String chatPoints(int points) => '🏅 $points';
  static String chatWelcomeSubtitle(String name, String mode) => '$name — $mode';

  static const sameLevelBackLabel = 'চ্যাটে ফিরে যাও';
  static const sameLevelSubtitle = 'একই কঠিনতার সাবটপিক';
  static const sameLevelInfo = '🎯 একই কঠিনতার সাবটপিক যেগুলো এখনো আয়ত্ত হয়নি সেগুলো দেখাচ্ছি।';
  static const sameLevelEmpty = 'এই লেভেলের সব সাবটপিক আয়ত্ত হয়েছে! 🎉';
  static const sameLevelShowAll = 'সব সাবটপিক দেখাও';
  static const sameLevelDashboard = 'ড্যাশবোর্ডে ফেরত যাও';
  static String sameLevelTitle(String topic, int level) => '$topic — Level $level';

  static const logoutLabel = 'লগআউট';

  static const modeBadgeLearning = '🧠 শিক্ষা';
  static const modeBadgePractice = '🏋️ অনুশীলন';

  static const diffBadgeLabels = ['', 'সহজ', 'মধ্যম', 'কঠিন'];

  static const awardStars = ['⭐', '🌟', '✨', '💫', '🏆', '⭐', '🌟'];
  static const awardToast = '🏅 +১ পয়েন্ট';

  static const appStateDefaultUsername = 'শিক্ষার্থী';
}
