import 'package:flutter/material.dart';
import 'package:passaqui/src/core/di/service_locator.dart';
import 'package:passaqui/src/core/navigation/navigation_handler.dart';
import 'package:passaqui/src/modules/home/home_page.dart';
import 'package:passaqui/src/modules/withdraw/welcome/withdraw_welcome_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/text_button.dart';

class WithdrawStepsScreen extends StatefulWidget {
  static const String route = "/withdraw-how-to";

  const WithdrawStepsScreen({super.key});

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
    const WithdrawStepItem(
      step: 1,
      title: "Libere o seu Saque-Aniversário",
      image: "assets/images/withdraw/withdraw_one.png",
      description: "Para liberar o Saque aniversário é preciso que tenha o aplicativo do FGTS, baixe pelo App store ou google store do seu celular. \n- Se você ainda não liberou a modalidade Saque-Aniversário no aplicativo FGTS, preparamos um passo a passo para te apoiar.\nClique em entrar no aplicativo \n- Caso já tenha a modalidade liberada, falta apenas liberar nosso banco, clique aqui e veja como autorizar.",
    ),
    const WithdrawStepItem(
      step: 2,
      title: "Logue no aplicativo do FGTS",
      image: "assets/images/withdraw/withdraw_two.png",
      description: "- Digite seus dados e clique em entrar; \n- Caso seja seu primeiro acesso, clique em cadastre-se e siga o passo a passo da Caixa.",
    ),
    const WithdrawStepItem(
      step: 3,
      title: "No menu inicial",
      image: "assets/images/withdraw/withdraw_three.png",
      description: "Clique no saque aniversário.",
    ),
    const WithdrawStepItem(
      step: 4,
      title: "Confirme em autorizar e optar pelo Saque-Aniversário",
      image: "assets/images/withdraw/withdraw_four.png",
      description: "Clique no aceite e optar pelo saque aniversário. \nConfirme e clique em continuar, a caixa vai pedir para cadastrar seu banco e opções de como quer sacar. Siga os passos indicados até a sua solicitação ser processada com sucesso!",
    ),
    const WithdrawStepItem(
      step: 5,
      title: "Autorizando o banco BMP",
      image: "assets/images/withdraw/withdraw_five.png",
      description: "- Tudo certo com a opção do Saque FGTS, você precisa autorizar o banco a consultar seus dados e limite liberado pela caixa; \n- Novamente no menu principal, clique no botão Autorizar bancos a consultarem seu FGTS.",
    ),
    const WithdrawStepItem(
      step: 6,
      title: "Autorizei o Saque-Aniversário",
      image: "assets/images/withdraw/withdraw_six.png",
      description: "- Clique em Empréstimo Saque Aniversário na seta que indica a direita; \n- Na sequência clique em visualizar o termo;\n- Clique no aceite e no botão continuar.",
    ),
    const WithdrawStepItem(
      step: 7,
      title: "Procure o Banco BMP Sociedade de crédito direto S.A",
      image: "assets/images/withdraw/withdraw_seven.png",
      description: "- Digite BMP em buscar banco; \n- Seleciona o Banco BMP;\n- Clique em continuar;\n- Clique em confirmar seleção.\nPronto, você autorizou o BMP!\nDentro de 24 horas entre no Aplicativo e solicite seu empréstimo!",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          const Text(
            "Como realizar a contratação?",
            style: TextStyle(
                fontSize: 22,
                color: Color(0xFF136048),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: steps.length,
                itemBuilder: (context, index){
                  return steps[index];
                }
              )
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24
              ),
              child: Row(
                children: [
                  PassaquiTextButton(
                    isLeading: true,
                    label: "Anterior",
                    onTap: (){
                      _pageController.jumpToPage((_pageController.page?.toInt() ?? 0) - 1);
                    },
                  ),
                  const Spacer(),
                  PassaquiTextButton(
                    label: "Próximo",
                    onTap: (){
                      int? lastPage = _pageController.page?.toInt();
                      if(lastPage == steps.length -1) {
                        DIService().inject<NavigationHandler>().navigate(HomeScreen.route);
                      }
                      else{
                        _pageController.jumpToPage((_pageController.page
                            ?.toInt() ?? 0) + 1);
                      }
                    },
                  )
                ],
              ),
            )
          )
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
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$step.",
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF136048),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700),
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                color: Color(0xFF136048),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 32,),
          Image.asset(image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24,),
          Text(description,
            style: TextStyle(
                fontSize: 14,
                color: Color(0xFF1E1E1E),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
