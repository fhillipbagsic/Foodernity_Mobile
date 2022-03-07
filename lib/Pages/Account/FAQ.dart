import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Item.dart';
import 'package:sizer/sizer.dart';

class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  final List<Item> _questions = [
    Item(
        expandedValue: 'answer 1',
        headerValue: 'Question 1',
        subtitleValue: 'subtitle')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
          middle: Text('Frequently Asked Questions')),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
        child: SingleChildScrollView(
          child: Column(children: [_buildPanel()]),
        ),
      )),
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
