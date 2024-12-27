import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> user = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Api Test"),
      ),
      body: ListView.builder(
        itemCount: user.length,
        itemBuilder: (context, index) {
          final users = user[index];
          final email = users['email'];
          final userName = users['name']['first'];
          final userCountry = users['country'];
          final userProfile = users['picture']['thumbnail'];
          final ageUser = users['dob']['age'].toString();
          return ListTile(
            leading: ClipOval(child: Image.network(userProfile)),
            title: Text(userName),
            subtitle: Text(email),

            //leading: Text(email),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        fetchUser();
      }),
    );
  }

  void fetchUser() async {
    print("data starting");
    const uri = "https://randomuser.me/api/?results=50";
    final url = Uri.parse(uri);
    final response = await http.get(url);
    final result = response.body;
    final json = jsonDecode(result);
    setState(() {
      user = json['results'];
    });
    print("Data Fetched");
  }
}
