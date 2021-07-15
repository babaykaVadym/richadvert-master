import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rich_advert_app/constants.dart';
import 'package:rich_advert_app/localization/language_constraints.dart';
import 'package:rich_advert_app/providers/courses-provider.dart';
import 'package:rich_advert_app/screens/lesson-screen.dart';

class FavoritesScreen extends StatelessWidget {
  static String routeName = "/favorites";

  @override
  Widget build(BuildContext context) {
    var coursesState = Provider.of<CoursesState>(context);
    var favoriteLessons = coursesState.favoritesLessons;
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, "Избранное")),
      ),
      body: favoriteLessons.length == 0
          ? Center(
              child: Text("пусто"),
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: 16),
              itemCount: favoriteLessons.length,
              itemBuilder: (BuildContext context, int index) {
                var currentLesson = favoriteLessons[index];

                return AspectRatio(
                  aspectRatio: 90 / 16,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LessonScreen(currentLesson),
                          ));
                    },
                    leading: Icon(
                      Icons.assignment,
                      color: kOrangeColor,
                    ),
                    title: Text(currentLesson.name,
                        style: Theme.of(context).textTheme.subtitle1),
                    trailing: IconButton(
                      onPressed: () {
                        coursesState.toggleLessonFavoriteState(currentLesson);
                      },
                      icon: Icon(Icons.delete),
                    ),
                    dense: true,
                  ),
                );
              },
            ),
    );
  }
}
