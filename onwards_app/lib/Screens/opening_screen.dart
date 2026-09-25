// import 'package:flutter/material.dart';
// import 'package:unidec_app/Screens/home_screen.dart';
// import 'package:video_player/video_player.dart';
//
// class OpeningScreen extends StatefulWidget{
//   const OpeningScreen({super.key});
//
//   @override
//   State<OpeningScreen> createState() => _OpeningScreenState();
// }
//
// class _OpeningScreenState extends State<OpeningScreen> {
//
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset('lib/UI_animations/assets/loadingcircle.mp4')
//       ..initialize().then((_) {
//         _controller.setLooping(true);
//         setState(() {});
//         _navigateToHome();
//         _controller.play();
//
//       }).catchError((error) {
//         debugPrint('Error initializing video player: $error');
//         _navigateToHome();
//       });
//   }
//
//   void _navigateToHome() async {
//     await Future.delayed(const Duration(seconds: 4));
//     if (!mounted) return;
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const HomeScreen()),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: _controller.value.isInitialized
//             ? Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               width: 150,
//               height: 150,
//               child: FittedBox(
//                 fit: BoxFit.cover,
//                 child: SizedBox(
//                   width: _controller.value.size.width,
//                   height: _controller.value.size.height,
//                   child: VideoPlayer(_controller),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Your Universal Decision Helper',
//               style: TextStyle(
//                 fontStyle: FontStyle.italic,
//                 color: Color(0xFF2354B1),
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 letterSpacing: 1.2,
//               ),
//             ),
//           ],
//         )
//             : const CircularProgressIndicator(color: Colors.grey),
//       ),
//     );
//   }
// }