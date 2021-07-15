import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/providers/courses-provider.dart';
import 'package:rich_advert_app/widgets/course-bloc.dart';

class CourseDetailsScreen extends StatelessWidget {
  static appBar(context) => AppBar(
        title: Text(getTranslated(context, "Курсы")),
      );

  @override
  Widget build(BuildContext context) {
    var coursesState = Provider.of<CoursesState>(context);
    print(coursesState.courses);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...coursesState.courses.map((value) => CourseBloc(value)),
          ],
        ),
      ),
    );
  }
}
