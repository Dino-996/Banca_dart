import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

/**
* Questa classe permette di formattare una data e un ora tramite la libreria intl.
*/

class FormattatoreDate {
  /**
  * Questo metodo statico riceve in input una data e la trasforma in una stringa,
  * in formato anno/mese/giorno - ore:minuti.
  */

  static String dataFormattata(DateTime dt) {
    initializeDateFormatting('it_IT', null);
    DateFormat df = new DateFormat('d.M.y -').add_Hm();
    String dataFormattata = df.format(dt);
    return dataFormattata;
  }
}
