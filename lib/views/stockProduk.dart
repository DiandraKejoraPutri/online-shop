import 'package:flutter/material.dart';
import 'package:epicup/widgets/Navbar.dart';

class Stockproduk extends StatefulWidget {
  const Stockproduk({super.key});

  @override
  State<Stockproduk> createState()=> _StockprodukState();
}
class _StockprodukState extends State<Stockproduk>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("stock"),
      ),
      body: Text ("data"),
      bottomNavigationBar: Navbar(1),
    );
  }
}