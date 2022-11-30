import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sahada2_app/Jobs/jobs_screen.dart';
import 'package:sahada2_app/Profile/user_profile.dart';
import 'package:sahada2_app/Search/search_companies.dart';

class BottomNavigationBarForApp extends StatelessWidget {

  int indexNum = 0;

  BottomNavigationBarForApp ({required this.indexNum});
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Colors.black26,
      backgroundColor: Colors.black26,
      buttonBackgroundColor: Colors.white70,
      height: 50,
      index: indexNum,
      items: const[
        Icon(Icons.home, size :19, color: Colors.black,),
        Icon(Icons.add, size: 19, color: Colors.black,),
        Icon(Icons.person, size: 19, color: Colors.black,),

      ],

      animationDuration: const Duration(
        milliseconds: 300
      ),
      animationCurve: Curves.bounceInOut,
      onTap: (index){
        if(index==0){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => JobScreen()));
        }
        else if(index ==1){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AllWorkersSecreen()));

        }
        else if(index ==2){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => UserProfile()));

        }
      },
    );
  }
}
