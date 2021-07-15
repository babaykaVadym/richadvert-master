import 'package:flutter_test/flutter_test.dart';

import 'package:rich_advert_app/models/webinar-model.dart';
import 'package:rich_advert_app/providers/courses-provider.dart';
import 'package:rich_advert_app/providers/webinar-provider.dart';

void main() {
  group('Fetch', () {
    test('Fetch webinars', () {
      WebinarsState()
        ..fetch().then((data) {
          print(data);
          expect(data.length, 2);
          expect(data.runtimeType, List<Webinar>().runtimeType);
        });
    });
    test('Fetch courses', () {
      CoursesState()
        ..fetch().then((data) {
          print(data);
          // expect(data.length, 2);
          expect(data.runtimeType, List<CoursesState>().runtimeType);
        });
    });
    test('Fetch lessons', () {
      WebinarsState()
        ..fetch().then((data) {
          print(data);
          expect(data.length, 2);
          expect(data.runtimeType, List<Webinar>().runtimeType);
        });
    });
  });
}

// testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//   // Build our app and trigger a frame.
//   await tester.pumpWidget(App());

//   // Verify that our counter starts at 0.
//   expect(find.text('0'), findsOneWidget);
//   expect(find.text('1'), findsNothing);

//   // Tap the '+' icon and trigger a frame.
//   await tester.tap(find.byIcon(Icons.add));
//   await tester.pump();

//   // Verify that our counter has incremented.
//   expect(find.text('0'), findsNothing);
//   expect(find.text('1'), findsOneWidget);
// });
