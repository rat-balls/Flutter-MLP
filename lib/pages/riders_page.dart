import 'package:flutter/material.dart';
import 'package:flutter_mlp/dbConnect.dart';
import 'package:flutter_mlp/class/rider.dart';

class RidersPage extends StatefulWidget {
  @override
  _RidersPageState createState() => _RidersPageState();
}

class _RidersPageState extends State<RidersPage> {
  List<Rider> riders = [];
  DbConnect myDb = DbConnect();

  @override
  void initState() {
    super.initState();
    fetchRidersFromMongoDB();
  }

  void fetchRidersFromMongoDB() async {
    List<Rider> fetchedRiders = await myDb.getRiders();

    setState(() {
      riders = fetchedRiders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Cavaliers'),
      ),
      body: ListView.builder(
        itemCount: riders.length,
        itemBuilder: (context, index) {
          Rider rider = riders[index];
          return ListTile(
            title: Text(rider.name),
            subtitle: Text('Age: ${rider.age.toString()}'),
          );
        },
      ),
    );
  }
}
