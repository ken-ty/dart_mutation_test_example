# dart_mutation_test_example

https://test-talk.connpass.com/event/252830/

トーク２）DartでMutation testingをしてみよう
tarappo さんのトークで出てきたハンズオンです。

## ミューテーションテストとは？

- テストコードの十分さを測定するための手法。
- AOR: arithmetic operator replacement
  - 算術演算子置き換え
  a + b -> a - b, a / b などに変換
- LCR: logical connector replacement
  - 論理演算子置き換え
  a && b -> a || b, a && !b などに変換
- ROR: relational operator replacement
  - 関係演算子置き換え
  - a > b -> a <> b, a == b などに変換

## Dart でやるには？

https://pub.dev/packages/mutation_test


## mutation test で テストの質を上げる

コマンド: `dart run mutation_test mutating_test_config.xml`

before:

```example_test.dart
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
```

ミューテーション結果を見て、修正。

after:
```example_test.dart
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

```
