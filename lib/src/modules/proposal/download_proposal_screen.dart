import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';
import 'package:passaqui/src/shared/widget/button.dart';

class DownloadProposalScreen extends StatefulWidget {
  static const String route = "/download-proposal";

  const DownloadProposalScreen({super.key});

  @override
  State<DownloadProposalScreen> createState() => _DownloadProposalScreenState();
}

class _DownloadProposalScreenState extends State<DownloadProposalScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 96, 73, 1),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                  },
                ),
              ],
            ),
            Expanded(
              child: SvgPicture.asset(
                'assets/images/receive-money.svg', // Replace with your SVG asset path
                height: 300, // Adjust the height as needed
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 22.0),
              child: const Text(
                  'Agora falta pouco!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.5
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'Em instantes, você receberá seu contrato pelo e-mail cadastrado!\n\n Caso deseje fazer o download do mesmo, clique em Baixar Contrato.',
                // + '\n\n Assim que tiver o contrato ja salvo em seu celular, clique em Finalizar Proposta para finalizarmos seu processo!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.5
                ),
              ),
            ),
               const SizedBox(height: 40),
               Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 200),
                        child: PassaquiButton(
                          label: "Baixar Contrato",
                          centerText: true,
                          minimumSize: const Size(200, 40),
                          style: PassaquiButtonStyle.defaultLight,
                          onTap: () {
                          },
                        ),
                      ),
                    )),
              ),
            // Container(
            //   padding:
            //   const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            //   child: Align(
            //       alignment: Alignment.bottomCenter,
            //       child: SizedBox(
            //         width: double.infinity,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 0),
            //           child: PassaquiButton(
            //             label: "Finalizar Proposta",
            //             centerText: true,
            //             minimumSize: const Size(200, 40),
            //             style: PassaquiButtonStyle.invertedPrimary,
            //             onTap: () {
            //             },
            //           ),
            //         ),
            //       )),
            // ),
          ],
        ),
      ),
    );
  }
}