//%attributes = {}
  //AL_pgHistorico

C_BOOLEAN:C305(vb_HistoricoEditable)
vb_HistoricoEditable:=False:C215


ARRAY TEXT:C222(aHAsig;0)
ARRAY TEXT:C222(aHNota1;0)
ARRAY TEXT:C222(aHNota2;0)
ARRAY TEXT:C222(aHNota3;0)
ARRAY TEXT:C222(aHNota4;0)
ARRAY TEXT:C222(aHPF;0)
ARRAY TEXT:C222(aHEx;0)
ARRAY TEXT:C222(aHNF;0)
ARRAY TEXT:C222(aHNfOficial;0)
ARRAY INTEGER:C220(aHorder;0)
ARRAY LONGINT:C221(aHID;0)
ARRAY LONGINT:C221(aRecNum;0)  //RCH
ARRAY BOOLEAN:C223(aReprobada;0)  //RCH
_O_ENABLE BUTTON:C192(*;"NewNotasH@")  //RCH
_O_ENABLE BUTTON:C192(bModHistoric)  //RCH
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnosHistorico;1;True:C214;1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnosHistorico;2;True:C214;1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnosHistorico;3;True:C214;1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnosHistorico;4;True:C214;1;0)

ARRAY TEXT:C222(atSTR_ModoCalificaciones;5)
atSTR_ModoCalificaciones{1}:="Literal nativo"
atSTR_ModoCalificaciones{2}:="Notas"
atSTR_ModoCalificaciones{3}:="Puntos"
atSTR_ModoCalificaciones{4}:="Símbolos"
atSTR_ModoCalificaciones{5}:="Porcentaje"

If (atSTR_ModoCalificaciones=0)
	atSTR_ModoCalificaciones:=1
End if 

AL_CiclosEscolares_Historico ([Alumnos:2]numero:1)

If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
	ARRAY TEXT:C222(aPeriodos_Historico;0)
	r1:=1
	r2:=0
	r3:=0
	al_LoadHNotas 
	
	If (<>vtXS_CountryCode="cl")
		If (([Alumnos_SintesisAnual:210]NumeroNivel:6=12) & ([Alumnos_Historico:25]Situacion_final:19="P"))
			OBJECT SET VISIBLE:C603(*;"egreso@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"egreso@";False:C215)
		End if 
	End if 
	$0:=1
Else 
	$err:=AL_SetArraysNam (xALP_HNotasECursos;1;11;"aHAsig";"aHNota1";"aHnota2";"aHPF";"aHEX";"aHNF";"aHNfOficial";"aHOrder";"aHID";"aRecNum";"aReprobada")
	AL_SetHeaders (xALP_HNotasECursos;1;7;__ ("Asignatura");__ ("1S");__ ("2S");__ ("PF");"EX";__ ("NF");__ ("Nota Oficial"))
	AL_SetWidths (xALP_HNotasECursos;1;7;200;59;59;59;59;59;59)
	AL_SetStyle (xALP_HNotasECursos;0;"Tahoma";9;0)
	AL_SetHdrStyle (xALP_HNotasECursos;0;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_HNotasECursos;0;"Tahoma";9;1)
	AL_SetColOpts (xALP_HNotasECursos;0;0;0;4;0;0;0)
	AL_SetRowOpts (xALP_HNotasECursos;1;1;0;0;1)
	AL_SetMiscOpts (xALP_HNotasECursos;0;0;"\\";0;1)
	AL_SetDividers (xALP_HNotasECursos;"Black";"Light Gray";0;"Black";"Light Gray";0)
	AL_SetHeight (xALP_HNotasECursos;1;4;1;4)
	AL_UpdateArrays (xALP_HNotasECursos;-2)
	ALP_SetDefaultAppareance (xALP_HNotasECursos)
	  //DISABLE BUTTON(bModHistoric)
	OBJECT SET VISIBLE:C603(*;"egreso@";False:C215)
	$ignore:=CD_Dlog (0;__ ("No hay registros históricos para este alumno."))
	_O_DISABLE BUTTON:C193(*;"NewNotasH@")  //RCH
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnosHistorico;1;False:C215;1;0)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnosHistorico;2;False:C215;1;0)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnosHistorico;3;False:C215;1;0)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnosHistorico;4;False:C215;1;0)
	$0:=1
End if 

SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_alumnosHistorico;1)  //RCH
OBJECT SET VISIBLE:C603(*;"NotasH@";True:C214)
OBJECT SET VISIBLE:C603(*;"notas@";True:C214)
OBJECT SET VISIBLE:C603(*;"coment@";False:C215)
OBJECT SET VISIBLE:C603(*;"nivelhistorico@";False:C215)
OBJECT SET VISIBLE:C603(atSTR_ModoCalificaciones;True:C214)
REDRAW WINDOW:C456


PREF_fGet (<>lUSR_CurrentUserID;"NombreAsignaturasHistórico";String:C10(0))
If (bNombreAsignaturasH=1)
	OBJECT SET TITLE:C194(bNombreAsignaturasH;__ ("Nombre Interno"))
Else 
	OBJECT SET TITLE:C194(bNombreAsignaturasH;__ ("Nombre Oficial"))
End if 

_O_DISABLE BUTTON:C193(bEditaHistoricos)
OBJECT SET VISIBLE:C603(*;"locked";True:C214)
OBJECT SET VISIBLE:C603(*;"unlocked";False:C215)
_O_DISABLE BUTTON:C193(bAddHSubject)

If (Count list items:C380(hl_CiclosEscolares_Historico)=0)
	_O_DISABLE BUTTON:C193(hl_CiclosEscolares_Historico)
Else 
	_O_ENABLE BUTTON:C192(hl_CiclosEscolares_Historico)
End if 
