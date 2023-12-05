import 'package:depature/model/data_model.dart';
import 'package:depature/provider/language_provider.dart';
import 'package:depature/provider/light_dark_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chapter_details extends StatefulWidget {
  Chapter_details({super.key, required this.alldata});

  Alldata alldata;

  @override
  State<Chapter_details> createState() => _Chapter_detailsState();
}

class _Chapter_detailsState extends State<Chapter_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chapter ${widget.alldata.id} Details"),
        centerTitle: true,
        actions: [
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
      body: Column(
        children: [
          (Provider.of<LanguageProvider>(context).model.ishindi == false)
              ? Text(
                  "Chapter ${widget.alldata.chapter_number} : ${widget.alldata.image_name}",
                  style: TextStyle(fontSize: 20),
                )
              : Text(
                  "Chapter ${widget.alldata.chapter_number} : ${widget.alldata.name}",
                  style: TextStyle(fontSize: 20),
                ),
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.alldata.image_url),
                    fit: BoxFit.fill)),
          ),
          (Provider.of<LanguageProvider>(context).model.ishindi == false)
              ? Text("Chapter Summary : ${widget.alldata.chapter_summary}")
              : Text(
                  "Chapter Summary : ${widget.alldata.chapter_summary_hindi}")
        ],
      ),
    );
  }
}
