import 'package:flutter_test/flutter_test.dart';

class SM2Calculator {
  static Map<String, dynamic> calculateNextReview({
    required int qualityScore, // 0 to 5
    required int repetitions,
    required double easinessFactor,
    required int intervalDays,
  }) {
    if (qualityScore < 3) {
      return {
        'repetitions': 0,
        'intervalDays': 1,
        'easinessFactor': easinessFactor,
      };
    }

    int nextRepetitions = repetitions + 1;
    int nextIntervalDays;

    if (nextRepetitions == 1) {
      nextIntervalDays = 1;
    } else if (nextRepetitions == 2) {
      nextIntervalDays = 6;
    } else {
      nextIntervalDays = (intervalDays * easinessFactor).round();
    }

    double nextEF = easinessFactor + (0.1 - (5 - qualityScore) * (0.08 + (5 - qualityScore) * 0.02));
    if (nextEF < 1.3) nextEF = 1.3;

    return {
      'repetitions': nextRepetitions,
      'intervalDays': nextIntervalDays,
      'easinessFactor': nextEF,
    };
  }
}

void main() {
  group('SM-2 Spaced Repetition Algorithm Tests', () {
    test('Perfect recall (score 5) increases interval and easiness factor', () {
      final result = SM2Calculator.calculateNextReview(
        qualityScore: 5,
        repetitions: 2,
        easinessFactor: 2.5,
        intervalDays: 6,
      );

      expect(result['repetitions'], equals(3));
      expect(result['intervalDays'], equals(15)); // (6 * 2.5).round() = 15
      expect(result['easinessFactor'], greaterThan(2.5));
    });

    test('Failed recall (score 2) resets repetitions to 0 and interval to 1 day', () {
      final result = SM2Calculator.calculateNextReview(
        qualityScore: 2,
        repetitions: 4,
        easinessFactor: 2.5,
        intervalDays: 30,
      );

      expect(result['repetitions'], equals(0));
      expect(result['intervalDays'], equals(1));
    });
  });
}
