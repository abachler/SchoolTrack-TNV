//%attributes = {}
  //SRACT_PPCertificadoPagos

  //Informe para Colombia

If ($1=1)
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([ACT_Pagos:172])
	READ ONLY:C145([xxACT_Items:179])
	READ ONLY:C145([xxACT_ItemsCategorias:98])
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([Alumnos:2])
	
	ARRAY TEXT:C222(atACT_NombreCategoria;0)
	ARRAY LONGINT:C221(aRecNums;0)
	ARRAY LONGINT:C221(aRecNumsT;0)
	ARRAY TEXT:C222(at_Nombres;0)
	ARRAY TEXT:C222(at_Apellidos;0)
	
	ARRAY REAL:C219(arACT_MontoCategoria;0)
	ARRAY REAL:C219(alACT_RefCItems;0)
	ARRAY REAL:C219(arACT_CMontoNeto;0)
	
	ARRAY LONGINT:C221($aIDCategoria;0)
	ARRAY LONGINT:C221($aPosCategoria;0)
	ARRAY LONGINT:C221(aIdsCtas;0)
	
	C_REAL:C285(vt_MontoOtros)
	C_REAL:C285(vt_SumaTotal)
	C_REAL:C285(vt_SumaTotal2)
	_O_C_INTEGER:C282($w)
	C_TEXT:C284(vTexto1)
	C_TEXT:C284(vt_TotalEnTexto)
	C_TEXT:C284(vt_TotalEnTexto2)
	C_TEXT:C284(vt_NombresAlu)
	C_TEXT:C284(vt_Identificador)
	C_TEXT:C284(vt_noIde)
	C_TEXT:C284(vNombreApo)
	C_TEXT:C284(agnoC)
	C_TEXT:C284(vt_Nombres)
	C_TEXT:C284(vt_Apellidos)
	C_TEXT:C284(vt_NombresAlu)
	
	vt_Nombres:=""
	vt_Apellidos:=""
	vt_NombresAlu:=""
	vt_SumaTotal:=0
	vt_SumaTotal2:=0
	vt_MontoOtros:=0
	vt_TotalEnTexto:=""
	vt_TotalEnTexto2:=""
	vt_Identificador:=PP_TypeAndNumIdentificator (1)
	vt_noIde:=PP_TypeAndNumIdentificator (2)
	vNombreApo:=""
	agnoC:=""
	$w:=1
	vi_TipoInforme:=3
	
	vNombreApo:=[Personas:7]Apellidos_y_nombres:30
	
	
	QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
	If (ok=1)
		$0:=True:C214
		Case of 
			: (b1=1)
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2=Current date:C33(*))
				agnoC:=String:C10(Year of:C25(Current date:C33(*)))
			: (b3=1)
				$iniDate:=DT_GetDateFromDayMonthYear (1;vi_selectedMonth;viAño)
				$endDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vi_selectedMonth;viAño);vi_selectedMonth;viAño)
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$iniDate;*)
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=$endDate;*)
				agnoC:=String:C10(viAño)
			: (b5=1)
				$iniDate:=DT_GetDateFromDayMonthYear (1;1;viAño2)
				$endDate:=DT_GetDateFromDayMonthYear (31;12;viAño2)
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$iniDate;*)
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=$endDate;*)
				agnoC:=String:C10(viAño2)
			: (b6=1)
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=vd_Fecha1;*)
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=vd_Fecha2;*)
				If ((Year of:C25(vd_Fecha1))=Year of:C25((vd_Fecha2)))
					agnoC:=String:C10(Year of:C25(vd_Fecha1))
				Else 
					agnoC:=String:C10(Year of:C25(vd_Fecha1))+" - "+String:C10(Year of:C25(vd_Fecha2))
				End if 
		End case 
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
		If (Records in selection:C76([ACT_Pagos:172])>0)
			AT_RedimArrays (Records in selection:C76([ACT_Pagos:172]);->aRecNums)
			SELECTION TO ARRAY:C260([ACT_Pagos:172];aRecNums)
			
			ALL RECORDS:C47([xxACT_ItemsCategorias:98])
			SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]ID:2;$aIDCategoria;[xxACT_ItemsCategorias:98]Posicion:3;$aPosCategoria;[xxACT_ItemsCategorias:98]Nombre:1;atACT_NombreCategoria)
			AT_RedimArrays (Size of array:C274($aIDCategoria);->arACT_MontoCategoria)
			
			For ($i;1;Size of array:C274(aRecNums))
				GOTO RECORD:C242([ACT_Pagos:172];aRecNums{$i})
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
				  //20110812 RCH Cuando se tiene una forma de pago "Descuento por planilla", las transacciones no son encontradas y 
				  //el despliegue del pago no es correcto dentro de la ficha.
				  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]Glosa#"Pago con Des@";*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Pago con Descuento";*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Balanceo@")
				AT_RedimArrays (Records in selection:C76([ACT_Transacciones:178]);->aRecNumsT)
				SELECTION TO ARRAY:C260([ACT_Transacciones:178];aRecNumsT)
				
				For ($j;1;Size of array:C274(aRecNumsT))
					GOTO RECORD:C242([ACT_Transacciones:178];aRecNumsT{$j})
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=[ACT_Transacciones:178]ID_Item:3)
					QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
					AT_Insert (0;1;->alACT_RefCItems)
					AT_Insert (0;1;->arACT_CMontoNeto)
					AT_Insert (0;1;->aIdsCtas)
					alACT_RefCItems{$w}:=[xxACT_Items:179]ID:1
					arACT_CMontoNeto{$w}:=[ACT_Transacciones:178]Debito:6
					aIdsCtas{$w}:=[ACT_Transacciones:178]ID_CuentaCorriente:2
					$w:=$w+1
				End for 
			End for 
			
			For ($i;1;Size of array:C274(alACT_RefCItems))
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=alACT_RefCItems{$i})
				If ([xxACT_Items:179]ID_Categoria:8#0)
					$cat:=Find in array:C230($aIDCategoria;[xxACT_Items:179]ID_Categoria:8)
					arACT_MontoCategoria{$cat}:=arACT_MontoCategoria{$cat}+arACT_CMontoNeto{$i}
				Else 
					vt_MontoOtros:=vt_MontoOtros+arACT_CMontoNeto{$i}  //variable que  muestra los montos que no esten las categorias
				End if 
			End for 
			
			For ($i;1;Size of array:C274(arACT_MontoCategoria))
				vt_SumaTotal:=vt_SumaTotal+arACT_MontoCategoria{$i}
			End for 
			
			vt_SumaTotal2:=vt_SumaTotal+vt_MontoOtros  //variable que  muestra la suma total  incluidos los montos que no esteen las categorias
			
			SORT ARRAY:C229($aPosCategoria;atACT_NombreCategoria;arACT_MontoCategoria;>)
			
			vt_TotalEnTexto:=ST_Num2Text2 (vt_SumaTotal;"Spanish")
			vt_TotalEnTexto2:=ST_Num2Text2 (vt_SumaTotal2;"Spanish")  //Mustra la suma 2 en palabras
		Else 
			CD_Dlog (0;__ ("No hay pagos en el rango de fechas especificado."))
			$0:=False:C215
		End if 
	Else 
		$0:=False:C215
	End if 
Else 
	
	If ($1=2)
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([ACT_Pagos:172])
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		
		ARRAY LONGINT:C221(aRecNums;0)
		ARRAY LONGINT:C221(aRecNumsT;0)
		ARRAY TEXT:C222(at_Nombres;0)
		ARRAY TEXT:C222(at_Apellidos;0)
		
		ARRAY REAL:C219(arACT_CMontoNeto;0)
		
		ARRAY LONGINT:C221(aIdsCtas;0)
		
		C_REAL:C285(vR_SumaTotal)
		_O_C_INTEGER:C282($w)
		C_TEXT:C284(vt_NombresAlu)
		C_TEXT:C284(vt_Identificador)
		C_TEXT:C284(vt_noIde)
		C_TEXT:C284(vNombreApo)
		C_TEXT:C284(agnoC)
		C_TEXT:C284(vt_Nombres)
		C_TEXT:C284(vt_Apellidos)
		C_TEXT:C284(vt_NombresAlu)
		_O_C_STRING:C293(80;fecha)
		_O_C_STRING:C293(80;dia)
		_O_C_STRING:C293(80;mes)
		_O_C_STRING:C293(80;año)
		C_TEXT:C284(vt_SumTotal)
		C_TEXT:C284(viAñoIn)
		
		fecha:=DT_Date2SpanishString (Current date:C33(*))
		dia:=String:C10(Day of:C23(Current date:C33(*)))
		mes:=<>atXS_MonthNames{Month of:C24(Current date:C33(*))}
		año:=String:C10(Year of:C25(Current date:C33(*)))
		vt_SumTotal:="0"
		vt_Nombres:=""
		vt_Apellidos:=""
		vt_NombresAlu:=""
		vR_SumaTotal:=0
		vt_Identificador:=PP_TypeAndNumIdentificator (1)
		vt_noIde:=PP_TypeAndNumIdentificator (2)
		vNombreApo:=""
		agnoC:=""
		$w:=1
		vi_TipoInforme:=3
		
		viAño2:=Num:C11(viAñoIn)
		vNombreApo:=[Personas:7]Apellidos_y_nombres:30
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
		$iniDate:=DT_GetDateFromDayMonthYear (1;1;viAño2)
		$endDate:=DT_GetDateFromDayMonthYear (31;12;viAño2)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$iniDate;*)
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2<=$endDate;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; & ;[ACT_Pagos:172]Nulo:14=False:C215)
		agnoC:=String:C10(viAño2)
		
		If (Records in selection:C76([ACT_Pagos:172])>0)
			AT_RedimArrays (Records in selection:C76([ACT_Pagos:172]);->aRecNums)
			SELECTION TO ARRAY:C260([ACT_Pagos:172];aRecNums)
			
			For ($i;1;Size of array:C274(aRecNums))
				GOTO RECORD:C242([ACT_Pagos:172];aRecNums{$i})
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
				  //20110812 RCH Cuando se tiene una forma de pago "Descuento por planilla", las transacciones no son encontradas y 
				  //el despliegue del pago no es correcto dentro de la ficha.
				  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]Glosa#"Pago con Des@";*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Pago con Descuento";*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Balanceo@")
				AT_RedimArrays (Records in selection:C76([ACT_Transacciones:178]);->aRecNumsT)
				SELECTION TO ARRAY:C260([ACT_Transacciones:178];aRecNumsT)
				
				For ($j;1;Size of array:C274(aRecNumsT))
					GOTO RECORD:C242([ACT_Transacciones:178];aRecNumsT{$j})
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=[ACT_Transacciones:178]ID_Item:3)
					AT_Insert (0;1;->arACT_CMontoNeto)
					AT_Insert (0;1;->aIdsCtas)
					arACT_CMontoNeto{$w}:=[ACT_Transacciones:178]Debito:6
					aIdsCtas{$w}:=[ACT_Transacciones:178]ID_CuentaCorriente:2
					$w:=$w+1
				End for 
				
			End for 
			vR_SumaTotal:=AT_GetSumArray (->arACT_CMontoNeto)
			AT_DistinctsArrayValues (->aIdsCtas)
			AT_RedimArrays (Size of array:C274(aIdsCtas);->at_Nombres)
			AT_RedimArrays (Size of array:C274(aIdsCtas);->at_Apellidos)
			
			For ($e;1;Size of array:C274(aIdsCtas))
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=aIdsCtas{$e})
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				at_Nombres{$e}:=[Alumnos:2]Nombres:2
				at_Apellidos{$e}:=[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4
			End for 
			
			For ($e;1;Size of array:C274(at_Nombres))
				Case of 
					: (Size of array:C274(at_Nombres)=1)
						vt_Nombres:=at_Nombres{$e}
						vt_Apellidos:=at_Apellidos{$e}
					: (($e=(Size of array:C274(at_Nombres)-1)))
						vt_Nombres:=vt_Nombres+" "+at_Nombres{$e}
						If (at_Apellidos{$e}#at_Apellidos{$e-1})
							vt_Apellidos:=vt_Apellidos+" "+at_Apellidos{$e}
						End if 
					: (($e=Size of array:C274(at_Nombres)) & (Size of array:C274(at_Nombres)#1))
						vt_Nombres:=vt_Nombres+" y "+at_Nombres{$e}
						If (at_Apellidos{$e}#at_Apellidos{$e-1})
							vt_Apellidos:=vt_Apellidos+" y "+at_Apellidos{$e}
						End if 
					Else 
						vt_Nombres:=vt_Nombres+" "+at_Nombres{$e}+","
						If (at_Apellidos{$e}#at_Apellidos{$e-1})
							vt_Apellidos:=vt_Apellidos+" "+at_Apellidos{$e}
						End if 
				End case 
			End for 
			  //Junta el nombre de los alumnos con el apellido
			vt_NombresAlu:=vt_Nombres+" "+vt_Apellidos
			vt_TotalEnTexto:=ST_Num2Text2 (vR_SumaTotal;"Spanish")
			vt_SumTotal:=String:C10(vR_SumaTotal;"|Despliegue_ACT")
		Else 
			CD_Dlog (0;__ ("No hay pagos en el rango de fechas especificado."))
		End if 
	End if 
End if 
