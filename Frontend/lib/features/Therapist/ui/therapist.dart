import 'package:flutter/material.dart';
import 'package:mindbloom/features/BottomNavbar/ui/bottomNav.dart';
import 'package:mindbloom/features/Home/ui/chatScreen.dart';
import 'package:mindbloom/features/Therapist/models/therapists.dart';

class Therapists extends StatefulWidget {
  const Therapists({super.key});

  @override
  State<Therapists> createState() => _TherapistsState();
}

class _TherapistsState extends State<Therapists> {
  final List<Therapist> therapists = [
    Therapist(
      name: "Dr. John Doe",
      photoUrl:
          "https://media.istockphoto.com/id/177373093/photo/indian-male-doctor.jpg?s=612x612&w=0&k=20&c=5FkfKdCYERkAg65cQtdqeO_D0JMv6vrEdPw3mX1Lkfg=",
      location: "Los Angeles, CA",
      hourlyRate: 150.0,
      rating: 4.8,
    ),
    Therapist(
      name: "Dr. Sarah Connor",
      photoUrl:
          "https://static.vecteezy.com/system/resources/thumbnails/028/287/555/small_2x/an-indian-young-female-doctor-isolated-on-green-ai-generated-photo.jpg",
      location: "San Francisco, CA",
      hourlyRate: 200.0,
      rating: 4.7,
    ),
    Therapist(
      name: "Dr. Bruce Wayne",
      photoUrl:
          "https://t3.ftcdn.net/jpg/02/25/70/72/360_F_225707294_V0jKFrHm1Bm5mLQjTAhKFplaWQIgdHby.jpg",
      location: "Gotham, NJ",
      hourlyRate: 250.0,
      rating: 4.9,
    ),
    Therapist(
      name: "Dr. Clark Kent",
      photoUrl:
          "https://familydoctor.org/wp-content/uploads/2018/02/41808433_l-848x566.jpg",
      location: "Metropolis, NY",
      hourlyRate: 300.0,
      rating: 4.6,
    ),
    Therapist(
      name: "Dr. Diana Prince",
      photoUrl:
          "https://static.vecteezy.com/system/resources/thumbnails/041/409/059/small_2x/ai-generated-a-female-doctor-with-a-stethoscope-isolated-on-transparent-background-free-png.png",
      location: "Themyscira, WW",
      hourlyRate: 350.0,
      rating: 4.8,
    ),
    Therapist(
      name: "Dr. Peter Parker",
      photoUrl:
          "https://hips.hearstapps.com/hmg-prod/images/portrait-of-a-happy-young-doctor-in-his-clinic-royalty-free-image-1661432441.jpg",
      location: "Queens, NY",
      hourlyRate: 100.0,
      rating: 4.5,
    ),
    Therapist(
      name: "Dr. Natasha Romanoff",
      photoUrl:
          "https://thumbs.dreamstime.com/b/smiling-female-doctor-holding-medical-records-lab-coat-her-office-clipboard-looking-camera-56673035.jpg",
      location: "Sokovia, EU",
      hourlyRate: 150.0,
      rating: 4.7,
    ),
    Therapist(
      name: "Dr. Tony Stark",
      photoUrl: "https://example.com/tony_stark.jpg",
      location: "Malibu, CA",
      hourlyRate: 200.0,
      rating: 4.6,
    ),
    Therapist(
      name: "Dr. Stephen Strange",
      photoUrl: "https://example.com/stephen_strange.jpg",
      location: "New York, NY",
      hourlyRate: 250.0,
      rating: 4.8,
    ),
    Therapist(
      name: "Dr. Wade Wilson",
      photoUrl: "https://example.com/wade_wilson.jpg",
      location: "Canada, CA",
      hourlyRate: 300.0,
      rating: 4.5,
    ),
    Therapist(
      name: "Dr. Logan Howlett",
      photoUrl: "https://example.com/logan_howlett.jpg",
      location: "Canada, CA",
      hourlyRate: 350.0,
      rating: 4.7,
    ),
    Therapist(
      name: "Dr. Thor Odinson",
      photoUrl: "https://example.com/thor_odinson.jpg",
      location: "Asgard, AS",
      hourlyRate: 100.0,
      rating: 4.9,
    ),
    Therapist(
      name: "Dr. T'Challa",
      photoUrl: "https://example.com/tchalla.jpg",
      location: "Wakanda, AF",
      hourlyRate: 150.0,
      rating: 4.6,
    ),
    Therapist(
      name: "Dr. Carol Danvers",
      photoUrl: "https://example.com/carol_danvers.jpg",
      location: "Space, UN",
      hourlyRate: 200.0,
      rating: 4.8,
    ),
    Therapist(
      name: "Dr. Clint Barton",
      photoUrl: "https://example.com/clint_barton.jpg",
      location: "New York, NY",
      hourlyRate: 250.0,
      rating: 4.5,
    ),
    Therapist(
      name: "Dr. Bucky Barnes",
      photoUrl: "https://example.com/bucky_barnes.jpg",
      location: "Brooklyn, NY",
      hourlyRate: 300.0,
      rating: 4.7,
    ),
    Therapist(
      name: "Dr. Jennifer Walters",
      photoUrl: "https://example.com/jennifer_walters.jpg",
      location: "Los Angeles, CA",
      hourlyRate: 350.0,
      rating: 4.6,
    ),
    Therapist(
      name: "Dr. Vision",
      photoUrl: "https://example.com/vision.jpg",
      location: "Westview, MA",
      hourlyRate: 100.0,
      rating: 4.8,
    ),
    Therapist(
      name: "Dr. Loki Laufeyson",
      photoUrl: "https://example.com/loki_laufeyson.jpg",
      location: "Asgard, AS",
      hourlyRate: 150.0,
      rating: 4.7,
    ),
    Therapist(
      name: "Dr. Gamora",
      photoUrl: "https://example.com/gamora.jpg",
      location: "Space, UN",
      hourlyRate: 200.0,
      rating: 4.9,
    ),
    Therapist(
      name: "Dr. Rocket Raccoon",
      photoUrl: "https://example.com/rocket_raccoon.jpg",
      location: "Space, UN",
      hourlyRate: 250.0,
      rating: 4.6,
    ),
    Therapist(
      name: "Dr. Drax the Destroyer",
      photoUrl: "https://example.com/drax_the_destroyer.jpg",
      location: "Space, UN",
      hourlyRate: 300.0,
      rating: 4.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Navbar()),
            );
          },
        ),
        title: Text('Therapists',
            style: TextStyle(
                fontSize: screenWidth * 27 / 432, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: therapists.length,
          itemBuilder: (context, index) {
            return TherapistCard(therapist: therapists[index]);
          },
        ),
      ),
    );
  }
}

class TherapistCard extends StatelessWidget {
  final Therapist therapist;

  const TherapistCard({Key? key, required this.therapist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(therapist.photoUrl),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  therapist.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  therapist.location,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '\₹${therapist.hourlyRate.toStringAsFixed(2)}/hour',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4),
                        Text(
                          therapist.rating.toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
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
}
