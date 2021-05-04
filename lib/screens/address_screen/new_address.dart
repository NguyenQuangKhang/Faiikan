import 'package:faiikan/widgets/intput_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewAddressScreen extends StatefulWidget {
  @override
  _NewAddressScreenState createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  bool valueCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Địa chỉ của tôi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
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
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.end,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                    Text(
                      "Chọn",
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
                    Text(
                      "Chọn",
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
                    Text(
                      "Chọn",
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
    );
  }
}
