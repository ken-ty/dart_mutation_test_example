import 'package:dart_mutation_test_example/model/user.dart';
import 'package:dart_mutation_test_example/service/point_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("60歳未満", () {
    test('59歳の場合、100円で購入した場合は1ポイント付与される', () {
      expect(PointService.point(100, User(name: "", age: 59)), equals(1));
    });
    test('59歳で19900円購入した場合、199ポイント付与される', () {
      expect(PointService.point(19900, User(name: "", age: 59)), equals(199));
    });
    test('59歳で20000円購入した場合、200ポイント付与される', () {
      expect(PointService.point(20000, User(name: "", age: 59)), equals(200));
    });
    test('59歳で20100円購入した場合、200ポイント付与される', () {
      expect(PointService.point(20100, User(name: "", age: 59)), equals(200));
    });
  });
  group("60歳以上", () {
    test('60歳の場合、100円で購入した場合は2ポイント付与される', () {
      expect(PointService.point(100, User(name: "", age: 60)), equals(2));
    });
    test('61歳の場合、100円で購入した場合は2ポイント付与される', () {
      expect(PointService.point(100, User(name: "", age: 61)), equals(2));
    });
  });
}
