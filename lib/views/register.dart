import 'package:flutter/material.dart';
import 'package:epicup/services/user.dart';
import 'package:epicup/widgets/alert.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  UserService user = UserService();
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  List<String> roleChoice = ["chasier", "user"];
  String? role;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlueAccent, Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          buildTextField("Name", Icons.person, name),
                          buildTextField("Email", Icons.email, email),
                          buildTextField("Phone", Icons.phone, phone),
                          const SizedBox(height: 10),
                          buildDropdownField(),
                          const SizedBox(height: 10),
                          buildPasswordField(),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: registerUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Sign Up!",
                              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Log In');
                            },
                            child: const Text("Already have an account? Log In"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) return "$label is required!";
          return null;
        },
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: password,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) return 'Password is required!';
        return null;
      },
    );
  }

  Widget buildDropdownField() {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      value: role,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      ),
      items: roleChoice.map((r) {
        return DropdownMenuItem(value: r, child: Text(r));
      }).toList(),
      onChanged: (value) {
        setState(() {
          role = value;
        });
      },
      hint: const Text("Select Role"),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Role is required!';
        return null;
      },
    );
  }

  void registerUser() async {
    if (formKey.currentState!.validate()) {
      var data = {
        "name": name.text,
        "email": email.text,
        "phone": phone.text,
        "role": role,
        "password": password.text,
      };
      var result = await user.registerUser(data);

      if (result.status == true) {
        name.clear();
        email.clear();
        phone.clear();
        password.clear();
        setState(() {
          role = null;
        });
        AlertMessage().showAlert(context, result.message, true);
      } else {
        AlertMessage().showAlert(context, result.message, false);
      }
    }
  }
}
