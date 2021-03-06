import 'package:faiikan/blocs/address_bloc/address_bloc.dart';
import 'package:faiikan/blocs/address_bloc/address_event.dart';
import 'package:faiikan/blocs/address_bloc/address_state.dart';
import 'package:faiikan/screens/address_screen/choose_unit_screen.dart';
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
    context.read<AddressBloc>().selectedProvice = null;
    context.read<AddressBloc>().selectedWard = null;
    context.read<AddressBloc>().selectedDistric = null;
    context.read<AddressBloc>().districts = [];
    context.read<AddressBloc>().wards = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: context.read<AddressBloc>(),
      listener: (context,state){
        if(state is InitialAddressState)
          setState(() {
          });
      },
      child: Scaffold(
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Họ & Tên",
                              children: <InlineSpan>[
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {});
                              },
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
                    if (txtName.text.isEmpty)
                      Column(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Text(
                              "Vui lòng điền phần bắt buộc",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                letterSpacing: 0.5,
                              ),
                            ),
                          )
                        ],
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
                          Text.rich(
                            TextSpan(
                              text: "Số điện thoại",
                              children: <InlineSpan>[
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextFormField(
                              controller: txtNumberPhone,
                              onChanged: (value) {
                                setState(() {});
                              },
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
                    if (txtNumberPhone.text.isEmpty)
                      Column(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Text(
                              "Vui lòng điền phần bắt buộc",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                                letterSpacing: 0.5,
                              ),
                            ),
                          )
                        ],
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                          value: context.read<AddressBloc>(),
                                          child: ChooseProvinceScreen())));
                            },
                            child: Row(
                              children: [
                                Text(
                                  context.read<AddressBloc>().selectedProvice ==
                                          null
                                      ? "Chọn Tỉnh/Thành phố"
                                      : context
                                          .read<AddressBloc>()
                                          .provinces[context
                                              .read<AddressBloc>()
                                              .selectedProvice!]
                                          .name,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 20,
                                  color: Colors.black.withOpacity(0.5),
                                )
                              ],
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
                          InkWell(
                            onTap: () {
                              if(context.read<AddressBloc>().selectedProvice!=null)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                          value: context.read<AddressBloc>(),
                                          child: ChooseDistrictScreen())));
                              else
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Vui lòng chọn tỉnh/thành phố trước."),
                                ));
                            },
                            child: Row(
                              children: [
                                Text(
                                  context.read<AddressBloc>().selectedDistric ==
                                          null
                                      ? "Chọn Quận/Huyện"
                                      : context
                                          .read<AddressBloc>()
                                          .districts[context
                                              .read<AddressBloc>()
                                              .selectedDistric!]
                                          .name,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 20,
                                  color: Colors.black.withOpacity(0.5),
                                )
                              ],
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
                          InkWell(
                            onTap: () {
                              if(context.read<AddressBloc>().selectedDistric!=null)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                          value: context.read<AddressBloc>(),
                                          child: ChooseWardScreen())));
                              else  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Vui lòng chọn Quận/Huyện trước."),
                              ));
                            },
                            child: Row(
                              children: [
                                Text(
                                  context.read<AddressBloc>().selectedWard == null
                                      ? "Chọn Phường/Xã"
                                      : context
                                          .read<AddressBloc>()
                                          .wards[context
                                              .read<AddressBloc>()
                                              .selectedWard!]
                                          .name,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 20,
                                  color: Colors.black.withOpacity(0.5),
                                )
                              ],
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
            ),
            BlocListener(
              bloc: context.read<AddressBloc>(),
              listener: (context, state) {
                if (state is AddSuccessAddress) {
                  context
                      .read<AddressBloc>()
                      .add(InitialAddressEvent(userId: widget.userId));
                  Navigator.of(context).pop();
                }
              },
              child: InkWell(
                onTap: () {
                  if (txtName.text.isNotEmpty && txtNumberPhone.text.isNotEmpty) {
                    if (context.read<AddressBloc>().selectedWard == null)
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Vui lòng chọn địa chỉ trước khi hoàn tất."),
                      ));
                    else
                    context.read<AddressBloc>().add(AddNewAddressEvent(
                        userId: widget.userId,
                        name: txtName.text,
                        specificAddress: txtSpecificAddress.text,
                        numberPhone: txtNumberPhone.text,
                        defaultIs: valueCheckBox,
                        ward: context
                            .read<AddressBloc>()
                            .wards[context
                            .read<AddressBloc>()
                            .selectedWard!].id.toString()));
                  }

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
      ),
    );
  }
}
