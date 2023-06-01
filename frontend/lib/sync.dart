// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:traditional_financial_asistant/infrastructure/ekub/ekub.Dto.dart';

// import 'domain/ekub/Ekub.dart';
// import 'infrastructure/register/memberDto.dart';
// import 'local_storage/local_storage.dart';

// Future<void> fetchDataFromAPI() async {
//   // ekub
//   Future<List<EkubDto>> fetchAllEnrolled(accessToken) async {
//       const String _baseUrl = "http://192.168.251.221:3000/equb";

//     print("all enrolled prov ${accessToken}");
//     try {
//       final response = await http.get(Uri.parse("$_baseUrl/all"),
//           headers: <String, String>{"Authorization": "Bearer $accessToken"});

//       if (response.statusCode == 200) {
//         print("FETCHED");
//         var ekubs = jsonDecode(response.body);

//         print(response.body);
//         // List<EkubDto> ekubsList = EkubDto.fromJson(jsonDRecode(response.body));

//         //      List<EkubDto> ekubsList = ekubs
//         // .map((e) => e != null ? EkubDto.fromJson(jsonDecode(jsonEncode(e))) : null)
//         // .toList();
//         String jsonString = response.body;
//         List<dynamic> jsonList = json.decode(jsonString);
//         List<EkubDto> equbDtoList = jsonList.map((e) => EkubDto.fromJson(e)).toList();
//         print('after response');

//         return equbDtoList;
//       } else {
//         print("provider error");
//         throw Exception("Could not fetch Ekubs");
//       }
//     } catch (e) {
//       print(e);
//       throw Exception("Could not fetch Ekubs");
//     }
//   }




//   //  members
//   Future<List<MemberDto>> fetchAllMembers(String name, accessToken) async {
//   const String _baseUrl = "http://192.168.251.221:3000/equb";

//     print('user provider');
//     final response = await http.get(
//       Uri.parse("$_baseUrl/members/:$name"),
//       headers: <String, String>{
//         "Content-Type": "application/json",
//         "Authorization": "Bearer $accessToken"
//       },
//     );
//     print('member response');
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       String jsonString = response.body;
//       List<dynamic> jsonList = json.decode(jsonString);
//       List<MemberDto> MemberDtoList =
//           jsonList.map((e) => MemberDto.fromJson(e)).toList();
//       print(MemberDtoList);

//       return MemberDtoList;
//     } else {
//       throw Exception("Could not update the Ekub");
//     }
//   }

//     DbHelper helper = DbHelper();
//     // equb update
//     String accessToken = await helper.getAccessToken();
//     List<EkubDto> ekubDtoList = await fetchAllEnrolled(accessToken);
//     List<Ekub> ekubListEntity = ekubDtoList.map((e) => e.toEntity()).toList();
//     await helper.updateEkubList(ekubListEntity);

//     // member update
//     // List<MemberDto> membersListDto = await fetchAllMembers(name, accessToken);

  

// }


// void startSyncTimer() {
//   const duration = Duration(minutes: 1); // Adjust the interval as per your needs
//   Timer.periodic(duration, (_) {
//     fetchDataFromAPI();
//   });
// }
