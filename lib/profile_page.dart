import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'custom_bottom_nav_bar.dart';
import 'rewardpointsaward.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _textController = TextEditingController();
  bool _isEditing = false;
  String _nickname = 'Username';
  final advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _saveImagePath(pickedFile.path);
    }
  }

  Future<void> _toggleEdit() async {
    setState(() {
      if (_isEditing) {
        _nickname = _textController.text;
        _saveNickname(_nickname);
      } else {
        _textController.text = _nickname;
      }
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveNickname(String nickname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', nickname);
  }

  Future<void> _saveImagePath(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', path);
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nickname = prefs.getString('nickname') ?? 'Username';
      String? imagePath = prefs.getString('imagePath');
      if (imagePath != null) {
        _image = File(imagePath);
      }
    });
  }

  Stream<List<Challenge>> _getChallengesStream() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('challenges')
        .where('completionPercentage.$userId', isEqualTo: 100)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        String title = doc.id;
        String points = doc.data()['points'].toString();
        return Challenge(title: title, points: points);
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: advancedDrawerController,
      backdropColor: Color(0xffA1C34A),
      rtlOpening: true,
      animationCurve: Curves.easeInOut,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 20),
              child: ListTile(
                leading: Stack(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xffA1C34A), width: 2),
                      ),
                      child: _image == null
                          ? Icon(Icons.person, size: 30, color: Colors.grey)
                          : ClipOval(
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                          width: 55,
                          height: 55,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -8,
                      right: -15,
                      child: IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 20,
                        color: Colors.grey,
                        onPressed: _pickImage,
                      ),
                    ),
                  ],
                ),
                subtitle: GestureDetector(
                  onTap: _toggleEdit,
                  child: _isEditing
                      ? Container(
                    width: 60,
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type..',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff444242),
                      ),
                      onSubmitted: (_) => _toggleEdit(),
                    ),
                  )
                      : Text(
                    _nickname,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffA1C34A),
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      'Hey !',
                      style: TextStyle(
                          color: Color(0xff444242),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 30,
                      child: const Center(
                        child: Image(
                          image: AssetImage('images/wavinghand-1.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  child: Icon(Icons.menu, color: Color(0xffA1C34A), size: 28),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 10),
              child: ListTile(
                leading: Text('Reward Points Award',
                    style: TextStyle(color: Color(0xff87A430), fontSize: 20)),
                trailing: Container(
                  child: Icon(Icons.arrow_forward_ios, color: Color(0xffA1C34A), size: 20),
                ),
              ),
            ),
            Container(
              height: 200,
              child: StreamBuilder<List<Challenge>>(
                stream: _getChallengesStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No challenges found'));
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: snapshot.data!.map((challenge) {
                        return Rewardpointsaward(
                          title: challenge.title,
                          points: challenge.points,
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0),
      ),
      drawer: SafeArea(
        child: Column(
          children: [

      ],
        ),
      ),
    );
  }
  void drawerControl(){
    advancedDrawerController.showDrawer();
  }
}

class Challenge {
  final String title;
  final String points;

  Challenge({required this.title, required this.points});
}
