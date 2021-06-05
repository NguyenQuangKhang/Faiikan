import 'package:faiikan/blocs/address_bloc/address_bloc.dart';
import 'package:faiikan/blocs/address_bloc/address_event.dart';
import 'package:faiikan/blocs/address_bloc/address_state.dart';
import 'package:faiikan/widgets/intput_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewAddressScreen extends StatefulWidget {
  final String userId;

  NewAddressScreen({required this.userId});

  @override
  _NewAddressScreenState createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  bool valueCheckBox = false;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNumberPhone = TextEditingController();
  TextEditingController txtSpecificAddress = TextEditingController();
  int? provinceValue;
  int? districtValue;
  int? wardValue;

  @override
  void initState() {
    context.read<AddressBloc>().districts = [];
    context.read<AddressBloc>().wards = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thêm địa chỉ mới",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 3,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Họ & Tên",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: 0.5,
                          ),
                          controller: txtName,
                          maxLength: 50,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            hintText: "Điền Họ & Tên",
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 3,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Số điện thoại",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: txtNumberPhone,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.end,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                            hintText: "Điền Số điện thoại",
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Tỉnh/ Thành Phố",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: BlocBuilder<AddressBloc, AddressState>(
                                builder: (context, state) {
                              return DropdownButton<int>(
                                value: provinceValue,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                isExpanded: true,
//                                itemHeight: 50,
                                dropdownColor: Colors.white,
                                elevation: 18,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                ),
                                hint: Text("Chọn"),
//                  underline: Container(
//                    height: 2,
//                    color: Colors.deepPurpleAccent,
//                  ),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    provinceValue = newValue!;
                                  });
                                  if (provinceValue != null)
                                    context.read<AddressBloc>().add(
                                        GetDistrictEvent(
                                            provinceId:
                                                provinceValue.toString()));
                                },
                                items: context
                                    .read<AddressBloc>()
                                    .provinces
                                    .map<DropdownMenuItem<int>>((value) {
                                  return DropdownMenuItem<int>(
                                    value: value.id,
                                    child: Container(
//                                      height: 100,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      color: Colors.white,
                                      child: Text(
                                        value.name,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                isDense: true,
                              );
                            }),
                          ),
//                    Text(
//                      "Chọn",
//                      style: TextStyle(
//                        color: Colors.black.withOpacity(0.5),
//                        fontWeight: FontWeight.w500,
//                        fontSize: 18,
//                        letterSpacing: 0.5,
//                      ),
//                    ),
//                    Icon(
//                      Icons.arrow_forward_ios_sharp,
//                      size: 20,
//                      color: Colors.black.withOpacity(0.5),
//                    )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Quận/ Huyện",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: BlocBuilder<AddressBloc, AddressState>(
                                builder: (context, state) {
                              return DropdownButton<int>(
                                value: districtValue,
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                dropdownColor: Colors.white,
                                elevation: 18,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                ),
                                hint: Text("Chọn"),
//                  underline: Container(
//                    height: 2,
//                    color: Colors.deepPurpleAccent,
//                  ),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    districtValue = newValue!;
                                  });
                                  if (districtValue != null) {
                                    context.read<AddressBloc>().add(
                                        GetWardEvent(
                                            districtId:
                                                districtValue.toString()));
                                  }
                                },
                                items: context
                                    .read<AddressBloc>()
                                    .districts
                                    .map<DropdownMenuItem<int>>((value) {
                                  return DropdownMenuItem<int>(
                                    value: value.id,
                                    child: Text(
                                      value.name,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }),
                          ),
//                    Text(
//                      "Chọn",
//                      style: TextStyle(
//                        color: Colors.black.withOpacity(0.5),
//                        fontWeight: FontWeight.w500,
//                        fontSize: 18,
//                        letterSpacing: 0.5,
//                      ),
//                    ),
//                    Icon(
//                      Icons.arrow_forward_ios_sharp,
//                      size: 20,
//                      color: Colors.black.withOpacity(0.5),
//                    )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Phường/ Xã",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: BlocBuilder<AddressBloc, AddressState>(
                                builder: (context, state) {
                              return DropdownButton<int>(
                                value: wardValue,
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 18,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                ),
                                hint: Text("Chọn"),
//                  underline: Container(
//                    height: 2,
//                    color: Colors.deepPurpleAccent,
//                  ),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    wardValue = newValue!;
                                  });
                                },
                                items: context
                                    .read<AddressBloc>()
                                    .wards
                                    .map<DropdownMenuItem<int>>((value) {
                                  return DropdownMenuItem<int>(
                                    value: value.id,
                                    child: Text(
                                      value.name,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }),
                          ),
//                    Text(
//                      "Chọn",
//                      style: TextStyle(
//                        color: Colors.black.withOpacity(0.5),
//                        fontWeight: FontWeight.w500,
//                        fontSize: 18,
//                        letterSpacing: 0.5,
//                      ),
//                    ),
//                    Icon(
//                      Icons.arrow_forward_ios_sharp,
//                      size: 20,
//                      color: Colors.black.withOpacity(0.5),
//                    )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black.withOpacity(0.2),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Địa chỉ cụ thể",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: txtSpecificAddress,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                letterSpacing: 0.5,
                              ),
                              maxLength: 500,
                              maxLines: null,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                counterText: "",
                                border: InputBorder.none,
                                hintText: "Nhập địa chỉ cụ thể",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                  color: Colors.black.withOpacity(0.1),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Đặt làm địa chỉ mặc định",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Checkbox(
                          value: valueCheckBox,
                          activeColor: Color(0xffFE3C3C),
                          onChanged: (value) {
                            setState(() {
                              valueCheckBox = !valueCheckBox;
                            });
                          })
                    ],
                  ),
                ),
                Container(
                  height: 10,
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
          ),
          BlocListener(
            bloc: context.read<AddressBloc>(),
            listener: (context, state) {
              if (state is AddSuccessAddress) {
                context.read<AddressBloc>().add(InitialAddressEvent(userId: widget.userId));
                Navigator.of(context).pop();
              }

            },
            child: InkWell(
              onTap: () {
                context.read<AddressBloc>().add(AddNewAddressEvent(
                    userId: widget.userId,
                    name: txtName.text,
                    specificAddress: txtSpecificAddress.text,
                    numberPhone: txtNumberPhone.text,
                    defaultIs: valueCheckBox,
                    ward: wardValue.toString()));
              },
              child: Container(
                height: 70,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: Color(0xffF34646),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0),
                          spreadRadius: 1,
                          blurRadius: 2)
                    ]),
                child: Center(
                  child: Text(
                    "Thêm địa chỉ mới",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
