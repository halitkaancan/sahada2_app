import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Services/global_variables.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  final TextEditingController _fullNameController =TextEditingController(text: " ");
  final TextEditingController _emailTextController =TextEditingController(text: " ");
  final TextEditingController _passTextController = TextEditingController(text: " ");
  final TextEditingController _phoneNumberController = TextEditingController(text: " ");



  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _positionCPFocusNode = FocusNode();



  final _signUpFromKey = GlobalKey<FormState>();
  bool _obscureText =true;
  File? imageFile;
  bool _isLoading= false;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {})
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: signUpUrlImage,
            placeholder: (context, url) => Image.asset(
              "sahada_assets/images/wallpaper.jpg",
              fit: BoxFit.fill,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Container(
              color: Colors.black54,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 80),
                child: ListView(
                  children: [
                    Form(
                      key: _signUpFromKey,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              //create ShowImageDialog
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: size.width * 0.24,
                                  height: size.height * 0.24,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.cyanAccent,
                                    ),
                                    borderRadius: BorderRadius.circular(200),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: imageFile == null
                                          ? const Icon(
                                              Icons.camera_enhance_sharp,
                                              color: Colors.cyan,
                                              size: 30,
                                            )
                                          : Image.file(
                                              imageFile!,
                                              fit: BoxFit.fill,
                                            ))),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //name
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_emailFocusNode),
                            keyboardType: TextInputType.name,
                            controller: _fullNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Bu alan eksik";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Full name',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //email
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passFocusNode),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTextController,
                            validator: (value) {
                              if (value!.isEmpty || !value.contains("@")) {
                                return "Lütfen geçerli bir email adresi giriniz";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //password
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context).requestFocus(_phoneNumberFocusNode),

                            keyboardType: TextInputType.visiblePassword,
                            controller: _passTextController,
                            obscureText: ! _obscureText,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return "Lütfen geçerli bir sifre giriniz";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration:  InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap:(){
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,

                                ),
                              ),
                              hintText: 'Şifre',
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder:const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder:const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context) .requestFocus(_positionCPFocusNode),
                            keyboardType: TextInputType.phone,
                            controller:_phoneNumberController ,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Lütfen  bir telefon numarası giriniz";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Telefon numarası',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),

                          const SizedBox(height: 25,),
                          _isLoading
                          ?
                              Center(
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                              :
                              MaterialButton(
                                onPressed: (){
                                  //Create submitFormOnSignUp
                                },
                                color:Colors.cyan ,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14, ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Kayıt Ol',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                  ),

                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          const SizedBox(height: 40,),
                          Center(
                            child: RichText(
                              text:  TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Zaten bir hesabınız var mı?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )
                                  ),
                                  TextSpan(
                                    text: '       '
                                  ),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                        ..onTap = () => Navigator.canPop(context)
                                        ? Navigator.pop(context)
                                            : null,
                                    text: 'Giriş',
                                      style: TextStyle(
                                        color: Colors.cyan,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )

                                  )
                                ]
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
