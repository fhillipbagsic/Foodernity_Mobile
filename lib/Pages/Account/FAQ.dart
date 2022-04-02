import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/FAQ.dart';
import 'package:foodernity_mobile/Classes/Item.dart';
import 'package:foodernity_mobile/Services/FAQGuideline.dart';
import 'package:sizer/sizer.dart';

class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  late Future<bool> futureQuestions;
  final List<Item> _questions = [];

  @override
  void initState() {
    super.initState();
    futureQuestions = getQuestions();
  }

  Future<bool> getQuestions() async {
    Response response = await FAQGuidelineService().getFAQs();

    for (var i = 0; i < response.data['value'].length; i++) {
      var faq = FAQ.fromJSON(response.data['value'][i]);
      _questions.add(Item(
          expandedValue: faq.answer,
          headerValue: faq.question,
          subtitleValue: faq.lastUpdated));
    }
    return true;
  }

/*
Container(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        child: SingleChildScrollView(
          child: Column(children: [_buildPanel()]),
        ),
      ),
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
          middle: Text('Frequently Asked Questions')),
      body: SafeArea(
        child: FutureBuilder(
          future: futureQuestions,
          builder: (context, snapshot) {
            Widget questionsList;
            if (snapshot.hasData) {
              questionsList = Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _questions[index].isExpanded = !isExpanded;
                    });
                  },
                  children: _questions.map((item) {
                    return ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(item.headerValue),
                        );
                      },
                      body: ListTile(
                        title: Text(item.expandedValue),
                        subtitle: Text(
                          'Last updated: ' + item.subtitleValue,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      isExpanded: item.isExpanded,
                    );
                  }).toList(),
                ),
              );
            } else {
              questionsList = Container(
                margin: EdgeInsets.only(top: 2.h),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Container(
              color: Colors.grey[200],
              child: SingleChildScrollView(
                child: questionsList,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _questions[index].isExpanded = !isExpanded;
        });
      },
      children: _questions.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
            title: Text(item.expandedValue),
            subtitle: Text(item.subtitleValue),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
