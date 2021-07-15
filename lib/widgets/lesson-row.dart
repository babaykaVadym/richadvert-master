import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/models/lesson-model.dart';
import 'package:rich_advert_app/providers/courses-provider.dart';
import 'package:rich_advert_app/screens/lesson-screen.dart';

class LessonRow extends StatelessWidget {
  final Lesson lesson;
  LessonRow(this.lesson);
  @override
  Widget build(BuildContext context) {
    var coursesState = Provider.of<CoursesState>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonScreen(lesson),
              ));
        },
        leading: Icon(
          Icons.assignment,
          color: kOrangeColor,
        ),
        title: Text(lesson.name, style: Theme.of(context).textTheme.subtitle1),
        trailing: IconButton(
          icon: Icon(
            lesson.isFavorite ? Icons.star : Icons.star_outline,
            color: lesson.isFavorite ? kYellowColor : kMidGreyColor,
          ),
          onPressed: () {
            coursesState.toggleLessonFavoriteState(lesson);
          },
        ),
        dense: true,
      ),
    );
    ;
  }
}
