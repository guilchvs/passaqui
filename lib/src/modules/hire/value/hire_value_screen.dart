import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/modules/hire/confirmCpf/confirm_cpf_screen.dart';
import 'package:passaqui/src/modules/hire/installment/installments_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import '../../../shared/widget/button.dart';

class HireValueScreen extends StatefulWidget {
  static const String route = "/hire-value";
  final Map<String, dynamic>? jsonResponse;
  final String cpf;
  final int selectedPeriod;

  const HireValueScreen(
      {Key? key,
      this.jsonResponse,
      required this.cpf,
      required this.selectedPeriod})
      : super(key: key);

  @override
  State<HireValueScreen> createState() => _HireValueScreenState();
}

class _HireValueScreenState extends State<HireValueScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final simulacao = widget.jsonResponse?['Simulacoes'][0];
    final List<dynamic>? parcelas = simulacao?['SimulacaoParcelas'];
    print('Parcelas: $parcelas');

    double? valorDesejado = simulacao['VlrLiberado'];
    double? valorIOF = simulacao['VlrIOF'];
    double? valorFinanciado = simulacao['VlrEmprestimoCliente'];
    double? valorJuros = simulacao['VlrJuros'];
    double? cetMensal = simulacao['TaxaCETMensal'];
    double? cetAnual = simulacao['TaxaCETAnual'];
    double? valorTotal = simulacao['VlrOperacao'];

    return Scaffold(
      appBar: const PassaquiAppBar(showLogo: false, showBackButton: true),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Color.fromRGBO(18, 96, 73, 1),
              height: MediaQuery.of(context).size.height * 0.33,
            ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.33,
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned.fill(
            top: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 16.0),
                  child: Text(
                    'Essa é a proposta ideal para você?',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, top: 22.0, bottom: 10.0),
                  child: Text(
                    'Confirme os dados para a contratação',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 180,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildValueItem('Valor Desejado', valorDesejado),
                          _buildValueItem('Valor do IOF', valorIOF),
                          _buildValueItem('Valor Financiado', valorFinanciado),
                          _buildValueItem('Valor do Juros', valorJuros),
                          _buildCetItem(cetMensal, cetAnual),
                          SizedBox(height: 8),
                          _buildValueItem('Valor total a pagar', valorTotal),
                          SizedBox(height: 22),
                          GestureDetector(
                              child: Center(
                                  child: const Text(
                                'Ver parcelas',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: const Color.fromRGBO(18, 96, 73, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )),
                              onTap: () {
                                DIService()
                                    .inject<NavigationHandler>()
                                    .navigate(InstallmentsScreen.route,
                                        arguments: {'parcelas': parcelas});
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 130,
            right: 130,
            bottom: 44,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PassaquiButton(
                  label: 'Sim',
                  borderRadius: 50,
                  style: PassaquiButtonStyle.primary,
                  centerText: true,
                  onTap: () {
                    DIService().inject<NavigationHandler>().navigate(
                      HireConfirmCpfScreen.route,
                      arguments: {'cpf': widget.cpf},
                    );
                  },
                ),
                SizedBox(height: 12),
                PassaquiButton(
                  label: "Não",
                  borderRadius: 50,
                  textColor: Color.fromRGBO(18, 96, 73, 1),
                  borderColor: Color.fromRGBO(18, 96, 73, 1),
                  style: PassaquiButtonStyle.secondary,
                  centerText: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepasseItem(dynamic parcela) {
    double? valorRepasse =
        parcela['VlrRepasse']; // Adjust the key to match your data structure
    String dataRepasse = parcela['DtRepasse'];
    double? valorPrincipal = parcela['VlrPrincipal'];
    double? valorJuros = parcela['VlrJuros'];
    double? valorIOF = parcela['VlrIOF'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Valor repasse',
              style: GoogleFonts.roboto(
                color: Color(0xFF9B9B9B),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              valorRepasse != null
                  ? 'R\$ ${valorRepasse.toStringAsFixed(2)}'
                  : 'N/A',
              style: GoogleFonts.roboto(
                color: Color(0xFF151515),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
          const SizedBox(width: 24),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Valor repasse',
              style: GoogleFonts.roboto(
                color: Color(0xFF9B9B9B),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              valorRepasse != null
                  ? 'R\$ ${valorRepasse.toStringAsFixed(2)}'
                  : 'N/A',
              style: GoogleFonts.roboto(
                color: Color(0xFF151515),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildValueItem(String label, double? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.roboto(
              color: Color(0xFF9B9B9B),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            value != null ? 'R\$ ${value.toStringAsFixed(2)}' : 'N/A',
            style: GoogleFonts.roboto(
              color: Color(0xFF151515),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCetItem(double? cetMensal, double? cetAnual) {
  if (cetMensal != null && cetAnual != null) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${cetMensal.toStringAsFixed(2)}% a.m / ${cetAnual.toStringAsFixed(2)}% ao ano',
          style: GoogleFonts.inter(
            color: Color(0xFF515151),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  } else {
    return Container();
  }
}
