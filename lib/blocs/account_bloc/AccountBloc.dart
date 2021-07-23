import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:faiikan/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:faiikan/screens/main_screen/chat_screen/Controllers/fb_storage.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'AccountEvent.dart';
import 'AccountState.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
   User? user;
  bool isLogined=false;
  int? userId=0;
   late SharedPreferences prefs;
  AccountBloc(AccountState initialState) : super(initialState);

  @override
  AccountState get initialState => AccountInitial();

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {

    if(event is InitialAccount)
      {
        yield AccountLoading();
         prefs = await SharedPreferences.getInstance();
        print("userId: local ");
        print(prefs.get("userId"));
        if(prefs.get("userId")!=null) {

          user = User(id: int.parse(prefs.get("userId") as String),
              active: true,
              birthday: "",
              email: prefs.getString("email",),
              imageUrl: prefs.getString("avarta"),
              name: prefs.getString("name"),
              phoneNumber: "",
              sex: "",
              timeCreated: "",
              timeUpdated: "");
          userId=user!.id!;
        }
        yield AccountInitial();
      }
    if(event is LogOutEvent)
      {
        yield AccountLoading();
         prefs = await SharedPreferences.getInstance();
       await prefs.clear();
       userId=0;
       user=null;
        yield AccountOk();
      }
    if (event is LoginButtonPressed) {
      yield AccountLoading();
      try {

        final response = await http.post(
          Uri.parse("http://$server:8080/api/v1/account/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "username": event.username,
            "password": event.password,
          }),
        );

        if (response.statusCode == 200) {
          user = User.fromJson(json.decode(response.body)["user"]);
          userId=user!.id!;
          print(" userid: " + user!.id.toString());
          isLogined=true;
//          FBStorage.instanace.saveUserImageToFirebaseStorage("",
//              user!.id.toString(),user!.name,"",
//             await urlToFile(user!.imageUrl ?? ""));
           prefs = await SharedPreferences.getInstance();
         await  prefs.setString("userId", userId!.toString());
         await  prefs.setString("email", user!.email ?? "");
          await prefs.setString("avarta", user!.imageUrl!);
         await  prefs.setString("name", user!.name!);

          yield AccountOk();
        } else {
          yield AccountInitial();

          yield AccountFailure(error: "login failed");
        }
      } catch (error) {
        yield AccountInitial();
        yield AccountFailure(error: error.toString());
      }
    }
    if(event is RegisterEvent)
      {
        AccountLoading();
        try {
          final response = await http.post(
            Uri.parse("http://$server:8080/api/v1/account/register"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "username": event.username,
              "password": event.password,
              "name": event.name
            }),
          );
          print(response.body);
          print(response.reasonPhrase);
          if(response.statusCode == 200)
            yield RegisterOk();
          else yield AccountFailure(error: json.decode(response.body)['message'] );
        }catch(error) {
          yield  AccountFailure(error: "Lỗi trùng email");
        }
      }

    if(event is UpdateProfileInfo)
      {
        AccountLoading();
//        try {
         http.MultipartFile? avarta;
          if (event.avarta != null) {

             avarta =http.MultipartFile.fromBytes(
                "listItem",
                event.avarta!.readAsBytesSync(), filename: '${DateTime.now().second}.jpg',contentType:MediaType("image", "jpg")
            );
          }

          var request = http.MultipartRequest(
              'PUT',
              Uri.parse(
                "http://$server:8080/api/v1/user/update",
              ));


          request.fields['id'] = event.id;
          request.fields['name'] = event.name;
        if(event.birthday!=null)  request.fields['birthday'] = event.birthday!;
          request.fields['email'] = event.email;
           request.fields['sex'] = event.sex;
          request.fields['phoneNumber'] = event.phone;


          request.headers['Content-Type'] = 'multipart/form-data';

          if(avarta!=null)
            request.files.add(avarta);
          var res = await request.send();
          print(await res.stream.bytesToString());
         user = User.fromJson(json.decode(await res.stream.bytesToString()));
         print(user!.imageUrl);

          yield AccountInitial();
//        }catch(error) {
//          yield  AccountFailure(error: "Lỗi ");
//        }
      }
  }
}

Future<File> urlToFile(String imageUrl) async {

  Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
  String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
  File file = new File('$tempPath'+ "myFile.png");
// call http.get method and pass imageUrl into it to get response.
  http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
  await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
  return file;
}