import 'package:flutter/material.dart';
import 'package:quiz_app/utils/strings.dart';

import '../../app/locator.dart';
import '../../services/database_services/database_services.dart';
import '../../services/navigation/navigation_service.dart';
import '../../utils/assets.dart';
import '../home/home.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  DataBaseService ds = locator<DataBaseService>();
  List<Map<String, dynamic>> leaderboard = [];
  @override
  void initState() {
    leaderboard = ds.makeRank();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.leaderboard), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              Strings.topResults,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: leaderboard.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final user = leaderboard[index];
                  return Container(
                    color: Color(
                      index == 0
                          ? 0xffd7efa8
                          : "new user" == user["name"]
                          ? 0xddBC72FF
                          : 0xffffffff,
                    ),
                    child: ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: index == 0
                                ? Image.asset(Assets.trophy)
                                : Text(
                                    (index + 1).toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ],
                      ),
                      title: Text(
                        user["name"],
                        style: TextStyle(
                          fontSize: index == 0 ? 24 : 18,
                          fontWeight: index == 0
                              ? FontWeight.w900
                              : FontWeight.normal,
                        ),
                      ),
                      trailing: Text(
                        "${user["score"]} pts",
                        style: TextStyle(
                          fontSize: index == 0 ? 24 : 18,
                          fontWeight: index == 0
                              ? FontWeight.w900
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                locator<NavigationService>().pushAndRemoveAll(
                  Home(),
                  arguments: {},
                );
              },
              child: Text(Strings.backToHome),
            ),
          ],
        ),
      ),
    );
  }
}
