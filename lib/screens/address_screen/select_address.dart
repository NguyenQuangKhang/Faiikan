import 'package:faiikan/blocs/address_bloc/address_bloc.dart';
import 'package:faiikan/blocs/address_bloc/address_event.dart';
import 'package:faiikan/blocs/address_bloc/address_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_address.dart';

class SelectAddressScreen extends StatefulWidget {
  final String userId;

  const SelectAddressScreen({required this.userId});

  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddressScreen> {
  int selected = 0;
  int defaultIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        title: Text(
          "Chọn địa chỉ nhận hàng",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value:  context.read<AddressBloc>(),
                        child: MyAddressScreen(
                              userId: widget.userId,
                            ),
                      )));
            },
            child: Center(
              child: Text(
                "Sửa",
                style: TextStyle(
                  color: Color(0xffFE3C3C),
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body:  BlocBuilder<AddressBloc,AddressState>(builder: (context,state){
        if(state is LoadAddress)
          return Center(child: CircularProgressIndicator(backgroundColor: Colors.redAccent,),);
        return Column(
          children: [

            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: context.read<AddressBloc>().myAddresses.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.read<AddressBloc>().add(ChangeCurrentAddressEvent(index: index));
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  spacing: 10,
                                  direction: Axis.vertical,
                                  children: [
                                    Row(
                                      children: [

                                        if (context.read<AddressBloc>().myAddresses[index].defaultIs == true)
                                          Text(
                                            "[Mặc định]",
                                            style: TextStyle(
                                              color: Color(0xffF83434),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                      ],
                                    ),
                                    Text(
                                      context.read<AddressBloc>().myAddresses[index].name +
                                          " | " +
                                          context.read<AddressBloc>().myAddresses[index].numberPhone,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      context.read<AddressBloc>().myAddresses[index].specificAddress,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                        context.read<AddressBloc>().myAddresses[index].ward.prefix +" " +context.read<AddressBloc>().myAddresses[index].ward.name+" - "+      context.read<AddressBloc>().myAddresses[index].district.prefix +" " +context.read<AddressBloc>().myAddresses[index].district.name+" - "+ context.read<AddressBloc>().myAddresses[index].province.name,
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                if (context.read<AddressBloc>().myAddresses[index].id == context.read<AddressBloc>().currentAddress!.id)
                                  Icon(
                                    Icons.done_sharp,
                                    size: 25,
                                    color: Color(0xffF62D2D),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 5,
                            color: Colors.black.withOpacity(0.2),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        );
      }),
    );
  }
}
