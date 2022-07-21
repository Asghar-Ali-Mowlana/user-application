import 'package:flutter/material.dart';
import 'package:user_app/pages/home/view/home_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String market = "Lebanon";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF3f3f37),
                Color(0xFF3d3d37),
                Color(0xFF434335),
                Color(0xFF4f4f2f),
                Color(0xFF57572d),
                Color(0xFF636329),
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 8,
                ),
                child: Image.asset(
                  "assets/logo",
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 10),
                    child: const Text(
                      "Hello",
                      style: TextStyle(
                        color: Color(0xFFfdfe00),
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                    child: Divider(
                      color: Color(0xFFfdfe00),
                      thickness: 3,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 30),
                    child: Text(
                      "Choose your market",
                      style: TextStyle(color: Color(0xFFfdfe00), fontSize: 15),
                    ),
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        this.market = "Lebanon";
                      });
                      print(market);
                    }),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            "assets/lebanon",
                            width: MediaQuery.of(context).size.width / 12,
                          ),
                          Container(
                            height: 38,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: market == "Lebanon"
                                  ? const Color(0xFFffc922)
                                  : Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Lebanon",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        this.market = "United Arab Emirates";
                      });
                      print(market);
                    }),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            "assets/uae",
                            width: MediaQuery.of(context).size.width / 12,
                          ),
                          Container(
                            height: 38,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: market == "United Arab Emirates"
                                  ? const Color(0xFFffc922)
                                  : Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "United Arab Emirates",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFffc922),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        textStyle: const TextStyle(fontSize: 16)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                      );
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
