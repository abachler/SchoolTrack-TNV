//%attributes = {}
  //ACTcc_MetodoInforme_Deudores
$sem:=Semaphore:C143("InformeServer")

  //MONO Ticket:167055 Estoy realizando una revisión con respecto al cambio de ejecutar este informe en el servidor, debido a que en pruebas no generó resultados o quedó pegado en el servidor mas de una hora.   

C_LONGINT:C283($d;$el;$SedeFlag;$l_idTermometro)
C_POINTER:C301($TotalConvPtr;$TotalMorosidadPtr;$TotalPagadoPtr;$TotalPctMorosidadPtr)
C_TEXT:C284($aHeaderTextAño;$BoletasNumText;$col2;$Header1;$Header2;$HeaderText2;$HeaderTextRow2)

ARRAY LONGINT:C221($aBoletasNum;0)
ARRAY LONGINT:C221($aIDFamilia;0)
ARRAY LONGINT:C221($aIDs;0)
ARRAY LONGINT:C221($al_recNumsCargos;0)
ARRAY LONGINT:C221($al_recNumTransacciones;0)
ARRAY TEXT:C222($aCodigo;0)
ARRAY TEXT:C222($aCursos;0)
ARRAY TEXT:C222($aFamilias;0)
ARRAY TEXT:C222($aNombres;0)
ARRAY TEXT:C222($aRUT;0)
ARRAY TEXT:C222($aSede;0)
C_TEXT:C284($ruta;$fileName;$t_fechaHoraGMT)


  // Modificado por: Saúl Ponce (26-09-2016) Ticket N° 167055, se cambia el tipo de blob y se declara variable 'b_terminar' para chequear el termino del proceso
  //C_BLOB(<>VBLOBACT_EmisionInformeServer)
C_BLOB:C604(x_Informe)
C_BOOLEAN:C305(b_terminar)

C_BLOB:C604($1)
C_BLOB:C604($blob;0)
SET BLOB SIZE:C606($blob;0;0)
SET BLOB SIZE:C606(x_Informe;0)
b_terminar:=False:C215

ARRAY LONGINT:C221($al_recnumCtasCorrientes;0)
ARRAY LONGINT:C221($alACT_IDsDefinitivos;0)
ARRAY LONGINT:C221($al_recnumCargos;0)
C_DATE:C307($vd_dateInicial;$vd_dateFinal)
C_REAL:C285($cb_considerarSoloPagosPeriodo;$cb_ProximoCurso;$cb_Agrupar;$cb_FiltrosExcel;$cb_PrintPhone;$cb_ObsApdo)
C_LONGINT:C283($vl_seleccion;$vl_WhichPhoneInfSelected)

ARRAY POINTER:C280($aPtr_WhichPhoneInf;0)
APPEND TO ARRAY:C911($aPtr_WhichPhoneInf;->[Personas:7]Telefono_domicilio:19)
APPEND TO ARRAY:C911($aPtr_WhichPhoneInf;->[Personas:7]Telefono_profesional:29)
APPEND TO ARRAY:C911($aPtr_WhichPhoneInf;->[Personas:7]Celular:24)
ARRAY TEXT:C222($at_WhichPhoneInf;0)
APPEND TO ARRAY:C911($at_WhichPhoneInf;"Teléfono Domicilio")
APPEND TO ARRAY:C911($at_WhichPhoneInf;"Teléfono Profesional")
APPEND TO ARRAY:C911($at_WhichPhoneInf;"Teléfono Móvil")
$blob:=$1

BLOB_Blob2Vars (->$blob;0;->$al_recnumCtasCorrientes;->$al_recnumCargos;->$cb_considerarSoloPagosPeriodo;->$cb_ProximoCurso;->$cb_Agrupar;->$cb_FiltrosExcel;->$cb_PrintPhone;->$cb_ObsApdo;->$vl_WhichPhoneInfSelected;->$fileName;->$vd_dateInicial;->$vd_dateFinal)

If (ok=1)
	$vl_seleccion:=$vl_WhichPhoneInfSelected
	SET BLOB SIZE:C606($blob;0)
	
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([xxACT_Items:179])
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([Cursos:3])
	
	CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];$al_recnumCtasCorrientes)
	
	If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
		
		  // Modificado por: Saúl Ponce (06-10-2016) Ticket N° 16811 y 168958 .
		  // No se crea la ruta estándar de los informes, no es necesaria en el server para archivo temporal. El archivo se creará en la ruta de la BD 
		  //$folderPath:=Folder separator+"AccountTrack"+Folder separator+"Informes de Morosidad"+Folder separator
		
		  // Modificado por: Saúl Ponce (06-10-2016) Ticket N° 16811 y 168958 .
		  // Reducción del path hacia el archivo temporal. Quedará en la ruta de la BD
		  //$folderPath:=sys_getRutaBaseDatos +Substring($folderPath;2)
		$folderPath:=sys_getRutaBaseDatos 
		  //
		If (SYS_TestPathName ($folderPath)<0)
			SYS_CreateFolder ($folderPath)
		End if 
		
		  // Modificado por: Saúl Ponce (26-09-2016) Ticket N° 167055, el nombre de archivo en el server quedaba con ':' (en windows no es válido)
		  //$t_fechaHoraGMT:=DTS_Get_GMT_TimeStamp (Current date;Current time) 
		  //$fileName:="Info_Morosidad_Detallado_"+$fileName+"_"+DTS_GetDateTimeString ($t_fechaHoraGMT;System date long;HH MM SS)
		
		  // Modificado por: Saúl Ponce (06-10-2016) Ticket N° 16811 y 168958 . 
		  // El nombre del archivo en el server no es importante; lo importante es la creación del blob x_informe que utiliza el cliente
		  //$fileName:="Info_Morosidad_Detallado_"+$fileName+"_"+DTS_MakeFromDateTime 
		$fileName:="IMD"+DTS_MakeFromDateTime 
		
		$filePath:=$folderPath+$fileName
		$vt_filePath:=$filePath+".txt"
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		If (SYS_TestPathName ($vt_filePath)=1)
			DELETE DOCUMENT:C159($vt_filePath)
		End if 
		EM_ErrorManager ("Clear")
		
		USE CHARACTER SET:C205("windows-1252";0)
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		$ref:=Create document:C266($vt_filePath;"TEXT")
		EM_ErrorManager ("Clear")
		
		  //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		  //18-09-09 Se verifica que hayan sedes ingresadas
		QUERY:C277([Cursos:3];[Cursos:3]Sede:19#"")
		$SedeFlag:=Records in selection:C76([Cursos:3])
		
		If ($ref#?00:00:00?)
			  //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			  //18-09-09 Se agrega la columna sede cuando existen registradas en cursos
			If ($cb_FiltrosExcel=0)
				
				If ($SedeFlag>0)
					$header:=__ ("Apoderado")+"\t"+__ ("Cuentas Corrientes")+"\t"+__ ("Curso")+"\t"+__ ("Sede")+"\t"+__ ("Cargos")+"\t"+__ ("Período")+"\t"+__ ("Boleta(s)")+"\t"+__ ("Saldos Ctas.")+"\t"+__ ("Saldo Apdo.")
				Else 
					$header:=__ ("Apoderado")+"\t"+__ ("Cuentas Corrientes")+"\t"+__ ("Curso")+"\t"+__ ("Cargos")+"\t"+__ ("Período")+"\t"+__ ("Boleta(s)")+"\t"+__ ("Saldos Ctas.")+"\t"+__ ("Saldo Apdo.")
				End if 
			Else 
				If ($SedeFlag>0)
					$header:=__ ("Apoderado")+"\t"+__ ("Cuentas Corrientes")+"\t"+__ ("Curso")+"\t"+__ ("Sede")+"\t"+__ ("Cargos")+"\t"+__ ("Período")+"\t"+__ ("Boleta(s)")+"\t"+__ ("Saldos Ctas.")
				Else 
					$header:=__ ("Apoderado")+"\t"+__ ("Cuentas Corrientes")+"\t"+__ ("Curso")+"\t"+__ ("Cargos")+"\t"+__ ("Período")+"\t"+__ ("Boleta(s)")+"\t"+__ ("Saldos Ctas.")
				End if 
			End if 
			If ($cb_PrintPhone=1)
				$header:=$header+"\t"+$at_WhichPhoneInf{$at_WhichPhoneInf}+__ (" Apdo.")
			End if 
			If ($cb_ObsApdo=1)
				$header:=$header+"\t"+__ ("Observación Apdo.")
			End if 
			$header:=$header+"\r\n"
			IO_SendPacket ($ref;$header)
			
			CREATE SET:C116([ACT_CuentasCorrientes:175];"CtasCorrientes")
			
			CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_recnumCargos)
			CREATE SET:C116([ACT_Cargos:173];"Cargos")
			
			KRL_RelateSelection (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9)
			ORDER BY:C49([Personas:7];[Personas:7]Apellidos_y_nombres:30;>)
			ARRAY LONGINT:C221($aPersonas;0)
			LONGINT ARRAY FROM SELECTION:C647([Personas:7];$aPersonas)
			$GranTotal:=0
			$l_idTermometro:=IT_Progress (1;0;0;__ ("Recopilando información y generando archivo..."))
			
			ARRAY LONGINT:C221($aRefsItemsTotales;0)
			ARRAY REAL:C219($aSaldosItemsTotales;0)
			For ($i;1;Size of array:C274($aPersonas))
				USE SET:C118("CtasCorrientes")
				GOTO RECORD:C242([Personas:7];$aPersonas{$i})
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
				
				If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
					ARRAY LONGINT:C221($al_idCtaCorriente;0)
					SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$al_idCtaCorriente)
					USE SET:C118("Cargos")
					QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CuentaCorriente:2;$al_idCtaCorriente)
					
					If ($cb_considerarSoloPagosPeriodo=1)
						$neto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
						QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_dateFinal;*)
						QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
						ARRAY LONGINT:C221($al_recNumTransacciones;0)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
						$MontoPagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
						$total:=$neto-$MontoPagado
						If ($total=0)
							REDUCE SELECTION:C351([ACT_Cargos:173];0)
						End if 
					End if 
					
					If (Records in selection:C76([ACT_Cargos:173])>0)
						CREATE SET:C116([ACT_Cargos:173];"marcados")
						DIFFERENCE:C122("Cargos";"marcados";"Cargos")
						$total:=Sum:C1([ACT_Cargos:173]Saldo:23)*-1
						If ($cb_considerarSoloPagosPeriodo=0)
							$total:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
						Else 
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_dateFinal;*)
							QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
							ARRAY LONGINT:C221($al_recNumTransacciones;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
							$MontoPagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
							$neto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							$total:=$neto-$MontoPagado
						End if 
						$GranTotal:=$GranTotal+$total
						If ($cb_FiltrosExcel=0)
							  //19-09-09 Se agrega espacio la columna de Boletas
							If ($SedeFlag>0)
								IO_SendPacket ($ref;[Personas:7]Apellidos_y_nombres:30+("\t"*8)+String:C10($total))
							Else 
								IO_SendPacket ($ref;[Personas:7]Apellidos_y_nombres:30+("\t"*7)+String:C10($total))
							End if 
							
							If ($cb_PrintPhone=1)
								IO_SendPacket ($ref;"\t"+$aPtr_WhichPhoneInf{$vl_seleccion}->)
							End if 
							If ($cb_ObsApdo=1)
								IO_SendPacket ($ref;"\t"+[Personas:7]Observaciones:32+"\r\n")
							Else 
								IO_SendPacket ($ref;"\r\n")
							End if 
						End if 
						QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID:1;$al_idCtaCorriente)
						KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
						ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
						FIRST RECORD:C50([Alumnos:2])
						For ($y;1;Records in selection:C76([Alumnos:2]))
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
							USE SET:C118("marcados")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
							If ($cb_ProximoCurso=1)
								Case of 
									: ([Alumnos:2]nivel_numero:29=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)})
										$curso:="EGR - "+String:C10(<>gYear)
									: ([Alumnos:2]nivel_numero:29<=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)-1})
										$el:=Find in array:C230(<>al_NumeroNivelRegular;[Alumnos:2]nivel_numero:29)
										If (($el>0) & ($el<Size of array:C274(<>al_NumeroNivelRegular)))
											$proximoNivel:=<>al_NumeroNivelRegular{$el+1}
										End if 
										$abrev:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$proximoNivel;->[xxSTR_Niveles:6]Abreviatura:19)
										$curso:=$abrev+Substring:C12([Alumnos:2]curso:20;Position:C15("-";[Alumnos:2]curso:20))
									Else 
										$curso:=[Alumnos:2]curso:20
								End case 
							Else 
								$curso:=[Alumnos:2]curso:20
							End if 
							If (Records in selection:C76([ACT_Cargos:173])>0)
								If ($cb_FiltrosExcel=0)
									If ($SedeFlag>0)
										QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$curso)
										IO_SendPacket ($ref;"\t"+[Alumnos:2]apellidos_y_nombres:40+"\t"+$curso+"\t"+[Cursos:3]Sede:19+"\r\n")
									Else 
										IO_SendPacket ($ref;"\t"+[Alumnos:2]apellidos_y_nombres:40+"\t"+$curso+"\r\n")
									End if 
								End if 
								If ($cb_Agrupar=1)
									CREATE SET:C116([ACT_Cargos:173];"cargosAlumno")
									ARRAY LONGINT:C221($aRefsCargos;0)
									DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;$aRefsCargos)
									For ($h;1;Size of array:C274($aRefsCargos))
										USE SET:C118("cargosAlumno")
										QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$aRefsCargos{$h})
										CREATE SET:C116([ACT_Cargos:173];"porItem")
										ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22;>)
										ARRAY TEXT:C222($aMesAño;0)
										FIRST RECORD:C50([ACT_Cargos:173])
										For ($w;1;Records in selection:C76([ACT_Cargos:173]))
											If (Find in array:C230($aMesAño;String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000"))=-1)
												INSERT IN ARRAY:C227($aMesAño;Size of array:C274($aMesAño)+1;1)
												$aMesAño{Size of array:C274($aMesAño)}:=String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000")
											End if 
											NEXT RECORD:C51([ACT_Cargos:173])
										End for 
										For ($w;1;Size of array:C274($aMesAño))
											USE SET:C118("PorItem")
											$mes:=Num:C11(Substring:C12($aMesAño{$w};1;2))
											$año:=Num:C11(Substring:C12($aMesAño{$w};3))
											QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Mes:13=$mes;*)
											QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$año)
											QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$aRefsCargos{$h})
											If (Records in selection:C76([xxACT_Items:179])=1)
												$glosa:=[xxACT_Items:179]Glosa_de_Impresión:20
											Else 
												$glosa:=[ACT_Cargos:173]Glosa:12
											End if 
											
											If (Sum:C1([ACT_Cargos:173]Monto_Neto:5)>0)
												$vr_multiplo:=1
											Else 
												$vr_multiplo:=-1
											End if 
											
											If ($cb_considerarSoloPagosPeriodo=0)
												$vr_saldo:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
											Else 
												$neto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
												KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
												QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_dateFinal;*)
												QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
												ARRAY LONGINT:C221($al_recNumTransacciones;0)
												LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
												$pagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
												$vr_saldo:=$neto-$pagado
											End if 
											
											  //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
											  //19-09-09 Búsqueda de boletas
											ARRAY LONGINT:C221($aboletas_numero;0)
											C_TEXT:C284($boletas_numero)
											KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
											KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
											SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;$aboletas_numero)
											$boletas_numero:=AT_array2text (->$aboletas_numero;" - ")
											
											$vr_saldo:=$vr_saldo*$vr_multiplo
											$vt_saldo:=String:C10($vr_saldo)
											If ($cb_FiltrosExcel=0)
												
												If ($SedeFlag>0)
													IO_SendPacket ($ref;("\t"*4)+$glosa+"\t"+String:C10($mes;"00")+" "+String:C10($año;"0000")+"\t"+$boletas_numero+"\t"+$vt_saldo+"\r\n")
												Else 
													IO_SendPacket ($ref;("\t"*3)+$glosa+"\t"+String:C10($mes;"00")+" "+String:C10($año;"0000")+"\t"+$boletas_numero+"\t"+$vt_saldo+"\r\n")
												End if 
												
												
											Else 
												  //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
												  //19-09-09 Se agrega el numero de boleta y la sede si existen registradas
												If ($SedeFlag>0)
													QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$curso)
													IO_SendPacket ($ref;[Personas:7]Apellidos_y_nombres:30+"\t"+[Alumnos:2]apellidos_y_nombres:40+"\t"+$curso+"\t"+[Cursos:3]Sede:19+"\t"+$glosa+"\t"+String:C10($mes;"00")+" "+String:C10($año;"0000")+"\t"+$boletas_numero+"\t"+$vt_saldo)
												Else 
													IO_SendPacket ($ref;[Personas:7]Apellidos_y_nombres:30+"\t"+[Alumnos:2]apellidos_y_nombres:40+"\t"+$curso+"\t"+$glosa+"\t"+String:C10($mes;"00")+" "+String:C10($año;"0000")+"\t"+$boletas_numero+"\t"+$vt_saldo)
												End if 
												
												If ($cb_PrintPhone=1)
													IO_SendPacket ($ref;"\t"+$aPtr_WhichPhoneInf{$vl_seleccion}->)
												End if 
												If ($cb_ObsApdo=1)
													IO_SendPacket ($ref;"\t"+[Personas:7]Observaciones:32+"\r\n")
												Else 
													IO_SendPacket ($ref;"\r\n")
												End if 
											End if 
											$el:=Find in array:C230($aRefsItemsTotales;$aRefsCargos{$h})
											If ($el=-1)
												INSERT IN ARRAY:C227($aRefsItemsTotales;Size of array:C274($aRefsItemsTotales)+1;1)
												INSERT IN ARRAY:C227($aSaldosItemsTotales;Size of array:C274($aSaldosItemsTotales)+1;1)
												$aRefsItemsTotales{Size of array:C274($aRefsItemsTotales)}:=$aRefsCargos{$h}
												$aSaldosItemsTotales{Size of array:C274($aSaldosItemsTotales)}:=$vr_saldo
											Else 
												$aSaldosItemsTotales{$el}:=$aSaldosItemsTotales{$el}+$vr_saldo
											End if 
											
										End for 
									End for 
								Else 
									ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22;>)
									ARRAY LONGINT:C221($al_recNum;0)
									SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNum)
									For ($r;1;Size of array:C274($al_recNum))
										REDUCE SELECTION:C351([ACT_Cargos:173];0)
										KRL_GotoRecord (->[ACT_Cargos:173];$al_recNum{$r})
										
										  //For ($u;1;Records in selection([ACT_Cargos]))
										QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
										If (Records in selection:C76([xxACT_Items:179])=1)
											$glosa:=[xxACT_Items:179]Glosa_de_Impresión:20
										Else 
											$glosa:=[ACT_Cargos:173]Glosa:12
										End if 
										$vl_mes:=[ACT_Cargos:173]Mes:13
										$vl_agno:=[ACT_Cargos:173]Año:14
										
										If (Sum:C1([ACT_Cargos:173]Monto_Neto:5)>0)
											$vr_multiplo:=1
										Else 
											$vr_multiplo:=-1
										End if 
										
										If ($cb_considerarSoloPagosPeriodo=0)
											$vr_saldo:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
										Else 
											  //Esta opción es para revisar si los cargos fueron pagados pero no dentro de la fecha de vencimiento.
											$neto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
											KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
											QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5<=$vd_dateFinal;*)
											QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
											ARRAY LONGINT:C221($al_recNumTransacciones;0)
											LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
											$pagado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
											$vr_saldo:=$neto-$pagado
										End if 
										
										  //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
										  //19-09-09 Búsqueda de boletas
										ARRAY LONGINT:C221($aboletas_numero;0)
										C_TEXT:C284($boletas_numero)
										KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
										KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
										SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;$aboletas_numero)
										$boletas_numero:=AT_array2text (->$aboletas_numero;" - ")
										
										$vr_saldo:=$vr_saldo*$vr_multiplo
										
										If ($cb_FiltrosExcel=0)
											If ($SedeFlag>0)
												  //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
												  //19-09-09 Se agrega la columna de boletas
												IO_SendPacket ($ref;("\t"*4)+$glosa+"\t"+String:C10($vl_mes;"00")+" "+String:C10($vl_agno;"0000")+"\t"+$boletas_numero+"\t"+String:C10($vr_saldo)+"\r\n")
											Else 
												IO_SendPacket ($ref;("\t"*3)+$glosa+"\t"+String:C10($vl_mes;"00")+" "+String:C10($vl_agno;"0000")+"\t"+$boletas_numero+"\t"+String:C10($vr_saldo)+"\r\n")
											End if 
										Else 
											  //-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
											  //19-09-09 Se agrega la columna de boletas y sede si hay registradas
											If ($SedeFlag>0)
												QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$curso)
												IO_SendPacket ($ref;[Personas:7]Apellidos_y_nombres:30+"\t"+[Alumnos:2]apellidos_y_nombres:40+"\t"+$curso+"\t"+[Cursos:3]Sede:19+"\t"+$glosa+"\t"+String:C10($vl_mes;"00")+" "+String:C10($vl_agno;"0000")+"\t"+$boletas_numero+"\t"+String:C10($vr_saldo))
											Else 
												IO_SendPacket ($ref;[Personas:7]Apellidos_y_nombres:30+"\t"+[Alumnos:2]apellidos_y_nombres:40+"\t"+$curso+"\t"+$glosa+"\t"+String:C10($vl_mes;"00")+" "+String:C10($vl_agno;"0000")+"\t"+$boletas_numero+"\t"+String:C10($vr_saldo))
											End if 
											
											  //kjhq¬z-'-1N JM UJ<zw <<  <<  <<  <<  <<  <<  <<  <<  <<  <<  <<  <<  <<  << << <------Segunda linea de Emilia Herreros Mayo 2007
											  //<¿[0                n mm ,9o7xx edc m                    rv                                        uuuuuuuy  <------Tercera linea de Emilia Herreros Mayo 2007
											If ($cb_PrintPhone=1)
												IO_SendPacket ($ref;"\t"+$aPtr_WhichPhoneInf{$vl_seleccion}->+"\r\n")
											Else 
												IO_SendPacket ($ref;"\r\n")
											End if 
										End if 
										
										  //If ($r#Size of array($al_recNum))
										  //KRL_GotoRecord (->[ACT_Cargos];$al_recNum{$r+1}) Monto en totales sale con glosa en blanco
										If ($r<=Size of array:C274($al_recNum))
											KRL_GotoRecord (->[ACT_Cargos:173];$al_recNum{$r})
										Else 
											REDUCE SELECTION:C351([ACT_Cargos:173];0)
										End if 
										$el:=Find in array:C230($aRefsItemsTotales;[ACT_Cargos:173]Ref_Item:16)
										If ($el=-1)
											INSERT IN ARRAY:C227($aRefsItemsTotales;Size of array:C274($aRefsItemsTotales)+1;1)
											INSERT IN ARRAY:C227($aSaldosItemsTotales;Size of array:C274($aSaldosItemsTotales)+1;1)
											$aRefsItemsTotales{Size of array:C274($aRefsItemsTotales)}:=[ACT_Cargos:173]Ref_Item:16
											$aSaldosItemsTotales{Size of array:C274($aSaldosItemsTotales)}:=$vr_saldo
										Else 
											$aSaldosItemsTotales{$el}:=$aSaldosItemsTotales{$el}+$vr_saldo
										End if 
									End for 
								End if 
							End if 
							NEXT RECORD:C51([Alumnos:2])
						End for 
						CLEAR SET:C117("marcados")
						CLEAR SET:C117("cargosAlumnos")
						CLEAR SET:C117("PorItem")
					End if 
				End if 
				$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($aPersonas))
			End for 
			$vt_title:="Totales"
			If ($cb_considerarSoloPagosPeriodo=1)
				$vt_title:=$vt_title+__ (" - El informe sólo considera pagos ingresados hasta el ")+String:C10($vd_dateFinal)
			End if 
			IO_SendPacket ($ref;"\r\n"+"\r\n"+$vt_title+"\r\n")
			For ($e;1;Size of array:C274($aRefsItemsTotales))
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$aRefsItemsTotales{$e})
				If (Records in selection:C76([xxACT_Items:179])=1)
					IO_SendPacket ($ref;[xxACT_Items:179]Glosa_de_Impresión:20+"\t"+String:C10($aSaldosItemsTotales{$e})+"\r\n")
				Else 
					SET QUERY LIMIT:C395(1)
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$aRefsItemsTotales{$e})
					SET QUERY LIMIT:C395(0)
					IO_SendPacket ($ref;[ACT_Cargos:173]Glosa:12+"\t"+String:C10($aSaldosItemsTotales{$e})+"\r\n")
				End if 
			End for 
			IO_SendPacket ($ref;__ ("Total")+"\t"+String:C10($GranTotal))
			$l_idTermometro:=IT_Progress (-1;$l_idTermometro)
			
			CLEAR SET:C117("CtasCorrientes")
			CLEAR SET:C117("Cargos")
			CLOSE DOCUMENT:C267($ref)
			
			  //DOCUMENT TO BLOB($vt_filePath;<>VBLOBACT_EmisionInformeServer)
			DOCUMENT TO BLOB:C525($vt_filePath;x_Informe)
			DELETE DOCUMENT:C159($vt_filePath)
			
		Else 
			LOG_RegisterEvt ("Se produjo un error al intentar crear el archivo "+$fileName+", al generar el informe de morosidad detallado.")
			
		End if 
		USE CHARACTER SET:C205(*;0)
		
		
		
	End if 
	
End if 

CLEAR SEMAPHORE:C144("InformeServer")

  // Modificado por: Saúl Ponce (26-09-2016) Ticket N° 167055, para validar en 'ACTcc_InformeDeudores' si terminó este proceso
While (Not:C34(b_terminar))
	IDLE:C311
	DELAY PROCESS:C323(Current process:C322;60)
End while 
