  //xxBBL_Preferencias.Generales.invisible button1
READ WRITE:C146([xxSTR_Periodos:100])
QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1=-2)
[xxSTR_Periodos:100]Inicio_Ejercicio:4:=vdSTR_PeriodoActual_Inicio
[xxSTR_Periodos:100]Fin_Ejercicio:5:=vdSTR_PeriodoActual_Termino
  //almacenaje de los feriados
$OTref_Calendario:=OT New 
OT PutArray ($OTref_Calendario;"adSTR_Calendario_Feriados";adSTR_Calendario_Feriados)
$blob:=OT ObjectToNewBLOB ($OTref_Calendario)
[xxSTR_Periodos:100]Feriados:7:=$blob
OT Clear ($OTref_Calendario)
SAVE RECORD:C53([xxSTR_Periodos:100])
KRL_ReloadAsReadOnly (->[xxSTR_Periodos:100])
