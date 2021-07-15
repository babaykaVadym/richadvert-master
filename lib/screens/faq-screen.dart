import 'package:flutter/material.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';

class FAQScreen extends StatefulWidget {
  static String routeName = "/faq";
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQScreen> {
  var questionsList = List<FAQModel>.generate(
    15,
    (i) => FAQModel(
        question: "Что такое арбитраж трафика?",
        answer:
            "Покупка и последующая перепродажа ранее купленного интернет-трафика на более выгодных условиях. Другими словами — это когда вы покупаете трафик в одном месте и монетизируете его в другом, зарабатывая на разнице цен."),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "FAQ")),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  questionsList[index].isExpanded = !isExpanded;
                });
              },
              children: [
                ...questionsList.map(
                  (value) => _buildFaqRow(value),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  ExpansionPanel _buildFaqRow(FAQModel item) {
    return ExpansionPanel(
      canTapOnHeader: true,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          title: Text(
            item.question,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        );
      },
      body: Container(
        margin: EdgeInsets.only(bottom: 24, left: 24, right: 24),
        child: Text(
          item.answer,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      isExpanded: item.isExpanded,
    );
  }
}

class FAQModel {
  FAQModel({
    this.answer,
    this.question,
    this.isExpanded = false,
  });

  String answer;
  String question;

  bool isExpanded;
}
