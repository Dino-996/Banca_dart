library src.it.utilita;

import 'dart:io';
import 'package:dart_console/dart_console.dart';

final console = Console.scrolling();
  /**
   * Questa classe consente di effettuare la maggior parte delle operazioni
   * di lettura con tipi di base dallo standart input.
   **/

class ConsoleBase {
    /**
     * Preleva una stringa dallo standard input
     * Restituisce la stringa acquisita dallo standard input.
     */

  static String leggiStringa() {
    var valore;
    while (true) {
      try {
        var input = console.readLine(cancelOnBreak: true);
        valore = input;
      } on IOException catch (ioEx) {
        stdout.write("ERRORE: I/O " + ioEx.toString());
      }
      return valore;
    }
  }

    /**
     * Preleva un numero intero dallo standard input;
     * costringe l'utente a ripetere l'immissione finche' il dato fornito
     * non e' effettivamente un valore ammissibile per il tipo int.
     * Restituisce il numero intero prelevato dallo standard input.
     */

  static int leggiIntero() {
    int intero;
    while (true) {
      try {
        intero = int.parse(console.readLine(cancelOnBreak: true)!);
        return intero;
      } on IOException catch (ioEx) {
        stdout.write("ERRORE I/O: " + ioEx.toString());
      } catch (FormatException) {
        stdout.write("ERRORE: non si tratta di un numero intero. \nRiprova: ");
      }
    }
  }

    /**
     * Preleva un numero reale di tipo double dallo standard input;
     * costringe l'utente a ripetere l'immissione finche' il dato fornito
     * non e' effettivamente un valore ammissibile per il tipo double.
     * Restituisce il valore double prelevato dallo standard input.
     */

  static double leggiDouble() {
    double reale;
    while (true) {
      try {
        reale = double.parse(console.readLine(cancelOnBreak: true)!);
        return reale;
      } on IOException catch (ioEx) {
        stdout.write("ERRORE I/O: " + ioEx.toString());
      } catch (FormatException) {
        stdout.write("ERRORE: non si tratta di un numero reale. \nRiprova: ");
      }
    }
  }

    /**
     * Preleva un carattere dallo standard input;
     * costringe l'utente a ripetere l'immissione finche' il dato fornito
     * non e' effettivamente un singolo carattere.
     * Ritorna il valore char prelevato dallo standard input.
     */

  static String leggiCaratteri() {
    String carattere;
    while (true) {
      try {
        String input = console.readLine(cancelOnBreak: true)!;
        if (input.length == 1) {
          carattere = input[0];
          return carattere;
        } else {
          stdout
              .write("ERRORE: non si tratta di un carattere. \nRiprova: ");
        }
      } on IOException catch (ioEx) {
        stdout.write("ERRORE I/O: " + ioEx.toString());
      }
    }
  }
}
