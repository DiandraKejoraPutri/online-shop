import 'package:flutter/material.dart';
import 'package:epicup/models/login.dart';

class Navbar extends StatefulWidget {
  final int ActivePage;
  const Navbar(this.ActivePage, {super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  Login login = Login();
  String? role;

  Future<void> DataLogin() async {
    var user = await login.getLogin();
    if (user != null) {
      setState(() {
        role = user.role;
      });
    } else {
      Navigator.popAndPushNamed(context, '/login_view');
    }
  }

  @override
  void initState() {
    super.initState();
    DataLogin();
  }

  void getlink(int index) {
    if (role == "cashier") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/stock');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/cashierprofile');
      }
    } else if (role == "pelanggan") {
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/beli');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/userprofile');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (role == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: widget.ActivePage,
      onTap: (index) => getlink(index),
      items: role == "cashier"
          ? [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.inventory),
                label: 'Stock',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ]
          : [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Beli Barang',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profil',
              ),
            ],
    );
  }
}
