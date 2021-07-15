import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/models/course-model.dart';
import 'package:rich_advert_app/providers/courses-provider.dart';
import 'package:rich_advert_app/widgets/lesson-row.dart';

class CourseBloc extends StatelessWidget {
  CourseBloc(this.course);
  final Course course;
  @override
  Widget build(BuildContext context) {
    Provider.of<CoursesState>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 24,
        ),
        Text(
          course.name,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headline1,
        ),
        SizedBox(height: 16),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: kOrangeColor,
            ),
            height: 150,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated(context, "Уроки"),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .apply(color: kMidGreyColor),
              ),
              SizedBox(height: 16),
              ...course.lessons.map(
                (lesson) => LessonRow(lesson),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
