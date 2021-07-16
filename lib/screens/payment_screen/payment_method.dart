import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7E7E7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.red.withOpacity(0.7),
        ),
        title: Text(
          "Phương thức thanh toán",
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
              color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: RichText(
              text: TextSpan(
                  text: "Thanh Toán ",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      color: Colors.black.withOpacity(0.7)),
                  children: <TextSpan>[
                    TextSpan(
                      text: "FAIIKAN",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        color: Color(0xffEF5454),
                      ),
                    ),
                  ]),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Thanh toán bằng ví")
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Colors.grey,
                      size: 20,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){Navigator.of(context).pop("VCB - *099*");},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        "https://play-lh.googleusercontent.com/hRq2DVKkzBXQkyftxr0e2ytl0fS2hEWx3UTe3V652RfJVYWqVRGgBNhmZgqNzJ8PKHE",
                                        fit: BoxFit.fill,
                                        height: 30,
                                        width: 30,
                                      ),
                                      SizedBox(width: 10,),
                                      Text("VCB",style: TextStyle(color: Colors.grey,letterSpacing: 0.5,fontSize: 15,fontWeight: FontWeight.w400),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("*099*",style:TextStyle(color: Colors.black.withOpacity(0.7),letterSpacing: 0.5,fontSize: 15,fontWeight: FontWeight.w400) ,),
                                      SizedBox(width: 10,),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Divider(height: 1,thickness: 1,color: Color(0xffC4C4C4).withOpacity(0.5),),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.add,color: Colors.blue,size: 30,),
                                    SizedBox(width: 10,),
                                    Text("Thêm tài khoản liên kết ngân hàng",style: TextStyle(color: Colors.grey,letterSpacing: 0.5,fontSize: 15,fontWeight: FontWeight.w400),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("",style:TextStyle(color: Colors.black.withOpacity(0.7),letterSpacing: 0.5,fontSize: 15,fontWeight: FontWeight.w400) ,),
                                    SizedBox(width: 10,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 1,thickness: 1,color: Color(0xffC4C4C4).withOpacity(0.5),),
                        ],
                      ),
                    ),

                  ],
                ),
                InkWell( onTap: (){Navigator.of(context).pop("Thẻ tín dụng\n/Ghi nợ");},
                  child: Container(padding: EdgeInsets.symmetric(vertical: 8),child: Row(children: [
                    Icon(Icons.credit_card,color: Colors.blueAccent,size: 25,),
                    SizedBox(width: 10,),
                    Text("Thẻ tín dụng/Ghi nợ",style: TextStyle(color: Colors.black,letterSpacing: 0.5,fontSize: 17,fontWeight: FontWeight.w400),),
                  ],),),
                ),
                Divider(height: 1,thickness: 1,color: Color(0xffC4C4C4).withOpacity(0.5),),    InkWell(

                    onTap: (){Navigator.of(context).pop("Thẻ ATM \nnội địa");},

                  child: Container(padding: EdgeInsets.symmetric(vertical: 8),child: Row(children: [
                    Icon(Icons.food_bank_outlined,color: Colors.lightGreen,size: 25,),
                    SizedBox(width: 10,),
                    Text("Thẻ ATM nội địa (Internet Banking)",style: TextStyle(color: Colors.black,letterSpacing: 0.5,fontSize: 17,fontWeight: FontWeight.w400),),
                  ],),),
                ),
                Divider(height: 1,thickness: 1,color: Color(0xffC4C4C4).withOpacity(0.5),),   InkWell(
                  onTap: (){Navigator.of(context).pop("Thanh toán \n khi nhận hàng");},
                  child: Container(padding: EdgeInsets.symmetric(vertical: 8),child: Row(children: [
                    Icon(Icons.delivery_dining,color: Colors.lightGreen,size: 25,),
                    SizedBox(width: 10,),
                    Text("Thanh toán khi nhận hàng",style: TextStyle(color: Colors.black,letterSpacing: 0.5,fontSize: 17,fontWeight: FontWeight.w400),),
                  ],),),
                ),
                Divider(height: 1,thickness: 1,color: Color(0xffC4C4C4).withOpacity(0.5),),

              ],
            ),
          )
        ],
      ),
    );
  }
}
