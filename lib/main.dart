import 'dart:async';
import 'dart:convert';

import 'package:depature/chapter_details.dart';
import 'package:depature/liked_chapter.dart';
import 'package:depature/model/data_model.dart';
import 'package:depature/model/language_model.dart';
import 'package:depature/model/theme_model.dart';
import 'package:depature/provider/language_provider.dart';
import 'package:depature/provider/light_dark_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => themeprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        )
      ],
      builder: (context, child) =>
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode:
            (Provider
                .of<themeprovider>(context)
                .themeModel
                .isDark == false)
                ? ThemeMode.light
                : ThemeMode.dark,
            home: splash_screen(),
          ),
    );
  }
}

class Chapter extends StatefulWidget {
  const Chapter({super.key});

  @override
  State<Chapter> createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
  List<Alldata> shloka = [];
  String data = '';

  Future<void> getdata() async {
    data = await rootBundle.loadString('assets/json/POST_json_model.json');
    Map detail = jsonDecode(data);
    List alldata = detail['bhagavad_gita'];
    shloka = alldata
        .map((e) =>
        Alldata(
            chapter_number: e['chapter_number'],
            chapter_summary: e['chapter_summary'],
            chapter_summary_hindi: e['chapter_summary_hindi'],
            id: e['id'],
            image_name: e['image_name'],
            name_meaning: e['name_meaning'],
            name_translation: e['name_translation'],
            name_transliterated: e['name_transliterated'],
            verses_count: e['verses_count'],
            name: e['name'],
            image_url: e['Image_url']))
        .toList();
    //return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata().then((value) {
      setState(() {
        print(shloka[0].id);
      });
    });
    //print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Depature"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LikedChapter(),
                      ));
                },
                icon: Icon(Icons.favorite_outline_rounded)),
            TextButton(
                onPressed: () {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .changelanguage();
                  setState(() {});
                },
                child: (Provider
                    .of<LanguageProvider>(context)
                    .model
                    .ishindi ==
                    false)
                    ? Text("Hindi")
                    : Text("English")),
            IconButton(
                onPressed: () {
                  Provider.of<themeprovider>(context, listen: false)
                      .changetheme();
                },
                icon: (Provider
                    .of<themeprovider>(context)
                    .themeModel
                    .isDark ==
                    false)
                    ? Icon(Icons.dark_mode_outlined)
                    : Icon(Icons.light_mode))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: shloka
                .map((e) =>
                Container(
                  height: 103,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.green, width: 1.8)),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Chapter No. : ${e.id}",
                              style: TextStyle(fontSize: 22),
                            ),
                            (Provider
                                .of<LanguageProvider>(context)
                                .model
                                .ishindi ==
                                false)
                                ? Text("Chapter Name : ${e.image_name}")
                                : Text("Chapter Name : ${e.name}"),
                            IconButton(
                                onPressed: () {
                                  likedchpter.add(e);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "Succesfully Added to Favorite List"),
                                    backgroundColor: Colors.green,
                                  ));
                                  setState(() {});
                                },
                                icon: Icon(Icons.favorite_outline_rounded)),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Chapter_details(
                                        alldata: e,
                                      ),
                                ));
                          },
                          icon: Icon(Icons.arrow_forward_ios_outlined))
                    ],
                  ),
                ))
                .toList(),
          ),
        ));
  }
}

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Chapter(),)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/intro.jpeg'),
                fit: BoxFit.fill)),
      ),
    );
  }
}
