import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

class Data {
  final int id;
  final String data;

  Data({
    required this.data,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["data"] = this.data;
    return data;
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
          future: saveData(context),
          builder: (context, snapshot) {
            return const Text("You will not see this");
          }),
    );
  }

  Future<void> saveData(context) async {
    final myData = Data(data: "Lorem ipsum, something, something...", id: 1);

    await FlutterSession().set('myData', myData);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Page2()));
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder(
        future: FlutterSession().get('myData'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Data data = snapshot.data as Data;
            return Text(data.data);
          }
          if (snapshot.hasData) {
            final data = snapshot.data as Data;
            return Text(snapshot.hasData ? "${data.id}|${data.data}" : 'Loading...');
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
