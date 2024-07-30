import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMasjid extends StatefulWidget {
  const AddMasjid({Key? key}) : super(key: key);

  @override
  _AddMasjidState createState() => _AddMasjidState();
}

class _AddMasjidState extends State<AddMasjid> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? selectedRole;


 Future<bool> createUser() async {
    try {
      // Create the user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Add the user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': emailController.text.trim(),
        'role': selectedRole,
      });

      if (selectedRole == 'MASJID') {
        await FirebaseFirestore.instance
            .collection('masjids')
            .doc(userCredential.user!.uid)
            .set(
          {
            "id": userCredential.user!.uid,
            'email': emailController.text.trim(),
            'address': '',
            "name": '',
            'image': '',
            'type': '',
            'fcmToken':'',
            "members":[]
          },
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
    return true;
  }


  void submitForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Password and confirm password do not match");
      return;
    }


    bool userCreated =  await createUser();
    if (userCreated){
        Get.snackbar("Success", "User added successfully");
      } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Masjid'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value!)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a role';
                  }
                  return null;
                },
                items: const [
                  DropdownMenuItem(
                    value: 'MASJID',
                    child: Text('Masjid'),
                  ),
                  DropdownMenuItem(
                    value: 'COMMITTEE',
                    child: Text('Committee'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedRole = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  fixedSize: Size(Get.width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Add User',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('User $index'),
                    subtitle: Text('Email: ${index + 1}@example.com'),
                    trailing: Text(
                        'Role: ${index % 2 == 0 ? 'Masjid' : 'Committee'}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
