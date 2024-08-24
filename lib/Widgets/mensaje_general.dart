import 'package:flutter/material.dart';

class MensajeGeneral extends StatelessWidget {
  final IconData icon;
  final String mensaje;
  const MensajeGeneral({
    super.key,
    this.icon = Icons.error,
    this.mensaje = 'Ocurrió un error al cargar la información',
  });

  @override
  Widget build(BuildContext context) {
    var color = Colors.grey[700];
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 70,
            color: color,
          ),
          Text(
            mensaje,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: color, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ));
  }
}
