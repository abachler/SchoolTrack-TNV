//%attributes = {}
  //MONO TICKET 188023
READ WRITE:C146([xShell_Fields:52])
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=230;*)
QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]NumeroCampo:2=1)
[xShell_Fields:52]AutomaticSequenceNumber:23:=True:C214
SAVE RECORD:C53([xShell_Fields:52])
KRL_UnloadReadOnly (->[xShell_Fields:52])

SQ_EscribeDatos 
SQ_CargaDatos 