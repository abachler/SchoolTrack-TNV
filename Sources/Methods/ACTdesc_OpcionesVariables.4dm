//%attributes = {}
  //ACTdesc_OpcionesVariables

  //20121017 RCH Metodo creado para centralizar trabajo con variables de descuentos. de a poco hay que agregar casos.

C_TEXT:C284($vt_accion)
C_POINTER:C301($varHijo;$varFamilia;$varTramo)
C_POINTER:C301($vy_pointer1;$vy_pointer2;$vy_pointer3;$vy_pointer4;$vy_pointer5)
C_POINTER:C301(${2})
C_LONGINT:C283($vl_idItem)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 
If (Count parameters:C259>=5)
	$vy_pointer4:=$5
End if 

Case of 
	: ($vt_accion="DeclaraVars")
		C_REAL:C285(vr_Hijo1;vr_Hijo2;vr_Hijo3;vr_Hijo4;vr_Hijo5;vr_Hijo6;vr_Hijo7;vr_Hijo8;vr_Hijo9;vr_Hijo10;vr_Hijo11;vr_Hijo12;vr_Hijo13;vr_Hijo14;vr_Hijo15;vr_Hijo16;vr_Hijo17)
		C_REAL:C285(vr_Tramo1;vr_Tramo2;vr_Tramo3;vr_Tramo4;vr_Tramo5;vr_Tramo6;vr_Tramo7;vr_Tramo8;vr_Tramo9;vr_Tramo10;vr_Tramo11;vr_Tramo12;vr_Tramo13;vr_Tramo14;vr_Tramo15;vr_Tramo16)
		C_REAL:C285(vr_Familia1;vr_Familia2;vr_Familia3;vr_Familia4;vr_Familia5;vr_Familia6;vr_Familia7;vr_Familia8;vr_Familia9;vr_Familia10;vr_Familia11;vr_Familia12;vr_Familia13;vr_Familia14;vr_Familia15;vr_Familia16;vr_Familia17)
		
	: ($vt_accion="InitVars")
		For ($i;2;17)
			$varHijo:=Get pointer:C304("vr_Hijo"+String:C10($i))
			$varFamilia:=Get pointer:C304("vr_Familia"+String:C10($i))
			$varTramo:=Get pointer:C304("vr_Tramo"+String:C10($i-1))
			$varHijo->:=0
			$varFamilia->:=0
			$varTramo->:=0
		End for 
		
	: ($vt_accion="DeclaraInitLee")
		$vl_idItem:=$vy_pointer1->
		ACTdesc_OpcionesVariables ("DeclaraInit")
		ACTdesc_OpcionesVariables ("LeeConfItem";->$vl_idItem)
		
	: ($vt_accion="DeclaraInit")
		ACTdesc_OpcionesVariables ("DeclaraVars")
		ACTdesc_OpcionesVariables ("InitVars")
		
	: ($vt_accion="LeeConfItem")
		  //ACTdesc_OpcionesVariables ("LeeConfItem")
		$vl_idItem:=$vy_pointer1->
		ACTdesc_OpcionesVariables ("LeeConfItemDH";->$vl_idItem)
		ACTdesc_OpcionesVariables ("LeeConfItemDI";->$vl_idItem)
		ACTdesc_OpcionesVariables ("LeeConfItemDF";->$vl_idItem)
		
	: ($vt_accion="LeeConfItemDH")
		$vl_idItem:=$vy_pointer1->
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$vl_idItem)
		BLOB_Blob2Vars (->[xxACT_Items:179]Descuentos_hijos:14;0;->vr_Hijo2;->vr_Hijo3;->vr_Hijo4;->vr_Hijo5;->vr_Hijo6;->vr_Hijo7;->vr_Hijo8;->vr_Hijo9;->vr_Hijo10;->vr_Hijo11;->vr_Hijo12;->vr_Hijo13;->vr_Hijo14;->vr_Hijo15;->vr_Hijo16;->vr_Hijo17)
		
	: ($vt_accion="LeeConfItemDI")
		$vl_idItem:=$vy_pointer1->
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$vl_idItem)
		BLOB_Blob2Vars (->[xxACT_Items:179]Descuentos_Ingreso:16;0;->vr_Tramo1;->vr_Tramo2;->vr_Tramo3;->vr_Tramo4;->vr_Tramo5;->vr_Tramo6;->vr_Tramo7;->vr_Tramo8;->vr_Tramo9;->vr_Tramo10;->vr_Tramo11;->vr_Tramo12;->vr_Tramo13;->vr_Tramo14;->vr_Tramo15;->vr_Tramo16)
		
	: ($vt_accion="LeeConfItemDF")
		$vl_idItem:=$vy_pointer1->
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$vl_idItem)
		BLOB_Blob2Vars (->[xxACT_Items:179]Descuento_Familia:32;0;->vr_Familia2;->vr_Familia3;->vr_Familia4;->vr_Familia5;->vr_Familia6;->vr_Familia7;->vr_Familia8;->vr_Familia9;->vr_Familia10;->vr_Familia11;->vr_Familia12;->vr_Familia13;->vr_Familia14;->vr_Familia15;->vr_Familia16;->vr_Familia17)
		
	: ($vt_accion="LeeValidaVariablesDescuentos")
		C_POINTER:C301($vy_numeroHijo;$vy_numeroCargas;$vy_descIndividual;$vy_tramoIngreso)
		$vy_numeroHijo:=$vy_pointer1
		$vy_numeroCargas:=$vy_pointer2
		$vy_descIndividual:=$vy_pointer3
		$vy_tramoIngreso:=$vy_pointer4
		
		$vy_numeroHijo->:=[ACT_CuentasCorrientes:175]Numero_Hijo:10
		$vy_descIndividual->:=[ACT_CuentasCorrientes:175]Descuento:23
		
		If (Not:C34(Undefined:C82(<>atACT_TramosIngreso)))
			$vy_tramoIngreso->:=Find in array:C230(<>atACT_TramosIngreso;[Personas:7]ACT_TramoIngresos:66)
		Else 
			$vy_tramoIngreso->:=0
		End if 
		$vy_numeroCargas->:=[Personas:7]ACT_NumCargas:65
		If ($vy_numeroCargas->=0)
			$vy_numeroCargas->:=1
		End if 
		If ($vy_numeroCargas->>17)
			$vy_numeroCargas->:=17
		End if 
		If ($vy_numeroHijo->=0)  //por si el chiquillo está en admision!!!
			$vy_numeroHijo->:=1
		End if 
		If ($vy_numeroHijo->>17)
			$vy_numeroHijo->:=17
		End if 
		
	: ($vt_accion="AsignaTextoDescuento")
		C_REAL:C285($descuento;$desctoFijo;$desctosPlata)
		$descuento:=$vy_pointer1->
		$desctoFijo:=$vy_pointer2->
		$desctosPlata:=$vy_pointer3->
		
		  //20120616 RCH Se centraliza la obtencion del texto "descuento"...
		$vt_textoDescto:=ACTcar_OpcionesGenerales ("ObtieneTextoDescuento")
		If (Position:C15($vt_textoDescto;[ACT_Cargos:173]Glosa:12)#0)
			[ACT_Cargos:173]Glosa:12:=Substring:C12([ACT_Cargos:173]Glosa:12;1;Position:C15($vt_textoDescto;[ACT_Cargos:173]Glosa:12)-1)
		End if 
		
		Case of 
			: (($descuento>0) & ($descuento<100) & ($desctoFijo=0))
				[ACT_Cargos:173]Glosa:12:=[ACT_Cargos:173]Glosa:12+$vt_textoDescto+String:C10($descuento;"|Pct_2DecIfNec")+")"
			: (($descuento>=100) & ($desctoFijo=0))
				[ACT_Cargos:173]Glosa:12:=[ACT_Cargos:173]Glosa:12+$vt_textoDescto+"100%)"
			: ($desctoFijo>0)
				[ACT_Cargos:173]Glosa:12:=[ACT_Cargos:173]Glosa:12+$vt_textoDescto+String:C10($desctoFijo+$desctosPlata;"|Despliegue_ACT")+")"
		End case 
		
End case 