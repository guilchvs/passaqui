import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passaqui/src/modules/hire/confirmCpf/confirm_cpf_screen.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/navigation/navigation_handler.dart';
import '../../../shared/widget/button.dart'; // Import your PassaquiButton widget

class HireValueScreen extends StatefulWidget {
  static const String route = "/hire-value";
  final Map<String, dynamic>? jsonResponse; // Accept jsonResponse as argument
  final String cpf; // Accept jsonResponse as argument
  final int selectedPeriod;

  const HireValueScreen({Key? key, this.jsonResponse, required this.cpf, required this.selectedPeriod}) : super(key: key);

  @override
  State<HireValueScreen> createState() => _HireValueScreenState();
}

class _HireValueScreenState extends State<HireValueScreen> {

  @override
  void initState(){
    super.initState();
    print('Selected Period: ${widget.selectedPeriod}');
  }


  @override
  Widget build(BuildContext context) {
    // Extract values from jsonResponse
    double? valorDesejado = widget.jsonResponse?['VlrLiberado'];
    double? valorIOF = widget.jsonResponse?['VlrIOF'];
    double? valorFinanciado = widget.jsonResponse?['VlrEmprestimoCliente'];
    double? valorJuros = widget.jsonResponse?['VlrJuros'];
    double? cetMensal = widget.jsonResponse?['TaxaCETMensal'];
    double? cetAnual = widget.jsonResponse?['TaxaCETAnual'];
    double? valorTotal = widget.jsonResponse?['VlrOperacao'];

    return Scaffold(
      appBar: const PassaquiAppBar(showLogo: false, showBackButton: true),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Color.fromRGBO(18, 96, 73, 1), // Green color for top section
              height: MediaQuery.of(context).size.height * 0.33, // 1/3 of the screen height
            ),
          ),
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.33, // Start below the green section
            child: Container(
              color: Colors.white, // White color for bottom section
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
                  padding: const EdgeInsets.only(left: 24.0, top: 22.0, bottom: 10.0),
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
                  width: MediaQuery.of(context).size.width * 0.9, // Set Card width to 90% of screen width
                  height: MediaQuery.of(context).size.height * 0.55, // Set Card height to 55% of screen height
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Rounded corners
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
                          SizedBox(height: 8), // Add some spacing between CET and total
                          _buildValueItem('Valor total a pagar', valorTotal),
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
      return Container(); // Return an empty container if either value is null
    }
  }
}

