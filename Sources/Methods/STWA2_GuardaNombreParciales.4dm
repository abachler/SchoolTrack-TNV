//%attributes = {}
  //AS_GuardaNombreParciales
  //MONO
ARRAY TEXT:C222($at_objRefAsig;0)
ARRAY OBJECT:C1221($ao_objAsig;0)
ARRAY TEXT:C222($at_objRefPeriodo;0)
ARRAY OBJECT:C1221($ao_objPeriodo;0)
ARRAY TEXT:C222($at_nombreParciales;0)
ARRAY BOOLEAN:C223($ab_printDetail;0)
ARRAY BOOLEAN:C223($ab_printDetail;12)
C_LONGINT:C283($i;$p;$l_nodes)
C_TEXT:C284($t_uuid;$t_original;$t_modificado)
C_OBJECT:C1216($o_dataAsig;$1;$o_dataSubAsig;$2;$o_nodo;$o_config)
C_BOOLEAN:C305($b_salvado;$0)

$o_dataAsig:=$1
$o_dataSubAsig:=$2
$userID:=$3  //20180719 ASM Ticket 212409
$b_salvado:=True:C214
$b_registrarLog:=False:C215


START TRANSACTION:C239
  //Parciales Asignaturas
If (Not:C34(OB Is empty:C1297($o_dataAsig)))
	
	$l_nodes:=OB_GetChildNodes ($o_dataAsig;->$at_objRefAsig;->$ao_objAsig)
	
	For ($i;1;Size of array:C274($at_objRefAsig))
		$l_recnum:=Num:C11($at_objRefAsig{$i})
		GOTO RECORD:C242([Asignaturas:18];$l_recnum)
		AS_ReadEvalProperties 
		
		READ WRITE:C146([Asignaturas:18])
		GOTO RECORD:C242([Asignaturas:18];$l_recnum)
		$o_config:=[Asignaturas:18]Configuracion:63
		
		$l_nodes:=OB_GetChildNodes ($ao_objAsig{$i};->$at_objRefPeriodo;->$ao_objPeriodo)
		
		For ($p;1;Size of array:C274($at_objRefPeriodo))
			$t_nodo:=$at_objRefPeriodo{$p}
			OB GET ARRAY:C1229($ao_objPeriodo{$p};"PrintName";$at_nombreParciales)
			$o_nodo:=OB Get:C1224($o_config;$t_nodo)
			OB GET ARRAY:C1229($o_nodo;"PrintDetail";$ab_printDetail)
			
			$t_original:=AT_Arrays2Text (";";";";->atAS_EvalPropPrintName)
			$t_modificado:=AT_Arrays2Text (";";";";->$at_nombreParciales)
			If (Generate digest:C1147($t_original;MD5 digest:K66:1)#Generate digest:C1147($t_modificado;MD5 digest:K66:1))  //20180719 ASM Ticket 212409
				$b_registrarLog:=True:C214
				For ($x;1;Size of array:C274($ab_printDetail))
					$ab_printDetail{$x}:=($at_nombreParciales{$x}#"")
				End for 
			End if 
			OB SET ARRAY:C1227($o_nodo;"PrintName";$at_nombreParciales)
			OB SET ARRAY:C1227($o_nodo;"PrintDetail";$ab_printDetail)
			OB SET:C1220($o_config;$t_nodo;$o_nodo)
		End for 
		
		If (Not:C34(Locked:C147([Asignaturas:18])))
			[Asignaturas:18]Configuracion:63:=$o_config
			SAVE RECORD:C53([Asignaturas:18])
			If ($b_registrarLog)
				Log_RegisterEvtSTW (__ ("Se modifica nombre de parciales en asignatura: ^0 del curso ^1";[Asignaturas:18]Asignatura:3;[Asignaturas:18]Curso:5);$userID)  //20180719 ASM Ticket 212409
			End if 
		Else 
			$b_salvado:=False:C215
		End if 
		KRL_UnloadReadOnly (->[Asignaturas:18])
	End for 
	
End if 

  //Parciales SubAsignaturas
If (Not:C34(OB Is empty:C1297($o_dataSubAsig)))
	ARRAY TEXT:C222($at_nombreParcialesOriginal;0)
	$l_nodes:=OB_GetChildNodes ($o_dataSubAsig;->$at_objRefAsig;->$ao_objAsig)
	
	For ($i;1;Size of array:C274($at_objRefAsig))
		READ WRITE:C146([xxSTR_Subasignaturas:83])
		$t_uuid:=OB Get:C1224($ao_objAsig{$i};"UUID")
		QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Auto_UUID:20=$t_uuid)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[xxSTR_Subasignaturas:83]ID_Mother:6)
		OB GET ARRAY:C1229($ao_objAsig{$i};"aSubEvalNombreParciales";$at_nombreParciales)
		OB GET ARRAY:C1229([xxSTR_Subasignaturas:83]o_Data:21;"aSubEvalNombreParciales";$at_nombreParcialesOriginal)
		$t_original:=AT_Arrays2Text (";";";";->$at_nombreParcialesOriginal)
		$t_modificado:=AT_Arrays2Text (";";";";->$at_nombreParciales)
		
		If (Not:C34(Locked:C147([xxSTR_Subasignaturas:83])))
			If (Generate digest:C1147($t_original;MD5 digest:K66:1)#Generate digest:C1147($t_modificado;MD5 digest:K66:1))  //20180719 ASM Ticket 212409
				OB SET ARRAY:C1227([xxSTR_Subasignaturas:83]o_Data:21;"aSubEvalNombreParciales";$at_nombreParciales)
				SAVE RECORD:C53([xxSTR_Subasignaturas:83])
				$t_original:=AT_Arrays2Text (";";";";->$at_nombreParcialesOriginal)
				$t_modificado:=AT_Arrays2Text (";";";";->$at_nombreParciales)
				Log_RegisterEvtSTW (__ ("Se modifica nombre de parciales en subasignatura: ^0 de la asignatura ^1, curso ^2";[xxSTR_Subasignaturas:83]Name:2;[Asignaturas:18]Asignatura:3;[Asignaturas:18]Curso:5);$userID)  //20180719 ASM Ticket 212409
			End if 
		Else 
			$b_salvado:=False:C215
			$i:=Size of array:C274($at_objRefAsig)
		End if 
		KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
	End for 
	
End if 

If ($b_salvado)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
End if 

$0:=$b_salvado