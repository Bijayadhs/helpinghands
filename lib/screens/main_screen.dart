import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpinghands/screens/auth_screen.dart';
import 'package:helpinghands/screens/get_service_service.dart';
import 'package:helpinghands/screens/home_screen.dart';
import 'package:helpinghands/screens/post_service_screen.dart';
import 'package:helpinghands/screens/signup_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> screens = const [
    PostServiceScreen(),
    HomeScreen(),
    GetServiceScreen()
  ];
  int currentIndex = 1;
  bool isSignedIn = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  void getUser() async {
    user = auth.currentUser!;
    isSignedIn = true;
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void onTap(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helping Hands'),
        centerTitle: true,
        actions: [
          isSignedIn
              ? IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    auth.signOut();
                    setState(() {
                      isSignedIn = false;
                    });
                  },
                )
              : const Text('Hi, Guest'),
        ],
      ),
      bottomNavigationBar:
          MyBottomNavigationBar(onTap: onTap, currentIndex: currentIndex),
      drawer: const myDrawer(),
      body: StreamBuilder<User?>(
          stream: auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return screens[currentIndex];
              }
            }
            return const AuthScreen();
          }),
    );
  }
}

class myDrawer extends StatelessWidget {
  const myDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.indigo[300],
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            child: Text('Account'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: const Text('History'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Sign Out'),
            onTap: () {
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();
            },
          ),
          ListTile(
            title: const Text('Sign In Anonymously'),
            onTap: () async {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return const SignUpScreen();
              // }));
              FirebaseAuth auth = FirebaseAuth.instance;
              await auth.signInAnonymously();
            },
          ),
          ListTile(
            title: const Text('Sign Up Default'),
            onTap: () async {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return const SignUpScreen();
              // }));
              FirebaseAuth auth = FirebaseAuth.instance;
              await auth.createUserWithEmailAndPassword(
                  email: 'bj@gmail.com', password: '123456');
            },
          ),
          ListTile(
            title: const Text('Sign In Default'),
            onTap: () async {
              Navigator.pop(context);
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return const SignUpScreen();
              // }));
              FirebaseAuth auth = FirebaseAuth.instance;
              await auth.signInWithEmailAndPassword(
                  email: 'bj@gmail.com', password: '123456');
            },
          ),
        ],
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar(
      {Key? key, required this.onTap, required this.currentIndex})
      : super(key: key);
  final Function(int) onTap;
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.upload_outlined),
          label: 'Post Service',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.design_services_outlined),
          label: 'Get Service',
        ),
      ],
    );
  }
}
