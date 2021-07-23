import 'dart:io';

import 'package:faiikan/blocs/account_bloc/AccountBloc.dart';
import 'package:faiikan/blocs/account_bloc/AccountEvent.dart';
import 'package:faiikan/utils/server_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileInfoScreen extends StatefulWidget {
  @override
  _ProfileInfoScreenState createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  TextEditingController txtName = TextEditingController();

  TextEditingController txtEmail = TextEditingController();

  TextEditingController txtSex = TextEditingController();

  TextEditingController txtPhone = TextEditingController();
  File? avarta;

  String? birthday;


  @override
  void initState() {
    txtName.text = context.read<AccountBloc>().user!.name!;
    txtEmail.text = context.read<AccountBloc>().user!.email!;
    txtSex.text = context.read<AccountBloc>().user!.sex!;
    txtPhone.text = context.read<AccountBloc>().user!.phoneNumber ?? "";
    birthday = context.read<AccountBloc>().user!.birthday;

    super.initState();
  }
  @override
  void dispose() {
    txtName.dispose();
    txtEmail.dispose();
    txtSex.dispose();
    txtPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    txtName.text = context.read<AccountBloc>().user!.name!;
    txtEmail.text = context.read<AccountBloc>().user!.email!;
    txtSex.text = context.read<AccountBloc>().user!.sex!;
    txtPhone.text = context.read<AccountBloc>().user!.phoneNumber ?? "";
    birthday = context.read<AccountBloc>().user!.birthday;
    return Scaffold(
      backgroundColor: Color(0xffE7E7E7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.deepOrange,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AccountBloc>().add(UpdateProfileInfo(
                  id: context.read<AccountBloc>().userId!.toString(),
                  name: txtName.text,
                  sex: txtSex.text,
                  avarta: avarta,
                  phone: txtPhone.text,
                  birthday: birthday,
                  email: txtEmail.text));
              Navigator.pop(context);

            },
            icon: Icon(
              Icons.done,
              color: Colors.deepOrange,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 5,
              color: Colors.deepOrange,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(
                      context
                              .read<AccountBloc>()
                              .user!
                              .imageUrl
                              ?.replaceAll("localhost", server) ??
                          "https://portal.staralliance.com/imagelibrary/aux-pictures/prototype-images/avatar-default.png/@@images/image.png",
                    ),radius: 40,),
                    Positioned(
                        bottom: 0,
                        child: InkWell(
                          onTap: ()async{
                            await ImagePicker().getImage(source: ImageSource.gallery).then((value) {
                              avarta =File(value!.path);
                            });
                          },
                          child: Container(
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                backgroundBlendMode: BlendMode.colorBurn),
                            child: Center(
                              child: Text(
                                "Sửa",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Color(0xffE5E5E5), width: 1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Tên"),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none, hintText: "Mời nhập tên"),
                      controller: txtName,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: Color(0xffE5E5E5), width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Giới tính"),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                        border: InputBorder.none,),
                    controller: txtSex,
                  ),
                ),
              ],
            ),
          ),
          Container(

            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: Color(0xffE5E5E5), width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Ngày sinh: "+  (birthday ?? "")),
                InkWell(
                  onTap: () async {
                    await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900, 1, 1),
                            lastDate: DateTime.now())
                        .then((value) {
                      setState(() {
                        birthday = DateFormat('yyyy-MM-dd').format(value!);
                      });
                    });
                  },
                  child: Icon(
                    Icons.date_range,
                    color: Colors.blueAccent,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: Color(0xffE5E5E5), width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Email"),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(

                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none, hintText: "Mời nhập email"),
                    controller: txtEmail,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!))
                        return null;
                      else
                        return "Vui lòng nhập đúng định dạnh email.";
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: Color(0xffE5E5E5), width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Số điện thoại"),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: "Mời nhập số điện thoại "),
                    controller: txtPhone,
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}
