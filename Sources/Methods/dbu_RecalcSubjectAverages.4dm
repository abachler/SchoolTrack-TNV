//%attributes = {}
  // MÉTODO: dbu_RecalcSubjectAverages
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 15/12/11, 15:02:02
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // dbu_RecalcSubjectAverages()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_BLOB:C604($x_RecNumsBlob)
C_LONGINT:C283($l_currentTerm;$l_ServerProcessID)
C_BOOLEAN:C305($b_MostrarOpcionComparacion;$b_setVariable)

ARRAY LONGINT:C221($al_RecNums;0)


  //20121113 RCH Para que se ejecute solo de a una vez.
C_BOOLEAN:C305(<>vb_calculandoPromediosT)
GET PROCESS VARIABLE:C371(-1;<>vb_calculandoPromediosT;<>vb_calculandoPromediosT)

  // CODIGO PRINCIPAL

If (Not:C34(<>vb_calculandoPromediosT))
	SET PROCESS VARIABLE:C370(-1;<>vb_calculandoPromediosT;True:C214)
	If (Not:C34(<>vb_BloquearModifSituacionFinal))
		BRING TO FRONT:C326(Current process:C322)
		ALL RECORDS:C47([Asignaturas:18])
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNums;"")
		BLOB_Variables2Blob (->$x_RecNumsBlob;0;->$al_RecNums)
		$l_currentTerm:=atSTR_Periodos_Nombre
		  //20121113 RCH Se pasa parametro 2 por defecto y se pasa nuevo parametro 3 en verdadero para que se setee la variable
		  //$l_ServerProcessID:=New process("EV2dbu_Recalculos";256000;"Calculo de promedios de asignaturas";$x_RecNumsBlob)
		$b_MostrarOpcionComparacion:=True:C214
		$b_setVariable:=True:C214
		$l_ServerProcessID:=New process:C317("EV2dbu_Recalculos";256000;"Calculo de promedios de asignaturas";$x_RecNumsBlob;$b_MostrarOpcionComparacion;$b_setVariable)
		$l_currentTerm:=atSTR_Periodos_Nombre
		atSTR_Periodos_Nombre:=$l_currentTerm
	End if 
End if 