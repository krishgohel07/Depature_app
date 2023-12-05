import 'package:depature/chapter_details.dart';
import 'package:depature/model/language_model.dart';
import 'package:depature/provider/language_provider.dart';
import 'package:depature/provider/light_dark_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikedChapter extends StatefulWidget {
  const LikedChapter({super.key});

  @override
  State<LikedChapter> createState() => _LikedChapterState();
}

class _LikedChapterState extends State<LikedChapter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liked Chapter"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LikedChapter(),));
          }, icon: Icon(Icons.favorite_outline_rounded)),
          TextButton(
              onPressed: () {
                Provider.of<LanguageProvider>(context, listen: false)
                    .changelanguage();
                setState(() {});
              },
              child: (Provider.of<LanguageProvider>(context).model.ishindi ==
                  false)
                  ? Text("Hindi")
                  : Text("English")),
          IconButton(
              onPressed: () {
                Provider.of<themeprovider>(context, listen: false)
                    .changetheme();
              },
              icon: (Provider.of<themeprovider>(context).themeModel.isDark ==
                  false)
                  ? Icon(Icons.dark_mode_outlined)
                  : Icon(Icons.light_mode))
        ],
      ),
        body: Container(
            child: (likedchpter.isNotEmpty)
                ? ListView.builder(
                    itemCount: likedchpter.length,
                    itemBuilder: (context, index) => Container(
                          height: 103,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border:
                                  Border.all(color: Colors.green, width: 1.8)),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 7),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Chapter No. : ${likedchpter[index].id}",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    (Provider.of<LanguageProvider>(context)
                                                .model
                                                .ishindi ==
                                            false)
                                        ? Text(
                                            "Chapter Name : ${likedchpter[index].image_name}")
                                        : Text(
                                            "Chapter Name : ${likedchpter[index].name}"),
                                    IconButton(
                                        onPressed: () {
                                          likedchpter
                                              .remove(likedchpter[index]);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Succesfully Removed From Favorite List"),
                                            backgroundColor: Colors.green,
                                          ));
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.hide_source_sharp,
                                          color: Colors.red,
                                        )),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Chapter_details(
                                            alldata: likedchpter[index],
                                          ),
                                        ));
                                  },
                                  icon: Icon(Icons.arrow_forward_ios_outlined))
                            ],
                          ),
                        ))
                : Center(
                    child: Text("Your Favorite List Is Empty"),
                  )));
  }
}
