  // [BBL_Subscripciones].Input.List Box()
  // 
  //
  // creado por: Alberto Bachler Klein: 25-05-16, 18:09:32
  // -----------------------------------------------------------

READ WRITE:C146([BBL_Registros:66])
READ WRITE:C146([BBL_Items:61])
GOTO SELECTED RECORD:C245([BBL_Registros:66];Selected record number:C246([BBL_Registros:66]))
WDW_OpenFormWindow (->[BBL_Registros:66];"Periodicals";0;-Palette form window:K39:9;[BBL_Subscripciones:117]Titulo:2;"wdwClose")
FORM SET INPUT:C55([BBL_Registros:66];"Periodicals")
MODIFY RECORD:C57([BBL_Registros:66];*)
CLOSE WINDOW:C154

QUERY:C277([BBL_Registros:66];[BBL_Items:61]Número_de_suscripción:41=[BBL_Subscripciones:117]ID:1)
LISTBOX SORT COLUMNS:C916(*;"lb_Ejemplares";1;<)
bBWR_Cancel:=0
BBWR_SAVERECORD:=0
bBWR_CloseRecord:=0
