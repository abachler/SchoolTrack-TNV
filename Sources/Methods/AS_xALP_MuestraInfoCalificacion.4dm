//%attributes = {}
  // AS_xALP_MuestraInfoCalificacion()
  // Por: Alberto Bachler K.: 04-02-14, 17:21:46
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($l_fila;$1;$l_columna;$2;$3)
C_POINTER:C301($y_campo)
C_TEXT:C284(t_infoAsociada;$t_infoExtraFieldName)  //MONO TICKET 186392
$l_fila:=$1
$l_columna:=$2
$l_eventoALP:=$3
vi_Parcial:=Abs:C99($l_columna-vi_PrimeraColumnaParciales)+1
$l_periodo:=aiSTR_Periodos_Numero{atSTR_Periodos_Nombre}


ARRAY TEXT:C222($at_nombreArreglos;0)
ARRAY TEXT:C222($at_encabezados;0)
$l_error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Source;$at_nombreArreglos)
$l_error:=AL_GetObjects (xALP_ASNotas;ALP_Object_HeaderText;$at_encabezados)


Case of 
	: ($at_nombreArreglos{$l_columna}="aNtaP1")
		$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]P01_Final_Literal:116)
	: ($at_nombreArreglos{$l_columna}="aNtaP2")
		$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]P02_Final_Literal:191)
	: ($at_nombreArreglos{$l_columna}="aNtaP3")
		$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]P03_Final_Literal:266)
	: ($at_nombreArreglos{$l_columna}="aNtaP4")
		$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]P04_Final_Literal:341)
	: ($at_nombreArreglos{$l_columna}="aNtaP5")
		$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]P05_Final_Literal:416)
	: ($at_nombreArreglos{$l_columna}="aNtaEXP")
		vi_Parcial:=0
		Case of   //MONO TICKET 186392
			: ($l_periodo=1)
				$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]P01_Control_Literal:111)
				$y_infoExtra:=->[Alumnos_Calificaciones:208]P01_Presentacion_Literal:106
				$t_infoExtraFieldName:=__ ("Periodo 1 promedio de presentación")
			: ($l_periodo=2)
				$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]P02_Control_Literal:186)
				$y_infoExtra:=->[Alumnos_Calificaciones:208]P02_Presentacion_Literal:181
				$t_infoExtraFieldName:=__ ("Periodo 2 promedio de presentación")
			: ($l_periodo=3)
				$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]P03_Control_Literal:261)
				$y_infoExtra:=->[Alumnos_Calificaciones:208]P03_Presentacion_Literal:256
				$t_infoExtraFieldName:=__ ("Periodo 3 promedio de presentación")
			: ($l_periodo=4)
				$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]P04_Control_Literal:336)
				$y_infoExtra:=->[Alumnos_Calificaciones:208]P04_Presentacion_Literal:331
				$t_infoExtraFieldName:=__ ("Periodo 4 promedio de presentación")
			: ($l_periodo=5)
				$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]P05_Control_Literal:411)
				$y_infoExtra:=->[Alumnos_Calificaciones:208]P05_Presentacion_Literal:406
				$t_infoExtraFieldName:=__ ("Periodo 5 promedio de presentación")
		End case 
		
	: ($at_nombreArreglos{$l_columna}="aNtaPF")
		$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]Anual_Literal:15)
		
	: ($at_nombreArreglos{$l_columna}="aNtaEX")
		$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]ExamenAnual_Literal:20)
		
	: ($at_nombreArreglos{$l_columna}="aNtaEXX")
		$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]ExamenExtra_Literal:25)
		
	: ($at_nombreArreglos{$l_columna}="aNtaF")
		$l_numeroCampo:=Field:C253(->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30)
		
	Else 
		
		Case of 
			: ($l_periodo=1)
				$l_numeroCampo:=42+((vi_Parcial-1)*5)+4
			: ($l_periodo=2)
				$l_numeroCampo:=117+((vi_Parcial-1)*5)+4
			: ($l_periodo=3)
				$l_numeroCampo:=192+((vi_Parcial-1)*5)+4
			: ($l_periodo=4)
				$l_numeroCampo:=267+((vi_Parcial-1)*5)+4
			: ($l_periodo=5)
				$l_numeroCampo:=342+((vi_Parcial-1)*5)+4
		End case 
		
End case 


$l_recNum:=aNtaRecNum{$l_fila}
KRL_GotoRecord (->[Alumnos_Calificaciones:208];$l_recNum)
vs_Key:=[Alumnos_Calificaciones:208]Llave_principal:1+"."+String:C10($l_numeroCampo)

$y_campo:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$l_numeroCampo)

$t_tituloVentana:="Información de la calificación"
$l_recNum:=KRL_FindAndLoadRecordByIndex (->[xxSTR_InfoCalificaciones:142]Llave:1;->vs_Key;True:C214)

  //MONO TICKET 186392
If (Not:C34(Is nil pointer:C315($y_infoExtra)))
	t_infoAsociada:="Información relacionada, "+$t_infoExtraFieldName+": "+$y_infoExtra->
Else 
	t_infoAsociada:=""
End if 

If ($l_recNum<0)
	Case of 
		: ($l_eventoALP=AL Single click event)
			BEEP:C151
			$t_itemsPopup:=""
		: ($l_eventoALP=AL Single Control Click)
			$t_itemsPopup:="("+__ ("Información de la calificación")
	End case 
Else 
	Case of 
		: ($l_eventoALP=AL Single click event)
			$t_itemsPopup:=""
		: ($l_eventoALP=AL Single Control Click)
			$t_itemsPopup:=__ ("Información de la calificación")
	End case 
End if 

If ($t_itemsPopup#"")
	$l_ItemSeleccionado:=Pop up menu:C542($t_itemsPopup;-1)
Else 
	$l_ItemSeleccionado:=1
End if 

If (($l_ItemSeleccionado=1) & ($l_recNum>0))
	WDW_OpenFormWindow (->[xxSTR_InfoCalificaciones:142];"InfoCalificacion";7;Movable form dialog box:K39:8;$t_tituloVentana)
	KRL_ModifyRecord (->[xxSTR_InfoCalificaciones:142];"InfoCalificacion")
End if 
CLOSE WINDOW:C154

