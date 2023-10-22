import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../tabbar.dart';
import '../../images.dart';

final _checkboxProvider = StateProvider<bool>((ref) => false);
final _showPasswordProvider = StateProvider<bool>((ref) => false);

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isChecked = ref.watch(_checkboxProvider);
    final bool showPassword = ref.watch(_showPasswordProvider);

    final licenseCheckWidget = Container(
      padding: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: Checkbox(
              value: isChecked,
              onChanged: (_) {
                ref.read(_checkboxProvider.notifier).state = !isChecked;
              },
            ),
          ),
          Flexible(
            child: RichText(
              maxLines: 2,
              text: TextSpan(
                text: '我已阅读并同意 ',
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  const TextSpan(
                    text: '软件许可及服务协议',
                    style: TextStyle(color: Colors.blue),
                  ),
                  const TextSpan(text: ' 和 '),
                  TextSpan(
                    text: '隐私政策',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    final thirdAuthWidget = [
      const SizedBox(height: 20),
      Row(
        children: [
          const Expanded(child: Divider()),
          const SizedBox(width: 8),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 60,
            ),
            child: const Text(
              maxLines: 3,
              '第三方账号授权登录',
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Divider()),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(LoginImages.login_method_apple, width: 40, height: 40),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: Image.asset(LoginImages.login_method_wechat, width: 40, height: 40),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: Image.asset(LoginImages.login_method_xiaomi, width: 40, height: 40),
          ),
        ],
      ),
    ];

    final buttonsWidget = [
      Row(
        children: [
          TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
            onPressed: () {},
            child: const Text("忘记密码?"),
          ),
          const Spacer()
        ],
      ),
      ElevatedButton(
        onPressed: () => _loginButtonTapped(context),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: const Text('登录'),
        ),
      ),
      const SizedBox(height: 10),
      OutlinedButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: const Text('注册'),
        ),
      ),
    ];

    final textFieldWidget = [
      const SizedBox(height: 20),
      TextField(
        decoration: InputDecoration(
          hintText: "请输入手机号/邮箱号",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        style: Theme.of(context).textTheme.labelLarge,
      ),
      const SizedBox(height: 20),
      TextField(
        obscureText: !showPassword,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () => ref.read(_showPasswordProvider.notifier).state = !showPassword,
            icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
          ),
          hintText: "请输入密码",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        style: Theme.of(context).textTheme.labelLarge,
      ),
    ];

    return Stack(
      children: [
        Positioned.fill(child: Image.asset(LoginImages.bg_light, fit: BoxFit.cover)),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(LoginImages.logo, width: 60, height: 60),
                      ...textFieldWidget,
                      ...buttonsWidget,
                      ...thirdAuthWidget,
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: licenseCheckWidget,
              )
            ],
          ),
        ),
      ],
    );
  }

  void _loginButtonTapped(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return const MainTabBar();
      }),
    );
  }
}
