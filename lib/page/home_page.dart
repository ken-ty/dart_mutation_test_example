import 'package:dart_mutation_test_example/model/user.dart';
import 'package:dart_mutation_test_example/service/point_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _money = 0;
  int _point = 0;
  User _user = User(name: "anonymous", age: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("ポイント計算"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '入力した金額に対して、以下のルールでポイントを計算します。',
            ),
            const Text(
              '100円で1ポイント'
              ' / '
              '60歳以上だとポイント2倍'
              ' / '
              'ポイントの最大値は200',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                      onChanged: (value) {
                        // money を intにする
                        final age = int.tryParse(value);
                        setState(() {
                          _user = User(name: _user.name, age: age ?? _user.age);
                          _point = PointService.point(_money, _user);
                        });
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                ),
                const Text('歳')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {
                      // money を intにする
                      final money = int.tryParse(value);
                      setState(() {
                        _money = money ?? _money;
                        _point = PointService.point(_money, _user);
                      });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                const Text('円')
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              '↓',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_point',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Text('ポイント'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
