import 'package:dart_mutation_test_example/point_service.dart';
import 'package:dart_mutation_test_example/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("60歳未満", () {
    test('59歳の場合、100円で購入した場合は1ポイント付与される', () {
      expect(PointService.point(100, User(name: "", age: 59)), equals(1));
    });
  });
  group("60歳以上", () {
    test('60歳の場合、100円で購入した場合は2ポイント付与される', () {
      expect(PointService.point(100, User(name: "", age: 60)), equals(2));
    });

    test('60歳の場合、10000円で購入した場合は200ポイント付与される', () {
      expect(PointService.point(10000, User(name: "", age: 60)), equals(200));
    });
  });
}
