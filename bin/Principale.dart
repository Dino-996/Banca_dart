import 'dart:io';

import 'package:Conti/src/Archivio.dart';
import 'package:Conti/src/Conto.dart';
import 'package:Conti/src/Costanti.dart';
import 'package:Conti/src/FormattatoreDate.dart';
import 'package:Conti/src/Movimento.dart';
import 'package:Conti/Console/lib/src/it/utilita/ConsoleBase.dart';
import 'package:dart_console/dart_console.dart';
import 'dart:math';

/**
 * Metodo principale, avvia l'applicazione.
 */
void main(List<String> args) {
  Principale principale = new Principale();
  principale.esegui();
}

/**
 * Questa classe si occupa di avviare l'applicazione e convalidare le varie operazioni
 * durante il suo normale ciclo di utilizzo.
 */

class Principale {
  final console = Console();
  static final row = "\u2550";
  static final column = "\u2551";
  static final angleTopLeft = "\u2554";
  static final angleTopRight = "\u2557";
  static final closeLeft = "\u2560";
  static final closeRight = "\u2563";
  static final angleBottomRight = "\u255D";
  static final angleBottomLeft = "\u255A";

  /**
   * Esegue lo splashScreen (barra di caricamento), 
   * setta il colore di sfondo e di testo della console, 
   * setta il testo della console,
   * esegue le operazioni previste dall'applicazione.
   */

  void esegui() {
    Archivio archivio = new Archivio();
    archivio = ArchivioMock();
    splashScreen();
    console.setBackgroundColor(ConsoleColor.black);
    console.setForegroundColor(ConsoleColor.white);
    console.setTextStyle(italic: true);
    console.setTextStyle(bold: true);
    while (true) {
      int scelta = schermoMenu();
      if (scelta == 0) {
        console.clearScreen();
        break;
      }

      if (scelta == 1) {
        nuovoContoCorrente(archivio);
      }

      if (scelta == 2) {
        selezionaOperazione(archivio);
      }

      if (scelta == 3) {
        verificaMovimentiFinali(archivio);
      }

      if (scelta == 4) {
        verificaSaldo(archivio);
      }
    }
  }

/**
 * Visualizza a schermo un titolo seguito da una barra di caricamento.
 */

  void splashScreen() {
    console.setBackgroundColor(ConsoleColor.black);
    console.setForegroundColor(ConsoleColor.white);
    console.clearScreen();

    final row = (console.windowHeight / 2).round() - 1;
    final progressBarWidth = max(console.windowWidth - 10, 10);

    console.cursorPosition = Coordinate(row - 2, 0);
    console.writeLine('B_A_N_C_A', TextAlignment.center);
    console.cursorPosition = Coordinate(row + 2, 0);
    console.writeLine('Caricamento in corso...', TextAlignment.center);
    console.hideCursor();

    for (var i = 0; i <= 50; i++) {
      console.cursorPosition = Coordinate(row, 4);
      final progress = (i / 50 * progressBarWidth).ceil();
      final bar = '[${'#' * progress}${' ' * (progressBarWidth - progress)}]';
      console.write(bar);
      sleep(const Duration(milliseconds: 40));
    }
    console.clearScreen();
    console.showCursor();
  }

  /**
   * Visualizza a schermo un menu' testuale. 
   * E' possibile selezionare varie opzioni.
   */

  int schermoMenu() {
    console.write("\n");
    console.writeLine(
        " ${angleTopLeft}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${angleTopRight}",
        TextAlignment.left);
    console.writeLine(
        " ${column}  BANCA                              ${column}",
        TextAlignment.left);
    console.writeLine(
        " ${closeLeft}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${closeRight}",
        TextAlignment.left);
    console.writeLine(
        " ${column} 1. Nuovo conto corrente             ${column}",
        TextAlignment.left);
    console.writeLine(
        " ${column} 2. Nuova operazione                 ${column}",
        TextAlignment.left);
    console.writeLine(
        " ${column} 3. Visualizza gli ultimi 5 movimenti${column}",
        TextAlignment.left);
    console.writeLine(
        " ${column} 4. Visualizza saldo                 ${column}",
        TextAlignment.left);
    console.writeLine(
        " ${closeLeft}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${closeRight}",
        TextAlignment.left);
    console.writeLine(
        " ${column} 0. Esci                             ${column}",
        TextAlignment.left);
    console.writeLine(
        " ${angleBottomLeft}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${row}${angleBottomRight}\n",
        TextAlignment.left);
    int scelta = convalidaIntero(0, 4, "Scelta: ");
    return scelta;
  }

  /** 
   * Convalida numeri interi. 
   * Se il valore immesso non e' compreso 
   * tra il minimo e il massimo, inclusi, 
   * il sistema segnala un errore e 
   * forza l'utente a reiserire il valore.
   */

  int convalidaIntero(int min, int max, String valore) {
    console.write(valore);
    int scelta = ConsoleBase.leggiIntero();
    while (scelta < min || scelta > max) {
      console.write(
          "ERRORE: Scegliere un valore compresa tra ${min} e ${max}." + "\n");
      console.write("Scelta:  ");
      scelta = ConsoleBase.leggiIntero();
    }
    return scelta;
  }

  /** 
   * Convalida stringhe.
   * Se la stringa immessa e' vuota il sistema segnala un errore e 
   * forza l'utente a reiserire una stringa.
   */

  String convalidaStringa(String valore) {
    console.write(valore);
    String stringa = ConsoleBase.leggiStringa();
    while (stringa.isEmpty) {
      console.write("Impossibile lasciare il campo vuoto!\n");
      console.write("Riprova: ");
      stringa = ConsoleBase.leggiStringa();
    }
    return stringa;
  }

  /**
   * Crea un nuovo conto corrente.
   * Chiede all'utente di iserire IBAN e intestatario, 
   * convalida i dati e crea un nuovo conto corrente.
   */

  void nuovoContoCorrente(Archivio archivio) {
    String iban = convalidaStringa("IBAN: ");
    while (iban.length > 6 || iban.length < 6) {
      //Per semplicita' l'IBAN e' composto da 6 caratteri alfanumerici
      console.write(
          "ERRORE: Il codice IBAN deve essere composto da 6 caratteri alfanumerici\n");
      iban = convalidaStringa("IBAN: ");
    }
    String intestatario = convalidaStringa("Intestatario: ");
    final dataSottoscrizione = DateTime.now();
    Conto conto = new Conto(iban, intestatario, dataSottoscrizione);
    if (archivio.verificaDuplicati(iban, intestatario)) {
      console.write("ERRORE: Intestatario o IBAN gia' presente.\n");
      return;
    }
    archivio.addConto(conto);
    console.clearScreen();
    console.write("AVVISO: Il nuovo conto e' stato aperto correttamente.\n");
  }

  /**
   * Permette di selezionare una nuova operazione.
   * E' possibile effettuare prelievi o versamenti.
   */

  void selezionaOperazione(Archivio archivio) {
    int operazione = convalidaIntero(
        1, 2, "\nScegli un operazione:\n1.Versamento\n2.Prelievo\n\nScelta: ");
    if (operazione == 1) {
      nuovoVersamento(archivio);
    } else {
      nuovoPrelievo(archivio);
    }
  }

  /**
   * Permette di effettuare un nuovo versamento.
   * Chiede all'utente di iserire l'intestatario, se esiste,  
   * chiede di inserire l'importo del versamento.
   */
  void nuovoVersamento(Archivio archivio) {
    String intestatario = convalidaStringa("Intestatario del conto: ");
    Conto? conto = archivio.cercaConto(intestatario);
    if (conto != null) {
      int importo = convalidaIntero(20, 5000, "Importo del versamento: ");
      Movimento movimento =
          new Movimento(DateTime.now(), Costanti.VERSAMENTO, 0);
      int nuovoImporto = movimento.getImporto() + importo;
      movimento.setImporto(nuovoImporto);
      conto.addMovimento(movimento);
      console.clearScreen();
      stdout.write("AVVISO: Versamento effettuato correttamente.\n\n" +
          movimento.toString());
    } else {
      console.clearScreen();
      console.write(
          "ERRORE: Non esiste nessun conto aperto a nome '${intestatario}'." +
              "\n");
    }
  }

  /**
   * Permette di effettuare un nuovo prelievo.
   * Chiede all'utente di iserire l'intestatario, se esiste,  
   * chiede di inserire l'importo del prelievo.
   * Il prelievo va a buon fine se l'importo richiesto e' inferiore 
   * o uguale al saldo attualmente registrato.
   */

  void nuovoPrelievo(Archivio archivio) {
    String intestatario = convalidaStringa("Intestatario del conto: ");
    Conto? conto = archivio.cercaConto(intestatario);
    if (conto != null) {
      int saldo = conto.verificaSaldo();
      int importo = convalidaIntero(20, 5000, "Importo del prelievo: ");
      if (importo <= saldo) {
        Movimento movimento =
            new Movimento(DateTime.now(), Costanti.PRELIEVO, 0);
        int nuovoImporto = movimento.getImporto() - importo;
        movimento.setImporto(nuovoImporto);
        conto.addMovimento(movimento);
        console.clearScreen();
        stdout.write("AVVISO: Prelievo effettuato correttamente.\n\n" +
            movimento.toString());
      } else {
        console.clearScreen();
        console.write(
            "\nAVVISO: Impossibile effettuare il prelievo, il saldo e' inferiore all'importo richiesto.\n");
        console.write(
            "Saldo al ${FormattatoreDate.dataFormattata(DateTime.now())}: ${saldo} euro." +
                "\n");
      }
    } else {
      console.clearScreen();
      console.write(
          "Non esiste nessun conto aperto a nome ${intestatario}" + "\n");
    }
  }

  /**
   * Effettua la verifica del saldo.
   * Chiede all'utente di iserire l'intestatario, se esiste,  
   * restituisce il saldo corrente dell'intestatario immesso.
   */

  void verificaSaldo(Archivio archivio) {
    String intestatario = convalidaStringa("Intestatario del conto: ");
    Conto? conto = archivio.cercaConto(intestatario);
    if (conto != null) {
      int saldo = conto.verificaSaldo();
      console.clearScreen();
      console.write(
          "Il saldo per il conto a nome ${intestatario} e di ${saldo} euro" +
              "\n");
    } else {
      console.clearScreen();
      console.write(
          "Non esiste nessun conto aperto a nome ${intestatario}" + "\n");
    }
  }

  /**
   * Verifica gli ultimi 5 movimenti.
   * Chiede all'utente di iserire l'intestatario, se esiste,  
   * restituisce la lista partendo da gli ultimi 5 movimenti.
   */

  void verificaMovimentiFinali(Archivio archivio) {
    String intestatario = convalidaStringa("Intestatario del conto: ");
    Conto? conto = archivio.cercaConto(intestatario);
    if (conto == null) {
      console.clearScreen();
      console.write(
          "Non esiste nessun conto aperto a nome ${intestatario}" + "\n");
      return;
    }
    if (conto.getListaMovimenti().length >= 1) {
      List nuovaLista = [];
      for (int i = 0; i < conto.listaInversa().length; i++) {
        Movimento movimento = conto.listaInversa().elementAt(i);
        if (i < 4) {
          nuovaLista.add(movimento);
        }
        console.clearScreen();
        console.write("----------------------------\n\n" + nuovaLista.toString());
      }
    } else {
      console.clearScreen();
      console.write(
          "AVVISO: Non risultano movimenti a nome ${conto.getIntestatario()}" +
              "\n");
    }
  }

  /**
   * Mock_Object per testare l'applicazione.
   */
  Archivio ArchivioMock() {
    Archivio archivio = new Archivio();
    Conto conto1 = new Conto("123456", "Mario Rossi", DateTime.now());
    Conto conto2 = new Conto("654123", "Mirco Bianchi", DateTime.now());

    conto1.addMovimento(new Movimento(
        new DateTime(2022, DateTime.august, 8, 14, 30),
        Costanti.VERSAMENTO,
        6000));
    conto1.addMovimento(new Movimento(
        new DateTime(2022, DateTime.august, 24, 18, 30),
        Costanti.PRELIEVO,
        -3000));
    conto1.addMovimento(new Movimento(
        new DateTime(2022, DateTime.august, 30, 21, 30),
        Costanti.PRELIEVO,
        -250));

    archivio.addConto(conto1);
    archivio.addConto(conto2);

    return archivio;
  }
}
