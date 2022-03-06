import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Item.dart';
import 'package:foodernity_mobile/Pages/MakeDonation/MakeaDonation.dart';
import 'package:sizer/sizer.dart';

class Guidelines extends StatefulWidget {
  const Guidelines({Key? key}) : super(key: key);

  @override
  State<Guidelines> createState() => _GuidelinesState();
}

class _GuidelinesState extends State<Guidelines> {
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
              _guidelines(),
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
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: Text(
          description,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  List<Item> guidelinesList() {
    return [Item(headerValue: 'h1', expandedValue: 'e1')];
  }

  Widget _guidelines() {
    return SliverToBoxAdapter(
      child: ExpansionPanelList(
        expansionCallback: ((index, isExpanded) {
          setState(() {
            guidelinesList()[index].isExpanded = true;
          });
        }),
        children: guidelinesList().map((guideline) {
          return ExpansionPanel(
              headerBuilder: ((context, isExpanded) {
                return ListTile(
                  title: Text(guideline.headerValue),
                );
              }),
              body: ListTile(
                title: Text(guideline.expandedValue),
              ),
              isExpanded: false);
        }).toList(),
      ),
    );
  }

  Widget _proceedButton() {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MakeDonation()));
          },
          child: Text('PROCEED', style: TextStyle(fontSize: 11.sp)),
        ),
      ),
    );
  }
}
