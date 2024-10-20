import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageGallery = [
    'foto1.jpg',
    'foto2.png',
    'foto3.jpg',
    'foto4.png',
  ];

  int activeIndex = 0; // Keep track of the active image index

  // Dropdown menu data
  final List<String> locations = [
    'Seattle, USA',
    'New York, USA',
    'Los Angeles, USA'
  ];
  String selectedLocation = 'Seattle, USA'; // Default selected location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Set the desired height here
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_sharp,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: selectedLocation, // Use the selected value here
                        items: locations.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedLocation = newValue!; // Update the selected value
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.notifications_active, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search doctor...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  fillColor: Colors.grey[200],
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    borderSide: BorderSide.none, // Remove the border outline
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners when focused
                    borderSide: BorderSide(color: Colors.blue, width: 2), // Border color when focused
                  ),
                ),
              ),
              SizedBox(height: 20),

              // #################### Carousel Slider ####################
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  slider.CarouselSlider(
                    options: slider.CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      viewportFraction: 1.0, // Show one image at a time
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                    items: imageGallery.map((imagePath) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Positioned(
                    bottom: 10, // Position dots 10 pixels from the bottom
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: imageGallery.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.grey,
                        dotColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // #################### Categories ####################
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('See All', style: TextStyle(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCategoryIcon(
                      'Dentistry', FontAwesomeIcons.tooth, Colors.pink[200]!),
                  buildCategoryIcon(
                      'Cardiology', Icons.monitor_heart_outlined, Colors.green[100]!),
                  buildCategoryIcon(
                      'Pulmonology', FontAwesomeIcons.lungs, Colors.orange[300]!),
                  buildCategoryIcon(
                      'General', Icons.local_hospital, Colors.purple[100]!),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCategoryIcon(
                      'Neurology', FontAwesomeIcons.brain, Color.fromARGB(255, 50, 205, 50)),
                  buildCategoryIcon(
                      'Gastroenterology', Icons.fastfood, Colors.purple[600]!),
                  buildCategoryIcon(
                      'Laboratory', Icons.science, Colors.pink[100]!),
                  buildCategoryIcon(
                      'Vaccination', Icons.vaccines, Colors.blue[100]!),
                ],
              ),

              SizedBox(height: 20),

              // #################### Nearby Medical Centers ####################
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nearby Medical Centers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('See All', style: TextStyle(color: Colors.grey)),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildMedicalCenterCard(
                        'medical_center1.jpg',
                        // Image path
                        'MedPark Clinic',
                        // Center name
                        'Valea Trandafirilor Street, 27',
                        // Address
                        4.9,
                        // Rating
                        67,
                        // Number of reviews
                        '11km/32 min',
                        // Distance
                        'Hospital' // Hospital Type
                    ),
                    buildMedicalCenterCard(
                        'medical_center2.jpg',
                        'Geisinger Health Clinic',
                        'Valea Morilor Street, 124',
                        4.5,
                        // Rating
                        59,
                        // Number of reviews
                        '26km/50 min',
                        // Distance
                        'Hospital' // Hospital Type
                    ),
                    buildMedicalCenterCard(
                        'medical_center3.jpg',
                        'DCH Central Hospital',
                        'Alba Iulia Street, 354',
                        3.8,
                        // Rating
                        101,
                        // Number of reviews
                        '9km/21 min',
                        // Distance
                        'Hospital' // Hospital Type
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // #################### Doctor List ####################
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('532 Found',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text('Default ', style: TextStyle(color: Colors.grey)),
                      Icon(FontAwesomeIcons.arrowUp, color: Colors.grey, size: 12.0),
                      Icon(FontAwesomeIcons.arrowDown, color: Colors.grey, size: 12.0),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 10),
              buildDoctorCard(
                'Dr. John Doe',
                'Cardiologist',
                'Heart Care Center',
                'New York, USA',
                'doctor1.jpg', // Custom doctor image
                5, // Doctor's rating
                320,
              ),

              buildDoctorCard(
                'Dr. John Doe',
                'Cardiologist',
                'Heart Care Center',
                'New York, USA',
                'doctor2.jpg', // Custom doctor image
                4, // Doctor's rating
                416,
              ),

              buildDoctorCard(
                'Dr. John Doe',
                'Cardiologist',
                'Heart Care Center',
                'New York, USA',
                'doctor3.jpeg', // Custom doctor image
                3, // Doctor's rating
                389,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryIcon(String label, IconData icon, Color backgroundColor) {
    return Column(
      children: [
        Container(
          width: 80, // Set width for the square
          height: 80, // Set height for the square
          decoration: BoxDecoration(
            color: backgroundColor, // Use the passed background color
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          child: Icon(icon,
              color: Colors.white, size: 60), // Icon inside the square
        ),
        SizedBox(height: 8), // Space between icon and label
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey[600])), // Label text
      ],
    );
  }

  Widget buildMedicalCenterCard(String imagePath,
      String centerName,
      String address,
      double rating,
      int reviewCount,
      String distance,
      String hospitalType) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image at the top half
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),

          // Padding for the text
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  centerName,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),

                // Row for location icon and address
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.grey, // Set the color of the location icon
                      size: 16, // Adjust the icon size
                    ),
                    SizedBox(width: 4), // Space between icon and address
                    Expanded(
                      child: Text(
                        address,
                        style: TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Row for stars and reviews
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: rating,
                      itemBuilder: (context, index) =>
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                      itemCount: 5,
                      itemSize: 18.0,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '($reviewCount reviews)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Horizontal line
                Divider(
                  color: Colors.grey[400], // Line color
                  thickness: 1, // Line thickness
                ),

                // Row for distance and hospital info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.directions_walk, // Distance icon
                          color: Colors.blue,
                          size: 16,
                        ),
                        SizedBox(width: 4), // Space between icon and text
                        Text(
                          distance, // Use the passed distance value
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_hospital, // Hospital icon
                          color: Colors.red,
                          size: 16,
                        ),
                        SizedBox(width: 4), // Space between icon and text
                        Text(
                          hospitalType, // Use the passed hospital type value
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDoctorCard(String doctorName,
      String profession,
      String medicalCenterName,
      String location,
      String imagePath,
      double rating,
      int views) {
    // Added views parameter
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          // Heart Icon at the top-right corner
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 40.0),
            // Padding to prevent overlap with heart icon
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Rounded corners
                child: Image.asset(
                  imagePath, // Custom image for each doctor
                  width: 80,
                  height: 100,
                  fit: BoxFit.cover, // Ensures the image fits within the square
                ),
              ),
              title: Text(
                doctorName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profession),

                  // Row for location icon and medical center name
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        medicalCenterName,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Review row with a star rating, vertical line, and views
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: rating,
                        itemBuilder: (context, index) =>
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        itemCount: 1,
                        // Only one star shown
                        itemSize: 18,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(width: 8),

                      // Display the rating value
                      Text(
                        '$rating  ', // Show the rating
                        style: TextStyle(color: Colors.grey),
                      ),
                      // Number of views
                      Text(
                        '|  $views views', // Show the number of views
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
