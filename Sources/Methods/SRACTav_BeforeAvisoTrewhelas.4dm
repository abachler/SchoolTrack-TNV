//%attributes = {}
  //SRACTav_BeforeAvisoTrewhelas

C_POINTER:C301(Var1;Var2;Var3;Var4;Var5)
C_TEXT:C284(vCursos1;vCursos2;vCursos3;vCursos4;vFamilia1;vFamilia2;vFamilia3;vFamilia4)
C_TEXT:C284(vtACT_Glosa1;vtACT_Glosa2;vtACT_Glosa3;vtACT_Glosa4;vtACT_Glosa5;vtACT_Glosa6;vtACT_Glosa7;vtACT_Glosa8;vtACT_Glosa9;vtACT_Glosa10;vtACT_Glosa11;vtACT_Glosa12;vtACT_Glosa13;vtACT_Glosa14;vtACT_Glosa15;vtACT_Glosa16)
C_REAL:C285(vrACT_Monto1;vrACT_Monto2;vrACT_Monto3;vrACT_Monto4;vrACT_Monto5;vrACT_Monto6;vrACT_Monto7;vrACT_Monto8;vrACT_Monto9;vrACT_Monto10;vrACT_Monto11;vrACT_Monto12;vrACT_Monto13;vrACT_Monto14;vrACT_Monto15;vrACT_Monto16)
C_TEXT:C284(vtACT_Glosa17;vtACT_Glosa18;vtACT_Glosa19;vtACT_Glosa20;vtACT_Glosa21;vtACT_Glosa22;vtACT_Glosa23;vtACT_Glosa24;vtACT_Glosa25;vtACT_Glosa26;vtACT_Glosa27;vtACT_Glosa28;vtACT_Glosa29;vtACT_Glosa30;vtACT_Glosa31;vtACT_Glosa32)
C_REAL:C285(vrACT_Monto17;vrACT_Monto18;vrACT_Monto19;vrACT_Monto20;vrACT_Monto21;vrACT_Monto22;vrACT_Monto23;vrACT_Monto24;vrACT_Monto25;vrACT_Monto26;vrACT_Monto27;vrACT_Monto28;vrACT_Monto29;vrACT_Monto30;vrACT_Monto31;vrACT_Monto32)
C_TEXT:C284(vtACT_Glosa33;vtACT_Glosa34;vtACT_Glosa35;vtACT_Glosa36;vtACT_Glosa37;vtACT_Glosa38;vtACT_Glosa39;vtACT_Glosa40;vtACT_Glosa41;vtACT_Glosa42;vtACT_Glosa43;vtACT_Glosa44;vtACT_Glosa45;vtACT_Glosa46;vtACT_Glosa47;vtACT_Glosa48)
C_REAL:C285(vrACT_Monto33;vrACT_Monto34;vrACT_Monto35;vrACT_Monto36;vrACT_Monto37;vrACT_Monto38;vrACT_Monto39;vrACT_Monto40;vrACT_Monto41;vrACT_Monto42;vrACT_Monto43;vrACT_Monto44;vrACT_Monto45;vrACT_Monto46;vrACT_Monto47;vrACT_Monto48)
C_TEXT:C284(vtACT_Glosa49;vtACT_Glosa50;vtACT_Glosa51;vtACT_Glosa52;vtACT_Glosa53;vtACT_Glosa54;vtACT_Glosa55;vtACT_Glosa56;vtACT_Glosa57;vtACT_Glosa58;vtACT_Glosa59;vtACT_Glosa60;vtACT_Glosa61;vtACT_Glosa62;vtACT_Glosa63;vtACT_Glosa64)
C_REAL:C285(vrACT_Monto49;vrACT_Monto50;vrACT_Monto51;vrACT_Monto52;vrACT_Monto53;vrACT_Monto54;vrACT_Monto55;vrACT_Monto56;vrACT_Monto57;vrACT_Monto58;vrACT_Monto59;vrACT_Monto60;vrACT_Monto61;vrACT_Monto62;vrACT_Monto63;vrACT_Monto64)
C_REAL:C285(vTotal1;vTotal2;vTotal3;vTotal4)
ARRAY TEXT:C222(atACT_Cursos;0)
ARRAY TEXT:C222(atACT_Familia;0)
C_LONGINT:C283($table)
ACTav_FormArrayDeclarations 
SRACTac_EndAviso 
$Table:=Table:C252(->[ACT_Avisos_de_Cobranza:124])*-1
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3=$table;*)
QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26=atACT_ModelosAviso{atACT_ModelosAviso})
RecNumSR:=Record number:C243([xShell_Reports:54])
GOTO RECORD:C242([xShell_Reports:54];RecNumSR)
xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
  //MONO Ticket 179726
SRP_ValidaAjustesImpresion ($reportRecNum)
  //If (SR Validate (xSR_ReportBlob)=0)
  //OK:=SR Page Setup (xSR_ReportBlob)
  //If (OK=1)
  //READ WRITE([xShell_Reports])
  //LOAD RECORD([xShell_Reports])
  //[xShell_Reports]xReportData_:=xSR_ReportBlob
  //SAVE RECORD([xShell_Reports])
  //KRL_ReloadAsReadOnly (->[xShell_Reports])
  //End if 
  //Else 
  //OK:=1
  //End if 
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"Seleccion")
$Seleccion:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
$Loops:=Int:C8($Seleccion/4)
$BloquesProcesados:=0
For ($i;1;$Loops)
	USE SET:C118("Seleccion")
	REDUCE SELECTION:C351([ACT_Avisos_de_Cobranza:124];4)
	For ($j;1;4)
		GOTO SELECTED RECORD:C245([ACT_Avisos_de_Cobranza:124];$j)
		REMOVE FROM SET:C561([ACT_Avisos_de_Cobranza:124];"Seleccion")
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
		CREATE SET:C116([ACT_CuentasCorrientes:175];"TempCtas")
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
		SELECTION TO ARRAY:C260([Alumnos:2]curso:20;atACT_Cursos)
		Var3:=Get pointer:C304("vCursos"+String:C10($j))
		Var3->:=AT_array2text (->atACT_Cursos;" - ")
		USE SET:C118("TempCtas")
		KRL_RelateSelection (->[Familia:78]Numero:1;->[ACT_CuentasCorrientes:175]ID_Familia:2;"")
		SELECTION TO ARRAY:C260([Familia:78]Nombre_de_la_familia:3;atACT_Familia)
		Var4:=Get pointer:C304("vFamilia"+String:C10($j))
		Var4->:=AT_array2text (->atACT_Familia;" - ")
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
		$CuantosCargos:=Records in selection:C76([ACT_Cargos:173])
		SELECTION TO ARRAY:C260([ACT_Cargos:173];alACT_RecNumsCargos;[ACT_Cargos:173]FechaEmision:22;adACT_CFechaEmision;[ACT_Cargos:173]Fecha_de_Vencimiento:7;adACT_CFechaVencimiento;[ACT_Cargos:173]Glosa:12;atACT_CGlosa;[ACT_Cargos:173]Monto_Neto:5;arACT_CMontoNeto;[ACT_Cargos:173]Intereses:29;arACT_CIntereses;[ACT_Cargos:173]Saldo:23;arACT_CSaldo;[ACT_Cargos:173]ID_CuentaCorriente:2;alACT_IDCtaCte;[ACT_Cargos:173]Ref_Item:16;alACT_CRefs;[ACT_Cargos:173]ID_CuentaCorriente:2;alACT_CIDCtaCte)
		SELECTION TO ARRAY:C260([ACT_Cargos:173]Monto_Moneda:9;arACT_MontoMoneda;[ACT_Cargos:173]Moneda:28;atACT_MonedaCargo;[ACT_Cargos:173]MontosPagados:8;arACT_MontoPagado)
		_O_ARRAY STRING:C218(2;asACT_Marcas;$CuantosCargos)
		ARRAY TEXT:C222(atACT_CAlumno;$CuantosCargos)
		ARRAY TEXT:C222(atACT_MonedaSimbolo;$CuantosCargos)
		ARRAY TEXT:C222(atACT_CGlosaImpresion;$Cuantoscargos)
		_O_ARRAY STRING:C218(2;asACT_Afecto;$CuantosCargos)
		READ ONLY:C145([Alumnos:2])
		For ($al;1;$CuantosCargos)
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=alACT_IDCtaCte{$al})
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
			atACT_CAlumno{$al}:=[Alumnos:2]apellidos_y_nombres:40
		End for 
		ACTpgs_OrdenaCargos 
		ACTpgs_SimboloMoneda 
		If (Size of array:C274(atACT_CGlosa)<=16)
			$NumVars:=Size of array:C274(atACT_CGlosa)
		Else 
			$NumVars:=16
		End if 
		$LinearIndex:=1
		For ($t;((16*$j)-15);((16*$j)-15)+$NumVars-1)
			Var1:=Get pointer:C304("vtACT_Glosa"+String:C10($t))
			Var2:=Get pointer:C304("vrACT_Monto"+String:C10($t))
			Var1->:=atACT_CGlosa{$LinearIndex}
			Var2->:=arACT_CMontoNeto{$LinearIndex}
			$LinearIndex:=$LinearIndex+1
		End for 
		Var5:=Get pointer:C304("vTotal"+String:C10($j))
		Var5->:=[ACT_Avisos_de_Cobranza:124]Monto_Neto:11
	End for 
	$Err:=SR Print Report (xSR_ReportBlob;4;65535)
	$BloquesProcesados:=$BloquesProcesados+1
End for 

$Faltan:=$Seleccion-($BloquesProcesados*4)

USE SET:C118("Seleccion")
For ($k;1;$Faltan)
	GOTO SELECTED RECORD:C245([ACT_Avisos_de_Cobranza:124];$k)
	QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
	CREATE SET:C116([ACT_CuentasCorrientes:175];"TempCtas")
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
	SELECTION TO ARRAY:C260([Alumnos:2]curso:20;atACT_Cursos)
	Var3:=Get pointer:C304("vCursos"+String:C10($k))
	Var3->:=AT_array2text (->atACT_Cursos;" - ")
	USE SET:C118("TempCtas")
	KRL_RelateSelection (->[Familia:78]Numero:1;->[ACT_CuentasCorrientes:175]ID_Familia:2;"")
	SELECTION TO ARRAY:C260([Familia:78]Nombre_de_la_familia:3;atACT_Familia)
	Var4:=Get pointer:C304("vFamilia"+String:C10($k))
	Var4->:=AT_array2text (->atACT_Familia;" - ")
	QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
	$CuantosCargos:=Records in selection:C76([ACT_Cargos:173])
	SELECTION TO ARRAY:C260([ACT_Cargos:173];alACT_RecNumsCargos;[ACT_Cargos:173]FechaEmision:22;adACT_CFechaEmision;[ACT_Cargos:173]Fecha_de_Vencimiento:7;adACT_CFechaVencimiento;[ACT_Cargos:173]Glosa:12;atACT_CGlosa;[ACT_Cargos:173]Monto_Neto:5;arACT_CMontoNeto;[ACT_Cargos:173]Intereses:29;arACT_CIntereses;[ACT_Cargos:173]Saldo:23;arACT_CSaldo;[ACT_Cargos:173]ID_CuentaCorriente:2;alACT_IDCtaCte;[ACT_Cargos:173]Ref_Item:16;alACT_CRefs;[ACT_Cargos:173]ID_CuentaCorriente:2;alACT_CIDCtaCte)
	SELECTION TO ARRAY:C260([ACT_Cargos:173]Monto_Moneda:9;arACT_MontoMoneda;[ACT_Cargos:173]Moneda:28;atACT_MonedaCargo;[ACT_Cargos:173]MontosPagados:8;arACT_MontoPagado)
	_O_ARRAY STRING:C218(2;asACT_Marcas;$CuantosCargos)
	ARRAY TEXT:C222(atACT_CAlumno;$CuantosCargos)
	ARRAY TEXT:C222(atACT_MonedaSimbolo;$CuantosCargos)
	ARRAY TEXT:C222(atACT_CGlosaImpresion;$Cuantoscargos)
	For ($al;1;$CuantosCargos)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=alACT_IDCtaCte{$al})
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		atACT_CAlumno{$al}:=[Alumnos:2]apellidos_y_nombres:40
	End for 
	ACTpgs_OrdenaCargos 
	ACTpgs_SimboloMoneda 
	If (Size of array:C274(atACT_CGlosa)<=16)
		$NumVars:=Size of array:C274(atACT_CGlosa)
	Else 
		$NumVars:=16
	End if 
	$LinearIndex:=1
	For ($t;((16*$k)-15);((16*$k)-15)+$NumVars-1)
		Var1:=Get pointer:C304("vtACT_Glosa"+String:C10($t))
		Var2:=Get pointer:C304("vrACT_Monto"+String:C10($t))
		Var1->:=atACT_CGlosa{$LinearIndex}
		Var2->:=arACT_CMontoNeto{$LinearIndex}
		$LinearIndex:=$LinearIndex+1
	End for 
	Var5:=Get pointer:C304("vTotal"+String:C10($k))
	Var5->:=[ACT_Avisos_de_Cobranza:124]Monto_Neto:11
End for 
If ($Faltan>0)
	$Err:=SR Print Report (xSR_ReportBlob;4;65535)
End if 
SET_ClearSets ("Seleccion";"TempCtas")
SRACTac_EndAviso 