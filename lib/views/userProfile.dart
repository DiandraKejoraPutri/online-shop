import 'package:flutter/material.dart';
import 'package:epicup/widgets/Navbar.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState()=> _UserprofileState();
}
class _UserprofileState extends State<Userprofile>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("profile"),
      ),
      body: Text ("data"),
      bottomNavigationBar: Navbar(2),
    );
  }
}