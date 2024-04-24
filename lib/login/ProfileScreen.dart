import 'package:flutter/material.dart';
import 'package:room_automation/services/auth.dart';
import 'package:room_automation/services/firestore.dart';
import 'package:room_automation/services/models.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestoreService = FirestoreService();
  UserProfile _profile = UserProfile();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  _loadProfile() async {
    try {
      UserProfile profile = await _firestoreService.getUserProfile();
      setState(() {
        _profile = profile;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Error loading profile";
      });
    }
  }

  _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _firestoreService.updateUserReport(_profile);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Profile updated successfully'),
        ));
      } catch (e) {
        setState(() {
          _errorMessage = "Error updating profile";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              TextFormField(
                initialValue: _profile.name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onSaved: (value) => _profile.name = value!,
              ),
              TextFormField(
                initialValue: _profile.detail,
                decoration: InputDecoration(labelText: 'Details'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Details are required';
                  }
                  return null;
                },
                onSaved: (value) => _profile.detail = value!,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _profile.isFaculty,
                    onChanged: (value) {
                      setState(() {
                        _profile.isFaculty = value!;
                      });
                    },
                  ),
                  Text('Is Faculty'),
                ],
              ),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save'),
              ),
              Center(
                child: ElevatedButton(
                  child: Text('Sign Out'),
                  onPressed: () async {
                    await AuthService().signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
