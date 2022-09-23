import 'package:Conti/src/FormattatoreDate.dart';
import 'Movimento.dart';

/**
 * Costante che rappresenta l'ora corrente (non formattata).
 */

final ora = DateTime.now();

/**
 * Questa classe rappresenta un conto corrente bancario, 
 * contenente logica applicativa.
 * Viene utilizzata come "contenitore" per i movimenti e 
 * permette di effettuare operazioni su di essi.
 */

class Conto {
  String _iban = "";
  String _intestatario = "";
  DateTime _dataSottoscrizione = ora;
  List<Movimento> _listaMovimenti = [];

/**
 * Costruttore di Conto.
 */

  Conto(String iban, String intestatario, DateTime dataSottoscrizione) {
    this._iban = iban;
    this._intestatario = intestatario;
    this._dataSottoscrizione = dataSottoscrizione;
  }

/**
 * Restituisce l'IBAN.
 */

  String getIban() {
    return _iban;
  }

  void setIban(String iban) {
    this._iban = iban;
  }

/**
 * Restituisce il nome dell'intestatario.
 */

  String getIntestatario() {
    return _intestatario;
  }

  /**
   * Permette di settare in nome dell'intestatario.
   */

  void setIntestatario(String intestatario) {
    this._intestatario = intestatario;
  }

  /**
   * Restituisce la data di sottoscrizione.
   */

  DateTime getDataSottoscrizione() {
    return _dataSottoscrizione;
  }

  /**
   * Permette di settare la data di sottoscrizione.
   */

  void setDataSottoscrizione(DateTime dataSottoscrizione) {
    this._dataSottoscrizione = dataSottoscrizione;
  }

  /**
   * Restituisce la lista dei movimenti.
   */

  List<Movimento> getListaMovimenti() {
    return this._listaMovimenti;
  }

  /**
   * Permette di settare la lista di movimenti con un altra lista di movimenti.
   */

  void setListaMoviemnti(List<Movimento> listaMovimenti) {
    this._listaMovimenti = listaMovimenti;
  }

  /**
   * Permette di aggiungere un nuovo movimento alla lista.
   */

  void addMovimento(Movimento movimento) {
    this._listaMovimenti.add(movimento);
  }

  /**
   * Verifica se la lista dei movimenti e' piena.
   */

  bool listaPiena() {
    return !_listaMovimenti.isEmpty;
  }

  /**
   * Restituisce il saldo corrente. 
   */

  int verificaSaldo() {
    int saldo = 0;
    for (int i = 0; i < _listaMovimenti.length; i++) {
      Movimento movimento = _listaMovimenti.elementAt(i);
      saldo += movimento.getImporto();
    }
    return saldo;
  }

/**
* Restituisce l'intera lista dei movimenti,
* partendo dall'ultimo elemento.
*/

  List<Movimento> listaInversa() {
   List<Movimento> listaFiltrata = [];
   for(int i = 0; i < this._listaMovimenti.length; i++) {
      Movimento movimento = _listaMovimenti.elementAt(i);
      listaFiltrata.add(movimento);
   }
   listaFiltrata.sort();
   return listaFiltrata; 
  }

  /**
   * Stampa le proprieta' del conto corrente e,
   * se la lista contiene movimenti, l'intera lista dei movimenti.
   */

  @override
  String toString() {
    var sb = new StringBuffer();
    sb.write("IBAN: ${_iban}\n");
    sb.write("Intestatario: ${_intestatario}\n");
    sb.write("Data sottoscrizione:" +
        FormattatoreDate.dataFormattata(_dataSottoscrizione) +
        "\n");
    if (listaPiena()) {
      sb.write("--- Lista movimenti ---\n");
      sb.write(this._listaMovimenti.toString());
    } else {
      sb.write("---------------------------\n");
      sb.write("Non esiste nessun movimento\n");
      sb.write("---------------------------\n");
    }
    return sb.toString();
  }
}
