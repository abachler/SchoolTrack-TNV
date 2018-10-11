//%attributes = {}
  //ACTcc_LoadCargosIntoArrays

  //carga la seleccion actual de cargos en arreglos y luego los ordena de acuerdo con preferencia...
C_BOOLEAN:C305($1;$cargarGlosasImpresion)
C_POINTER:C301($2;$3;$varAfecta;$varExenta;$varTotal2;$varTotal3;$varTotal4;$varIVA)
C_REAL:C285(cbCrearDctosEnLineasSeparadas)
C_BOOLEAN:C305($b_DTECLG)

$sum:=False:C215
$intereses:=False:C215
$iva:=False:C215
Case of 
	: (Count parameters:C259=1)
		$cargarGlosasImpresion:=$1
	: (Count parameters:C259=3)
		$cargarGlosasImpresion:=$1
		$varAfecta:=$2
		$varExenta:=$3
		$sum:=True:C214
	: (Count parameters:C259=6)
		$cargarGlosasImpresion:=$1
		$varAfecta:=$2
		$varExenta:=$3
		$varTotal2:=$4
		$varTotal3:=$5
		$varTotal4:=$6
		$sum:=True:C214
		$intereses:=True:C214
	: (Count parameters:C259=7)
		$cargarGlosasImpresion:=$1
		$varAfecta:=$2
		$varExenta:=$3
		$varTotal2:=$4
		$varTotal3:=$5
		$varTotal4:=$6
		$varIVA:=$7
		$sum:=True:C214
		$intereses:=True:C214
		$iva:=True:C214
		
	: (Count parameters:C259=11)
		$cargarGlosasImpresion:=$1
		$varAfecta:=$2
		$varExenta:=$3
		$varTotal2:=$4
		$varTotal3:=$5
		$varTotal4:=$6
		$varIVA:=$7
		$sum:=$8
		$intereses:=$9
		$iva:=$10
		$b_DTECLG:=$11
		
End case 

ARRAY DATE:C224(adACT_CFechaEmision;0)
ARRAY DATE:C224(adACT_CFechaVencimiento;0)
ARRAY TEXT:C222(atACT_CAlumno;0)
ARRAY TEXT:C222(atACT_CAlumnoCurso;0)
ARRAY TEXT:C222(atACT_CAlumnoNivelNombre;0)
ARRAY TEXT:C222(atACT_CAlumnoPCurso;0)
ARRAY TEXT:C222(atACT_CAlumnoPNivelNombre;0)
ARRAY TEXT:C222(atACT_CGlosa;0)
ARRAY REAL:C219(arACT_CMontoNeto;0)
ARRAY REAL:C219(arACT_CIntereses;0)
ARRAY REAL:C219(arACT_CSaldo;0)
ARRAY LONGINT:C221(alACT_RecNumsCargos;0)
ARRAY LONGINT:C221(alACT_CRefs;0)
ARRAY LONGINT:C221(alACT_CIDCtaCte;0)
_O_ARRAY STRING:C218(2;asACT_Marcas;0)
ARRAY REAL:C219(arACT_MontoMoneda;0)
ARRAY TEXT:C222(atACT_MonedaCargo;0)
ARRAY TEXT:C222(atACT_MonedaSimbolo;0)
ARRAY TEXT:C222(atACT_CGlosaImpresion;0)
ARRAY REAL:C219(arACT_TasaIVA;0)
ARRAY REAL:C219(arACT_MontoPagado;0)
ARRAY REAL:C219(arACT_MontoIVA;0)
ARRAY REAL:C219(arACT_CTotalDesctos;0)
ARRAY LONGINT:C221(aIDCta;0)
ARRAY LONGINT:C221(alACT_MesCargo;0)
ARRAY LONGINT:C221(alACT_AñoCargo;0)
ARRAY TEXT:C222(atACT_MesCargo;0)
ARRAY TEXT:C222(atACT_CAlumnoNoMatricula;0)
ARRAY TEXT:C222(atACT_AñoCargo;0)

ARRAY TEXT:C222(atACT_CAlumnoRUT;0)

ARRAY TEXT:C222(atACT_unidadCargo;0)

ARRAY OBJECT:C1221($ao_objetos;0)

If (cbCrearDctosEnLineasSeparadas=1)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EsRelativo:10=False:C215)
End if 
$CuantosCargos:=Records in selection:C76([ACT_Cargos:173])
SELECTION TO ARRAY:C260([ACT_Cargos:173];alACT_RecNumsCargos;[ACT_Cargos:173]FechaEmision:22;adACT_CFechaEmision;[ACT_Cargos:173]Fecha_de_Vencimiento:7;adACT_CFechaVencimiento;[ACT_Cargos:173]Glosa:12;atACT_CGlosa;[ACT_Cargos:173]Monto_Neto:5;arACT_CMontoNeto;[ACT_Cargos:173]Intereses:29;arACT_CIntereses;[ACT_Cargos:173]Saldo:23;arACT_CSaldo;[ACT_Cargos:173]ID_CuentaCorriente:2;alACT_IDCtaCte;[ACT_Cargos:173]Ref_Item:16;alACT_CRefs;[ACT_Cargos:173]ID_CuentaCorriente:2;alACT_CIDCtaCte;*)
SELECTION TO ARRAY:C260([ACT_Cargos:173]Monto_Moneda:9;arACT_MontoMoneda;[ACT_Cargos:173]Moneda:28;atACT_MonedaCargo;[ACT_Cargos:173]MontosPagados:8;arACT_MontoPagado;[ACT_Cargos:173]Monto_IVA:20;arACT_MontoIVA;[ACT_Cargos:173]TasaIVA:21;arACT_TasaIVA;*)
SELECTION TO ARRAY:C260([ACT_Cargos:173]Total_Desctos:45;arACT_CTotalDesctos;[ACT_Cargos:173]Mes:13;alACT_MesCargo;[ACT_Cargos:173]Año:14;alACT_AñoCargo;[ACT_Cargos:173]OB_Responsable:70;$ao_objetos;*)
SELECTION TO ARRAY:C260


AT_CopyArrayElements (->alACT_AñoCargo;->atACT_AñoCargo)

_O_ARRAY STRING:C218(2;asACT_Marcas;$CuantosCargos)
ARRAY TEXT:C222(atACT_CAlumno;$CuantosCargos)
ARRAY TEXT:C222(atACT_CAlumnoCurso;$CuantosCargos)
ARRAY TEXT:C222(atACT_CAlumnoNivelNombre;$CuantosCargos)
ARRAY TEXT:C222(atACT_CAlumnoPCurso;$CuantosCargos)
ARRAY TEXT:C222(atACT_CAlumnoPNivelNombre;$CuantosCargos)
ARRAY TEXT:C222(atACT_MonedaSimbolo;$CuantosCargos)
ARRAY TEXT:C222(atACT_CGlosaImpresion;$Cuantoscargos)
_O_ARRAY STRING:C218(2;asACT_Afecto;$CuantosCargos)
ARRAY TEXT:C222(atACT_MesCargo;$CuantosCargos)
ARRAY TEXT:C222(atACT_CAlumnoNoMatricula;$CuantosCargos)

ARRAY TEXT:C222(atACT_CAlumnoRUT;$CuantosCargos)

ARRAY TEXT:C222(atACT_unidadCargo;$CuantosCargos)

READ ONLY:C145([Alumnos:2])
For ($j;1;$CuantosCargos)
	
	atACT_MesCargo{$j}:=<>atXS_MonthNames{alACT_MesCargo{$j}}
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=alACT_IDCtaCte{$j})
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	atACT_CAlumno{$j}:=[Alumnos:2]apellidos_y_nombres:40
	atACT_CAlumnoCurso{$j}:=[Alumnos:2]curso:20
	atACT_CAlumnoNivelNombre{$j}:=[Alumnos:2]Nivel_Nombre:34
	atACT_CAlumnoNoMatricula{$j}:=[Alumnos:2]numero_de_matricula:51
	
	atACT_CAlumnoRUT{$j}:=SR_FormatoRUT2 ([Alumnos:2]RUT:5)
	
	C_LONGINT:C283($proximoNivel)
	If ([Alumnos:2]nivel_numero:29<=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)-1})
		$el:=Find in array:C230(<>al_NumeroNivelRegular;[Alumnos:2]nivel_numero:29)
		If (($el>0) & ($el<Size of array:C274(<>al_NumeroNivelRegular)))
			$proximoNivel:=<>al_NumeroNivelRegular{$el+1}
		End if 
		atACT_CAlumnoPCurso{$j}:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$proximoNivel;->[xxSTR_Niveles:6]Abreviatura:19)+Substring:C12([Alumnos:2]curso:20;Position:C15("-";[Alumnos:2]curso:20)+1)
		atACT_CAlumnoPNivelNombre{$j}:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$proximoNivel;->[xxSTR_Niveles:6]Nivel:1)
	Else 
		atACT_CAlumnoPCurso{$j}:=""
		atACT_CAlumnoPNivelNombre{$j}:=""
	End if 
	
	If ($cargarGlosasImpresion)
		READ ONLY:C145([xxACT_Items:179])
		GOTO RECORD:C242([ACT_Cargos:173];alACT_RecNumsCargos{$j})
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
		atACT_CGlosaImpresion{$j}:=[xxACT_Items:179]Glosa_de_Impresión:20
		If (atACT_CGlosaImpresion{$j}="")
			atACT_CGlosaImpresion{$j}:=atACT_CGlosa{$j}
		End if 
	End if 
	If ($sum)
		$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
		If (arACT_TasaIVA{$j}>0)
			asACT_Afecto{$j}:="SI"
			$varAfecta->:=$varAfecta->+$vr_monto
		Else 
			asACT_Afecto{$j}:="NO"
			$varExenta->:=$varExenta->+$vr_monto
		End if 
	End if 
	If ($iva)
		$varIVA->:=$varIVA->+arACT_MontoIVA{$j}
	End if 
	If ($intereses)
		$ints2:=ACTutl_EstimaInteres ([ACT_Cargos:173]ID:1;[ACT_Avisos_de_Cobranza:124]Fecha_Pago2:18)
		$ints3:=ACTutl_EstimaInteres ([ACT_Cargos:173]ID:1;[ACT_Avisos_de_Cobranza:124]Fecha_Pago3:19)
		$ints4:=ACTutl_EstimaInteres ([ACT_Cargos:173]ID:1;[ACT_Avisos_de_Cobranza:124]Fecha_Pago4:20)
		$varTotal2->:=$varTotal2->+$ints2+(Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*))))
		$varTotal3->:=$varTotal3->+$ints3+(Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*))))
		$varTotal4->:=$varTotal4->+$ints4+(Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*))))
	End if 
	
	atACT_unidadCargo{$j}:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->alACT_CRefs{$j};->[xxACT_Items:179]Unidad_de_Medida:46)
	
	If ((cb_SepararCargosXPct=1) & (cb_SepararACsXPct=0))
		C_LONGINT:C283($l_idResp)
		$l_idResp:=OB Get:C1224(ACTcc_DividirEmision ("ObtieneIdsResponsablesDesdeObjeto";->$ao_objetos{$j});"id_responsable")
		If ($l_idResp>0)
			atACT_CAlumno{$j}:=atACT_CAlumno{$j}+" - "+KRL_GetTextFieldData (->[Personas:7]No:1;->$l_idResp;->[Personas:7]Apellidos_y_nombres:30)
		End if 
	End if 
End for 
ACTpgs_OrdenaCargos ($b_DTECLG)
ACTpgs_SimboloMoneda 

  //se utiliza para imprimir las boletas
ARRAY LONGINT:C221(alACT_RecNumsCargosT;0)
ARRAY TEXT:C222(atACT_RecNumsCargosT;0)
ARRAY TEXT:C222(atACT_RecNumsCargosCat;0)
ARRAY TEXT:C222(atACT_RecNumsCargosAgr;0)
COPY ARRAY:C226(alACT_RecNumsCargos;alACT_RecNumsCargosT)
AT_CopyArrayElements (->alACT_RecNumsCargosT;->atACT_RecNumsCargosT)

  //20151005 RCH
ARRAY REAL:C219(arACT_Cantidad;0)
AT_RedimArrays (Size of array:C274(alACT_RecNumsCargos);->arACT_Cantidad)
For ($l_indice;1;Size of array:C274(alACT_RecNumsCargos))
	KRL_GotoRecord (->[ACT_Cargos:173];alACT_RecNumsCargos{$l_indice})
	arACT_Cantidad{$l_indice}:=[ACT_Cargos:173]cantidad:65
	If (arACT_Cantidad{$l_indice}=0)
		arACT_Cantidad{$l_indice}:=1
	End if 
End for 

ACTcc_DividirEmision ("QuitaCargosMonto0")  //20170809 RCH

$0:=$CuantosCargos