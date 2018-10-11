//%attributes = {}
  // BBL_LeeConfiguracion()
  // Por: Alberto Bachler: 17/09/13, 12:43:15
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_DATE:C307($d_fecha;$d_fechaInicio;$d_fechaTermino)
C_LONGINT:C283($l_refObjetoOT;$l_refLista)

ARRAY LONGINT:C221($al_refItemsLista;0)

While (Semaphore:C143("Lectura_BBLConfig"))
	DELAY PROCESS:C323(Current process:C322;10)
End while 

READ ONLY:C145([xxBBL_ReglasParaUsuarios:64])
READ ONLY:C145([xxBBL_ReglasParaItems:69])
ALL RECORDS:C47([xxBBL_ReglasParaUsuarios:64])
QUERY:C277([xxBBL_ReglasParaUsuarios:64];[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1="GEN")
If (Records in selection:C76([xxBBL_ReglasParaUsuarios:64])=0)
	CREATE RECORD:C68([xxBBL_ReglasParaUsuarios:64])
	[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1:="GEN"
	[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2:="Genérica"
	[xxBBL_ReglasParaUsuarios:64]Max_Prestamos:3:=2
	[xxBBL_ReglasParaUsuarios:64]Max_Vencidos:4:=1
	[xxBBL_ReglasParaUsuarios:64]Max_Reservas:5:=1
	[xxBBL_ReglasParaUsuarios:64]Dias_Prestamo:8:=14
	[xxBBL_ReglasParaUsuarios:64]Reservas_caducan:10:=1
	[xxBBL_ReglasParaUsuarios:64]Reserva_DiasAnticipacion:9:=0
	[xxBBL_ReglasParaUsuarios:64]Gracia_multa:14:=0
	[xxBBL_ReglasParaUsuarios:64]MultaDiaria:13:=0
	SAVE RECORD:C53([xxBBL_ReglasParaUsuarios:64])
	UNLOAD RECORD:C212([xxBBL_ReglasParaUsuarios:64])
End if 

ALL RECORDS:C47([xxBBL_ReglasParaUsuarios:64])
SELECTION TO ARRAY:C260([xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;<>aPrefUsr;[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2;<>aPrefUsrName)
SORT ARRAY:C229(<>aPrefUsr;<>aPrefUsrName;>)

BBL_LeeReglasPorDefecto 
QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1="GEN")
If (Records in selection:C76([xxBBL_ReglasParaItems:69])=0)
	CREATE RECORD:C68([xxBBL_ReglasParaItems:69])
	[xxBBL_ReglasParaItems:69]Codigo_regla:1:="GEN"
	[xxBBL_ReglasParaItems:69]Nombre Regla:2:="Genérica"
	[xxBBL_ReglasParaItems:69]DiasPrestamo:3:=14
	[xxBBL_ReglasParaItems:69]Dias_gracia:4:=3
	[xxBBL_ReglasParaItems:69]Multa_diaria:5:=0
	[xxBBL_ReglasParaItems:69]Max_renovacione:6:=1
	[xxBBL_ReglasParaItems:69]Reserva_anticipación:7:=2
	SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
	UNLOAD RECORD:C212([xxBBL_ReglasParaItems:69])
End if 
QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1="SYS")
If (Records in selection:C76([xxBBL_ReglasParaItems:69])=0)
	CREATE RECORD:C68([xxBBL_ReglasParaItems:69])
	[xxBBL_ReglasParaItems:69]Codigo_regla:1:="SYS"
	[xxBBL_ReglasParaItems:69]Nombre Regla:2:="Sistema"
	SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
	UNLOAD RECORD:C212([xxBBL_ReglasParaItems:69])
End if 

ALL RECORDS:C47([xxBBL_ReglasParaItems:69])
SELECTION TO ARRAY:C260([xxBBL_ReglasParaItems:69]Codigo_regla:1;<>aPrefDoc;[xxBBL_ReglasParaItems:69]Nombre Regla:2;<>aPrefDocName)
SORT ARRAY:C229(<>aPrefDoc;<>aPrefDocName;>)
If (Records in table:C83([xxBBL_Preferencias:65])=0)
	CREATE RECORD:C68([xxBBL_Preferencias:65])
	[xxBBL_Preferencias:65]Registro_BarCodeConPrefijo:32:=True:C214
	[xxBBL_Preferencias:65]Dias prestamo:9:=14
	[xxBBL_Preferencias:65]Dias gracia:11:=0
	[xxBBL_Preferencias:65]Multa diaria:10:=0
	[xxBBL_Preferencias:65]DiasReserva:20:=2
	[xxBBL_Preferencias:65]MaxRenovaciones:21:=1
	[xxBBL_Preferencias:65]AutoCreatCpy:24:=True:C214
	[xxBBL_Preferencias:65]CharsToIndex:25:=2
	[xxBBL_Preferencias:65]RefCampo_BarCodeLectores:33:=Field:C253(->[BBL_Lectores:72]ID:1)
	[xxBBL_Preferencias:65]Lector_PrefijoCodigoBarra:34:="LEC"
	[xxBBL_Preferencias:65]Registro_CampoFuenteBarcode:27:=Field:C253(->[BBL_Registros:66]No_Registro:25)
	[xxBBL_Preferencias:65]Registro_PrefijoCodigoBarra:23:="REG"
	[xxBBL_Preferencias:65]Usa_MARC:38:=False:C215
	SAVE RECORD:C53([xxBBL_Preferencias:65])
	UNLOAD RECORD:C212([xxBBL_Preferencias:65])
End if 

ST_LoadModuleFormatExceptions 

ARRAY TEXT:C222(<>aPlaceCode;0)
ARRAY TEXT:C222(<>aPlace;0)
BLOB_Variables2Blob (->$x_blob;0;-><>aPlaceCode;-><>aPlace)
$x_blob:=PREF_fGetBlob (0;"Lugares Biblioteca";$x_blob)
BLOB_Blob2Vars (->$x_blob;0;-><>aPlaceCode;-><>aPlace)

SET BLOB SIZE:C606($x_blob;0)
$x_blob:=PREF_fGetBlob (0;"BBL_ListaInteres";$x_blob)
If (BLOB size:C605($x_blob)=0)
	$l_refLista:=Load list:C383("BBL_Interes")
	<>hl_InterestList:=Copy list:C626($l_refLista)
	PREF_SetBlob (0;"BBL_ListaInteres";$x_blob)
Else 
	<>hl_InterestList:=BLOB to list:C557($x_blob)
End if 
SET BLOB SIZE:C606($x_blob;0)
ARRAY TEXT:C222(<>atBBL_Interest;0)
HL_CopyReferencedListToArray (<>hl_InterestList;-><>atBBL_Interest)

READ ONLY:C145([xxBBL_Preferencias:65])
ALL RECORDS:C47([xxBBL_Preferencias:65])
FIRST RECORD:C50([xxBBL_Preferencias:65])

<>MTi_LnDay:=[xxBBL_Preferencias:65]Dias prestamo:9
<>MTi_GrDay:=[xxBBL_Preferencias:65]Dias gracia:11
<>MTr_Fine:=[xxBBL_Preferencias:65]Multa diaria:10
<>MTi_RsDays:=[xxBBL_Preferencias:65]DiasReserva:20
<>MTi_Renov:=[xxBBL_Preferencias:65]MaxRenovaciones:21

<>MTv_AutoCop:=[xxBBL_Preferencias:65]AutoCreatCpy:24
<>MTs_BBLName:=[xxBBL_Preferencias:65]Nombre:1
<>MTi_MinChar:=[xxBBL_Preferencias:65]CharsToIndex:25

<>bBBL_BarcodeRegistroConPrefijo:=[xxBBL_Preferencias:65]Registro_BarCodeConPrefijo:32
<>bBBL_BarcodeLectorConPrefijo:=[xxBBL_Preferencias:65]Lector_BarCodeConPrefijo:35

<>gUsaMARC:=[xxBBL_Preferencias:65]Usa_MARC:38
<>gBBL_NombreBiblioteca:=[xxBBL_Preferencias:65]Nombre:1
<>gBBL_BibliotecaPrincipal:=[xxBBL_Preferencias:65]Lugar principal:29

BBL_LeePrefsCodigosBarra 

ARRAY TEXT:C222(<>aExAuto;0)
LIST TO ARRAY:C288("BBL_ExcepcionesIndexacion";<>aExAuto)
AT_Text2Array (-><>aExAuto;[xxBBL_Preferencias:65]Exclusiones:17;"\r")

ARRAY TEXT:C222(<>atBBL_Command;0)
LIST TO ARRAY:C288("BBL_ComandosConsola_Etiquetas";<>atBBL_Command;$al_refItemsLista)
SORT ARRAY:C229($al_refItemsLista;<>atBBL_Command;>)

ARRAY TEXT:C222(<>atBBL_CommandCode;0)
LIST TO ARRAY:C288("BBL_ComandosConsola_Codigos";<>atBBL_CommandCode;$al_refItemsLista)
SORT ARRAY:C229($al_refItemsLista;<>atBBL_CommandCode;>)

ARRAY TEXT:C222(<>aQltAutor;0)
LIST TO ARRAY:C288("BBL_CalidadAutor";<>aQltAutor)

ARRAY TEXT:C222(<>aNivReg;0)
LIST TO ARRAY:C288("BBL_NivelesRegistro";<>aNivReg)

ARRAY TEXT:C222(<>aSF600;6)
ARRAY TEXT:C222(<>aSF600c;6)
<>aSF600{1}:="Calificación"
<>aSF600c{1}:="q"
<>aSF600{2}:="Titulos y otros asociados"
<>aSF600c{2}:="c"
<>aSF600{3}:="Fechas"
<>aSF600c{3}:="d"
<>aSF600{4}:="Subdivisión temática"
<>aSF600c{4}:="x"
<>aSF600{5}:="Subdivisión cronológica"
<>aSF600c{5}:="y"
<>aSF600{6}:="Subdivisión geográfica"
<>aSF600c{6}:="z"

ARRAY TEXT:C222(<>aSF650;3)
ARRAY TEXT:C222(<>aSF650c;3)
<>aSF650{1}:="Subdivión general"
<>aSF650c{1}:="x"
<>aSF650{2}:="Subdivisión cronológica"
<>aSF650c{2}:="y"
<>aSF650{3}:="Subdivisión geográfica"
<>aSF650c{3}:="z"

UNLOAD RECORD:C212([xxBBL_Preferencias:65])
READ ONLY:C145([xxBBL_Preferencias:65])

PERIODOS_Init 
QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1=-2)
If (Records in selection:C76([xxSTR_Periodos:100])=0)
	QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1=-1)
	DUPLICATE RECORD:C225([xxSTR_Periodos:100])
	[xxSTR_Periodos:100]Nombre_Configuracion:2:="Biblioteca"
	[xxSTR_Periodos:100]ID:1:=-2
	[xxSTR_Periodos:100]Inicio_Ejercicio:4:=DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*)))
	[xxSTR_Periodos:100]Fin_Ejercicio:5:=DT_GetDateFromDayMonthYear (31;12;Year of:C25(Current date:C33(*)))
	[xxSTR_Periodos:100]Tipo_de_Periodos:3:=0
	SET BLOB SIZE:C606([xxSTR_Periodos:100]Horarios:8;0)
	SET BLOB SIZE:C606([xxSTR_Periodos:100]Feriados:7;0)
	[xxSTR_Periodos:100]Auto_UUID:13:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
	SAVE RECORD:C53([xxSTR_Periodos:100])
	$d_fechaInicio:=DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*)))
	$d_fechaTermino:=DT_GetDateFromDayMonthYear (31;12;Year of:C25(Current date:C33(*)))
	$d_fecha:=$d_fechaInicio
	  //lectura de los feriados
	ARRAY DATE:C224(adSTR_Calendario_Feriados;0)
	$l_refObjetoOT:=OT BLOBToObject ([xxSTR_Periodos:100]Feriados:7)
	OT GetArray ($l_refObjetoOT;"adSTR_Calendario_Feriados";adSTR_Calendario_Feriados)
	OT Clear ($l_refObjetoOT)
	Repeat 
		If (Day number:C114($d_fecha)=1)
			If (Find in array:C230(adSTR_Calendario_Feriados;$d_fecha)=-1)
				AT_Insert (0;1;->adSTR_Calendario_Feriados)
				adSTR_Calendario_Feriados{Size of array:C274(adSTR_Calendario_Feriados)}:=$d_fecha
			End if 
		End if 
		$d_fecha:=$d_fecha+1
	Until ($d_fecha>$d_fechaTermino)
	
	  //almacenaje de los feriados
	$l_refObjetoOT:=OT New 
	OT PutArray ($l_refObjetoOT;"adSTR_Calendario_Feriados";adSTR_Calendario_Feriados)
	$x_blob:=OT ObjectToNewBLOB ($l_refObjetoOT)
	[xxSTR_Periodos:100]Feriados:7:=$x_blob
	OT Clear ($l_refObjetoOT)
	SAVE RECORD:C53([xxSTR_Periodos:100])
	UNLOAD RECORD:C212([xxSTR_Periodos:100])
End if 
PERIODOS_LoadData (0;-2)

CLEAR SEMAPHORE:C144("Lectura_BBLConfig")