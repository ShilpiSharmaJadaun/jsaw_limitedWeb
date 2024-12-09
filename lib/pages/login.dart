import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jsaw_limited/routes/app_routes.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../utils/app_color.dart';
import '../bloc/login_bloc.dart';
import '../service/login_service.dart';
import '../state/login_state.dart';
import '../utils/textfiled.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {

  late TextEditingController mobileUserTextController = TextEditingController();
  late TextEditingController mobilePassTextController = TextEditingController();
  late final LoginPageBloc bloc;

  void initState(){
    super.initState();
    final loginService = Provider.of<LoginService>(context, listen: false);
    bloc = LoginPageBloc(loginService);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  Colors.transparent,
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration:
            const BoxDecoration(
              // image: DecorationImage(image: AssetImage("assets/images/photo-collage.png.png",),fit: BoxFit.fill,
              //    colorFilter:  ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
              //     //opacity: 0.2
              // ),
                gradient: LinearGradient(colors: [navyBlue,cream, golden])
            ),
            child: _buildDesktop(),
          ),
        )
    );
  }

  _buildDesktop() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          _buildTabBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_buildMirrorText(), _buildLoginContainer()],
          )
        ],
      ),
    );
  }

  _buildTabBar(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: Row(
                children: [
                  Image.asset("assets/images/jindal-saw-logo.png",scale: 1.5,),
                  // Icon(
                  //   Icons.waving_hand_outlined,
                  //   color: Colors.white,
                  // ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "JINDAL SAW LIMITED",
                      style: TextStyle(color: Colors.white,
                          fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              )),
          const Spacer(flex: 60,),
          // const Padding(
          //   padding:
          //   EdgeInsets.symmetric(vertical: 50, horizontal: 100),
          //   child: Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: Text(
          //       "HARESAMUDRAM " ,maxLines: 5,
          //       textAlign: TextAlign.center,
          //       style: TextStyle(color: kcmegenta,
          //           decoration: TextDecoration.underline,
          //           fontSize: 50,overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),

          const Padding(
            padding:
            EdgeInsets.symmetric(vertical: 50, horizontal: 100),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "KUDATHINI" ,maxLines: 5,
                textAlign: TextAlign.center,
                style: TextStyle(color: kcmegenta,
                    decoration: TextDecoration.underline,
                    fontSize: 50,overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildMirrorText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: 600,
            child: Row(
              children: [
                Image.asset(
                  "assets/images/worker.png",
                  scale: 6,
                ),
                const Text(
                  " SAFETY PORTAL " ,maxLines: 5,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                      decoration: TextDecoration.underline,
                      fontSize: 50,overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: SizedBox(
              width: 500,
              child: Text(
                "Jindal SAW Ltd. is a part of the multi-billion dollar O.P. Jindal Group, one of the country's topmost industry houses and the foremost indigenous steel producers and exporters. It started operation in the year 1984, when it became the first company in India to manufacture Submerged Arc Welded (SAW) Pipes using the internationally acclaimed U-O-E technology."
                ,maxLines: 5,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white,overflow: TextOverflow.ellipsis, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildLoginContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
      child: SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: InputField(
                controller: mobileUserTextController,
                hintText: "Enter User Code",
                icon: Icons.person_outline_rounded, obscureText: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: InputField(
                controller: mobilePassTextController,
                hintText: "Enter Password",
                icon: Icons.password_outlined, obscureText: true,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //   child: TextButton(
            //       onPressed: () {},
            //       child: const Text(
            //         "Forgot Password ?",
            //         style:
            //         TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
            //       )),
            // ),
            _buildLoginButton(),
            _buildDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/images/icons8-facebook-48.png",
                ),
                Image.asset(
                  "assets/images/icons8-insta-48.png",
                ),
                Image.asset(
                  "assets/images/icons8-linkedin-48.png",
                ),
                Image.asset(
                  "assets/images/icons8-youtube-48.png",
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  const Text("Facing any difficulty ?", style: TextStyle(color: navyBlue),),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Contact Us",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: kcRed,
                            decoration: TextDecoration.underline),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildDivider(){
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Center(
          child: Row(
            children: [
              Expanded(flex: 5,child: Divider(height: 3,color: Colors.black,thickness: 2,)),
              Expanded(flex: 1,child: Center(child: Text("Or", style: TextStyle(color: Colors.black),))),
              Expanded(flex: 5,child: Divider(height: 1,color: Colors.black,thickness: 2,)),
            ],
          )
      ),
    );
  }

  _buildLoginButton(){
    return BlocConsumer<LoginPageBloc, LoginState>(
      bloc: bloc,
      listener: (_, state) {
        state.maybeWhen(
            success: (_) {
              // context.go('/dashboard');
              Navigator.pushNamed(context, AppRoutes.dashboardSelection);
            },
            failed: (_, message) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            },
            orElse: () {});
      },
      builder: (context, state) {
        return state.maybeWhen(
          loading: (_) {
            return Lottie.asset("assets/lottie/loading.json",height: 20, width: 20 );
          },
          orElse: () {
            return  Center(
              child: ElevatedButton(
                onPressed: (){
                  if (mobileUserTextController.text.isEmpty || mobilePassTextController.text.isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Please enter both User Code and Password.')));
                    return;
                  }
                 bloc.logIn(mobileUserTextController.text, mobilePassTextController.text);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kcRed,
                    maximumSize: const Size(150, 40),
                    minimumSize: const Size(150, 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Login", style: TextStyle(fontSize: 16,color: kcWhite, fontWeight: FontWeight.w600),),
                ),
              ),
            );
          },
        );
      },
    );
  }


}
