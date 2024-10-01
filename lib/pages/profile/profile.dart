import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
      )
    );
  }
}



// bool isLoading = true;
//   double feedbackPercentage = 0;
//   Map<String, dynamic>? moodData;

//   static String _baseUrl = dotenv.env['BASE_URL']!;
//   final String fetchMoodApiUrl = '$_baseUrl/Analytics/mood_distribution';
//   final String fetchFeedbackPercentageApiUrl = '$_baseUrl/Analytics/feedback_percentage';
//   @override
//   void initState() {
//     super.initState();
//     fetchMoodData();
//     fetchFeedbackPercentage();
//   }

//   Future<void> fetchMoodData() async {
//     final response = await http.post(
//       Uri.parse(fetchMoodApiUrl),
//       headers: {"Content-Type": "application/json; charset=UTF-8"},
//       body: jsonEncode({"userid": FirebaseAuth.instance.currentUser!.uid}), // replace with actual user id
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         moodData = jsonDecode(response.body);
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       throw Exception('Failed to load mood data');
//     }
//   }

//   Future<void> fetchFeedbackPercentage() async {
//     final response = await http.post(
//       Uri.parse(fetchFeedbackPercentageApiUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'userid': FirebaseAuth.instance.currentUser!.uid, // Replace with actual user ID
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//         feedbackPercentage = double.parse(data['percentage'].toString());
//       });
//     } else {
//       // Handle error
//       print('Failed to load feedback percentage');
//     }
//   }
//   List<BarChartGroupData> showBars(){
//     return [
//       BarChartGroupData(
//         x: 0,
//         barRods: [
//           BarChartRodData(
//             fromY: 0, toY: feedbackPercentage['positive'], color: Colors.green, width: 30,
//           ),
//           BarChartRodData(
//             fromY: 0, toY: feedbackPercentage['negative'], color: Colors.green, width: 30,
//           ),
//         ]
//       ),
//     ]
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Analytics"),
//       ),
//       body: 
//               Column(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       child: isLoading
//                         ? const CircularProgressIndicator()
//                         : moodData != null
//                         ? Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: PieChart(
//                             PieChartData(
//                               sections: showingSections(),
//                               borderData: FlBorderData(show: false),
//                               centerSpaceRadius: 40,
//                               sectionsSpace: 2,
//                             ),
//                           ),
//                         )
//                       : const Text('No data available'),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       child: BarChart(
//                         BarChartData(
//                           borderData: FlBorderData(
//                             border: const Border(
//                               top: BorderSide.none,
//                               bottom: BorderSide.none,
//                               left: BorderSide(width: 1),
//                               right: BorderSide(width: 1),
//                             )
//                           ),
//                           groupsSpace: 10,
//                           barGroups: 
//                         )
//                       ),
//                     ) 
//                   )
//                 ],
//               ),
//     );
//   }
//   List<PieChartSectionData> showingSections() {
//     return [
//       PieChartSectionData(
//         color: Colors.red,
//         value: double.parse(moodData!['anger'].toString()),
//         title: '${moodData!['anger']}% anger',
//         radius: 100,
//         titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//       PieChartSectionData(
//         color: Colors.blue,
//         value: double.parse(moodData!['happy'].toString()),
//         title: '${moodData!['happy']}% happy',
//         radius: 100,
//         titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//       PieChartSectionData(
//         color: Colors.green,
//         value: double.parse(moodData!['fear'].toString()),
//         title: '${moodData!['fear']}% fear',
//         radius: 100,
//         titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//       PieChartSectionData(
//         color: Colors.orange,
//         value: double.parse(moodData!['anxiety'].toString()),
//         title: '${moodData!['anxiety']}% anxiety',
//         radius: 100,
//         titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//       PieChartSectionData(
//         color: Colors.purple,
//         value: double.parse(moodData!['sadness'].toString()),
//         title: '${moodData!['sadness']}% sadness',
//         radius: 100,
//         titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//       PieChartSectionData(
//         color: Colors.yellow,
//         value: double.parse(moodData!['boredom'].toString()),
//         title: '${moodData!['boredom']}% bored',
//         radius: 100,
//         titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//       PieChartSectionData(
//         color: Colors.pink,
//         value: double.parse(moodData!['excitement'].toString()),
//         title: '${moodData!['excitement']}% excitement',
//         radius: 100,
//         titleStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//     ];
//   }