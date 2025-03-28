import 'package:flutter/material.dart';
import 'package:epicup/widgets/Navbar.dart';

class Cashierprofile extends  StatefulWidget {
  const Cashierprofile({super.key});

  @override
  State<Cashierprofile> createState()=> _CashierprofileState();
}
class _CashierprofileState extends State<Cashierprofile>{
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