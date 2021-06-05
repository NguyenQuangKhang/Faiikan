import 'package:faiikan/blocs/address_bloc/address_bloc.dart';
import 'package:faiikan/blocs/address_bloc/address_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseProvinceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: context.read<AddressBloc>().provinces.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: (){
                         context.read<AddressBloc>().add(ChooseUnitAddressEvent(index: index, type: "province"));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      context.read<AddressBloc>().provinces[index].name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontSize: 16),
                    ),
                  ),
                ),
                Divider(height: 1,color: Colors.black.withOpacity(0.2),thickness: 1,),
              ],
            );
          }),
    );
  }
}
