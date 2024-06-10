import 'package:flutter/material.dart';

import '../../../../components/bottom_nav_bar.dart';
import '../../booking/Booking.dart';
import '../../user_profile/userprofile.dart';
import '../home_screen.dart';



class GoBooking extends StatefulWidget {
  const GoBooking({Key? key});

  static String routeName = "/pages/homepage";
  

  @override
  _GoBookingState createState() => _GoBookingState();
}

class _GoBookingState extends State<GoBooking> {
  int _currentIndex = 0;
  List<String> urls = [
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/6a/e2/f4/long-beach-hotel.jpg?w=1200&h=-1&s=1",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/e2/9f/60/grand-sylhet-hotel-resort.jpg?w=1100&h=-1&s=1",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/44/ea/2f/royal-tulip-sea-pearl.jpg?w=1200&h=-1&s=1",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/08/c6/62/amari-dhaka-arial-shot.jpg?w=1200&h=-1&s=1",
    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/0c/cb/10/exterior.jpg?w=1200&h=-1&s=1",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      bottomNavigationBar:   BottomnavBar( // Call the BottomnavBar widget
      onTabChanged: (index) { // Define the callback for tab change
        setState(() {
          _currentIndex = index; // Update the current index
        });
      },
      currentIndex: _currentIndex, // Pass the current index
      pageBuilder: (BuildContext context) { // Define the page builder function
        switch (_currentIndex) { // Use the current index to determine the page
          case 0:
            return HomeScreen(); // Replace YourHomePage with the actual page widget
           // Replace YourFavoritePage with the actual page widget
          case 1:
            return Booking(); // Replace YourBookingPage with the actual page widget
          case 2:
            return UserProfile(); // Replace YourProfilePage with the actual page widget
          default:
            return Container(); // Return an empty container for other indices
        }
      },
    ),
  
        // drawer: const NavBar(),
        // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(200),
        //   child: AppBar(
        //     centerTitle: true,
        //     flexibleSpace: Container(
        //       decoration: const BoxDecoration(
        //         image: DecorationImage(
        //           image: NetworkImage(
        //               "https://assets-global.website-files.com/645cf73a1399f9f6ed09a0e8/645cf73a1399f900e009a8cc_Hero-Wide-SaintMartin-SintMaarten-p-1600.jpeg"),
        //           fit: BoxFit.fill,
        //         ),
        //       ),
        //     ),
        //     title: const Text(
        //       'gobooking',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontFamily: 'Raleway',
        //         fontSize: 22,
        //         fontWeight: FontWeight.w400,
        //       ),
        //       textAlign: TextAlign.left,
        //     ),
        //   ),
        // ),
        // body: Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         ElevatedButton(
        //           onPressed: () {
        //             // Button action
        //           },
        //           style: ElevatedButton.styleFrom(
        //             foregroundColor: Colors.black,
        //             backgroundColor: Colors.white,
        //             minimumSize: const Size.square(50), // Button size
        //           ),
        //           child: const Row(
        //             children: [
        //               Icon(
        //                 Icons.hotel,
        //                 color: Colors.black, // Icon color
        //               ),
        //               SizedBox(width: 8), // Add space between the icon and text
        //               Text(
        //                 'Hotel',
        //                 style: TextStyle(
        //                   fontFamily: 'Raleway',
        //                   color: Colors.black, // Text color
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         const SizedBox(width: 16), // Add space between buttons
        //         ElevatedButton(
        //           onPressed: () {
        //             // Button action
        //           },
        //           style: ElevatedButton.styleFrom(
        //             foregroundColor: Colors.black,
        //             backgroundColor: Colors.white,
        //             minimumSize: const Size.square(50), // Button size
        //           ),
        //           child: const Row(
        //             children: [
        //               Icon(
        //                 Icons.car_rental,
        //                 color: Colors.black, // Icon color
        //               ),
        //               SizedBox(width: 8), // Add space between the icon and text
        //               Text(
        //                 'Car',
        //                 style: TextStyle(
        //                   fontFamily: 'Raleway',
        //                   color: Colors.black, // Text color
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         const SizedBox(width: 16), // Add space between buttons
        //         ElevatedButton(
        //           onPressed: () {
        //             // Button action
        //           },
        //           style: ElevatedButton.styleFrom(
        //             foregroundColor: Colors.black,
        //             backgroundColor: Colors.white,
        //             minimumSize: const Size.square(50), // Button size
        //           ),
        //           child: const Row(
        //             children: [
        //               Icon(
        //                 Icons.flight,
        //                 color: Colors.black, // Icon color
        //               ),
        //               SizedBox(width:8), // Add space between the icon and text
        //               Text(
        //                 'Flight',
        //                 style: TextStyle(
        //                   fontFamily: 'Raleway',
        //                   color: Colors.black, // Text color
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //     const SizedBox(height: 25), // Add space between the button and tab controller
        //     Expanded(
        //       child: DefaultTabController(
        //         length: 3,
        //         child: Column(
        //           children: [
        //             const TabBar(
        //               indicatorColor: Color.fromRGBO(1, 60, 148, 1),
        //               unselectedLabelColor: Color.fromARGB(255, 132, 132, 132),
        //               labelColor: Color.fromARGB(255, 0, 0, 0),
        //               labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
        //               tabs: [
        //                 Tab(text: "Trending",),
        //                 Tab(text: "Promotion"),
        //                 Tab(text: "Favorites")
        //               ],
        //             ),
        //             const SizedBox(height: 20),
        //             Expanded(
        //               child: TabBarView(
        //                 children: [
        //                   //Now let's create our first tab page
        //                   ListView(
        //                     scrollDirection: Axis.horizontal,
        //                     children: [
        //                       //Now let's add and test our first card
        //                       travelCard(urls[0], "The Long Beach", "Cox's Bazar", 5),
        //                       travelCard(urls[1], "Grand Sylhet Hotel And Resort",
        //                       "Cox's Bazar", 5),
        //                       travelCard(urls[2], " The Hotel Sea Pearl Beach Resort", "Bandarban", 5),
        //                     ],
        //                   ),
        //                   ListView(
        //                     scrollDirection: Axis.horizontal,
        //                     children: [
        //                       //Here you can add whatever you want
        //                       travelCard(urls[3], "Hotel Aamari ", "Dhaka", 5),
        //                       travelCard(urls[4], "The Westin", "Chittagong", 5),
        //                     ],
        //                   ),
        //                   ListView(
        //                     scrollDirection: Axis.horizontal,
        //                     children: const [],
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        // bottomNavigationBar: BottomnavBar(
        //   onTabChanged: (index) {
        //     setState(() {
        //       currentIndex = index;
        //     });
        //   },
        //   currentIndex: currentIndex,
        //   pageBuilder: (BuildContext context) { // Adjusted function signature
        //     switch (currentIndex) { // Use currentIndex instead of index
        //       case 0:
        //         return const GoBooking();
        //       case 1:
        //         return const favourite();
        //       case 2:
        //         return const Booking();
        //       case 3:
        //         return const UserProfile();
        //       default:
        //         return Container();
        //     }
        //   },
        // ),
      ),
    );
  }
}
