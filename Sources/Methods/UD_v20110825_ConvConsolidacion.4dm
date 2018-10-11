//%attributes = {}
  // MÉTODO: UD_v20110825_ConvConsolidacion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 25/08/11, 17:13:17
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // UD_v20110825_ConvConsolidacion()
  // ----------------------------------------------------


  // Método modificado por ABK 20110827
  // reemplazo de acceso a subtablas de consolidación (via [Asignaturas]Consolidantes por acceso estandar a tabla [Asignaturas_Consolidantes]
  //--------------------------------



  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL
READ WRITE:C146([Asignaturas_Consolidantes:231])
ALL RECORDS:C47([Asignaturas:18])
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
	QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]id_added_by_converter:4=Get subrecord key:C1137([Asignaturas:18]Consolidantes:42))
	APPLY TO SELECTION:C70([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5:=[Asignaturas:18]Numero:1)
End for 
READ ONLY:C145([Asignaturas_Consolidantes:231])

ALL RECORDS:C47([Asignaturas_Consolidantes:231])
QUERY SELECTION BY FORMULA:C207([Asignaturas_Consolidantes:231];([Asignaturas_Consolidantes:231]ID_ParentRecord:5=[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1))
KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])

