import 'package:Conti/src/FormattatoreDate.dart';
/**
 * Costante che rappresenta l'ora corrente (non formattata).
 */
final ora = DateTime.now();

/**
 * Questa classe rappresenta un movimento del conto corrente.
 */

class Movimento implements Comparable<Movimento> {
  DateTime _dataMovimento = ora;
  String _tipologia = "";
  int _importo = 0;

  /**
   * Costruttore di Movimento
   */

  Movimento(DateTime dataMovimento, String tipologia, int importo) {
    this._dataMovimento = dataMovimento;
    this._tipologia = tipologia;
    this._importo = importo;
  }

  /**
   * Restituisce la data del movimento.
   */

  DateTime getDataMovimento() {
    return _dataMovimento;
  }

  /**
   * Permette di settare la data di inserimento del movimento.
   */

  void setDataMovimento(DateTime dataMovimento) {
    this._dataMovimento = dataMovimento;
  }

  /**
   * Restituisce la tipologia del movimento.
   */

  String getTipologia() {
    return _tipologia;
  }

  /**
   * Permette di settare la tipologia del movimento.
   */

  void setTipologia(String tipologia) {
    this._tipologia = tipologia;
  }

  /**
   * Restituisce l'importo del movimento, sia positivo che negativo.
   */

  int getImporto() {
    return _importo;
  }

  /**
   * Permette di settare l'importo del movimento'.
   */

  void setImporto(int importo) {
    this._importo = importo;
  }

  /**
   * Stampa le proprieta' del movimento.
   */

  @override
  String toString() {
    var sb = new StringBuffer();
    sb.write("Data movimento: " +
        FormattatoreDate.dataFormattata(_dataMovimento) +
        "\n");
    sb.write("Tipologia: ${_tipologia}" + "\n");
    sb.write("Importo: ${_importo}" + " euro\n");
    return sb.toString();
  }
  
/**
 * Compara la data del movimento con un altra data del movimento e restituisce
 * la data del movimento piu' recente.
 */

  @override
  int compareTo(Movimento other) {
    return other._dataMovimento.compareTo(getDataMovimento());
  }
}
