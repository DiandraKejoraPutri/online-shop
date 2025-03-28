import 'package:flutter/material.dart';
import 'package:epicup/widgets/Navbar.dart';

class Produk extends StatefulWidget {
  const Produk({super.key});

  @override
  State<Produk> createState()=> _ProdukState();
}
class _ProdukState extends State<Produk>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beli"),
      ),
      body: Text ("data"),
      bottomNavigationBar: Navbar(1),
    );
  }
}