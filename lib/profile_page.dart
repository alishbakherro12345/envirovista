import 'package:envirovista/reduce_page.dart';
import 'package:envirovista/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:circular_charts/circular_charts.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/profile_controller.dart';
import 'custom_bottom_nav_bar.dart';
import 'foot_print_page.dart';
import 'learn_page.dart';
import 'rewardpointsaward.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: AdvancedDrawerController(),
      backdropColor: const Color(0xff2A3C24),
      openRatio: 0.60,
      rtlOpening: false,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 700),
      child: Scaffold(
        body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 20),
                child: ListTile(
                  leading: ProfileImagePicker(),
                  subtitle: NicknameEditor(),
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
                  trailing: IconButton(
                    icon: Icon(Icons.menu, color: Color(0xffA1C34A)),
                    onPressed: () {
                      AdvancedDrawerController().showDrawer();
                    },
                  ),
                ),
              ),
              Obx(() {
                if (profileController.pieChartNames.isEmpty) {
                  return CircularProgressIndicator();
                }

                // Use the dynamic colors here
                final List<Color> baseStartColors = [
                  Color(0xff2A3C24),
                  Color(0xff87A430),
                  Color(0xffA1C34A),
                  Color(0xffd7e883),
                  Color(0xffCAD593),
                ];

                final List<Color> baseEndColors = [
                  Color(0xff374f2f),
                  Color(0xffa2c53a),
                  Color(0xffc0e859),
                  Color(0xffcde171),
                  Color(0xffb4be7f),
                ];

                final int valueCount = profileController.pieChartPercentages.length;
                final List<Color> pieChartStartColors = baseStartColors.sublist(0, valueCount);
                final List<Color> pieChartEndColors = baseEndColors.sublist(0, valueCount);

                return CircularChart(
                  isShowingCentreCircle: true,
                  centreCircleBackgroundColor: Colors.white,
                  animationTime: 800,
                  chartHeight: 300,
                  chartWidth: 400,
                  pieChartChildNames: profileController.pieChartNames,
                  pieChartEndColors: pieChartEndColors,
                  pieChartStartColors: pieChartStartColors,
                  centreCircleTitle: "OVERALL",
                  pieChartPercentages: profileController.pieChartPercentages,
                  isShowingLegend: true,
                  overAllPercentage: profileController.totalPercentage,
                );
              }),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 10),
                child: ListTile(
                  leading: Text('Reward Points Award',
                      style: TextStyle(color: Color(0xff87A430), fontSize: 20)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Color(0xffA1C34A), size: 20),
                ),
              ),
              SingleChildScrollView(
                child: StreamBuilder<List<Challenge>>(
                  stream: _getChallengesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No challenges found'));
                    }
                    return Column(
                      children: snapshot.data!.map((challenge) {
                        return Rewardpointsaward(
                          title: challenge.title,
                          points: challenge.points,
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0),
      ),
      drawer: ProfileDrawer(),
    );
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
}

class Challenge {
  final String title;
  final String points;

  Challenge({required this.title, required this.points});
}

class ProfileImagePicker extends StatefulWidget {
  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath', pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}

class NicknameEditor extends StatefulWidget {
  @override
  _NicknameEditorState createState() => _NicknameEditorState();
}

class _NicknameEditorState extends State<NicknameEditor> {
  final TextEditingController _textController = TextEditingController();
  bool _isEditing = false;
  String _nickname = 'Username';

  @override
  void initState() {
    super.initState();
    _loadProfile();
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

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nickname = prefs.getString('nickname') ?? 'Username';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}

class ProfileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100,bottom: 30),
            child: ProfileImagePicker()
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hey !',
                style: TextStyle(
                    color: Color(0xffd0c971),
                    fontSize: 18,
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
          NicknameEditor(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // Aligns all children to the start
            children: [
              TextButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));} ,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text('Profile Screen',style: TextStyle(color: Colors.white),),
                ),),
              TextButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => FootprintPage()));} ,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('Footprint Screen',style: TextStyle(color: Colors.white),),
                ),),
              TextButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => LearnPage()));} ,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('Learn Screen',style: TextStyle(color: Colors.white),),
                ),),
              TextButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ReducePage()));} ,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('Reduce Screen',style: TextStyle(color: Colors.white),),
                ),),
              TextButton(
                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));} ,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('Log Out',style: TextStyle(color: Colors.white),),
                ),),
            ],
          ),
        ],
      ),
    );
  }
}

