// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo_project/screens/pages/Hotelinfo/image_controller.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

// import 'details.dart';
// import 'hotel_model.dart';

// class HotelListScreen extends StatelessWidget {
//   final String? location;
//   final String fromDate;
//   final String toDate;
//   final int roomQuantity;
//   final int guestNumber;

//   const HotelListScreen({
//     required this.location,
//     required this.fromDate,
//     required this.toDate,
//     required this.roomQuantity,
//     required this.guestNumber,
//     Key? key,
//   }) : super(key: key);

//   Future<List<HotelModel>> queryAllHotels() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('hotels')
//         .where('location', isEqualTo: location)
//         .get();

//     List<HotelModel> hotels = [];
//     for (DocumentSnapshot document in querySnapshot.docs) {
//       hotels.add(HotelModel.fromMap(document.data() as Map<String, dynamic>));
//     }

//     return hotels;
//   }

//   Future<List<String>> queryHotelPhotos(String location) async {
//   List<String> photoUrls = [];
//   try {
//     final List<String> imagePaths = await FirebaseFirestore.instance
//         .collection('hotels')
//         .doc(location)
//         .get()
//         .then((snapshot) => List<String>.from(snapshot.data()?['imagePaths'] ?? []));

//     final List<Future<String>> downloadURLs = imagePaths.map((path) async {
//       final ref = FirebaseStorage.instance.ref().child(path);
//       return await ref.getDownloadURL();
//     }).toList();

//     photoUrls = await Future.wait(downloadURLs);
//   } catch (error) {
//     print('Error fetching hotel photos: $error');
//   }
//   return photoUrls;
// }



//   void navigateToHotelDetail(BuildContext context, HotelModel hotel) {
//     // Calculate the number of days between fromDate and toDate
//     DateTime start = DateTime.parse(fromDate);
//     DateTime end = DateTime.parse(toDate);
//     int numberOfDays = end.difference(start).inDays;

// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => HotelDetails(
//       hotel: hotel,
//       fromDate: fromDate,
//       toDate: toDate,
//       roomQuantity: roomQuantity,
//       guestNumber: guestNumber,
//       numberOfDays: numberOfDays,
//     ),
//   ),
// );
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80.0),
//         child: AppBar(
//           title: Text(
//             'Hotels in ${location ?? "Unknown Location"}',
//             style: const TextStyle(
//               fontSize: 24.0,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//               fontFamily: 'RaleWay',
//             ),
//           ),
//           backgroundColor: const Color.fromARGB(255, 0, 62, 112),
//           elevation: 0,
//           centerTitle: true,
//         ),
//       ),
//         body: GetBuilder<ImageController>(
//         init: ImageController(),
//         builder: (imageController) => FutureBuilder<List<HotelModel>>(
//           future: queryAllHotels(),
//           builder: (context, snapshot) { {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             // Error handling
//             print('Error fetching hotels: ${snapshot.error}');
//             return const Center(
//               child: Text('Error fetching hotels. Please try again later.'),
//             );
//           }
//           final hotels = snapshot.data!;

//           return SingleChildScrollView(
//             child: Column(
//               children: hotels.map((hotel) {
//                 return FutureBuilder<List<String>>(
//                   future: queryHotelPhotos(hotel.id),
//                   builder: (context, photoSnapshot) {
//                     if (photoSnapshot.connectionState == ConnectionState.waiting) {
//                       return const CircularProgressIndicator();
//                     }
//                     if (photoSnapshot.hasError) {
//                       // Error handling for photo fetching
//                       print('Error fetching hotel photos: ${photoSnapshot.error}');
//                       // Return some placeholder widget or handle the error as needed
//                       return const Text('Error fetching hotel photos.');
//                     }
//                     final photoUrls = photoSnapshot.data ?? [];
//                     return GestureDetector(
//                       onTap: () {
//                         navigateToHotelDetail(context, hotel);
//                       },
//                       child: Card(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Display images in a horizontal list view
//                             SizedBox(
//                               height: 400, // Set the desired height for the image
//                               child: ListView.builder(
//   scrollDirection: Axis.horizontal,
//   itemCount: photoUrls.length,
//   itemBuilder: (context, index) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Image.network(
//         photoUrls[index],
//         height: 400,
//         width: 400,
//         fit: BoxFit.cover,
//       ),
//     );
//   },
// ),
//                             ),
//                             ListTile(
//                               title: Text(
//                                 '${hotel.name}',
//                                 style: const TextStyle(
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Text(
//                                           hotel.location,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '${hotel.rating} ⭐',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 5),
//                                   Text(
//                                     hotel.address ?? 'Unknown Address',
//                                     style: const TextStyle(
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Tk.${hotel.price.toString()}',
//                                         style: const TextStyle(
//                                           fontSize: 18.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       const Text(
//                                         'For 1 night',
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Text(
//                                     'Amenities: ${hotel.amenities}',
//                                     style: const TextStyle(
//                                       color: Colors.blue,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }).toList(),
//             ),
//           );
//         }
//           },
//       ),
//     )
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:demo_project/screens/pages/Hotelinfo/image_controller.dart';
// import 'package:demo_project/screens/pages/Hotelinfo/details.dart';
// import 'package:demo_project/screens/pages/Hotelinfo/hotel_model.dart';

// class HotelListScreen extends StatelessWidget {
//   final String? location;
//   final String fromDate;
//   final String toDate;
//   final int roomQuantity;
//   final int guestNumber;

//   const HotelListScreen({
//     required this.location,
//     required this.fromDate,
//     required this.toDate,
//     required this.roomQuantity,
//     required this.guestNumber,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hotels in ${location ?? "Unknown Location"}'),
//         centerTitle: true,
//       ),
//       body: GetBuilder<ImageController>(
//         init: ImageController(), // Initialize the controller
//         builder: (imageController) => FutureBuilder<List<HotelModel>>(
//           future: imageController.getAllHotelImages(), // Call the method from the controller
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error fetching hotels: ${snapshot.error}'),
//               );
//             }
//             final List<HotelModel> hotels = snapshot.data as List<HotelModel>;

//             return ListView.builder(
//               itemCount: hotels.length,
//               itemBuilder: (context, index) {
//                 return HotelItem(
//                   hotel: hotels[index],
//                   fromDate: fromDate,
//                   toDate: toDate,
//                   roomQuantity: roomQuantity,
//                   guestNumber: guestNumber,
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // class HotelItem extends StatelessWidget {
// //   final HotelModel hotel;
// //   final String fromDate;
// //   final String toDate;
// //   final int roomQuantity;
// //   final int guestNumber;

// //   const HotelItem({
// //     required this.hotel,
// //     required this.fromDate,
// //     required this.toDate,
// //     required this.roomQuantity,
// //     required this.guestNumber,
// //     Key? key,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         navigateToHotelDetail(context);
// //       },
// //       child: ListTile(
// //         title: Text(hotel.name),
// //         subtitle: Text(hotel.location),
// //         leading: Image.network(
// //           hotel.photoUrls[0], // Assuming the hotel model contains the imageURL field
// //           width: 100,
// //           height: 100,
// //           fit: BoxFit.cover,
// //         ),
// //       ),
// //     );
// //   }

// //   void navigateToHotelDetail(BuildContext context) {
// //     DateTime start = DateTime.parse(fromDate);
// //     DateTime end = DateTime.parse(toDate);
// //     int numberOfDays = end.difference(start).inDays;

// //     Get.to(
// //       HotelDetails(
// //         hotel: hotel,
// //         fromDate: fromDate,
// //         toDate: toDate,
// //         roomQuantity: roomQuantity,
// //         guestNumber: guestNumber,
// //         numberOfDays: numberOfDays,
// //       ),
// //     );
// //   }
// // }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'details.dart';
import 'hotel_model.dart';

class HotelListScreen extends StatelessWidget {
  final String? location;
  final String fromDate;
  final String toDate;
  final int roomQuantity;
  final int guestNumber;

  const HotelListScreen({
    required this.location,
    required this.fromDate,
    required this.toDate,
    required this.roomQuantity,
    required this.guestNumber,
    Key? key,
  }) : super(key: key);

  Future<List<HotelModel>> queryAllHotels() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('hotels')
          .where('location', isEqualTo: location)
          .get();

      List<HotelModel> hotels = [];
      for (DocumentSnapshot document in querySnapshot.docs) {
        hotels.add(HotelModel.fromMap(document.data() as Map<String, dynamic>));
      }
      return hotels;
    } catch (error) {
      print('Error fetching hotels: $error');
      return []; // Return an empty list in case of an error
    }
  }

 Future<List<String>> queryHotelPhotos(String location, String id) async {
    try {
      QuerySnapshot hotelSnapshot = await FirebaseFirestore.instance
          .collection('hotels')
          .where('location', isEqualTo: location)
          .where('id', isEqualTo: id)
          .get();

      if (hotelSnapshot.docs.isNotEmpty) {
        DocumentSnapshot hotelDocument = hotelSnapshot.docs.first;
        Map<String, dynamic>? data =
            hotelDocument.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('url')) {
          dynamic photoUrlsData = data['url'];

          List<String> photoUrls = [];
          if (photoUrlsData is String) {
            photoUrls =
                photoUrlsData.split(',').map((url) => url.trim()).toList();
          } else if (photoUrlsData is List<dynamic>) {
            photoUrls = List<String>.from(photoUrlsData);
          }

          return photoUrls;
        } else {
          print(
              'No photoUrls found in the hotel document with location $location and hotel ID $id.');
          return [];
        }
      } else {
        print(
            'No hotel document found with location $location and hotel ID $id.');
        return [];
      }
    } catch (error, stackTrace) {
      print('Error fetching hotel photos: $error');
      print('StackTrace: $stackTrace');
      return [];
    }
  }





  void navigateToHotelDetail(BuildContext context, HotelModel hotel) {
    DateTime start = DateTime.parse(fromDate);
    DateTime end = DateTime.parse(toDate);
    int numberOfDays = end.difference(start).inDays;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HotelDetails(
          hotel: hotel,
          fromDate: fromDate,
          toDate: toDate,
          roomQuantity: roomQuantity,
          guestNumber: guestNumber,
          numberOfDays: numberOfDays,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          title: Text(
            'Hotels in ${location ?? "Unknown Location"}',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'RaleWay',
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 62, 112),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: FutureBuilder<List<HotelModel>>(
        future: queryAllHotels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching hotels. Please try again later.'),
            );
          }
          final hotels = snapshot.data ?? [];
          return SingleChildScrollView(
  child: Column(
    children: hotels.map((hotel) {
      return FutureBuilder<List<String>>(
       future: queryHotelPhotos(hotel.location, hotel.id), // Pass the hotel ID here
        builder: (context, photoSnapshot) {
          if (photoSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (photoSnapshot.hasError) {
            return const Text('Error fetching hotel photos.');
          }
          final photoUrls = photoSnapshot.data ?? [];
          return GestureDetector(
            onTap: () {
              navigateToHotelDetail(context, hotel);
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: photoUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            photoUrls[index],
                            height: 500,
                            width: 450,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      '${hotel.name}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                hotel.location,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '${hotel.rating} ⭐',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          hotel.address ?? 'Unknown Address',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tk.${hotel.price.toString()}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'For 1 night',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Amenities: ${hotel.amenities}',
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }).toList(),
  ),
);

        },
      ),
    );
  }
}
