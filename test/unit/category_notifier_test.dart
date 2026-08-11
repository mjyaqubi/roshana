import 'package:flutter_test/flutter_test.dart';
import 'package:roshana/src/features/library/presentation/notifiers/category_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CategoryNotifier Unit Tests', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('Initial selected categories include default topics', () {
      final notifier = CategoryNotifier();
      expect(notifier.selectedCategoryIds, contains('Self-Improvement'));
      expect(notifier.selectedCategoryIds, contains('Psychology'));
      expect(notifier.selectedCategoryIds, contains('Productivity'));
    });

    test('Toggling category state updates selected category IDs list', () {
      final notifier = CategoryNotifier();

      // Deselect Self-Improvement
      notifier.toggleCategory('Self-Improvement');
      expect(notifier.selectedCategoryIds, isNot(contains('Self-Improvement')));

      // Select Finance
      notifier.toggleCategory('Finance');
      expect(notifier.selectedCategoryIds, contains('Finance'));
    });
  });
}
