//%attributes = {}
  //STRdbu_AsignaNoMatricula

C_LONGINT:C283($proximoNumero)
If (USR_GetMethodAcces (Current method name:C684))
	C_DATE:C307(vd_fecha_matricula)  //mono
	C_LONGINT:C283($l_ProgressProcID)
	
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_AsignadorNoMatricula";-1;5)
	DIALOG:C40([xxSTR_Constants:1];"STR_AsignadorNoMatricula")
	CLOSE WINDOW:C154
	If (OK=1)
		
		  // Modificado por: Alexis Bustamante (27-07-2017)
		  //TICKET186124 
		  //Agrego Filtros para que solo se utilicen alumnos  Activos ya que flataba filtros para alumnos RETIRADOS y EGRESADOS.
		
		  //Para resetear los egresados y retirado.
		  //ASM 20160311 Se consideran solo los alumnos activos. ticket 157211 
		$pID:=IT_UThermometer (1;0;__ ("Procesando..."))
		READ WRITE:C146([Alumnos:2])
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=Nivel_Retirados;*)
		QUERY:C277([Alumnos:2]; | ;[Alumnos:2]nivel_numero:29=Nivel_Egresados;*)
		QUERY:C277([Alumnos:2]; | ;[Alumnos:2]Status:50#"Activo";*)
		QUERY:C277([Alumnos:2]; | ;[Alumnos:2]curso:20="@ADT")
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]numero_de_matricula:51#"")
		APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]numero_de_matricula:51:="")
		IT_UThermometer (-2;$pID)
		
		$desdeNivel:=aNivelNo{aPopNivel1}
		$hastaNivel:=aNivelNo{aPopNivel2}
		$pID:=IT_UThermometer (1;0;__ ("Inicializando Números de matrícula..."))
		Case of 
			: (i1InitNumMatricula=1)
				$numMatricula:=0
				READ WRITE:C146([Alumnos:2])
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=$desdeNivel;*)
				QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<=$hastaNivel;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50="Activo";*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@ADT";*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@RET";*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@EGR")
				
				If (bc_ReasignarTodo=1)
					$proximoNumero:=1
				Else 
					SCAN INDEX:C350([Alumnos:2]numero_de_matricula:51;1;<)
					$proximoNumero:=Num:C11([Alumnos:2]numero_de_matricula:51)+1
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=$desdeNivel;*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=$hastaNivel;*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50="Activo";*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@ADT";*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@RET";*)
					QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@EGR")
					
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]numero_de_matricula:51="")
				End if 
				
				Case of 
					: (aOrdenMatricula=1)
						ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]apellidos_y_nombres:40;>)
					: (aOrdenMatricula=2)
						ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
					: (aOrdenMatricula=3)
						ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]apellidos_y_nombres:40;>)
					: (aOrdenMatricula=4)
						ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]curso:20;<;[Alumnos:2]apellidos_y_nombres:40;>)
				End case 
				
				  //ORDER BY([Alumnos];[Alumnos]Apellidos_y_Nombres;>)
				SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
				For ($i;1;Size of array:C274($aRecNums))
					GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
					[Alumnos:2]numero_de_matricula:51:=String:C10($proximoNumero;"00000")
					If (bc_fecha_matricula=1)
						If (bc_ReasignarFechaTodos=1)
							[Alumnos:2]Fecha_Matricula:108:=vd_fecha_matricula
						Else 
							If ([Alumnos:2]Fecha_Matricula:108=!00-00-00!)
								[Alumnos:2]Fecha_Matricula:108:=vd_fecha_matricula
							End if 
						End if 
					End if 
					SAVE RECORD:C53([Alumnos:2])
					$proximoNumero:=$proximoNumero+1
				End for 
				
				
			: (i2InitNumMatricula=1)
				READ WRITE:C146([Alumnos:2])
				Case of 
					: (aOrdenMatricula<=2)
						For ($j;$desdeNivel;$hastaNivel)
							QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$j)
							QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$j;*)
							QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50="Activo";*)
							QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@ADT")
							If (bc_ReasignarTodo=1)
								$proximoNumero:=1
							Else 
								SCAN INDEX:C350([Alumnos:2]numero_de_matricula:51;1;<)
								$proximoNumero:=Num:C11([Alumnos:2]numero_de_matricula:51)+1
								QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$j;*)
								QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50="Activo";*)
								QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@ADT")
								QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]numero_de_matricula:51="")
							End if 
							
							Case of 
								: (aOrdenMatricula=1)
									ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
								: (aOrdenMatricula=2)
									ORDER BY:C49([Alumnos:2];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
							End case 
							SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
							For ($i;1;Size of array:C274($aRecNums))
								GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
								[Alumnos:2]numero_de_matricula:51:=[xxSTR_Niveles:6]Abreviatura:19+"-"+String:C10($proximoNumero;"0000")
								If (bc_fecha_matricula=1)
									If (bc_ReasignarFechaTodos=1)
										[Alumnos:2]Fecha_Matricula:108:=vd_fecha_matricula
									Else 
										If ([Alumnos:2]Fecha_Matricula:108=!00-00-00!)
											[Alumnos:2]Fecha_Matricula:108:=vd_fecha_matricula
										End if 
									End if 
								End if 
								SAVE RECORD:C53([Alumnos:2])
								$proximoNumero:=$proximoNumero+1
							End for 
						End for 
					: (aOrdenMatricula>2)
						For ($j;$hastaNivel;$desdeNivel;-1)
							QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$j)
							QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$j;*)
							QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50="Activo";*)
							QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@ADT";*)
							QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@RET";*)
							QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@EGR")
							
							If (bc_ReasignarTodo=1)
								$proximoNumero:=1
							Else 
								SCAN INDEX:C350([Alumnos:2]numero_de_matricula:51;1;<)
								$proximoNumero:=Num:C11([Alumnos:2]numero_de_matricula:51)+1
								QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$j;*)
								QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50="Activo";*)
								QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@ADT";*)
								QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@RET";*)
								QUERY:C277([Alumnos:2]; & ;[Alumnos:2]curso:20#"@EGR")
								
								QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]numero_de_matricula:51="")
							End if 
							
							Case of 
								: (aOrdenMatricula=3)
									ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
								: (aOrdenMatricula=4)
									ORDER BY:C49([Alumnos:2];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
							End case 
							SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
							For ($i;1;Size of array:C274($aRecNums))
								GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
								[Alumnos:2]numero_de_matricula:51:=[xxSTR_Niveles:6]Abreviatura:19+"-"+String:C10($proximoNumero;"0000")
								If (bc_fecha_matricula=1)
									If (bc_ReasignarFechaTodos=1)
										[Alumnos:2]Fecha_Matricula:108:=vd_fecha_matricula
									Else 
										If ([Alumnos:2]Fecha_Matricula:108=!00-00-00!)
											[Alumnos:2]Fecha_Matricula:108:=vd_fecha_matricula
										End if 
									End if 
								End if 
								SAVE RECORD:C53([Alumnos:2])
								$proximoNumero:=$proximoNumero+1
							End for 
						End for 
				End case 
			: (i3InitNumMatricula=1)
				
				ARRAY LONGINT:C221($al_recnumalu;0)
				ARRAY LONGINT:C221($al_TipoEnseñanza;0)
				READ WRITE:C146([Alumnos:2])
				READ ONLY:C145([Cursos:3])
				QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>=0;*)
				QUERY:C277([Cursos:3]; & ;[Cursos:3]Curso:1#"@ADT")
				
				
				  //20140310 ASM ticket 130084
				Case of 
					: (aOrdenMatricula=1)
						ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>)
					: (aOrdenMatricula=2)
						ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
					: (aOrdenMatricula=3)
						ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;<)
					: (aOrdenMatricula=4)
						ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;<;[Cursos:3]Curso:1;<)
				End case 
				
				SELECTION TO ARRAY:C260([Cursos:3]cl_CodigoTipoEnseñanza:21;$al_TipoEnseñanza)
				
				$l_ProgressProcID:=IT_Progress (1;0;0;"Asignando números de matricula...")
				
				For ($l_tipo;1;Size of array:C274($al_TipoEnseñanza))
					QUERY:C277([Cursos:3];[Cursos:3]cl_CodigoTipoEnseñanza:21=$al_TipoEnseñanza{$l_tipo})
					KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@";*)
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]curso:20#"@ADT";*)
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]curso:20#"@RET";*)
					QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]curso:20#"@EGR")
					
					$proximoNumero:=1
					
					If (bc_ReasignarTodo=0)
						CREATE SET:C116([Alumnos:2];"$Alumnos")
						SCAN INDEX:C350([Alumnos:2]numero_de_matricula:51;1;<)
						$proximoNumero:=Num:C11([Alumnos:2]numero_de_matricula:51)+1
						USE SET:C118("$Alumnos")
						QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]numero_de_matricula:51="")
						CLEAR SET:C117("$Alumnos")
					End if 
					  //ORDER BY([Alumnos];[Alumnos]Número;>)
					
					  //20140310 ASM ticket 130084
					Case of 
						: (aOrdenMatricula=1)
							ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]apellidos_y_nombres:40;>)
						: (aOrdenMatricula=2)
							ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
						: (aOrdenMatricula=3)
							ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]apellidos_y_nombres:40;>)
						: (aOrdenMatricula=4)
							ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]curso:20;<;[Alumnos:2]apellidos_y_nombres:40;>)
					End case 
					
					LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$al_recnumalu;"")
					
					For ($i_alu;1;Size of array:C274($al_recnumalu))
						GOTO RECORD:C242([Alumnos:2];$al_recnumalu{$i_alu})
						[Alumnos:2]numero_de_matricula:51:=String:C10($al_TipoEnseñanza{$l_tipo})+"-"+String:C10($proximoNumero;"0000")
						If (bc_fecha_matricula=1)
							If (bc_ReasignarFechaTodos=1)
								[Alumnos:2]Fecha_Matricula:108:=vd_fecha_matricula
							Else 
								If ([Alumnos:2]Fecha_Matricula:108=!00-00-00!)
									[Alumnos:2]Fecha_Matricula:108:=vd_fecha_matricula
								End if 
							End if 
						End if 
						SAVE RECORD:C53([Alumnos:2])
						$proximoNumero:=$proximoNumero+1
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_tipo/Size of array:C274($al_TipoEnseñanza);"Asignando números de matricula";$i_alu/Size of array:C274($al_recnumalu);[Alumnos:2]curso:20+" "+[Alumnos:2]apellidos_y_nombres:40)
					End for 
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_tipo/Size of array:C274($al_TipoEnseñanza);"Asignando números de matricula")
				End for 
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				
		End case 
		
		IT_UThermometer (-2;$pID)
		UNLOAD RECORD:C212([Alumnos:2])
		READ ONLY:C145([Alumnos:2])
	End if 
End if 