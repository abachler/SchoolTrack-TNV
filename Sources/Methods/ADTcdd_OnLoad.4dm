//%attributes = {}
  //ADTcdd_OnLoad

C_LONGINT:C283($table)
C_TEXT:C284($vt_formato)
ARRAY TEXT:C222(at_Connexions;0)

  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
C_BOOLEAN:C305(vb_guardarCambios)

xAlSet_AL_AreaConexiones 

ARRAY TEXT:C222(atADT_NivName;0)
ARRAY LONGINT:C221(aiADT_NivNo;0)

READ ONLY:C145([xxSTR_Niveles:6])
QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesAdmissionTrack)

ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;atADT_NivName;[xxSTR_Niveles:6]NoNivel:5;aiADT_NivNo)
UFLD_LoadFileTplt (->[ADT_Candidatos:49])
UFLD_LoadFields (->[ADT_Candidatos:49];->[ADT_Candidatos:49]UserFields:42;->[ADT_Candidatos]UserFields'Value;->xALP_UFields)
xALSet_AreasCamposUsuario (xALP_UFields)
vlADT_PrevTabMeta:=2

OBJECT SET VISIBLE:C603(*;"btn_comunicarResultados";[ADT_Candidatos:49]Resultados_comunicados:36)
OBJECT SET VISIBLE:C603(*;"img_ComunicarResultados";[ADT_Candidatos:49]Resultados_comunicados:36)

Case of 
	: (<>vrPST_precisionEvConductual=0)
		$vt_formato:="|Long"
	Else 
		$vt_formato:="|Real_"+String:C10(<>vrPST_precisionEvConductual)+"Dec"
End case 
OBJECT SET FORMAT:C236(*;"evaluacion_conductual";$vt_formato)


Case of 
	: (<>vrPST_precision=0)
		$vt_formato:="|Long"
	Else 
		$vt_formato:="|Real_"+String:C10(<>vrPST_precision)+"Dec"
End case 
OBJECT SET FORMAT:C236(*;"Puntaje_examen";$vt_formato)