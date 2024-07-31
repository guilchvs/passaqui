import 'package:flutter/material.dart';
import 'package:passaqui/src/shared/widget/appbar.dart';

class InstallmentsScreen extends StatefulWidget {
  static const String route = "/installments";
  final List<dynamic>? parcelas;

  const InstallmentsScreen({Key? key, required this.parcelas})
      : super(key: key);

  @override
  State<InstallmentsScreen> createState() => _InstallmentsScreenState();
}

class _InstallmentsScreenState extends State<InstallmentsScreen> {
  bool _isLoading = true;
  List<dynamic>? _parcelasList;

  @override
  void initState() {
    super.initState();
    _loadParcelasData();
  }

  Future<void> _loadParcelasData() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _parcelasList = widget.parcelas;
      _isLoading = false;
    });

    if (_parcelasList != null) {
      print("Parcelas data loaded: $_parcelasList");
    } else {
      print("No parcelas data found.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PassaquiAppBar(
        showBackButton: true,
        showLogo: false,
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Color.fromRGBO(18, 96, 73, 1),
        ),
      )
          : _parcelasList == null || _parcelasList!.isEmpty
          ? Center(
        child: Text(
          "Sem parcelas disponíveis",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView.builder(
          itemCount: _parcelasList!.length,
          itemBuilder: (context, index) {
            final parcela = _parcelasList![index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInstallment(
                  index + 1,
                  parcela['DtRepasse'],
                  parcela['VlrRepasse'],
                  parcela['VlrPrincipal'],
                  parcela['VlrJuros'],
                ),
                const Divider(
                  thickness: 2.0,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInstallment(int numeroParcela, String dataRepasse,
      double valorRepasse, double valorPrincipal, double valorJuros) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Número da parcela:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
            ),
            const SizedBox(width: 12),
            Text(
              '$numeroParcela',
              style: TextStyle(fontSize: 18, fontFamily: 'Inter'),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Valor de Repasse:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
            ),
            const SizedBox(width: 12),
            Text('R\$${valorRepasse.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontFamily: 'Inter'),
            )
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Valor de Principal:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
            ),
            const SizedBox(width: 12),
            Text('R\$${valorPrincipal.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontFamily: 'Inter'),
            )
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Valor do Juros:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
            ),
            const SizedBox(width: 12),
            Text('R\$${valorJuros.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontFamily: 'Inter'),
            )
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Data de Repasse:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
            ),
            const SizedBox(width: 12),
            Text('${_formatDate(dataRepasse)}',
              style: TextStyle(fontSize: 18, fontFamily: 'Inter'),
            )
          ],
        ),
      ],
    );
  }

  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return "${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}";
  }
}
