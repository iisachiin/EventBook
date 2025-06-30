import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream<QuerySnapshot> eventStream;

  @override
  void initState() {
    super.initState();
    eventStream = FirebaseFirestore.instance.collection('events').snapshots();
  }

  Widget allEvents() {
    return StreamBuilder<QuerySnapshot>(
      stream: eventStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> events = snapshot.data!.docs;

          // If Firestore has data, use it; otherwise show default events
          if (events.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: events.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = events[index];
                Map<String, dynamic> eventData =
                    ds.data() as Map<String, dynamic>;

                return Container(
                  margin: EdgeInsets.only(bottom: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                eventData['imageUrl'] ?? "images/Event.jpg",
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    "images/Event.jpg",
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 10.0),
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff6351ec),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  eventData['Date'] ?? "Aug\n24",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              eventData['Name'] ?? "Event Title",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              "\$${eventData['Price'] ?? '50'}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff6351ec),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Expanded(
                            child: Text(
                              eventData['location'] ?? "Location",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            // Show default events when Firestore is empty
            return ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                // Default Event 1
                Container(
                  margin: EdgeInsets.only(bottom: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "images/Event.jpg",
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 10.0),
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff6351ec),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Aug\n24",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Arijit Singh Concert",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              "\$50",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff6351ec),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Text(
                            "Bihar, India",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Default Event 2
                Container(
                  margin: EdgeInsets.only(bottom: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "images/Event1.jpg",
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.0, top: 10.0),
                              width: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff6351ec),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Aug\n24",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pritam chakraborty",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              "\$50",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff6351ec),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Text(
                            "Jharkhand, India",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading events: ${snapshot.error}',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 20.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffe3e6ff), Color(0xfff1f3ff), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined),
                Text(
                  "Nova, East US",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              "Hello, Sachin",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "There are 20 evnets\naround your location",
              style: TextStyle(
                color: Color(0xff6351ec),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            // Search Section
            Container(
              margin: EdgeInsets.only(right: 20.0),
              padding: EdgeInsets.only(left: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search_outlined),
                  border: InputBorder.none,
                  hintText: "Search a event",
                ),
              ),
            ),
            SizedBox(height: 20.0),

            // Event categories section
            Container(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 110,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/MusicIcon.png",
                              height: 50,
                              width: 50,
                            ),
                            Text(
                              "Music",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 110,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/T-Shirt.png",
                              height: 50,
                              width: 50,
                            ),
                            Text(
                              "Clothing",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 110,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/Confetti.png",
                              height: 50,
                              width: 50,
                            ),
                            Text(
                              "Festival",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 110,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/Food.png",
                              height: 50,
                              width: 50,
                            ),
                            Text(
                              "Food",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.0),
            // Upcoming Events Text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Upcoming Events",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    "See all",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),

            Expanded(child: allEvents()),
          ],
        ),
      ),
    );
  }
}
