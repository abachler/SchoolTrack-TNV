//%attributes = {}
  //ACTmnu_InformeIngresosXAl
  //Modificado por AS 03/09/2010  13:28

If (USR_GetMethodAcces (Current method name:C684))
	ARRAY TEXT:C222(at_nombresACT;0)
	ARRAY INTEGER:C220(ai_nosListaACT;0)
	ARRAY TEXT:C222(at_statusAlumnosACT;0)
	ARRAY TEXT:C222(at_MontosMatACT;0)
	ARRAY TEXT:C222(at_MontoBecaACT;0)
	ARRAY TEXT:C222(at_PctBeca;0)
	ARRAY TEXT:C222(at_bol3ACT;0)
	ARRAY TEXT:C222(at_val3ACT;0)
	ARRAY REAL:C219(ar_montoBeca3ACT;0)
	ARRAY TEXT:C222(at_tieneBeca1003ACT;0)
	ARRAY TEXT:C222(at_bol4ACT;0)
	ARRAY TEXT:C222(at_val4ACT;0)
	ARRAY REAL:C219(ar_montoBeca4ACT;0)
	ARRAY TEXT:C222(at_tieneBeca1004ACT;0)
	ARRAY TEXT:C222(at_bol5ACT;0)
	ARRAY TEXT:C222(at_val5ACT;0)
	ARRAY REAL:C219(ar_montoBeca5ACT;0)
	ARRAY TEXT:C222(at_tieneBeca1005ACT;0)
	ARRAY TEXT:C222(at_bol6ACT;0)
	ARRAY TEXT:C222(at_val6ACT;0)
	ARRAY REAL:C219(ar_montoBeca6ACT;0)
	ARRAY TEXT:C222(at_tieneBeca1006ACT;0)
	ARRAY TEXT:C222(at_bol7ACT;0)
	ARRAY TEXT:C222(at_val7ACT;0)
	ARRAY REAL:C219(ar_montoBeca7ACT;0)
	ARRAY TEXT:C222(at_tieneBeca1007ACT;0)
	ARRAY TEXT:C222(at_bol8ACT;0)
	ARRAY TEXT:C222(at_val8ACT;0)
	ARRAY REAL:C219(ar_montoBeca8ACT;0)
	ARRAY TEXT:C222(at_tieneBeca1008ACT;0)
	ARRAY TEXT:C222(at_bol9ACT;0)
	ARRAY TEXT:C222(at_val9ACT;0)
	ARRAY REAL:C219(ar_montoBeca9ACT;0)
	ARRAY TEXT:C222(at_tieneBeca1009ACT;0)
	ARRAY TEXT:C222(at_bol10ACT;0)
	ARRAY TEXT:C222(at_val10ACT;0)
	ARRAY REAL:C219(ar_montoBeca10ACT;0)
	ARRAY TEXT:C222(at_tieneBeca10010ACT;0)
	ARRAY TEXT:C222(at_bol11ACT;0)
	ARRAY TEXT:C222(at_val11ACT;0)
	ARRAY REAL:C219(ar_montoBeca11ACT;0)
	ARRAY TEXT:C222(at_tieneBeca10011ACT;0)
	ARRAY TEXT:C222(at_bol12ACT;0)
	ARRAY TEXT:C222(at_val12ACT;0)
	ARRAY REAL:C219(ar_montoBeca12ACT;0)
	ARRAY TEXT:C222(at_tieneBeca10012ACT;0)
	
	
	ARRAY REAL:C219($ar_montoTotalMensualACT;0)
	ARRAY REAL:C219($ar_montoDctoMensualACT;0)
	
	ARRAY LONGINT:C221(al_idsAlumnos;0)
	
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([xxACT_Items:179])
	READ ONLY:C145([xxACT_ItemsCategorias:98])
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Boletas:181])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([Alumnos_Historico:25])
	
	ARRAY LONGINT:C221($al_idsItemsColegiatura;0)
	ARRAY LONGINT:C221($al_idsItemsMatricula;0)
	ARRAY LONGINT:C221($al_idsItemsDscto;0)
	ARRAY LONGINT:C221($al_rnCargos;0)
	ARRAY LONGINT:C221($aIDCategoria;0)
	ARRAY LONGINT:C221($aPosCategoria;0)
	ARRAY TEXT:C222($atACT_NombreCategoria;0)
	C_LONGINT:C283($noBolTransaccion)
	C_LONGINT:C283($el;$el2;$el3;$el4;$vl_noDscto)
	C_REAL:C285($id_colegiatura;$id_matricula;$id_dscto;$vr_montoCol)
	
	ALL RECORDS:C47([xxACT_ItemsCategorias:98])
	ORDER BY:C49([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Posicion:3;>)
	SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]ID:2;$aIDCategoria;[xxACT_ItemsCategorias:98]Posicion:3;$aPosCategoria;[xxACT_ItemsCategorias:98]Nombre:1;$atACT_NombreCategoria)
	
	If (Size of array:C274($aIDCategoria)>0)
		vl_paginaFormulario:=2
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_SeleccionaCurso";-1;Movable form dialog box:K39:8;__ ("Opciones de impresión"))
		DIALOG:C40([xxSTR_Constants:1];"STR_SeleccionaCurso")
		CLOSE WINDOW:C154
		If (OK=1)
			$mesInicio:=Find in array:C230(aMeses;vs1)
			If ($mesInicio<3)
				$mesInicio:=3
			End if 
			$mesTermino:=Find in array:C230(aMeses;vs2)
			$numeroMeses:=$mesTermino-$mesInicio+1
			vd_fecha1:=DT_GetDateFromDayMonthYear (1;$mesInicio;vdACT_AñoAviso)
			vd_fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($mesTermino;vdACT_AñoAviso2);$mesTermino;vdACT_AñoAviso2)
			
			$id_colegiatura:=0
			$id_matricula:=0
			$id_dscto:=0
			$el:=Find in array:C230($atACT_NombreCategoria;"Cobro Mensual")  //busco sobre el nombre de la categoría estándar
			
			
			If ($el>0)
				$id_colegiatura:=$aIDCategoria{$el}
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=$id_colegiatura)
				SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$al_idsItemsColegiatura)
			End if 
			
			$el2:=Find in array:C230($atACT_NombreCategoria;"Derecho de Matrícula")  //busco sobre el nombre de la categoría estándar
			If ($el2>0)
				$id_matricula:=$aIDCategoria{$el2}
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=$id_matricula)
				SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$al_idsItemsMatricula)
			End if 
			
			$el2:=Find in array:C230($atACT_NombreCategoria;"Exención Sistema de Becas")  //busco sobre el nombre de la categoría estándar
			If ($el2>0)
				$id_dscto:=$aIDCategoria{$el2}
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=$id_dscto)
				SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$al_idsItemsDscto)
			End if 
			
			
			
			If (($id_colegiatura#0) & ($id_dscto#0) & ($id_matricula#0))
				
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4>=vd_fecha1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4<=vd_fecha2;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
				CREATE SET:C116([ACT_Cargos:173];"cargosPeriodo")
				
				If ((vd_fecha1<DT_GetDateFromDayMonthYear (1;1;Year of:C25(Current date:C33(*)))) & (<>gYear#Year of:C25(vd_fecha1)))  //para cuando se obtenga el informe para un año anterior y los alumnos ya no estén en el curso
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
					KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
					KRL_RelateSelection (->[Alumnos_Historico:25]Alumno_Numero:1;->[Alumnos:2]numero:1;"")
					QUERY SELECTION:C341([Alumnos_Historico:25];[Alumnos_Historico:25]Año:2=Year of:C25(vd_fecha1))
					ORDER BY:C49([Alumnos_Historico:25];[Alumnos_Historico:25]Curso:3;<)
					vt_CursoSeleccionado:=[Alumnos_Historico:25]Curso:3
				Else 
					QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=vt_CursoSeleccionado)
				End if 
				
				If (vl_becados=1)
					
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
					QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Becado:31=True:C214)
					KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
					
				End if 
				
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;at_nombresACT;[Alumnos:2]no_de_lista:53;ai_nosListaACT;[Alumnos:2]numero:1;al_idsAlumnos;[Alumnos:2]Status:50;at_statusAlumnosACT)
				SORT ARRAY:C229(ai_nosListaACT;at_nombresACT;al_idsAlumnos;at_statusAlumnosACT;>)
				AT_RedimArrays (Size of array:C274(at_nombresACT);->at_MontosMatACT;->at_MontoBecaACT;->at_PctBeca;->at_bol3ACT;->at_val3ACT;->at_bol4ACT;->at_val4ACT;->at_bol5ACT;->at_val5ACT;->at_bol6ACT;->at_val6ACT;->at_bol7ACT;->at_val7ACT)
				AT_RedimArrays (Size of array:C274(at_nombresACT);->at_bol8ACT;->at_val8ACT;->at_bol9ACT;->at_val9ACT;->at_bol10ACT;->at_val10ACT;->at_bol11ACT;->at_val11ACT;->at_bol12ACT;->at_val12ACT)
				
				For ($i;3;12)
					$ptr:=Get pointer:C304("ar_montoBeca"+String:C10($i)+"ACT")
					AT_RedimArrays (Size of array:C274(at_nombresACT);$ptr)
					$ptr:=Get pointer:C304("at_tieneBeca100"+String:C10($i)+"ACT")
					AT_RedimArrays (Size of array:C274(at_nombresACT);$ptr)
				End for 
				
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Buscando información...")
				
				
				
				For ($i;1;Size of array:C274(at_nombresACT))
					$vl_noDscto:=0
					$vr_montoCol:=0
					AT_Initialize (->$ar_montoTotalMensualACT;->$ar_montoDctoMensualACT)
					USE SET:C118("cargosPeriodo")
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=al_idsAlumnos{$i})
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
					CREATE SET:C116([ACT_Cargos:173];"cargosCta")
					DIFFERENCE:C122("cargosPeriodo";"cargosCta";"cargosPeriodo")
					ARRAY REAL:C219($ar_montoNetoMensual;0)
					ARRAY REAL:C219($ar_montoTotalMensual;0)
					ARRAY REAL:C219($ar_montoDctoMensual;0)
					ARRAY REAL:C219($ar_boletaNumero;0)
					For ($j;$mesInicio;$numeroMeses+2)
						AT_Initialize (->$ar_montoNetoMensual;->$ar_montoTotalMensual;->$ar_montoDctoMensual;->$ar_boletaNumero)
						USE SET:C118("cargosCta")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$j)
						SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_rnCargos)
						
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
						QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8#"Balanceo Descuento";*)
						QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Glosa:8#"Pago con Descuento")
						
						  //PS 30-05-2012 se realizan modificaciones ya que en los pagos mostraba el monto neto del cargo.. no el efectivamente pagado, ademas no se visualizaban montos de beca en ctas con 100%
						CREATE SET:C116([ACT_Transacciones:178];"tra1")
						
						$noBolTransaccion:=Max:C3([ACT_Transacciones:178]No_Boleta:9)
						  //$vb_hayPago:=(Max([ACT_Transacciones]ID_Pago)>0)
						$vb_hayPago:=True:C214
						If ($vb_hayPago)
							
							
							For ($k;1;Size of array:C274($al_rnCargos))
								GOTO RECORD:C242([ACT_Cargos:173];$al_rnCargos{$k})
								If ([ACT_Cargos:173]ID:1>0)
									
									  //PS 30-05-2012 se realizan modificaciones ya que en los pagos mostraba el monto neto del cargo.. no el efectivamente pagado, ademas no se visualizaban montos de beca en ctas con 100%
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
									CREATE SET:C116([ACT_Transacciones:178];"tra2")
									INTERSECTION:C121("tra1";"tra2";"tra2")
									SELECTION TO ARRAY:C260([ACT_Transacciones:178];aQR_longint99)
									vQR_real99:=ACTtra_CalculaMontos ("calculaFromRecNum";->aQR_longint99;->[ACT_Transacciones:178]Debito:6)
									
									$el4:=Find in array:C230($al_idsItemsMatricula;[ACT_Cargos:173]Ref_Item:16)
									If ($el4>0)  //matricula
										  //at_MontosMatACT{$i}:=String(Num(at_MontosMatACT{$i})+[ACT_Cargos]Monto_Neto;"|Despliegue_ACT")
										at_MontosMatACT{$i}:=String:C10(Num:C11(at_MontosMatACT{$i})+vQR_real99;"|Despliegue_ACT")
									End if 
									$el4:=Find in array:C230($al_idsItemsDscto;[ACT_Cargos:173]Ref_Item:16)
									If ($el4>0)  //descuento
										APPEND TO ARRAY:C911($ar_montoDctoMensual;Abs:C99([ACT_Cargos:173]Monto_Neto:5))
										APPEND TO ARRAY:C911($ar_montoNetoMensual;[ACT_Cargos:173]Monto_Neto:5)
									End if 
									
									If ($noBolTransaccion>0)
										QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=$noBolTransaccion;*)
										QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
										$el3:=Find in array:C230($al_idsItemsColegiatura;[ACT_Cargos:173]Ref_Item:16)
										If (($el3>0) & (Records in selection:C76([ACT_Boletas:181])>0))  //Colegiatura
											If ([ACT_Boletas:181]Numero:11>0)
												APPEND TO ARRAY:C911($ar_boletaNumero;[ACT_Boletas:181]Numero:11)
											End if 
										End if 
									End if 
									$el3:=Find in array:C230($al_idsItemsColegiatura;[ACT_Cargos:173]Ref_Item:16)
									If (($el3>0) | (([ACT_Cargos:173]Monto_Neto:5+[ACT_Cargos:173]Total_Desctos:45=[ACT_Cargos:173]Total_Desctos:45) & ([ACT_Cargos:173]Total_Desctos:45>0)))
										
										  //APPEND TO ARRAY($ar_montoNetoMensual;[ACT_Cargos]Monto_Neto)
										APPEND TO ARRAY:C911($ar_montoNetoMensual;vQR_real99)
										
										APPEND TO ARRAY:C911($ar_montoDctoMensual;Abs:C99([ACT_Cargos:173]Total_Desctos:45))
										$vr_montoCol:=$vr_montoCol+[ACT_Cargos:173]Monto_Neto:5
										
										If ([ACT_Cargos:173]Total_Desctos:45>0)
											APPEND TO ARRAY:C911($ar_montoTotalMensual;[ACT_Cargos:173]Monto_Neto:5+[ACT_Cargos:173]Total_Desctos:45)
										Else 
											  //APPEND TO ARRAY($ar_montoTotalMensual;[ACT_Cargos]Monto_Neto)
											  //se quita el comentario de esta linea debido a que no estaba cargando correctamen
											  //descuento ya que hace alusion a esta variable el calculo del descuento
											  //JVP  16/09/2013
											APPEND TO ARRAY:C911($ar_montoTotalMensual;[ACT_Cargos:173]Monto_Neto:5)
										End if 
										
									End if 
								End if 
							End for 
						End if 
						
						$ptr:=Get pointer:C304("at_val"+String:C10($j)+"ACT")
						$vr_montoMensual:=AT_GetSumArray (->$ar_montoNetoMensual)
						$ptr->{$i}:=String:C10($vr_montoMensual;"|Despliegue_ACT")
						$ptr:=Get pointer:C304("at_bol"+String:C10($j)+"ACT")
						$vt_bolSTR:=String:C10(AT_Maximum (->$ar_boletaNumero;1))
						If ($vt_bolSTR#"0")
							$ptr->{$i}:=$vt_bolSTR
						End if 
						$vr_dctomensual:=AT_GetSumArray (->$ar_montoDctoMensual)
						If ($vr_dctomensual>0)
							$ptr:=Get pointer:C304("ar_montoBeca"+String:C10($j)+"ACT")
							$ptr->{$i}:=$ptr->{$i}+$vr_dctomensual
						End if 
						$vr_montoTotal:=AT_GetSumArray (->$ar_montoTotalMensual)
						If ($vr_dctomensual#0)
							$ptr:=Get pointer:C304("at_tieneBeca100"+String:C10($j)+"ACT")
							$ptr->{$i}:="SI"
						End if 
						APPEND TO ARRAY:C911($ar_montoTotalMensualACT;AT_GetSumArray (->$ar_montoTotalMensual))
						
						APPEND TO ARRAY:C911($ar_montoDctoMensualACT;$vr_dctomensual)
						$ptr:=Get pointer:C304("at_val"+String:C10($j)+"ACT")
						If (($ptr->{$i}="0") & (at_statusAlumnosACT{$i}="Retirado@"))
							$ptr->{$i}:=at_statusAlumnosACT{$i}
						End if 
					End for 
					CLEAR SET:C117("cargosCta")
					at_PctBeca{$i}:=String:C10(Round:C94(AT_GetSumArray (->$ar_montoDctoMensualACT;True:C214)*100/AT_GetSumArray (->$ar_montoTotalMensualACT;True:C214);0))
					at_MontoBecaACT{$i}:=String:C10(Round:C94(AT_Mean (->$ar_montoDctoMensualACT;1);0))
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(at_nombresACT))
				End for 
				
				
				
				CLEAR SET:C117("cargosPeriodo")
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				ARRAY TEXT:C222($aMesesText;0)
				COPY ARRAY:C226(<>atXS_MonthNames;$aMesesText)
				ARRAY TEXT:C222(at_encabezadosACT;0)
				ARRAY TEXT:C222(at_nombresArreglosACT;0)
				Case of 
					: (vl_modeloInforme=1)
						APPEND TO ARRAY:C911(at_encabezadosACT;"Nombres")
						APPEND TO ARRAY:C911(at_nombresArreglosACT;"at_nombresACT")
						APPEND TO ARRAY:C911(at_encabezadosACT;"No L.")
						APPEND TO ARRAY:C911(at_nombresArreglosACT;"ai_nosListaACT")
						APPEND TO ARRAY:C911(at_encabezadosACT;"M. Mat")
						APPEND TO ARRAY:C911(at_nombresArreglosACT;"at_MontosMatACT")
						APPEND TO ARRAY:C911(at_encabezadosACT;"M. Beca")
						APPEND TO ARRAY:C911(at_nombresArreglosACT;"at_MontoBecaACT")
						APPEND TO ARRAY:C911(at_encabezadosACT;"% Beca")
						APPEND TO ARRAY:C911(at_nombresArreglosACT;"at_PctBeca")
						For ($r;1;Size of array:C274($aMesesText))
							If ($r>=3)
								APPEND TO ARRAY:C911(at_encabezadosACT;Substring:C12($aMesesText{$r};1;3)+" Boleta")
								APPEND TO ARRAY:C911(at_nombresArreglosACT;"at_bol"+String:C10($r)+"ACT")
								APPEND TO ARRAY:C911(at_encabezadosACT;Substring:C12($aMesesText{$r};1;3)+" Valor")
								APPEND TO ARRAY:C911(at_nombresArreglosACT;"at_val"+String:C10($r)+"ACT")
							End if 
						End for 
					Else 
						$vb_entrar:=True:C214
						APPEND TO ARRAY:C911(at_encabezadosACT;"No L.")
						APPEND TO ARRAY:C911(at_nombresArreglosACT;"ai_nosListaACT")
						APPEND TO ARRAY:C911(at_encabezadosACT;"Nombre alumno")
						APPEND TO ARRAY:C911(at_nombresArreglosACT;"at_nombresACT")
						For ($r;1;Size of array:C274($aMesesText))
							If ($r>=3)
								$vb_continue:=True:C214
								If (($r=8) & ($vb_entrar))
									APPEND TO ARRAY:C911(at_encabezadosACT;"No L.")
									APPEND TO ARRAY:C911(at_nombresArreglosACT;"ai_nosListaACT")
									APPEND TO ARRAY:C911(at_encabezadosACT;"Nombre alumno")
									APPEND TO ARRAY:C911(at_nombresArreglosACT;"at_nombresACT")
									$r:=7
									$vb_entrar:=False:C215
									$vb_continue:=False:C215
								End if 
								If ($vb_continue)
									APPEND TO ARRAY:C911(at_encabezadosACT;Substring:C12($aMesesText{$r};1;3)+"\r\n"+"Boleta")
									APPEND TO ARRAY:C911(at_encabezadosACT;Substring:C12($aMesesText{$r};1;3)+"\r\n"+"Cobro Mensual")
									APPEND TO ARRAY:C911(at_encabezadosACT;Substring:C12($aMesesText{$r};1;3)+"\r\n"+"Beca")
									APPEND TO ARRAY:C911(at_encabezadosACT;Substring:C12($aMesesText{$r};1;3)+"\r\n"+"Descuento")
									APPEND TO ARRAY:C911(at_nombresArreglosACT;"at_bol"+String:C10($r)+"ACT")
									APPEND TO ARRAY:C911(at_nombresArreglosACT;"at_val"+String:C10($r)+"ACT")
									APPEND TO ARRAY:C911(at_nombresArreglosACT;"at_tieneBeca100"+String:C10($r)+"ACT")
									APPEND TO ARRAY:C911(at_nombresArreglosACT;"ar_montoBeca"+String:C10($r)+"ACT")
								End if 
							End if 
						End for 
				End case 
				If (cs_imprimir=1)
					$page1:="ACT_PrintIngresosXAl1"
					$page2:="ACT_PrintIngresosXAl2"
					ALL RECORDS:C47([xxSTR_Constants:1])
					ONE RECORD SELECT:C189([xxSTR_Constants:1])
					FORM SET OUTPUT:C54([xxSTR_Constants:1];$page1)
					PRINT SETTINGS:C106
					If (ok=1)
						PRINT RECORD:C71([xxSTR_Constants:1];>)
						If ((OK=1) & (vl_modeloInforme#1))
							FORM SET OUTPUT:C54([xxSTR_Constants:1];$page2)
							PRINT RECORD:C71([xxSTR_Constants:1];>)
						End if 
					End if 
					FORM SET OUTPUT:C54([xxSTR_Constants:1];"Output")
				End if 
				If (cs_Exportar=1)
					USE CHARACTER SET:C205("windows-1252";0)
					C_TEXT:C284($texto;$fileName;$folderPath;$filePath)
					$fileName:="IngresosXCuenta"+Replace string:C233(vt_CursoSeleccionado;"-";"")+Replace string:C233(Replace string:C233(String:C10(Current date:C33(*));"-";"");"/";"")
					If (SYS_IsWindows )
						$fileName:=$fileName+".txt"
					End if 
					
					$ref:=ACTabc_CreaDocumento ("Ingresos por cuenta";$fileName)
					
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Enviando información a archivo de texto..."))
					If ($ref#?00:00:00?)
						$texto:=""
						Case of 
							: (vl_modeloInforme=1)
								For ($r;1;Size of array:C274(at_encabezadosACT))
									$texto:=$texto+at_encabezadosACT{$r}+"\t"
								End for 
								$texto:=Substring:C12($texto;1;Length:C16($texto)-1)
								$texto:=$texto+"\r\n"
								IO_SendPacket ($ref;$texto)
								$texto:=""
								
								For ($y;1;Size of array:C274(at_nombresACT))
									$texto:=at_nombresACT{$y}+"\t"+String:C10(ai_nosListaACT{$y})+"\t"+at_MontosMatACT{$y}+"\t"+at_MontoBecaACT{$y}+"\t"+at_PctBeca{$y}+"\t"+at_bol3ACT{$y}+"\t"+at_val3ACT{$y}+"\t"+at_bol4ACT{$y}+"\t"+at_val4ACT{$y}+"\t"+at_bol5ACT{$y}
									$texto:=$texto+"\t"+at_val5ACT{$y}+"\t"+at_bol6ACT{$y}+"\t"+at_val6ACT{$y}+"\t"+at_bol7ACT{$y}+"\t"+at_val7ACT{$y}+"\t"+at_bol8ACT{$y}+"\t"+at_val8ACT{$y}+"\t"+at_bol9ACT{$y}+"\t"+at_val9ACT{$y}
									$texto:=$texto+"\t"+at_bol10ACT{$y}+"\t"+at_val10ACT{$y}+"\t"+at_bol11ACT{$y}+"\t"+at_val11ACT{$y}+"\t"+at_bol12ACT{$y}+"\t"+at_val12ACT{$y}+"\r\n"
									IO_SendPacket ($ref;$texto)
									$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$y/Size of array:C274(at_nombresACT))
								End for 
							Else 
								
								For ($r;1;Size of array:C274(at_encabezadosACT))
									If ($r#22)  //repite la columna con el nombre
										$texto:=$texto+Replace string:C233(at_encabezadosACT{$r};"\r\n";" ")+"\t"
									End if 
								End for 
								$texto:=Substring:C12($texto;1;Length:C16($texto)-1)
								$texto:=$texto+"\r\n"
								IO_SendPacket ($ref;$texto)
								$texto:=""
								
								For ($y;1;Size of array:C274(at_nombresACT))
									$texto:=""
									For ($z;1;Size of array:C274(at_nombresArreglosACT))
										If ($z#22)  //repite la columna con el nombre
											$ptr:=Get pointer:C304(at_nombresArreglosACT{$z})
											$type:=Type:C295($ptr->)
											Case of 
												: ($type=Text array:K8:16)
													$texto:=$texto+$ptr->{$y}+"\t"
												: (($type=Real array:K8:17) | ($type=LongInt array:K8:19) | ($type=Integer array:K8:18))
													$texto:=$texto+String:C10($ptr->{$y})+"\t"
											End case 
										End if 
									End for 
									$texto:=Substring:C12($texto;1;Length:C16($texto)-1)
									$texto:=$texto+"\r\n"
									IO_SendPacket ($ref;$texto)
									$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$y/Size of array:C274(at_nombresACT))
								End for 
						End case 
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					End if 
					CLOSE DOCUMENT:C267($ref)
					
					USE CHARACTER SET:C205(*;0)
					CD_Dlog (0;__ ("La exportación del archivo ")+ST_Qte ($fileName)+__ (" ha concluido.")+"\r\r"+__ ("Encontrará el archivo en: ")+"\r"+$folderPath+"\r\r"+__ ("Le recomendamos abrir el archivo con Microsoft Excel."))
				End if 
				AT_Initialize (->at_MontoBecaACT;->at_PctBeca;->at_bol3ACT;->at_val3ACT;->at_bol4ACT;->at_val4ACT;->at_bol5ACT;->at_val5ACT;->at_bol6ACT;->at_val6ACT;->at_bol7ACT;->at_val7ACT)
				AT_Initialize (->at_bol8ACT;->at_val8ACT;->at_bol9ACT;->at_val9ACT;->at_bol10ACT;->at_val10ACT;->at_bol11ACT;->at_val11ACT;->at_bol12ACT;->at_val12ACT)
				For ($i;3;$numeroMeses+2)
					$ptr:=Get pointer:C304("ar_montoBeca"+String:C10($i)+"ACT")
					AT_Initialize ($ptr)
					$ptr:=Get pointer:C304("at_tieneBeca100"+String:C10($i)+"ACT")
					AT_Initialize ($ptr)
				End for 
				AT_Initialize (->at_encabezadosACT;->at_nombresACT;->at_nombresArreglosACT;->at_statusAlumnosACT;->at_statusAlumnosACT)
				REDUCE SELECTION:C351([ACT_Cargos:173];0)
				REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
				REDUCE SELECTION:C351([xxACT_Items:179];0)
				REDUCE SELECTION:C351([xxACT_ItemsCategorias:98];0)
				REDUCE SELECTION:C351([ACT_Transacciones:178];0)
				REDUCE SELECTION:C351([ACT_Boletas:181];0)
				REDUCE SELECTION:C351([Alumnos:2];0)
			Else 
				CD_Dlog (0;__ ("El sistema no tiene configuradas las categorías estándar para la modalidad subven"+"cionada."))
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("El sistema debe tener configuradas las categorías para poder utilizar este informe."))
	End if 
End if 