import 'package:flutter/material.dart';

class GoogleAndFacebookLogin extends StatelessWidget {
  final VoidCallback onTapLoginGoogle;
  final VoidCallback onTapLoginFacebook;
  final bool isLogin;

  const GoogleAndFacebookLogin({ this.isLogin = false, required this.onTapLoginGoogle,required this.onTapLoginFacebook});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Container(height: 1,color: Color(0xffEBF0FF),),),
            SizedBox(width: 15,),
            Center(
              child: Text(
                "Hoặc",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 16,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(child: Container(height: 1,color: Color(0xffEBF0FF),),),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        InkWell(
          onTap: onTapLoginGoogle,
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffEBF0FF),
              ),
            ),
            child: Center(
                child: Row(
                  children: [
                    Image.network(
                      "http://assets.stickpng.com/images/5847f9cbcef1014c0b5e48c8.png",
                      height: 35,
                      width: 35,
                      fit: BoxFit.contain,
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Text(
                            isLogin?"Đăng nhập bằng Google":"Đăng ký bằng Google",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: onTapLoginFacebook,
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffEBF0FF),
              ),
            ),
            child: Center(
                child: Row(
                  children: [
                    Image.network(
                      "https://www.vippng.com/png/detail/90-905721_facebook-facebook-lite-icon-png.png",
                      height: 35,
                      width: 35,
                      fit: BoxFit.contain,
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Text(
                            isLogin?"Đăng nhập bằng Facebook":"Đăng ký bằng Facebook",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
