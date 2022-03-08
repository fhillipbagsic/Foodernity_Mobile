import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Item.dart';
import 'package:foodernity_mobile/Pages/MakeDonation/MakeaDonation.dart';
import 'package:sizer/sizer.dart';

class Guidelines extends StatefulWidget {
  final String donatedTo;
  const Guidelines({Key? key, required this.donatedTo}) : super(key: key);

  @override
  State<Guidelines> createState() => _GuidelinesState();
}

class _GuidelinesState extends State<Guidelines> {
  final List<Item> _questions = [
    Item(
        expandedValue: 'answer 1',
        headerValue: 'Question 1',
        subtitleValue: 'subtitle')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          child: CustomScrollView(
            slivers: [
              const CupertinoSliverNavigationBar(
                largeTitle: Text('Guidelines'),
              ),
              _description(),
              _buildPanel(),
              _proceedButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _description() {
    String description =
        "Before proceeding to make a donation, you must adhere to the guidelines first to protect you and the safety of the others as we. The guidelines to acknowledge are as follows:";
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Text(
          description,
          // textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: ExpansionPanelList(
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
        ),
      ),
    );
  }

  Widget _proceedButton() {
    return SliverToBoxAdapter(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 3.h,
              ),
              Text(
                'By clicking',
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(
                height: 1.h,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MakeDonation(
                                donatedTo: widget.donatedTo,
                              )));
                },
                child: Text('I AGREE', style: TextStyle(fontSize: 11.sp)),
              ),
            ],
          )),
    );
  }
}
