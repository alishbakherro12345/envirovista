import 'package:envirovista/reduce_page.dart';
import 'package:envirovista/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:circular_charts/circular_charts.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/departmental_controller.dart';
import 'controller/profile_controller.dart';
import 'custom_bottom_nav_bar.dart';
import 'utils/footprint/foot_print_page.dart';
import 'utils/learn/learn_page.dart';
import 'rewardpointsaward.dart';

class ProfilePage extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final DepartmentalController departmentalController = Get.put(DepartmentalController());

  String userId = FirebaseAuth.instance.currentUser!.uid;


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
        resizeToAvoidBottomInset: false,
        body:
          Column(
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
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container( decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/departmental-1.png'),  // Background image path
                          fit: BoxFit.cover,  // How the image should be fitted inside the container
                        ),
                      ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Obx(() {
                              // Access the DepartmentalController instance
                              final departmentalController = Get.find<DepartmentalController>();

                              if (departmentalController.pieChartNames.isEmpty) {
                                return CircularProgressIndicator(color: Colors.green);
                              }

                              // Dynamic colors
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

                              // Accessing the pieChartPercentages from the controller
                              final int valueCount = departmentalController.pieChartPercentages.length;
                              final List<Color> pieChartStartColors = baseStartColors.sublist(0, valueCount);
                              final List<Color> pieChartEndColors = baseEndColors.sublist(0, valueCount);

                              return CircularChart(
                                isShowingCentreCircle: true,
                                centreCircleBackgroundColor: Colors.white,
                                animationTime: 800,
                                chartHeight: 300,
                                chartWidth: 400,
                                pieChartChildNames: departmentalController.pieChartNames,  // Accessing pieChartNames
                                pieChartEndColors: pieChartEndColors,
                                pieChartStartColors: pieChartStartColors,
                                centreCircleTitle: "OVERALL",
                                pieChartPercentages: departmentalController.pieChartPercentages,
                                isShowingLegend: true, // Accessing pieChartPercentages
                                overAllPercentage: departmentalController.totalPercentage,

                              );
                            }),
                          ),

                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/personalview-1.png'),  // Background image path
                            fit: BoxFit.cover,  // How the image should be fitted inside the container
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 30),
                            child: Obx(() {
                              if (profileController.pieChartNames.isEmpty) {
                                return CircularProgressIndicator(color: Colors.green);
                              }
          
                              // Dynamic colors
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
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 8, right: 8, bottom: 10),
                  child: ListTile(
                    leading: Text('Reward Points Award',
                        style: TextStyle(color: Color(0xff87A430), fontSize: 20)),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xffA1C34A), size: 20),
                  ),
                ),

                Expanded(
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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            children: snapshot.data!.map((challenge) {
                              return Rewardpointsaward(
                                title: challenge.title,
                                points: challenge.points,
                              );
                            }).toList(),
                          ),
                        ),
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
  File? _image; // Image file object
  final ImagePicker _picker = ImagePicker(); // ImagePicker instance
  final String userId = FirebaseAuth.instance.currentUser!.uid; // Get the current user's ID

  @override
  void initState() {
    super.initState();
    _loadProfileImage(); // Load the existing image when the widget is initialized
  }

  // Load the existing profile image path from shared preferences
  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('profileImagePath_$userId'); // Use user ID to get the specific image path
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath); // Set the loaded image
      });
    }
  }

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set the picked image
      });
      _saveImagePathToPrefs(pickedFile.path); // Save the image path to shared preferences
    }
  }

  // Save the image path to shared preferences
  Future<void> _saveImagePathToPrefs(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('profileImagePath_$userId', imagePath); // Use user ID to save the specific image path
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Profile image container
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xffA1C34A), width: 2),
          ),
          child: _image == null
              ? Icon(Icons.person, size: 30, color: Colors.grey) // Default icon if no image
              : ClipOval(
            child: Image.file(
              _image!,
              fit: BoxFit.cover,
              width: 55,
              height: 55,
            ),
          ),
        ),
        // Icon button to pick an image
        Positioned(
          bottom: -8,
          right: -15,
          child: IconButton(
            icon: Icon(Icons.add),
            iconSize: 20,
            color: Colors.grey,
            onPressed: _pickImage, // Call function to pick image
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

  Future<void> _toggleEdit(String currentNickname) async {
    setState(() {
      if (_isEditing) {
        String updatedNickname = _textController.text;
        _saveNicknameToFirestore(updatedNickname);
      } else {
        _textController.text = currentNickname;
      }
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveNicknameToFirestore(String nickname) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'nickname': nickname,
    });
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading...");
        }

        // Get the current nickname from the snapshot, or default to 'Username' if it doesn't exist.
        String nickname = snapshot.data?.get('nickname') ?? 'Username';

        return GestureDetector(
          onTap: () => _toggleEdit(nickname),
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
              onSubmitted: (_) => _toggleEdit(nickname),
            ),
          )
              : Text(
            nickname,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xffA1C34A),
            ),
          ),
        );
      },
    );
  }
}

class ProfileDrawer extends StatelessWidget {
  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      //final prefs = await SharedPreferences.getInstance();
      //prefs.remove('profileImagePath');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignIn()), // Replace with your login screen
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

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
                onPressed: () {logout(context);} ,
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

