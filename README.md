# uart
 Integrated digital systems Project course

In questo laboratorio è stato progettato un “Universal Asynchronous Receiver-Trasmitter”, dispositivo impiegato nella conversione di flussi di bit di dati, da un formato parallelo ad un formato seriale e viceversa.
La modalità di trasmissione viene definita asincrona poiché il trasmettitore ed il ricevitore non condividono lo stesso segnale di clock. Per questa ragione è necessario definire un meccanismo di sincronizzazione, tale da permettere lo scambio di bit tra i due componenti. Per realizzare quanto detto si è stabilito che il frame debba iniziare con un bit di start forzato allo 0 logico, seguito da 8 bit di dato ed infine 1 bit di stop.
La UART in questione andrà a gestire la comunicazione seriale tramite il protocollo RS-232, il quale prevede la possibilità di una comunicazione ‘’Full-Duplex’’, in cui il trasmettitore e il ricevitore, indipendenti tra di loro, lavorano in contemporanea.
Lavorando con un protocollo asincrono, per avere delle informazioni sulla trasmissione dei simboli quello che si deve fare è fissare la velocità di trasmissione del ricevitore e del trasmettitore, ovvero il Baud rate, il quale definisce la durata di un simbolo. In questo caso specifico, è stato fissato ad una velocità di 115200 baud/s, per cui il tempo di simbolo sarà . Il clock di sistema usato è a 16 MHz per cui un tempo di simbolo equivale a circa 139 colpi di clock.
L’intero blocco UART richiede che venga trasmesso e ricevuto un byte, quindi 8 bit, seguendo le seguenti specifiche di interfaccia:

- un bus dati in ingresso su 8 bit Din (7:0);
-  un bus dati in uscita su 8 bit Dou (7:0);
-  il clock;
 - Rx_p: interfaccia seriale;
 - tx_p: interfaccia seriale;
 - segnale di Chip Select attivo alto;
 - un segnale ;
 - un bus di indirizzi su 3 bit;
 - un segnale ATN;
 - un segnale ATNACK.
 
 Per l’interfaccia a registri:
 	- RegTx: contenente il dato da trasmettere;
  - RegRx: contenente il dato ricevuto; 
  - registro di stato: contenente le informazioni relative allo stato in cui si trova la UART;
  - registro di controllo.
 
Per quando riguarda il registro Rx, è stata utilizzata la tecnica a doppio buffer, in modo tale che il dato appena ricevuto venga salvato interamente in un ulteriore registro, al fine di concedere all’utente la possibilità di leggere il dato per un intero tempo di trasmissione, prima che questo venga sovrascritto dal nuovo dato.
