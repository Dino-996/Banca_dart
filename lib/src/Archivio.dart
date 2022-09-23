import 'Conto.dart';

/**
 * Questa classe contiene logica applicativa. 
 * Viene utilizzata come "contenitore" per i conti correnti e 
 * permette di effettuare operazioni su di essi.
 */

class Archivio {
/**
 * Lista di conti correnti.
 */

  List<Conto> _listaConti = [];

/**
 * Restituisce la lista dei consti correnti.
 */

  List<Conto> getListaConti() {
    return this._listaConti;
  }

  /**
   * Permette di settare la lista di conti correnti con un altra lista di conti correnti.
   */

  void setListaConti(List<Conto> listaConti) {
    this._listaConti = listaConti;
  }

  /**
   * Permette di aggiungere un nuovo conto corrente alla lista.
   */

  void addConto(Conto conto) {
    this._listaConti.add(conto);
  }

  /**
   * Verifica se la lista dei conti correnti e' piena.
   */

  bool listaPiena() {
    return !_listaConti.isEmpty;
  }

/**
 * Cerca nella lista un conto corrente in base all'intestatario,
 * se non lo trova resrituisce null.
 */

  Conto? cercaConto(String intestatario) {
    for (int i = 0; i < _listaConti.length; i++) {
      Conto conto = _listaConti.elementAt(i);
      if (intestatario == conto.getIntestatario()) {
        return conto;
      }
    }
    return null;
  }

  /**
   * Verifica se esistono conti correnti con lo stesso nome o lo stesso IBAN.
   */

  bool verificaDuplicati(String iban, String intestatario) {
    for(int i = 0; i < _listaConti.length; i++) {
      Conto conto = _listaConti.elementAt(i);
      if(conto.getIban() == iban || conto.getIntestatario() == intestatario) {
        return true;
      }
    }
    return false;
  }


  /**
   * Stampa l'intera lista dei conti correnti.
   */

  @override
  String toString() {
    var sb = new StringBuffer();
    if (listaPiena()) {
      sb.write("Conti correnti\n");
      sb.write(this._listaConti.toString());
    } else {
      sb.write("--------------------------------\n");
      sb.write("Non esiste nessun conto corrente\n");
      sb.write("--------------------------------\n");
    }
    return sb.toString();
  }
}
