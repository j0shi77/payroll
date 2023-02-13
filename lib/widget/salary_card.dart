import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardEarns extends StatelessWidget {
  const CardEarns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              children: [
                Card(
                  elevation: 0,
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.monetization_on_rounded,color: Colors.white,),
                        title: Text('Pendapatan', style: TextStyle(color: Colors.white, fontSize: 18),),
                        tileColor: Color(0xFF1151DD)
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        title: Text('Gaji Pokok', style: TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 14),),
                        trailing: Text("Rp. 7.000.000", style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w600),),
                        tileColor: Color.fromARGB(255, 252, 252, 252),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color:Color.fromARGB(255, 211, 211, 211), width: 1),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class CardCashOut extends StatelessWidget {
  const CardCashOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              children: [
                Card(
                  elevation: 0,
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.monetization_on_rounded,color: Colors.white,),
                        title: Text('Pengurangan', style: TextStyle(color: Colors.white, fontSize: 18),),
                        tileColor: Color(0xFF1151DD)
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        title: Text('Jumlah', style: TextStyle(color: Color.fromARGB(255, 112, 112, 112), fontSize: 14),),
                        trailing: Text("-", style: TextStyle(fontSize: 20, color: Colors.black,fontWeight: FontWeight.w600),),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color:Color.fromARGB(255, 211, 211, 211), width: 1),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}