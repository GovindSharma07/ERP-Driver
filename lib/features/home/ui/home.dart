import 'package:erp_driver/features/home/bloc/location_bloc.dart';
import 'package:erp_driver/features/login/ui/login.dart';
import 'package:erp_driver/features/services/firebase_firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final mAuth = FirebaseAuth.instance;
  late AnimationController _animationController;
  final LocationBloc _locationBloc = LocationBloc();
  late List<String> tokens;

  @override
  void initState() {
    mAuth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      }
    });
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _locationBloc.add(BusLocationStopEvent());
    _getTokens(mAuth.currentUser?.uid);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: const Text(
                        "Do You Want To LogOut from this App",
                        style: TextStyle(fontSize: 15),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel")),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              FirebaseAuth.instance.signOut();
                            },
                            child: const Text("Logout"))
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        bloc: _locationBloc,
        builder: (BuildContext context, state) {
          if (state is BusLocationStartState) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "This Application will gonna share your location with the college \n press START button to share location ",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (state is BusLocationStopState) {
                        if (tokens != []) {
                          _locationBloc.add(BusLocationStartEvent(tokens));
                        }
                      } else {
                        _locationBloc.add(BusLocationStopEvent());
                      }
                    },
                    child: AnimatedIcon(
                      progress: _animationController,
                      icon: AnimatedIcons.play_pause,
                      size: 200,
                      color: (state is BusLocationStartState)
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _getTokens(String? uid) async {
    tokens = await FirebaseFirestoreService().getTokens(uid!);
  }
}
