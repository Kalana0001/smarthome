import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  List<List<dynamic>> devices = [
    ["Bulb 01", "assets/icons/lock.png", false],
    ["Bulb 02", "assets/icons/window.png", false],
    ["Bulb 03", "assets/icons/smart-tv.png", false],
    ["Fan", "assets/icons/fan.png", false],
    ["Smart Light", "assets/icons/light-bulb.png", false],
    ["Smart AC", "assets/icons/air-conditioner.png", false],
  ];

  @override
  void initState() {
    super.initState();
    // Optionally, initialize state with values from Firebase
  }

  void powerSwitchChanged(bool value, int index) {
    setState(() {
      devices[index][2] = value;
    });

    // Update Firebase
    String deviceName = devices[index][0].toLowerCase().replaceAll(" ", "_");
    _database.child('devices/$deviceName').set(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.dashboard, size: 40, color: Colors.white),
                  Icon(Icons.person, size: 40, color: Colors.white)
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Welcome", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  Text("Smart Lodge System", style: TextStyle(fontSize: 35, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: const Text("Device List", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: devices.length,
                padding: const EdgeInsets.all(20.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Image.asset(devices[index][1], height: 50),
                              Icon(Icons.home, size: 50),
                              CupertinoSwitch(
                                value: devices[index][2],
                                onChanged: (value) {
                                  powerSwitchChanged(value, index);
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                            child: Text(
                              devices[index][0],
                              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
