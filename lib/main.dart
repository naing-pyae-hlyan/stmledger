import 'lib_exp.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryCtrl()),
        ChangeNotifierProvider(create: (_) => ItemPressStateCtrl(state: false)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ရွှေသမင် မုန့်တိုက်',
      theme: ThemeData(
        primarySwatch: AppColors.homePrimaryColor,
        primaryColor: AppColors.homePrimaryColor,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        hintColor: AppColors.textHintColor,
      ),
      home: const HomePage(),
    );
  }
}
