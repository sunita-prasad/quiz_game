import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_questions/Database/database.dart';
import 'package:quiz_questions/model/quiz_dao.dart';
import 'package:quiz_questions/model/quiz_model.dart';
import 'package:quiz_questions/questionpage/question_cubit.dart';
import 'package:quiz_questions/questionpage/question_state.dart';
import 'package:quiz_questions/questionpage/questionpage.dart';
import 'databasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

late QuizDAO quizDAO;

final RouteObserver routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDatabase();
  await _initDatabase();
  runApp(MyApp());
}

Future<void> _initDatabase() async {
  quizDAO = (await QuizDatabase.instance).quizDAO;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      // BlocProvider(create: (context)=>ListCubit(),child: const MyHomePage(),),
      routes: {
        "questionpage": (BuildContext context) {
          var args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          print(args);
          return BlocProvider(
            create: (context) => QuestionCubit(context, args["level"], args["que_no"]),
            child: QuestionPage(),
          );
        },
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with RouteAware {
  late QuizDatabase database;

  late BaseQuestionState state;

  bool isComplete = false;
  int level = 1;

  // setLevel() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setInt("level",state.level + 1);
  //   pref.setInt("que_no",state.queNo);
  // }
  //
  getLevel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      level = pref.getInt("level") ?? 1;
    });
  }

  @override
  void initState() {
    getLevel();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    getLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/bgimg.png"), fit: BoxFit.cover)),
      child: Center(
        child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Colors.black.withOpacity(0.5)),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 100, right: 100),
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Level 1",
                                style: TextStyle(color: Colors.brown, fontSize: 20,fontFamily: "Lobster",letterSpacing: 1),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.lock_open_rounded,
                                    color: Colors.brown,
                                  )))
                        ],
                      ),
                    ),
                    onTap: () async {
                      Navigator.of(context).pushNamed("questionpage", arguments: {"level": 1, "que_no": 1});
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () async {
                        if (level >= 2) {
                          Navigator.of(context).pushNamed("questionpage", arguments: {"level": 2, "que_no": 1});
                        } else {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: BorderSide(
                                          style: BorderStyle.solid,
                                          color: Colors.orangeAccent.withOpacity(0.5),
                                        )),
                                    actionsPadding: const EdgeInsets.all(10.0),
                                    actions: const [
                                      Center(
                                          child: Text(
                                            "Please Complete level 1",
                                            style: TextStyle(color: Colors.brown, fontSize: 20,fontFamily: "Lobster"),
                                          ),
                                      )
                                    ],
                                    title: Lottie.asset("assets/lock.json",width: 50,height: 100,repeat: true),

                                  ));
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 100, right: 100),
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Level 2",
                                  style: TextStyle(color: Colors.brown, fontSize: 20,fontFamily: "Lobster",letterSpacing: 1),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      level >= 2 ? Icons.lock_open_rounded : Icons.lock_outline_rounded,
                                      color: Colors.brown,
                                    )))
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 100, right: 100),
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10, bottom: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.white),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Level 3",
                                style: TextStyle(color: Colors.brown, fontSize: 20,fontFamily: "Lobster",letterSpacing: 1),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    level >= 3 ? Icons.lock_open_rounded : Icons.lock_outline_rounded,
                                    color: Colors.brown,
                                  )))
                        ],
                      ),
                    ),
                    onTap: () async {
                      if (level >= 3) {
                        Navigator.of(context).pushNamed("questionpage", arguments: {"level": 3, "que_no": 1});
                      } else {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(
                                        style: BorderStyle.solid,
                                        color: Colors.orangeAccent.withOpacity(0.5),
                                      )),
                                  actionsPadding: const EdgeInsets.all(10.0),
                                  title: Lottie.asset("assets/lock.json",width: 50,height: 100,repeat: true),
                                  actions: const [
                                      Center(
                                      child: Text(
                                      "Please Complete level 2",
                                        style: TextStyle(color: Colors.brown, fontSize: 20, fontFamily: "Lobster"),
                                      ),
                                  )
                                ],
                                ));
                      }
                    },
                  ),
                ],
              ),
            )),
      ),
    ));
  }
}
