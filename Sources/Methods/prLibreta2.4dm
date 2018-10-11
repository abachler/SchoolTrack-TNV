//%attributes = {}
  // prLibreta2()
  //
  //
  // creado por: Alberto Bachler Klein: 28-03-16, 20:31:02
  // -----------------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($i;$i_Registros;$k;$z)
C_POINTER:C301($y_opcion)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento)

ARRAY INTEGER:C220($al_indice;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222(aText1;0)



If (False:C215)
	C_TEXT:C284(prLibreta2 ;$1)
	C_TEXT:C284(prLibreta2 ;$2)
End if 

ARRAY TEXT:C222(aValores;0)
ARRAY TEXT:C222(aEValInfo1;0)
ARRAY TEXT:C222(aEValInfo2;0)
ARRAY TEXT:C222(aEValInfo3;0)
ARRAY TEXT:C222(aEValInfo4;0)
ARRAY TEXT:C222(aEvalFinal;0)
ARRAY INTEGER:C220(aCellClr;2;0)
ARRAY INTEGER:C220(aEvalSort;0)
ARRAY INTEGER:C220(aEvalPos;0)
ARRAY TEXT:C222(popL;0)
ARRAY TEXT:C222(popR;0)
ARRAY TEXT:C222(popC;0)
ARRAY BOOLEAN:C223(aCdtaPrints;7)
ARRAY TEXT:C222(aCdtatitles;7)
ARRAY TEXT:C222(aHdrs;0)
ARRAY TEXT:C222(aHdrs;22)  //v461 (was 21 elements)
ARRAY TEXT:C222(aObjects;14)
READ ONLY:C145([xxSTR_Niveles:6])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Profesores:4])
READ ONLY:C145([Personas:7])
LIST TO ARRAY:C288("STR_InformesNotas_Objetos";aObjects)

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_formulaNombreDocumento:=$2
End if 

EVS_LoadStyles 

  //USE NAMED SELECTION("◊Editions")

PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
<>stopExec:=False:C215
LIST TO ARRAY:C288("STR_InformesNotas_Idiomas";<>aLang)
<>aLang:=1
<>LangPtr:=Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);<>aLang+7)
WDW_OpenFormWindow (->[Alumnos:2];"Choose_ReportCard";-1;Movable form dialog box:K39:8;__ ("Impresion de la libreta de notas"))
DIALOG:C40([Alumnos:2];"Choose_ReportCard")
CLOSE WINDOW:C154



If (ok=1)
	QR_AjustesImpresion 
	If (ok=1)
		MESSAGES OFF:C175
		CREATE SET:C116([Alumnos:2];"seleccion")
		ARRAY INTEGER:C220(aSelectedNiveles;0)
		AT_DistinctsFieldValues (->[Alumnos:2]nivel_numero:29;->aSelectedNiveles)
		vPeriodo:=atSTR_Periodos_Nombre
		
		For ($i;1;Size of array:C274(aSelectedNiveles))
			USE SET:C118("seleccion")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29=aSelectedNiveles{$i})
			ORDER BY:C49([Alumnos:2];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
			QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=aSelectedNiveles{$i})
			SELECTION TO ARRAY:C260([Alumnos:2];$al_recNums)
			vs_lastRCModel:=popInformes{popInformes}+"/"+String:C10(aSelectedNiveles{$i})
			
			NIVrc_GetSettings 
			
			  //Selección del lenguaje a utilizar
			READ ONLY:C145([xxSTR_TextosInformesNotas:56])
			QUERY:C277([xxSTR_TextosInformesNotas:56];[xxSTR_TextosInformesNotas:56]ID:1=17001)
			BLOB_Blob2Vars (Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);<>aLang+7);0;->$al_indice;->aText1)
			
			  // MOD Ticket N° 188625 Patricio Aliaga
			  // Se corrige indice de ciclos for, ya que se utilizaba la misma variable que del principal
			For ($z;14;20)
				aCdtatitles{$z-13}:=aText1{$z}
			End for 
			aHdrs{1}:=aText1{47}
			For ($z;24;36)
				aHdrs{$z-22}:=aText1{$z}
			End for 
			Case of 
				: (Size of array:C274(atSTR_Periodos_Nombre)=2)
					aHdrs{15}:=aText1{40}
					aHdrs{16}:=aText1{41}
					aHdrs{17}:=""
					aHdrs{18}:=""
					sNote:=aText1{5}+"\r"+aText1{42}+"\r"+aText1{56}
				: (Size of array:C274(atSTR_Periodos_Nombre)=3)
					aHdrs{15}:=aText1{43}
					aHdrs{16}:=aText1{44}
					aHdrs{17}:=aText1{45}
					aHdrs{18}:=""
					sNote:=aText1{5}+"\r"+aText1{46}+"\r"+aText1{56}
				: (Size of array:C274(atSTR_Periodos_Nombre)=4)
					aHdrs{15}:=aText1{63}
					aHdrs{16}:=aText1{64}
					aHdrs{17}:=aText1{65}
					aHdrs{18}:=aText1{66}
					sNote:=aText1{5}+"\r"+aText1{67}+"\r"+aText1{56}
			End case 
			  //por motivos de tamaño de texto se cambia glosa en el informe de notas
			  //JVP 20160811 
			  //aHdrs{19}:=aText1{37}  //promedio
			aHdrs{19}:="Prom"
			  //aHdrs{20}:=aText1{38}  //pondera
			aHdrs{20}:="Pond"
			aHdrs{21}:=aText1{39}  // NF
			aHdrs{22}:=aText1{48}  //P_curso
			aHdrs{22}:="PG"
			  //Arreglo para decision de impresion de conducta
			For ($z;1;Size of array:C274(aCdtaPrints))
				$y_opcion:=Get pointer:C304("bc"+String:C10($z))
				aCdtaPrints{$z}:=($y_opcion->=1)
			End for 
			If (bTitle=1)
				sColegio:=<>gCustom
			Else 
				sColegio:=""
			End if 
			stitle:=aText1{1}
			If (popInformes<3)
				sSubTitle:=atSTR_Periodos_Nombre{vPeriodo}
			Else 
				sSubTitle:=aText1{62}+String:C10(<>gYear)
			End if 
			sParciales:=aText1{2}
			sPromedios:=aText1{6}
			sttlNotas:=aText1{7}
			sName:=aText1{21}
			sClass:=aText1{13}
			If (r2=1)
				<>asNmPtr:=->[Asignaturas:18]Asignatura:3
			Else 
				<>asNmPtr:=->[Asignaturas:18]denominacion_interna:16
			End if 
			Case of 
				: (popInformes=1)
					vb_PrintAverages:=False:C215
					vb_printDetail:=True:C214
				: (popInformes=2)
					vb_PrintAverages:=True:C214
					vb_printDetail:=True:C214
				: (popInformes=3)
					vb_PrintAverages:=True:C214
					vb_printDetail:=False:C215
			End case 
			C_PICTURE:C286(vp_LeftPict;vp_RightPict)
			If (bPrintLogoCol=1)
				READ ONLY:C145([xShell_ApplicationData:45])
				ALL RECORDS:C47([xShell_ApplicationData:45])
				FIRST RECORD:C50([xShell_ApplicationData:45])
				vp_LeftPict:=[xShell_ApplicationData:45]Logo:9
			End if 
			
			
			<>stopExec:=False:C215
			For ($i_Registros;1;Size of array:C274($al_recNums))
				GOTO RECORD:C242([Alumnos:2];$al_recNums{$i_Registros})
				QR_ImprimeFormularioRegistro (->[Alumnos:2];"rep_Libreta2";$t_destinoImpresion;$t_formulaNombreDocumento)
				If (<>stopExec)
					$i_Registros:=Size of array:C274($al_recNums)
				End if 
			End for 
			
		End for 
	End if 
End if 