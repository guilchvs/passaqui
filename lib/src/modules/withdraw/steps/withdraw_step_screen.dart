import 'package:flutter/material.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/shared/widget/text_button.dart';

class WithdrawStepsScreen extends StatefulWidget {
  static const String route = "/withdraw-how-to";

  const WithdrawStepsScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawStepsScreen> createState() => _WithdrawStepsScreenState();
}

class _WithdrawStepsScreenState extends State<WithdrawStepsScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  List<WithdrawStepItem> steps = [
    WithdrawStepItem(
      step: 1,
      title: "1. Libere o seu Saque-Aniversário",
      image: "assets/images/withdraw/withdraw_one.png",
      description:
      "Para liberar o Saque aniversário é preciso que tenha o aplicativo do FGTS, baixe pelo App store ou google store do seu celular. \n\n- Se você ainda não liberou a modalidade Saque-Aniversário no aplicativo FGTS, preparamos um passo a passo para te apoiar.\nClique em entrar no aplicativo \n- Caso já tenha a modalidade liberada, falta apenas liberar nosso banco, clique aqui e veja como autorizar.",
    ),
    WithdrawStepItem(
      step: 2,
      title: "2. Logue no aplicativo do FGTS",
      image: "assets/images/withdraw/withdraw_two.png",
      description:
      "- Digite seus dados e clique em entrar; \n- Caso seja seu primeiro acesso, clique em cadastre-se e siga o passo a passo da Caixa.",
    ),
    WithdrawStepItem(
      step: 3,
      title: "3. No menu inicial",
      image: "assets/images/withdraw/withdraw_three.png",
      description: "Clique no saque aniversário.",
    ),
    WithdrawStepItem(
      step: 4,
      title: "4. Confirme em autorizar e optar pelo Saque-Aniversário",
      image: "assets/images/withdraw/withdraw_four.png",
      description:
      "Clique no aceite e optar pelo saque aniversário. \n\nConfirme e clique em continuar, a caixa vai pedir para cadastrar seu banco e opções de como quer sacar. Siga os passos indicados até a sua solicitação ser processada com sucesso!",
    ),
    WithdrawStepItem(
      step: 5,
      title: "5. Autorizando o banco BMP",
      image: "assets/images/withdraw/withdraw_five.png",
      description:
      "- Tudo certo com a opção do Saque FGTS, você precisa autorizar o banco a consultar seus dados e limite liberado pela caixa; \n- Novamente no menu principal, clique no botão Autorizar bancos a consultarem seu FGTS.",
    ),
    WithdrawStepItem(
      step: 6,
      title: "6. Autorize o Saque-Aniversário",
      image: "assets/images/withdraw/withdraw_six.png",
      description:
      "- Clique em Empréstimo Saque Aniversário na seta que indica a direita; \n- Na sequência clique em visualizar o termo;\n- Clique no aceite e no botão continuar.",
    ),
    WithdrawStepItem(
      step: 7,
      title: "7. Procure o Banco BMP Sociedade de crédito direto S.A",
      image: "assets/images/withdraw/withdraw_seven.png",
      description:
      "- Digite BMP em buscar banco; \n- Seleciona o Banco BMP;\n- Clique em continuar;\n- Clique em confirmar seleção.\n\nPronto, você autorizou o BMP!\nDentro de 24 horas entre no Aplicativo e solicite seu empréstimo!",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 32),
          Text(
            "Como realizar a contratação?",
            style: TextStyle(
              fontSize: 22,
              color: Color(0xFF1E1E1E),
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 22),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return steps[index];
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 78, vertical: 48),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PassaquiTextButton(
                    isLeading: true,
                    label: "Anterior",
                    textColor: Color(0xFF1E1E1E),
                    arrowColor: Color(0xFF126049),
                    onTap: () {
                      if (_pageController.page?.toInt() != 0) {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                    PassaquiTextButton(
                      label: "Próxima",
                      textColor: Color(0xFF1E1E1E),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      arrowColor: Color(0xFF126049),
                      onTap: () {
                        int? lastPage = _pageController.page?.toInt();
                        if (lastPage == steps.length - 1) {
                          DIService()
                              .inject<NavigationHandler>()
                              .navigate(HomeScreen.route);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WithdrawStepItem extends StatelessWidget {
  final int step;
  final String title;
  final String image;
  final String description;

  const WithdrawStepItem({
    required this.step,
    required this.title,
    required this.image,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$step.",
            style: const TextStyle(
              fontSize: 22,
              color: Color(0xFF136048),
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF136048),
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 32),
          Image.asset(
            image,
            height: 270,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF1E1E1E),
                fontFamily: 'Raleway',
              ),
              children: _buildDescription(description, step),
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildDescription(String description, int step) {
    final List<String> boldTexts = [
      "clique aqui e veja como autorizar",
      "Autorizar bancos a consultarem seu FGTS",
      "visualizar o termo",
      "continuar"
    ];

    const boldStyle = TextStyle(fontWeight: FontWeight.bold);
    const regularStyle = TextStyle(fontWeight: FontWeight.normal);

    List<String> stepBoldTexts = [];
    if (step == 1) {
      stepBoldTexts.add(boldTexts[0]);
    } else if (step == 5) {
      stepBoldTexts.add(boldTexts[1]);
    } else if (step == 6) {
      stepBoldTexts.add(boldTexts[2]);
      stepBoldTexts.add(boldTexts[3]);
    }

    List<TextSpan> textSpans = [];
    String remainingText = description;

    for (String boldText in stepBoldTexts) {
      List<String> splitText = remainingText.split(boldText);
      for (int i = 0; i < splitText.length - 1; i++) {
        textSpans.add(TextSpan(text: splitText[i], style: regularStyle));
        textSpans.add(TextSpan(text: boldText, style: boldStyle));
      }
      remainingText = splitText.last;
    }

    textSpans.add(TextSpan(text: remainingText, style: regularStyle));
    return textSpans;
  }
}

