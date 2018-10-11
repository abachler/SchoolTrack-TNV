//%attributes = {}
  // AScsd_DesconectaHija_UNA()
  // Por: Alberto Bachler K.: 21-03-14, 17:24:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_columnaEnAsignaturaMadre;$l_IdAsignaturaHija;$l_periodo;$l_idAsignaturaMadre)
C_TEXT:C284($t_llaveSubasignatura)

If (False:C215)
	C_LONGINT:C283(AScsd_DesconectaHija_UNA ;$1)
	C_LONGINT:C283(AScsd_DesconectaHija_UNA ;$2)
	C_LONGINT:C283(AScsd_DesconectaHija_UNA ;$3)
End if 

$l_IdAsignaturaHija:=$1
$l_periodo:=$2
$l_columnaEnAsignaturaMadre:=$3
$l_idAsignaturaMadre:=0

If (Count parameters:C259=4)
	$l_idAsignaturaMadre:=$4
End if 

Case of 
	: ($l_IdAsignaturaHija>0)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignaturaHija;True:C214)
		If (vb_CsdVariable)  //si la consolidación es identica para todo el año
			  //AScsd_EliminaReferencias ([Asignaturas]Numero;$l_periodo)  //eliminamos las referencia a asignaturas madres correspondientes al período
			  // 20140610 ASM Para eliminar solo las consolidaciones de la asignatura seleccionada
			AScsd_EliminaReferencias ([Asignaturas:18]Numero:1;$l_periodo;$l_idAsignaturaMadre)  //eliminamos las referencia a asignaturas madres correspondientes al período
			[Asignaturas:18]Consolidacion_Madre_Id:7:=-1
			[Asignaturas:18]Consolidacion_Madre_nombre:8:="Varía según período"
			QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;[Asignaturas:18]Numero:1)
			If (Records in selection:C76([Asignaturas_Consolidantes:231])=0)
				[Asignaturas:18]Consolidacion_Madre_Id:7:=0
				[Asignaturas:18]Consolidacion_Madre_nombre:8:=""
			End if 
		Else 
			  //AScsd_EliminaReferencias ([Asignaturas]Numero)  //eliminamos las referencia a asignaturas madres
			  // 20140610 ASM Para eliminar solo las consolidaciones de la asignatura seleccionada
			AScsd_EliminaReferencias ([Asignaturas:18]Numero:1;0;$l_idAsignaturaMadre)  //eliminamos las referencia a asignaturas madres
			[Asignaturas:18]Consolidacion_Madre_Id:7:=0
			[Asignaturas:18]Consolidacion_Madre_nombre:8:=""
		End if 
		QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;[Asignaturas:18]Numero:1)
		If (Records in selection:C76([Asignaturas_Consolidantes:231])=0)
			[Asignaturas:18]nivel_jerarquico:107:=0
			[Asignaturas:18]ordenGeneral:105:=String:C10([Asignaturas:18]posicion_en_informes_de_notas:36;"000")
		End if 
		SAVE RECORD:C53([Asignaturas:18])
		UNLOAD RECORD:C212([Asignaturas:18])
		READ ONLY:C145([Asignaturas:18])
		
	: ($l_IdAsignaturaHija<0)
		$t_llaveSubasignatura:=String:C10($l_IdAsignaturaHija)+"."+String:C10($l_periodo)+"."+String:C10($l_columnaEnAsignaturaMadre)
		KRL_FindAndLoadRecordByIndex (->[xxSTR_Subasignaturas:83]Referencia:11;->$t_llaveSubasignatura;True:C214)
		[xxSTR_Subasignaturas:83]Columna:13:=0
		SAVE RECORD:C53([xxSTR_Subasignaturas:83])
		
End case 
