import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:investkuy/ui/screen/visitor/login_choice_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key, required this.title});

  final String title;

  @override
  _RegisterState  createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isObsecurePass1 = true;
  bool isObsecurePass2 = true;
  bool isChecked = false;
  bool register = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image
                Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Image.asset('assets/images/logo.png')
                ),

                Form(
                  child: Column(
                    children: [
                      // Nama
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff146C94)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Nama',
                            hintStyle: TextStyle(
                              color: Color(0xff4A4A4A),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      // Email
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff146C94)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Color(0xff4A4A4A),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      // Username
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff146C94)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Username',
                            hintStyle: TextStyle(
                              color: Color(0xff4A4A4A),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),

                      // Password
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: TextFormField(
                          obscureText: isObsecurePass1,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff146C94)),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                color: Color(0xff4A4A4A),
                                fontSize: 14,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(isObsecurePass1 ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    isObsecurePass1 = !isObsecurePass1;
                                  });
                                },
                              )
                          ),
                        ),
                      ),

                      // Repeat Password
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: TextFormField(
                          obscureText: isObsecurePass2,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff146C94)),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'Masukan kembali password',
                              hintStyle: const TextStyle(
                                color: Color(0xff4A4A4A),
                                fontSize: 14,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(isObsecurePass2 ? Icons.visibility_off : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    isObsecurePass2 = !isObsecurePass2;
                                  });
                                },
                              )
                          ),
                        ),
                      ),

                      // PIN
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: TextFormField(
                          obscureText: true,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff146C94)),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'PIN',
                            hintStyle: TextStyle(
                              color: Color(0xff4A4A4A),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    const Expanded(
                        child: Text('Saya telah menyetujui Syarat & Ketentuan yang berlaku.')
                    )
                  ],
                ),


                // Button Register Now!
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    onPressed:  ()  {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginChoice(title: 'Login'))
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff19A7CE),
                        fixedSize: const Size(double.maxFinite, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    child: const Text(
                      "Daftar Sekarang!",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}