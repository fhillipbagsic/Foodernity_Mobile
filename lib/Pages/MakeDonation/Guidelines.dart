import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Guideline.dart';
import 'package:foodernity_mobile/Classes/Item.dart';
import 'package:foodernity_mobile/Pages/MakeDonation/MakeaDonation.dart';
import 'package:foodernity_mobile/Services/FAQGuideline.dart';
import 'package:sizer/sizer.dart';

class Guidelines extends StatefulWidget {
  final String donatedTo;
  const Guidelines({Key? key, required this.donatedTo}) : super(key: key);

  @override
  State<Guidelines> createState() => _GuidelinesState();
}

class _GuidelinesState extends State<Guidelines> {
  late Future<bool> futureGuidelines;
  final List<Item> _guidelines = [
    // Item(
    //     expandedValue:
    //         'Non-perishable goods:\nCanned Goods\nInstant Noodles\nEggs\nRice\nCereals\nTea/Coffee/Milk/Sugar\nBiscuits\nSnacks\nCondiments and Sauces\nBeverages',
    //     headerValue: 'Donations that are allowed to be donated:',
    //     subtitleValue: ''),
    // Item(
    //     expandedValue: 'Perishable goods:\nRaw meat\nAny kind of cooked foods',
    //     headerValue: 'Donations that are not allowed to be donated:',
    //     subtitleValue: ''),
    // Item(
    //     expandedValue: 'Address',
    //     headerValue: 'Where to donate:',
    //     subtitleValue: '')
  ];

  @override
  void initState() {
    super.initState();
    futureGuidelines = getGuidelines();
  }

  Future<bool> getGuidelines() async {
    Response response = await FAQGuidelineService().getGuidelines();
    for (var i = 0; i < response.data['value'].length; i++) {
      var guideline = Guideline.fromJSON(response.data['value'][i]);
      print(guideline);
      _guidelines.add(Item(
          expandedValue: guideline.description,
          headerValue: guideline.guideline,
          subtitleValue: guideline.lastUpdated));
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: futureGuidelines,
        builder: ((context, snapshot) {
          Widget guidelinesSliverList;
          if (snapshot.hasData) {
            guidelinesSliverList = SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      _guidelines[index].isExpanded = !isExpanded;
                    });
                  },
                  children: _guidelines.map((item) {
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
              ),
            );
          } else {
            guidelinesSliverList = SliverToBoxAdapter(
              child: Container(
                  margin: EdgeInsets.only(top: 2.h),
                  child: const Center(child: CircularProgressIndicator())),
            );
          }

          return Container(
            color: Colors.grey[200],
            child: CustomScrollView(
              slivers: [
                const CupertinoSliverNavigationBar(
                  largeTitle: Text('Guidelines'),
                ),
                _description(),
                // _buildPanel(),
                guidelinesSliverList,
                _proceedButton()
              ],
            ),
          );
        }),
      )),
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
              _guidelines[index].isExpanded = !isExpanded;
            });
          },
          children: _guidelines.map<ExpansionPanel>((Item item) {
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
                'By clicking I agree, you adhere to the guidelines set by the organization.',
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
