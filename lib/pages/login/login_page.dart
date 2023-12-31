import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../../tabbar.dart';
import '../../images.dart';

final _checkboxProvider = StateProvider<bool>((ref) => false);
final _showPasswordProvider = StateProvider<bool>((ref) => false);
final _accountTextProvider = StateProvider<String>((ref) => "");
final _passswordTextProvider = StateProvider<String>((ref) => "");
final _loginButtonEnabledProvider = Provider((ref) {
  final String accountText = ref.watch(_accountTextProvider);
  final String passwordText = ref.watch(_passswordTextProvider);
  return accountText.length >= 6 && passwordText.length >= 6;
});

final _showClearAccounTextIcontProvider = Provider<bool>((ref) {
  final accountText = ref.watch(_accountTextProvider);
  return accountText.isNotEmpty;
});

final _showClearPasswordTextIcontProvider = Provider<bool>((ref) {
  final passwordText = ref.watch(_passswordTextProvider);
  return passwordText.isNotEmpty;
});

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final _accountTexttextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isChecked = ref.watch(_checkboxProvider);
    final bool showPassword = ref.watch(_showPasswordProvider);
    final bool loginButtonEnabled = ref.watch(_loginButtonEnabledProvider);
    final bool showClearAccountTextIcon = ref.watch(_showClearAccounTextIcontProvider);
    final bool showClearPasswordTextIcon = ref.watch(_showClearPasswordTextIcontProvider);

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
        onPressed: loginButtonEnabled ? () => _loginButtonTapped(context) : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.blue,
          disabledBackgroundColor: Colors.blue.withAlpha(100),
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
        controller: _accountTexttextController,
        onChanged: (value) => ref.read(_accountTextProvider.notifier).state = value,
        decoration: InputDecoration(
          suffixIcon: !showClearAccountTextIcon
              ? null
              : IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _accountTexttextController.clear();
                    ref.read(_accountTextProvider.notifier).state = '';
                  }),
          hintText: "请输入手机号/邮箱号",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        style: Theme.of(context).textTheme.labelLarge,
      ),
      const SizedBox(height: 20),
      TextField(
        controller: _passwordTextController,
        onChanged: (value) => ref.read(_passswordTextProvider.notifier).state = value,
        obscureText: !showPassword,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showClearPasswordTextIcon)
                IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _passwordTextController.clear();
                      ref.read(_passswordTextProvider.notifier).state = '';
                    }),
              IconButton(
                onPressed: () => ref.read(_showPasswordProvider.notifier).state = !showPassword,
                icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
              ),
            ],
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
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
              ),
              backgroundColor: Colors.transparent,
            ),
            body: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
        ),
      ],
    );
  }

  void _goHomePage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return const MainTabBar();
      }),
    );
  }

  void _loginButtonTapped(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    FocusManager.instance.primaryFocus?.unfocus();

    var url = Uri.https('dummyjson.com', 'auth/login');
    var response = await http.post(
      url,
      body: {'username': 'kminchelle', 'password': '0lelplR'},
    );

    EasyLoading.dismiss();

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      _goHomePage(context);
    } else {
      EasyLoading.showError('Login failed');
    }
  }
}
