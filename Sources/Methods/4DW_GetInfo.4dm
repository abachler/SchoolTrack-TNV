//%attributes = {}
  //4DW_GetInfo

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Documentos_de_Pago:176])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([xxACT_ItemsCategorias:98])
C_LONGINT:C283($año;$accion;$detalle;$accion)
C_DATE:C307($fecha1;$fecha2)
C_TEXT:C284($vt_datosAlumnos;$vt_detalle)
C_TEXT:C284($0)

ARRAY LONGINT:C221($al_rnCargos;0)
ARRAY LONGINT:C221($al_rnAlu;0)
ARRAY LONGINT:C221($al_nosDeNivelAlu;0)
ARRAY TEXT:C222($at_cursosAlu;0)
ARRAY TEXT:C222($at_rutAlu;0)
ARRAY TEXT:C222($at_apeYNombres;0)
ARRAY TEXT:C222($at_cursoPostula;0)
Case of 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		Case of 
			: (Count parameters:C259=3)
				$año:=$1
				$accion:=Num:C11($2)
				$detalle:=$3
			: (Count parameters:C259=2)
				$año:=$1
				$accion:=Num:C11($2)
			: (Count parameters:C259=1)
				$año:=$1
			Else 
		End case 
		If ($año<2007)
			Case of 
				: ($año=1)
					$año:=Year of:C25(Current date:C33(*))+1
				Else 
					$año:=Year of:C25(Current date:C33(*))
			End case 
		End if 
		$fecha1:=DT_GetDateFromDayMonthYear (1;1;$año)
		$fecha2:=DT_GetDateFromDayMonthYear (31;12;$año)
		
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4>=$fecha1;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4<=$fecha2)
		Case of 
			: ($accion=1)  //monto cargos año seleccionado
				$0:=String:C10(Sum:C1([ACT_Cargos:173]Monto_Neto:5);"|Despliegue_ACT")
				
			: ($accion=2)  //en moneda nacional
				ARRAY LONGINT:C221($alACT_recNumCargos;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumCargos;"")
				$0:=String:C10(ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$alACT_recNumCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*));"|Despliegue_ACT")
			: ($accion=3)  //en moneda emisión
				$0:=String:C10(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*));"|Despliegue_ACT")
				
		End case 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
		Case of 
			: (Count parameters:C259=3)
				$año:=$1
				$accion:=Num:C11($2)
				$detalle:=$3
			: (Count parameters:C259=2)
				$año:=$1
				$accion:=Num:C11($2)
			: (Count parameters:C259=1)
				$año:=$1
			Else 
		End case 
		If ($año<2007)
			Case of 
				: ($año=1)
					$año:=Year of:C25(Current date:C33(*))+1
				Else 
					$año:=Year of:C25(Current date:C33(*))
			End case 
		End if 
		$fecha1:=DT_GetDateFromDayMonthYear (1;1;$año)
		$fecha2:=DT_GetDateFromDayMonthYear (31;12;$año)
		
		If ($accion>0)
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>=$fecha1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$fecha2)
			SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_rnCargos)
			
			SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnos;[Alumnos:2]nivel_numero:29;$al_nosDeNivel;[Alumnos:2]curso:20;$at_cursosAlu)
			SELECTION TO ARRAY:C260([Alumnos:2]RUT:5;$at_rutAlu;[Alumnos:2]apellidos_y_nombres:40;$at_apeYNombres;[Alumnos:2]Nivel_al_que_ingreso:35;$at_cursoPostula)
			SORT ARRAY:C229($al_nosDeNivel;$at_cursosAlu;$at_apeYNombres;$at_rutAlu;$at_cursoPostula;$al_rnAlumnos;>)
			
			Case of 
				: ($accion=50)  //montos anuales
					Case of 
						: ($detalle=0)
							$0:=String:C10(Sum:C1([ACT_Cargos:173]Monto_Neto:5);"|Despliegue_ACT")
						: ($detalle=1)
							$0:=String:C10(ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_rnCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*));"|Despliegue_ACT")
						: ($detalle=2)
							$0:=String:C10(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*));"|Despliegue_ACT")
					End case 
					
				: ($accion=51)  //` datos de alumnos
					Case of 
						: ($detalle=1)  //apellidos y nombres y rut
							$vt_datosAlumnos:=""
							For ($i;1;Size of array:C274($al_rnAlumnos))
								$vt_datosAlumnos:=$vt_datosAlumnos+$at_apeYNombres{$i}+"\t"+SR_FormatoRUT2 ($at_rutAlu{$i})+"\r"
							End for 
							$0:=Substring:C12($vt_datosAlumnos;1;Length:C16($vt_datosAlumnos)-1)
						: ($detalle=2)  //apellidos y nombres y próximo curso
							$vt_datosAlumnos:=""
							For ($i;1;Size of array:C274($al_rnAlumnos))
								Case of 
									: (($al_nosDeNivel{$i}<-3) | ($al_nosDeNivel{$i}=Nivel_AdmissionTrack))
										$vt_datosAlumnos:=$vt_datosAlumnos+$at_apeYNombres{$i}+"\t"+"ADM-"+String:C10($año)+"\r"
									: ($al_nosDeNivel{$i}<=11)
										$numeroNivel:=$al_nosDeNivel{$i}+1
										If ($numeroNivel=0)
											$numeroNivel:=$numeroNivel+1
										End if 
										$vt_datosAlumnos:=$vt_datosAlumnos+$at_apeYNombres{$i}+"\t"+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$numeroNivel;->[xxSTR_Niveles:6]Abreviatura:19)+Substring:C12($at_cursosAlu{$i};Position:C15("-";$at_cursosAlu{$i})+1)+"\r"
									: ($al_nosDeNivel{$i}>=12)
										
									Else 
										$vt_datosAlumnos:=$vt_datosAlumnos+$at_apeYNombres{$i}+"\t"+""+"\r"
								End case 
							End for 
							$0:=Substring:C12($vt_datosAlumnos;1;Length:C16($vt_datosAlumnos)-1)
						Else 
							For ($i;1;Size of array:C274($al_rnAlumnos))
								$vt_datosAlumnos:=$vt_datosAlumnos+$at_apeYNombres{$i}+"\r"
							End for 
							$0:=Substring:C12($vt_datosAlumnos;1;Length:C16($vt_datosAlumnos)-1)
					End case 
				: ($accion=52)  //datos de cargos
					CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_rnCargos)
					ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22;>)
					Case of 
						: ($detalle=1)  //día de vencimiento primer aviso
							FIRST RECORD:C50([ACT_Cargos:173])
							$0:=String:C10(Day of:C23([ACT_Cargos:173]Fecha_de_Vencimiento:7))
							
						: ($detalle=2)  //mes de vencimiento primer aviso
							FIRST RECORD:C50([ACT_Cargos:173])
							$0:=String:C10(Month of:C24([ACT_Cargos:173]Fecha_de_Vencimiento:7))
							
						: ($detalle=3)  //año de vencimiento primer aviso
							FIRST RECORD:C50([ACT_Cargos:173])
							$0:=String:C10(Year of:C25([ACT_Cargos:173]Fecha_de_Vencimiento:7))
						Else 
							$0:=String:C10([ACT_Cargos:173]Fecha_de_Vencimiento:7;7)
					End case 
					
				: ($accion=53)  //montos netos dividido por no de cuotas
					C_REAL:C285($vr_monto)
					If ([Personas:7]ACT_NoCuotasCup:80>0)
						Case of 
							: ($detalle=0)
								$vr_monto:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
							: ($detalle=1)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_rnCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							: ($detalle=2)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						End case 
						$0:=String:C10(Round:C94($vr_monto/[Personas:7]ACT_NoCuotasCup:80;<>vlACT_Decimales);"|Despliegue_ACT")
					Else 
						Case of 
							: ($detalle=0)
								$vr_monto:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
							: ($detalle=1)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_rnCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							: ($detalle=2)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						End case 
						$0:=String:C10(Round:C94($vr_monto/10;<>vlACT_Decimales);"|Despliegue_ACT")
					End if 
					
				: ($accion=54)  //montos a pagar anuales
					Case of 
						: ($detalle=0)
							$0:=String:C10(Sum:C1([ACT_Cargos:173]Saldo:23);"|Despliegue_ACT")
						: ($detalle=1)
							$0:=String:C10(ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_rnCargos;->[ACT_Cargos:173]Saldo:23;Current date:C33(*));"|Despliegue_ACT")
						: ($detalle=2)
							$0:=String:C10(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*));"|Despliegue_ACT")
					End case 
					
				: ($accion=55)  //montos a pagar dividido por no de cuotas
					C_REAL:C285($vr_monto)
					If ([Personas:7]ACT_NoCuotasCup:80>0)
						Case of 
							: ($detalle=0)
								$vr_monto:=Sum:C1([ACT_Cargos:173]Saldo:23)
							: ($detalle=1)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_rnCargos;->[ACT_Cargos:173]Saldo:23;Current date:C33(*))
							: ($detalle=2)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*))
						End case 
						$0:=String:C10(Round:C94($vr_monto/[Personas:7]ACT_NoCuotasCup:80;<>vlACT_Decimales);"|Despliegue_ACT")
					Else 
						Case of 
							: ($detalle=0)
								$vr_monto:=Sum:C1([ACT_Cargos:173]Saldo:23)
							: ($detalle=1)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_rnCargos;->[ACT_Cargos:173]Saldo:23;Current date:C33(*))
							: ($detalle=2)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*))
						End case 
						$0:=String:C10(Round:C94($vr_monto/10;<>vlACT_Decimales);"|Despliegue_ACT")
					End if 
				: ($accion=56)  //datos de cargos con saldo
					CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_rnCargos)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
					ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22;>)
					Case of 
						: ($detalle=1)  //día de vencimiento primer aviso
							FIRST RECORD:C50([ACT_Cargos:173])
							$0:=String:C10(Day of:C23([ACT_Cargos:173]Fecha_de_Vencimiento:7))
							
						: ($detalle=2)  //mes de vencimiento primer aviso
							FIRST RECORD:C50([ACT_Cargos:173])
							$0:=String:C10(Month of:C24([ACT_Cargos:173]Fecha_de_Vencimiento:7))
							
						: ($detalle=3)  //año de vencimiento primer aviso
							FIRST RECORD:C50([ACT_Cargos:173])
							$0:=String:C10(Year of:C25([ACT_Cargos:173]Fecha_de_Vencimiento:7))
						Else 
							$0:=String:C10([ACT_Cargos:173]Fecha_de_Vencimiento:7;7)
					End case 
			End case 
			
		Else 
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>=$fecha1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$fecha2)
			SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_rnCargos)
			
			SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnos;[Alumnos:2]nivel_numero:29;$al_nosDeNivel;[Alumnos:2]curso:20;$at_cursosAlu)
			SELECTION TO ARRAY:C260([Alumnos:2]RUT:5;$at_rutAlu;[Alumnos:2]apellidos_y_nombres:40;$at_apeYNombres;[Alumnos:2]Nivel_al_que_ingreso:35;$at_cursoPostula)
			SORT ARRAY:C229($al_nosDeNivel;$at_cursosAlu;$at_apeYNombres;$at_rutAlu;$at_cursoPostula;$al_rnAlumnos;>)
			
			Case of 
				: ($accion=-50)  //montos anuales
					Case of 
						: ($detalle=0)
							$0:=String:C10(Sum:C1([ACT_Cargos:173]Monto_Neto:5);"|Despliegue_ACT")
						: ($detalle=1)
							$0:=String:C10(ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_rnCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*));"|Despliegue_ACT")
						: ($detalle=2)
							$0:=String:C10(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*));"|Despliegue_ACT")
					End case 
					
				: ($accion=-51)  //` datos de alumnos
					Case of 
						: ($detalle=1)  //apellidos y nombres y rut
							$vt_datosAlumnos:=""
							For ($i;1;Size of array:C274($al_rnAlumnos))
								$vt_datosAlumnos:=$vt_datosAlumnos+$at_apeYNombres{$i}+"\t"+SR_FormatoRUT2 ($at_rutAlu{$i})+"\r"
							End for 
							$0:=Substring:C12($vt_datosAlumnos;1;Length:C16($vt_datosAlumnos)-1)
						: ($detalle=2)  //apellidos y nombres y próximo curso
							$vt_datosAlumnos:=""
							For ($i;1;Size of array:C274($al_rnAlumnos))
								Case of 
									: (($al_nosDeNivel{$i}<-3) | ($al_nosDeNivel{$i}=Nivel_AdmissionTrack))
										$vt_datosAlumnos:=$vt_datosAlumnos+$at_apeYNombres{$i}+"\t"+"ADM-"+String:C10($año)+"\r"
									: ($al_nosDeNivel{$i}<=11)
										$numeroNivel:=$al_nosDeNivel{$i}+1
										If ($numeroNivel=0)
											$numeroNivel:=$numeroNivel+1
										End if 
										$vt_datosAlumnos:=$vt_datosAlumnos+$at_apeYNombres{$i}+"\t"+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$numeroNivel;->[xxSTR_Niveles:6]Abreviatura:19)+Substring:C12($at_cursosAlu{$i};Position:C15("-";$at_cursosAlu{$i})+1)+"\r"
									: ($al_nosDeNivel{$i}>=12)
									Else 
										$vt_datosAlumnos:=$vt_datosAlumnos+$at_apeYNombres{$i}+"\t"+""+"\r"
								End case 
							End for 
							$0:=Substring:C12($vt_datosAlumnos;1;Length:C16($vt_datosAlumnos)-1)
						Else 
							For ($i;1;Size of array:C274($al_rnAlumnos))
								$vt_datosAlumnos:=$vt_datosAlumnos+$at_apeYNombres{$i}+"\r"
							End for 
							$0:=Substring:C12($vt_datosAlumnos;1;Length:C16($vt_datosAlumnos)-1)
					End case 
				: ($accion=-52)  //datos de cargos
					CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_rnCargos)
					ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22;>)
					Case of 
						: ($detalle=1)  //día de vencimiento primer aviso
							FIRST RECORD:C50([ACT_Cargos:173])
							$0:=String:C10(Day of:C23([ACT_Cargos:173]Fecha_de_Vencimiento:7))
							
						: ($detalle=2)  //mes de vencimiento primer aviso
							FIRST RECORD:C50([ACT_Cargos:173])
							$0:=String:C10(Month of:C24([ACT_Cargos:173]Fecha_de_Vencimiento:7))
							
						: ($detalle=3)  //año de vencimiento primer aviso
							FIRST RECORD:C50([ACT_Cargos:173])
							$0:=String:C10(Year of:C25([ACT_Cargos:173]Fecha_de_Vencimiento:7))
						Else 
							$0:=String:C10([ACT_Cargos:173]Fecha_de_Vencimiento:7;7)
					End case 
					
				: ($accion=-53)  //montosdividido por no de cuotas
					C_REAL:C285($vr_monto)
					If ([Personas:7]ACT_NoCuotasCup:80>0)
						Case of 
							: ($detalle=0)
								$vr_monto:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
							: ($detalle=1)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_rnCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							: ($detalle=2)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						End case 
						$0:=String:C10(Round:C94($vr_monto/[Personas:7]ACT_NoCuotasCup:80;<>vlACT_Decimales);"|Despliegue_ACT")
					Else 
						Case of 
							: ($detalle=0)
								$vr_monto:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
							: ($detalle=1)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->$al_rnCargos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							: ($detalle=2)
								$vr_monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
						End case 
						$0:=String:C10(Round:C94($vr_monto/10;<>vlACT_Decimales);"|Despliegue_ACT")
					End if 
			End case 
		End if 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
		Case of 
			: (Count parameters:C259=2)
				$accion:=$1
				$vt_detalle:=$2
			: (Count parameters:C259=1)
				$accion:=$1
		End case 
		ARRAY TEXT:C222($at_glosasItems;0)
		ARRAY REAL:C219($ar_montosItems;0)
		ARRAY LONGINT:C221($al_refItemDeCargo;0)
		ARRAY TEXT:C222($at_categorias;0)
		QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Pagos:172]ID_Apoderado:3)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
		SELECTION TO ARRAY:C260([Alumnos:2];$al_rnAlumnos;[Alumnos:2]nivel_numero:29;$al_nosDeNivel;[Alumnos:2]curso:20;$at_cursosAlu)
		SELECTION TO ARRAY:C260([Alumnos:2]RUT:5;$at_rutAlu;[Alumnos:2]apellidos_y_nombres:40;$at_apeYNombres;[Alumnos:2]Nivel_al_que_ingreso:35;$at_cursoPostula)
		SORT ARRAY:C229($al_nosDeNivel;$at_cursosAlu;$at_apeYNombres;$at_rutAlu;$at_cursoPostula;$al_rnAlumnos;>)
		ACTpgs_LoadDesgloseArrays 
		Case of 
			: ($accion=100)  //montos pagados agrupados por ítem
				C_TEXT:C284($vt_categorias)
				$vt_datosAlumnos:=""
				$vt_categorias:=""
				COPY ARRAY:C226(aACT_ApdosDPRefItem;$al_refItemDeCargo)
				AT_DistinctsArrayValues (->$al_refItemDeCargo)
				For ($i;1;Size of array:C274($al_refItemDeCargo))
					$monto:=0
					aACT_ApdosDPRefItem{0}:=$al_refItemDeCargo{$i}
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->aACT_ApdosDPRefItem;"=";->$DA_Return)
					For ($j;1;Size of array:C274($DA_Return))
						$monto:=$monto+aACT_ApdosDPMonto{$DA_Return{$j}}
					End for 
					QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$al_refItemDeCargo{$i})
					QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]ID:2=[xxACT_Items:179]ID_Categoria:8)
					AT_Insert (0;1;->$at_glosasItems;->$ar_montosItems;->$at_categorias)
					$at_glosasItems{Size of array:C274($at_glosasItems)}:=[xxACT_Items:179]Glosa_de_Impresión:20
					$ar_montosItems{Size of array:C274($ar_montosItems)}:=$monto
					$at_categorias{Size of array:C274($at_categorias)}:=[xxACT_ItemsCategorias:98]Nombre:1
				End for 
				For ($i;1;Size of array:C274($at_glosasItems))
					If ($ar_montosItems{$i}>0)
						$vt_datosAlumnos:=$vt_datosAlumnos+$at_glosasItems{$i}+"\t"+String:C10($ar_montosItems{$i};"|Despliegue_ACT")+"\r"
					End if 
				End for 
				$0:=Substring:C12($vt_datosAlumnos;1;Length:C16($vt_datosAlumnos)-1)
			: ($accion=101)  //montos pagados agrupados por categorías
				$vt_datosAlumnos:=""
				ARRAY TEXT:C222(atACT_NombreCategoria;0)
				ARRAY REAL:C219(arACT_MontoCategoria;0)
				ARRAY LONGINT:C221($aIDCategoria;0)
				ARRAY LONGINT:C221($aPosCategoria;0)
				ALL RECORDS:C47([xxACT_ItemsCategorias:98])
				SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]ID:2;$aIDCategoria;[xxACT_ItemsCategorias:98]Posicion:3;$aPosCategoria;[xxACT_ItemsCategorias:98]Nombre:1;atACT_NombreCategoria)
				SORT ARRAY:C229($aPosCategoria;atACT_NombreCategoria;$aIDCategoria;>)
				AT_RedimArrays (Size of array:C274($aIDCategoria);->arACT_MontoCategoria)
				For ($i;Size of array:C274(aACT_ApdosDPIDItem);1;-1)
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aACT_ApdosDPIDItem{$i})
					QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
					If ([xxACT_Items:179]ID_Categoria:8#0)
						$cat:=Find in array:C230($aIDCategoria;[xxACT_Items:179]ID_Categoria:8)
						arACT_MontoCategoria{$cat}:=arACT_MontoCategoria{$cat}+aACT_ApdosDPMonto{$i}
					End if 
				End for 
				If ($vt_detalle#"")
					$el:=Find in array:C230(atACT_NombreCategoria;$vt_detalle)
					If ($el>0)
						$0:=String:C10(arACT_MontoCategoria{$el};"|Despliegue_ACT")
					Else 
						For ($i;1;Size of array:C274(arACT_MontoCategoria))
							If (arACT_MontoCategoria{$i}>0)
								$vt_datosAlumnos:=$vt_datosAlumnos+atACT_NombreCategoria{$i}+"\t"+String:C10(arACT_MontoCategoria{$i};"|Despliegue_ACT")+"\r"
							End if 
						End for 
						$0:=Substring:C12($vt_datosAlumnos;1;Length:C16($vt_datosAlumnos)-1)
					End if 
				Else 
					For ($i;1;Size of array:C274(arACT_MontoCategoria))
						$vt_datosAlumnos:=$vt_datosAlumnos+String:C10(arACT_MontoCategoria{$i};"|Despliegue_ACT")+"\r"
					End for 
					$0:=Substring:C12($vt_datosAlumnos;1;Length:C16($vt_datosAlumnos)-1)
				End if 
			: ($accion=102)  //nombres alumnos
				$vt_datosAlumnos:=""
				For ($i;1;Size of array:C274($al_rnAlumnos))
					$vt_datosAlumnos:=$vt_datosAlumnos+$at_apeYNombres{$i}+"\r"
				End for 
				$0:=Substring:C12($vt_datosAlumnos;1;Length:C16($vt_datosAlumnos)-1)
		End case 
End case 
REDUCE SELECTION:C351([ACT_Cargos:173];0)