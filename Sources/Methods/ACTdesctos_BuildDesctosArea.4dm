//%attributes = {}
  //ACTdesctos_BuildDesctosArea

C_DATE:C307($1;$2;$date1;$date2)
C_TEXT:C284($3;$set)

ARRAY REAL:C219(arACT_DesctosCargas;0)
ARRAY TEXT:C222(atACT_DesctosMoneda;0)

$date1:=$1
$date2:=$2
$set:=$3

AL_UpdateArrays (xALP_Desctos;0)
AL_RemoveArrays (xALP_Desctos;1;512)
READ ONLY:C145([ACT_Cargos:173])
If (Size of array:C274(apACT_Glosas)>0)
	For ($i;1;Size of array:C274(apACT_Glosas))
		Bash_Return_Variable (apACT_Glosas{$i})
	End for 
End if 
USE SET:C118($set)
$encontrados:=BWR_SearchRecords 
If ($encontrados#-1)
	QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]apellidos_y_nombres:40;>)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	CREATE SET:C116([ACT_CuentasCorrientes:175];"Selection")
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	USE SET:C118("Selection")
	APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1:=[ACT_CuentasCorrientes:175]ID:1)
	DIFFERENCE:C122("Selection";"LockedSet";"Selection")
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	USE SET:C118("Selection")
	CLEAR SET:C117("Selection")
	If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
		vb_AplicarDesctos:=True:C214
		ARRAY TEXT:C222(atACT_NombreAlumnos;0)
		ARRAY LONGINT:C221(alACT_IDCtas;0)
		$arraySize:=(3*Records in selection:C76([ACT_CuentasCorrientes:175]))+1
		ARRAY TEXT:C222(atACT_NombreAlumnos;$arraySize)
		ARRAY LONGINT:C221(alACT_IDCtas;$arraySize)
		FIRST RECORD:C50([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		$alumno:=Find in field:C653([Alumnos:2]numero:1;[ACT_CuentasCorrientes:175]ID_Alumno:3)
		If ($alumno#-1)
			GOTO RECORD:C242([Alumnos:2];$alumno)
			atACT_NombreAlumnos{2}:=[Alumnos:2]apellidos_y_nombres:40
		End if 
		alACT_IDCtas{2}:=[ACT_CuentasCorrientes:175]ID:1
		NEXT RECORD:C51([ACT_CuentasCorrientes:175])
		For ($j;1;Records in selection:C76([ACT_CuentasCorrientes:175])-1)
			$alumno:=Find in field:C653([Alumnos:2]numero:1;[ACT_CuentasCorrientes:175]ID_Alumno:3)
			If ($alumno#-1)
				GOTO RECORD:C242([Alumnos:2];$alumno)
				atACT_NombreAlumnos{(3*$j)+2}:=[Alumnos:2]apellidos_y_nombres:40
			End if 
			alACT_IDCtas{(3*$j)+2}:=[ACT_CuentasCorrientes:175]ID:1
			NEXT RECORD:C51([ACT_CuentasCorrientes:175])
		End for 
		$RestaraSize:=Records in selection:C76([ACT_CuentasCorrientes:175])
		KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4>=$date1;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4<=$date2;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-2;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-1;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Monto_Neto:5>=0;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
		CREATE SET:C116([ACT_Cargos:173];"Involved")
		AT_DistinctsFieldValues (->[ACT_Cargos:173]Ref_Item:16;->alACT_GlosasIDs;1)
		For ($g;Size of array:C274(alACT_GlosasIDs);1;-1)
			$rn:=Find in field:C653([xxACT_Items:179]ID:1;alACT_GlosasIDs{$g})
			If ($rn#-1)
				READ ONLY:C145([xxACT_Items:179])
				GOTO RECORD:C242([xxACT_Items:179];$rn)
				If (Not:C34([xxACT_Items:179]Afecto_a_descuentos:4))
					DELETE FROM ARRAY:C228(alACT_GlosasIDs;$g;1)
				End if 
			Else 
				DELETE FROM ARRAY:C228(alACT_GlosasIDs;$g;1)
			End if 
		End for 
		ARRAY TEXT:C222(atACT_Glosas;0)
		ARRAY TEXT:C222(atACT_Glosas;Size of array:C274(alACT_GlosasIDs))
		SET QUERY LIMIT:C395(1)
		For ($h;1;Size of array:C274(alACT_GlosasIDs))
			USE SET:C118("Involved")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=alACT_GlosasIDs{$h})
			If (Position:C15(" (des";[ACT_Cargos:173]Glosa:12)#0)
				$glosa:=Substring:C12([ACT_Cargos:173]Glosa:12;1;Position:C15(" (de";[ACT_Cargos:173]Glosa:12)-1)
			Else 
				$glosa:=[ACT_Cargos:173]Glosa:12
			End if 
			atACT_Glosas{$h}:=$glosa
		End for 
		SET QUERY LIMIT:C395(0)
		KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4>=$date1;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4<=$date2;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-2;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=-1;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Monto_Neto:5>=0;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
		CREATE SET:C116([ACT_Cargos:173];"InvolvedExtras")
		FIRST RECORD:C50([ACT_Cargos:173])
		For ($b;1;Records in selection:C76([ACT_Cargos:173]))
			If (Position:C15(" (des";[ACT_Cargos:173]Glosa:12)#0)
				$glosa:=Substring:C12([ACT_Cargos:173]Glosa:12;1;Position:C15(" (de";[ACT_Cargos:173]Glosa:12)-1)
			Else 
				$glosa:=[ACT_Cargos:173]Glosa:12
			End if 
			AT_Insert (0;1;->atACT_Glosas;->alACT_GlosasIDs)
			atACT_Glosas{Size of array:C274(atACT_Glosas)}:=$glosa
			alACT_GlosasIDs{Size of array:C274(alACT_GlosasIDs)}:=-1
			NEXT RECORD:C51([ACT_Cargos:173])
		End for 
		UNION:C120("Involved";"InvolvedExtras";"Involved")
		SORT ARRAY:C229(atACT_Glosas;alACT_GlosasIDs;>)
		USE SET:C118("Involved")
		CLEAR SET:C117("Involved")
		CLEAR SET:C117("InvolvedExtras")
		If (Size of array:C274(alACT_GlosasIDs)>0)
			OBJECT SET TITLE:C194(bOK;__ ("Aplicar Descuentos"))
			vb_AplicarDesctos:=True:C214
			ARRAY LONGINT:C221(alACT_IDsCtasdeCargos;0)
			ARRAY LONGINT:C221(alACT_RefsCargos;0)
			ARRAY TEXT:C222(atACT_Glosas4Extra;0)
			SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_CuentaCorriente:2;alACT_IDsCtasdeCargos;[ACT_Cargos:173]Ref_Item:16;alACT_RefsCargos;[ACT_Cargos:173]Glosa:12;atACT_Glosas4Extra;[ACT_Cargos:173]Monto_Neto:5;arACT_Montos;[ACT_Cargos:173]ID:1;alACT_IDCargo;[ACT_Cargos:173]PctDescto_XItem:34;arACT_PctDescto;[ACT_Cargos:173]Descuentos_XItem:35;arACT_Descto)
			SELECTION TO ARRAY:C260([ACT_Cargos:173]Descuentos_Familia:26;arACT_DesctoFlia;[ACT_Cargos:173]Descuentos_Individual:31;arACT_DesctoInd;[ACT_Cargos:173]Descuentos_Ingresos:25;arACT_DesctoIngr)
			SELECTION TO ARRAY:C260([ACT_Cargos:173]Descuentos_Cargas:51;arACT_DesctosCargas)
			SELECTION TO ARRAY:C260([ACT_Cargos:173]Moneda:28;atACT_DesctosMoneda)
			ARRAY POINTER:C280(apACT_Glosas;0)
			ARRAY REAL:C219(aFooterL1;0)
			ARRAY REAL:C219(aFooterL2;0)
			ARRAY REAL:C219(aFooterL3;0)
			ARRAY TEXT:C222(atACT_ArrNames;0)
			ARRAY POINTER:C280(apACT_Glosas;Size of array:C274(atACT_Glosas))
			ARRAY REAL:C219(aFooterL1;Size of array:C274(atACT_Glosas)+1)
			ARRAY REAL:C219(aFooterL2;Size of array:C274(atACT_Glosas)+1)
			ARRAY REAL:C219(aFooterL3;Size of array:C274(atACT_Glosas)+1)
			ARRAY TEXT:C222(atACT_ArrNames;Size of array:C274(atACT_Glosas))
			For ($i;1;Size of array:C274(apACT_Glosas))
				apACT_Glosas{$i}:=Bash_Get_Array_By_Type (Is real:K8:4)
				AT_RedimArrays (Size of array:C274(atACT_NombreAlumnos);apACT_Glosas{$i})
				RESOLVE POINTER:C394(apACT_Glosas{$i};$name;$table;$field)
				atACT_ArrNames{$i}:=$name
			End for 
			ARRAY LONGINT:C221(aCtasCargos;0;0)
			ARRAY LONGINT:C221(aCtasCargos;3+Size of array:C274(apACT_Glosas);Size of array:C274(atACT_NombreAlumnos))
			COPY ARRAY:C226(alACT_IDCtas;aCtasCargos{1})
			ARRAY REAL:C219(arACT_DesctoXAlumno;0)
			ARRAY TEXT:C222(atACT_4TitleOnly;0)
			ARRAY REAL:C219(arACT_Totales;0)
			ARRAY REAL:C219(arACT_DesctoXAlumno;Size of array:C274(atACT_NombreAlumnos))
			ARRAY TEXT:C222(atACT_4TitleOnly;Size of array:C274(atACT_NombreAlumnos))
			If (b1=1)
				atACT_4TitleOnly{1}:="Por Item (%)->"
			Else 
				atACT_4TitleOnly{1}:="Por Item->"
			End if 
			ARRAY REAL:C219(arACT_Totales;Size of array:C274(atACT_NombreAlumnos))
			xALP_ACT_Set_Desctos 
			AL_SetFtrStyle (xALP_Desctos;3;"";9;1)
			$size:=Size of array:C274(atACT_NombreAlumnos)-$RestaraSize
			ARRAY INTEGER:C220(aInteger2D;2;0)
			ARRAY INTEGER:C220(aInteger2D;2;$size)
			$r:=1
			For ($i;2;$size;2)
				For ($ii;0;1)
					aInteger2D{1}{$i+$ii}:=2
					aInteger2D{2}{$i+$ii}:=$i+$ii+$r
				End for 
				$r:=$r+1
			End for 
			AL_SetCellEnter (xALP_Desctos;0;0;0;0;aInteger2D;0)
			AL_SetCellEnter (xALP_Desctos;2;1;0;0;aInteger2D;0)
			ARRAY INTEGER:C220(aInteger2D;2;0)
			AL_SetCellColor (xALP_Desctos;1;1;2;1;aInteger2D;"Light Gray";0;"Light Gray";0)
			AL_SetCellStyle (xALP_Desctos;3;1;0;0;aInteger2D;1)
			ARRAY INTEGER:C220(aInteger2D;2;Size of array:C274(atACT_NombreAlumnos))
			For ($i;2;Size of array:C274(atACT_NombreAlumnos))
				aInteger2D{1}{$i}:=3
				aInteger2D{2}{$i}:=$i
			End for 
			AL_SetCellColor (xALP_Desctos;0;0;0;0;aInteger2D;"Light Gray";0;"Light Gray";0)
			For ($u;4;3+Size of array:C274(apACT_Glosas))
				$err:=AL_SetArraysNam (xALP_Desctos;$u;1;atACT_ArrNames{$u-3})
				AL_SetHeaders (xALP_Desctos;$u;1;atACT_Glosas{$u-3})
				If (b1=1)
					AL_SetFormat (xALP_Desctos;$u;"|Real_4DecIfNec";0;0;0;0)
				Else 
					$vt_monedaItem:=atACT_DesctosMoneda{Find in array:C230(alACT_RefsCargos;alACT_GlosasIDs{$u-3})}
					$formato:=ACTcar_OpcionesGenerales ("retornaFormato";->$vt_monedaItem)
					AL_SetFormat (xALP_Desctos;$u;$formato;0;0;0;0)
					  //AL_SetFormat (xALP_Desctos;$u;"|Despliegue_ACT";0;0;0;0)
				End if 
				$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
				AL_SetFilter (xALP_Desctos;$u;$filter)
				AL_SetHdrStyle (xALP_Desctos;$u;"Tahoma";9;1)
				AL_SetFtrStyle (xALP_Desctos;$u;"Tahoma";9;0)
				AL_SetStyle (xALP_Desctos;$u;"Tahoma";9;0)
				AL_SetForeColor (xALP_Desctos;$u;"Black";0;"Black";0;"Black";0)
				AL_SetBackColor (xALP_Desctos;$u;"White";0;"White";0;"White";0)
				AL_SetEnterable (xALP_Desctos;$u;1)
				AL_SetEntryCtls (xALP_Desctos;$u;0)
			End for 
			$err:=AL_SetArraysNam (xALP_Desctos;$u+1;1;"arACT_Totales")
			AL_SetHeaders (xALP_Desctos;$u+1;1;__ ("Total por\rCuenta Corriente"))
			AL_SetFormat (xALP_Desctos;$u+1;"|Despliegue_ACT_Pagos";0;0;0;0)
			AL_SetHdrStyle (xALP_Desctos;$u+1;"Tahoma";9;1)
			AL_SetFtrStyle (xALP_Desctos;$u+1;"Tahoma";9;0)
			AL_SetStyle (xALP_Desctos;$u+1;"Tahoma";9;0)
			AL_SetForeColor (xALP_Desctos;$u+1;"Black";0;"Black";0;"Black";0)
			AL_SetBackColor (xALP_Desctos;$u+1;"White";0;"White";0;"White";0)
			AL_SetEnterable (xALP_Desctos;$u+1;0)
			AL_SetEntryCtls (xALP_Desctos;$u+1;0)
			For ($t;4;3+Size of array:C274(atACT_Glosas))
				ARRAY INTEGER:C220(aInteger2D;2;0)
				ARRAY INTEGER:C220(aInteger2D;2;$size)
				$r:=1
				For ($i;3;$size-1;2)
					For ($ii;0;1)
						aInteger2D{1}{$i+$ii}:=$t
						aInteger2D{2}{$i+$ii}:=$i+$ii+$r
					End for 
					$r:=$r+1
				End for 
				aInteger2D{1}{Size of array:C274(aInteger2D{2})}:=$t
				aInteger2D{2}{Size of array:C274(aInteger2D{2})}:=Size of array:C274(atACT_NombreAlumnos)
				AL_SetCellEnter (xALP_Desctos;0;0;0;0;aInteger2D;0)
				AL_SetCellEnter (xALP_Desctos;$t;2;0;0;aInteger2D;0)
			End for 
			AL_SetCellColor (xALP_Desctos;$u+1;1;0;0;aInteger2D;"Light Gray";0;"Light Gray";0)
			ARRAY INTEGER:C220(aInteger2D;2;0)
			For ($l;2;Size of array:C274(alACT_IDCtas);3)
				For ($w;1;Size of array:C274(alACT_GlosasIDs))
					alACT_RefsCargos{0}:=alACT_GlosasIDs{$w}
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->alACT_RefsCargos;"=";->$DA_Return)
					$noEsta:=True:C214
					For ($x;1;Size of array:C274($DA_Return))
						If (alACT_GlosasIDs{$w}#-1)
							If (alACT_IDsCtasdeCargos{$DA_Return{$x}}=alACT_IDCtas{$l})
								Case of 
									: (b1=1)
										apACT_Glosas{$w}->{$l+2}:=arACT_Montos{$DA_Return{$x}}
										If (arACT_PctDescto{$DA_Return{$x}}#0)
											apACT_Glosas{$w}->{$l+1}:=arACT_PctDescto{$DA_Return{$x}}
											If (arACT_PctDescto{$DA_Return{$x}}>=100)
												apACT_Glosas{$w}->{$l}:=arACT_Descto{$DA_Return{$x}}
											Else 
												  //apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_DesctoFlia{DA_Return{$x}}+arACT_DesctoInd{DA_Return{$x}}+arACT_DesctoIngr{DA_Return{$x}}+arACT_Descto{DA_Return{$x}}
												apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_Descto{$DA_Return{$x}}
												apACT_Glosas{$w}->{$l+2}:=Round:C94(apACT_Glosas{$w}->{$l}*(1-(apACT_Glosas{$w}->{$l+1}/100));0)  //se recalcula debido a que es posible que el cargo venga con algún tipo de dcto.
											End if 
										Else 
											If (arACT_Descto{$DA_Return{$x}}#0)
												  //apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_DesctoFlia{DA_Return{$x}}+arACT_DesctoInd{DA_Return{$x}}+arACT_DesctoIngr{DA_Return{$x}}+arACT_Descto{DA_Return{$x}}
												apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_Descto{$DA_Return{$x}}
												apACT_Glosas{$w}->{$l+1}:=100-Round:C94(((apACT_Glosas{$w}->{$l+2}*100)/apACT_Glosas{$w}->{$l});<>vlACT_Decimales)
												apACT_Glosas{$w}->{$l+2}:=Round:C94(apACT_Glosas{$w}->{$l}*(1-(apACT_Glosas{$w}->{$l+1}/100));0)
											Else 
												apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}
												apACT_Glosas{$w}->{$l+1}:=0
											End if 
										End if 
										aCtasCargos{$w+3}{$l}:=alACT_IDCargo{$DA_Return{$x}}
										
									: (b2=1)
										apACT_Glosas{$w}->{$l+2}:=arACT_Montos{$DA_Return{$x}}
										If (arACT_Descto{$DA_Return{$x}}#0)
											apACT_Glosas{$w}->{$l+1}:=arACT_Descto{$DA_Return{$x}}
											  //apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_DesctoFlia{DA_Return{$x}}+arACT_DesctoInd{DA_Return{$x}}+arACT_DesctoIngr{DA_Return{$x}}+arACT_Descto{DA_Return{$x}}
											apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_Descto{$DA_Return{$x}}
										Else 
											If (arACT_PctDescto{$DA_Return{$x}}#0)
												  //apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_DesctoFlia{DA_Return{$x}}+arACT_DesctoInd{DA_Return{$x}}+arACT_DesctoIngr{DA_Return{$x}}+arACT_Descto{DA_Return{$x}}
												apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_Descto{$DA_Return{$x}}
												apACT_Glosas{$w}->{$l+1}:=apACT_Glosas{$w}->{$l}-apACT_Glosas{$w}->{$l+2}
											Else 
												apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}
												apACT_Glosas{$w}->{$l+1}:=0
											End if 
										End if 
										aCtasCargos{$w+3}{$l}:=alACT_IDCargo{$DA_Return{$x}}
									Else 
										aCtasCargos{$w+3}{$l}:=alACT_IDCargo{$DA_Return{$x}}
								End case 
								$x:=Size of array:C274($DA_Return)+1
								$noEsta:=False:C215
							End if 
						Else 
							ARRAY LONGINT:C221(DA_Return2;0)
							atACT_Glosas4Extra{0}:=atACT_Glosas{$w}
							AT_SearchArray (->atACT_Glosas4Extra;"@";->DA_Return2)
							For ($xx;1;Size of array:C274(DA_Return2))
								If (alACT_IDsCtasdeCargos{DA_Return2{$xx}}=alACT_IDCtas{$l})
									Case of 
										: (b1=1)
											apACT_Glosas{$w}->{$l+2}:=arACT_Montos{DA_Return2{$xx}}
											If (arACT_PctDescto{DA_Return2{$xx}}#0)
												apACT_Glosas{$w}->{$l+1}:=arACT_PctDescto{DA_Return2{$xx}}
												If (arACT_PctDescto{DA_Return{$x}}>=100)
													apACT_Glosas{$w}->{$l}:=arACT_Descto{DA_Return{$x}}
												Else 
													  //apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_DesctoFlia{DA_Return{$x}}+arACT_DesctoInd{DA_Return{$x}}+arACT_DesctoIngr{DA_Return{$x}}+arACT_Descto{DA_Return{$x}}
													apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_Descto{DA_Return{$x}}
													apACT_Glosas{$w}->{$l+2}:=Round:C94(apACT_Glosas{$w}->{$l}*(1-(apACT_Glosas{$w}->{$l+1}/100));0)
												End if 
											Else 
												If (arACT_Descto{DA_Return2{$xx}}#0)
													  //apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_DesctoFlia{DA_Return{$x}}+arACT_DesctoInd{DA_Return{$x}}+arACT_DesctoIngr{DA_Return{$x}}+arACT_Descto{DA_Return{$x}}
													apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_Descto{DA_Return{$x}}
													apACT_Glosas{$w}->{$l+1}:=100-Round:C94(((apACT_Glosas{$w}->{$l+2}*100)/apACT_Glosas{$w}->{$l});<>vlACT_Decimales)
													apACT_Glosas{$w}->{$l+2}:=Round:C94(apACT_Glosas{$w}->{$l}*(1-(apACT_Glosas{$w}->{$l+1}/100));0)
												Else 
													apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}
													apACT_Glosas{$w}->{$l+1}:=0
												End if 
											End if 
											arACT_Totales{$l}:=arACT_Totales{$l}+apACT_Glosas{$w}->{$l}
											arACT_Totales{$l+2}:=arACT_Totales{$l+2}+apACT_Glosas{$w}->{$l+2}
											arACT_Totales{$l+1}:=arACT_Totales{$l}-arACT_Totales{$l+2}
											aFooterL1{$w}:=aFooterL1{$w}+apACT_Glosas{$w}->{$l}
											aFooterL2{$w}:=aFooterL2{$w}+(apACT_Glosas{$w}->{$l}-apACT_Glosas{$w}->{$l+2})
											aFooterL3{$w}:=aFooterL3{$w}+apACT_Glosas{$w}->{$l+2}
											aFooterL1{Size of array:C274(aFooterL1)}:=aFooterL1{Size of array:C274(aFooterL1)}+apACT_Glosas{$w}->{$l}
											aFooterL2{Size of array:C274(aFooterL2)}:=aFooterL2{Size of array:C274(aFooterL2)}+(apACT_Glosas{$w}->{$l}-apACT_Glosas{$w}->{$l+2})
											aFooterL3{Size of array:C274(aFooterL3)}:=aFooterL3{Size of array:C274(aFooterL3)}+apACT_Glosas{$w}->{$l+2}
											aCtasCargos{$w+3}{$l}:=alACT_IDCargo{DA_Return2{$xx}}
										: (b2=1)
											apACT_Glosas{$w}->{$l+2}:=arACT_Montos{DA_Return2{$xx}}
											If (arACT_Descto{DA_Return2{$xx}}#0)
												apACT_Glosas{$w}->{$l+1}:=arACT_Descto{DA_Return2{$xx}}
												  //apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_DesctoFlia{DA_Return{$x}}+arACT_DesctoInd{DA_Return{$x}}+arACT_DesctoIngr{DA_Return{$x}}+arACT_Descto{DA_Return{$x}}
												apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_Descto{DA_Return{$x}}
												  //apACT_Glosas{$w}->{$l+2}:=Round(apACT_Glosas{$w}->{$l}*(1-(apACT_Glosas{$w}->{$l+1}/100));0)
											Else 
												If (arACT_PctDescto{DA_Return2{$xx}}#0)
													  //apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_DesctoFlia{DA_Return{$x}}+arACT_DesctoInd{DA_Return{$x}}+arACT_DesctoIngr{DA_Return{$x}}+arACT_Descto{DA_Return{$x}}
													apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}+arACT_Descto{DA_Return{$x}}
													apACT_Glosas{$w}->{$l+1}:=apACT_Glosas{$w}->{$l}-apACT_Glosas{$w}->{$l+2}
													  //apACT_Glosas{$w}->{$l+2}:=Round(apACT_Glosas{$w}->{$l}*(1-(apACT_Glosas{$w}->{$l+1}/100));0)
												Else 
													apACT_Glosas{$w}->{$l}:=apACT_Glosas{$w}->{$l+2}
													apACT_Glosas{$w}->{$l+1}:=0
												End if 
											End if 
											arACT_Totales{$l}:=arACT_Totales{$l}+apACT_Glosas{$w}->{$l}
											arACT_Totales{$l+2}:=arACT_Totales{$l+2}+apACT_Glosas{$w}->{$l+2}
											arACT_Totales{$l+1}:=arACT_Totales{$l}-arACT_Totales{$l+2}
											aFooterL1{$w}:=aFooterL1{$w}+apACT_Glosas{$w}->{$l}
											aFooterL2{$w}:=aFooterL2{$w}+(apACT_Glosas{$w}->{$l}-apACT_Glosas{$w}->{$l+2})
											aFooterL3{$w}:=aFooterL3{$w}+apACT_Glosas{$w}->{$l+2}
											aFooterL1{Size of array:C274(aFooterL1)}:=aFooterL1{Size of array:C274(aFooterL1)}+apACT_Glosas{$w}->{$l}
											aFooterL2{Size of array:C274(aFooterL2)}:=aFooterL2{Size of array:C274(aFooterL2)}+(apACT_Glosas{$w}->{$l}-apACT_Glosas{$w}->{$l+2})
											aFooterL3{Size of array:C274(aFooterL3)}:=aFooterL3{Size of array:C274(aFooterL3)}+apACT_Glosas{$w}->{$l+2}
											aCtasCargos{$w+3}{$l}:=alACT_IDCargo{DA_Return2{$xx}}
										Else 
											apACT_Glosas{$w}->{$l}:=arACT_Montos{DA_Return2{$xx}}
											apACT_Glosas{$w}->{$l+2}:=arACT_Montos{DA_Return2{$xx}}
											aCtasCargos{$w+3}{$l}:=alACT_IDCargo{DA_Return2{$xx}}
											arACT_Totales{$l}:=arACT_Totales{$l}+arACT_Montos{DA_Return2{$xx}}
											arACT_Totales{$l+2}:=arACT_Totales{$l+2}+arACT_Montos{DA_Return2{$xx}}
											aFooterL1{$w}:=aFooterL1{$w}+arACT_Montos{DA_Return2{$xx}}
											aFooterL3{$w}:=aFooterL3{$w}+arACT_Montos{DA_Return2{$xx}}
											aFooterL1{Size of array:C274(aFooterL1)}:=aFooterL1{Size of array:C274(aFooterL1)}+arACT_Montos{DA_Return2{$xx}}
											aFooterL3{Size of array:C274(aFooterL3)}:=aFooterL3{Size of array:C274(aFooterL3)}+arACT_Montos{DA_Return2{$xx}}
									End case 
									atACT_Glosas4Extra{DA_Return2{$xx}}:=Char:C90(0)
									$xx:=Size of array:C274(DA_Return2)+1
									$x:=Size of array:C274(DA_Return)+1
									$noEsta:=False:C215
								End if 
							End for 
						End if 
					End for 
					If ($noEsta)
						INSERT IN ARRAY:C227(aInteger2D{1};Size of array:C274(aInteger2D{1})+1;3)
						INSERT IN ARRAY:C227(aInteger2D{2};Size of array:C274(aInteger2D{2})+1;3)
						aInteger2D{1}{Size of array:C274(aInteger2D{1})-2}:=$w+3
						aInteger2D{1}{Size of array:C274(aInteger2D{1})-1}:=$w+3
						aInteger2D{1}{Size of array:C274(aInteger2D{1})}:=$w+3
						aInteger2D{2}{Size of array:C274(aInteger2D{2})-1}:=$l
						aInteger2D{2}{Size of array:C274(aInteger2D{2})}:=$l+1
						aInteger2D{2}{Size of array:C274(aInteger2D{2})-2}:=$l+2
					End if 
				End for 
			End for 
			ACTdesctos_CalculaTotales 
			For ($w;1;Size of array:C274(alACT_GlosasIDs)+1)
				$footer:=String:C10(aFooterL1{$w};"|Despliegue_ACT_Pagos")+"\r"+String:C10(aFooterL2{$w};"|Despliegue_ACT_Pagos")+"\r"+String:C10(aFooterL3{$w};"|Despliegue_ACT_Pagos")
				AL_SetFooters (xALP_Desctos;$w+3;1;$footer)
			End for 
			COPY ARRAY:C226(aInteger2D{1};aDisColumns)
			COPY ARRAY:C226(aInteger2D{2};aDisRows)
			AL_SetCellColor (xALP_Desctos;0;0;0;0;aInteger2D;"Light Gray";0;"Light Gray";0)
			AL_SetCellEnter (xALP_Desctos;0;0;0;0;aInteger2D;0)
			OBJECT SET VISIBLE:C603(*;"NoCuentas";False:C215)
			OBJECT SET VISIBLE:C603(*;"NoCargos";False:C215)
			OBJECT SET VISIBLE:C603(xALP_Desctos;True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"NoCuentas";False:C215)
			OBJECT SET VISIBLE:C603(*;"NoCargos";True:C214)
			OBJECT SET VISIBLE:C603(xALP_Desctos;False:C215)
			OBJECT SET TITLE:C194(bOK;__ ("Cancelar"))
			vb_AplicarDesctos:=False:C215
		End if 
	Else 
		OBJECT SET VISIBLE:C603(xALP_Desctos;False:C215)
		OBJECT SET VISIBLE:C603(*;"NoCuentas";True:C214)
		OBJECT SET VISIBLE:C603(*;"NoCargos";False:C215)
		OBJECT SET ENTERABLE:C238(vl_Mes;False:C215)
		OBJECT SET ENTERABLE:C238(vl_Año;False:C215)
		IT_SetButtonState (False:C215;->bReGenerarArea;->bMes)
		OBJECT SET TITLE:C194(bOK;__ ("Cancelar"))
		vb_AplicarDesctos:=False:C215
	End if 
Else 
	OBJECT SET VISIBLE:C603(xALP_Desctos;False:C215)
	OBJECT SET VISIBLE:C603(*;"NoCuentas";True:C214)
	OBJECT SET VISIBLE:C603(*;"NoCargos";False:C215)
	OBJECT SET ENTERABLE:C238(vl_Mes;False:C215)
	OBJECT SET ENTERABLE:C238(vl_Año;False:C215)
	IT_SetButtonState (False:C215;->bReGenerarArea;->bMes)
	OBJECT SET TITLE:C194(bOK;__ ("Cancelar"))
	vb_AplicarDesctos:=False:C215
End if 
KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])