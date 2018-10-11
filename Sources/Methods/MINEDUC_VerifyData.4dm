//%attributes = {}
  //MINEDUC_VerifyData

C_BLOB:C604($blob)

READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])


$d1:=DT_GetDateFromDayMonthYear (30;4;<>gYear)
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Cursos:3])
ARRAY TEXT:C222($at_cursos;0)
QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesOficiales)
QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$at_cursos)
  //QUERY WITH ARRAY([Alumnos]Nivel_Número;<>al_NumeroNivelesOficiales)
QUERY WITH ARRAY:C644([Alumnos:2]curso:20;$at_cursos)
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="Retirado@";*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Status:50="Promovido anticipadamente@")
QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42=!00-00-00!;*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Fecha_de_retiro:42>$d1)

QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29>=1)  //CAMBIOS AQUI
CREATE SET:C116([Alumnos:2];"alumnos")


Case of 
	: (vl_VerifMineduc=1)
		$bad:=False:C215
		vt_Msg:="Verificando datos del colegio..."
		POST KEY:C465(Character code:C91("*");256)
		If (<>gRolBD="")
			vt_text1:=vt_text1+"EL ROL DE BASE DE DATOS DEL COLEGIO NO HA SIDO DEFINIDO"+"\r"
			$bad:=True:C214
		End if 
		If (([Colegio:31]Director_Nombres:20="") | ([Colegio:31]Director_ApellidoPaterno:18=""))
			vt_text1:=vt_text1+"EL NOMBRE DEL DIRECTOR(A) DEL COLEGIO NO HA SIDO DEFINIDO"+"\r"
			$bad:=True:C214
		End if 
		$run:=CTRY_CL_VerifRUT ([Colegio:31]Director_RUN:28;False:C215)
		If ($run="")
			vt_text1:=vt_text1+"EL RUN DEL DIRECTOR(A) DEL COLEGIO NO HA SIDO DEFINIDO O NO ES VALIDO"+"\r"
			$bad:=True:C214
		End if 
		If ($bad=False:C215)
			vt_msg:=Replace string:C233(vt_msg;"Verificando datos del colegio...";"OK - Verificación de datos del colegio completada exitosamente")
		Else 
			vt_msg:=Replace string:C233(vt_msg;"Verificando datos del colegio...";"ERROR - Nombre del rector o rol de base de datos incorrectos")
		End if 
		vl_VerifMineduc:=2
		POST KEY:C465(Character code:C91("+");256)
		
	: (vl_VerifMineduc=2)
		If (r1_Actas=1)
			vt_Msg:=vt_Msg+"\r"+"Verificando códigos de evaluación y plan de estudios…"
			POST KEY:C465(Character code:C91("*");256)
			READ WRITE:C146([xxSTR_Niveles:6])
			QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesOficiales)
			QUERY SELECTION:C341([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5>=1)  //CAMBIOS AQUI
			QUERY SELECTION:C341([xxSTR_Niveles:6];[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41="";*)
			QUERY SELECTION:C341([xxSTR_Niveles:6]; & [xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38="";*)
			QUERY SELECTION:C341([xxSTR_Niveles:6]; & [xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39="";*)
			QUERY SELECTION:C341([xxSTR_Niveles:6]; & [xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40="")
			If (Records in selection:C76([xxSTR_Niveles:6])#0)
				vt_text1:=vt_text1+"\r"+"UNO O MAS CODIGOS NO HAN SIDO DEFINIDOS EN LOS SIGUIENTES NIVELES:"+"\r"
				SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;aText1)
				vt_text1:=vt_text1+AT_array2text (->aText1;"\r")+"\r"
				vt_msg:=Replace string:C233(vt_msg;"Verificando códigos de evaluación y plan de estudios…";"ERROR - Códigos de evaluación y plan de estudios inexistentes")
			Else 
				vt_msg:=Replace string:C233(vt_msg;"Verificando códigos de evaluación y plan de estudios…";"OK - Verificación de Códigos de evaluación y plan de estudios completada "+"exitosamente")
			End if 
		End if 
		vl_VerifMineduc:=3
		POST KEY:C465(Character code:C91("+");256)
		
	: (vl_VerifMineduc=3)
		  //vt_Msg:=vt_Msg+<>cr+"Verificando fechas de nacimiento de alumnos…"
		  //POST KEY(Character code("*");256)
		  //USE SET("alumnos")
		  //QUERY SELECTION([Alumnos];[Alumnos]Fecha_de_nacimiento=!00-00-0000!)
		  //If (Records in selection([Alumnos])#0)
		  //SELECTION TO ARRAY([Alumnos]Apellidos_y_Nombres;aText1;[Alumnos]Curso;aText2)
		  //vt_text1:=vt_text1+<>CR+"LA FECHA DE NACIMIENTO DE LOS SIGUIENTES ALUMNOS NO HA SIDO DEFINIDA:"+<>CR
		  //vt_text1:=vt_text1+AT_Arrays2Text (<>cr;", ";->aText1;->ATEXT2)+<>cr
		  //vt_msg:=Replace string(vt_msg;"Verificando fechas de nacimiento de alumnos…";"ERROR -  Alumnos con fecha de nacimiento inexistente")
		  //Else 
		  //vt_msg:=Replace string(vt_msg;"Verificando fechas de nacimiento de alumnos…";"OK - Verificación de fechas de nacimiento completada exitosamente")
		  //End if 
		vl_VerifMineduc:=4
		POST KEY:C465(Character code:C91("+");256)
		
	: (vl_VerifMineduc=4)
		  //vt_Msg:=vt_Msg+<>cr+"Verificando campo sexo de alumnos…"
		  //POST KEY(Character code("*");256)
		  //USE SET("alumnos")
		  //QUERY SELECTION([Alumnos];[Alumnos]Sexo#"F";*)
		  //QUERY SELECTION([Alumnos]; & [Alumnos]Sexo#"M")
		  //If (Records in selection([Alumnos])#0)
		  //SELECTION TO ARRAY([Alumnos]Apellidos_y_Nombres;aText1;[Alumnos]Curso;aText2)
		  //vt_text1:=vt_text1+<>CR+"EL SEXO DE LOS SIGUIENTES ALUMNOS NO HA SIDO DEFINIDO CORRECTAMENTE:"+<>CR
		  //vt_text1:=vt_text1+AT_Arrays2Text (<>cr;", ";->aText1;->ATEXT2)+<>cr
		  //vt_msg:=Replace string(vt_msg;"Verificando campo sexo de alumnos…";"ERROR - Alumnos sin información (o con información incorrecta) en campo sexo")
		  //Else 
		  //vt_msg:=Replace string(vt_msg;"Verificando campo sexo de alumnos…";"OK - Verificación de campo sexo completada exitosamente")
		  //End if 
		vl_VerifMineduc:=5
		POST KEY:C465(Character code:C91("+");256)
		
	: (vl_VerifMineduc=5)
		  //vt_Msg:=vt_Msg+<>cr+"Verificando comuna de residencia de alumnos…"
		  //POST KEY(Character code("*");256)
		  //USE SET("alumnos")
		  //QUERY SELECTION([Alumnos];[Alumnos]Codigo_Comuna="")
		  //If (Records in selection([Alumnos])#0)
		  //AL_AsignaCodigoComuna 
		  //USE SET("alumnos")
		  //QUERY SELECTION([Alumnos];[Alumnos]Codigo_Comuna="")
		  //If (Records in selection([Alumnos])#0)
		  //SELECTION TO ARRAY([Alumnos]Apellidos_y_Nombres;aText1;[Alumnos]Curso;aText2;[Alumnos]Comuna;aText3)
		  //vt_text1:=vt_text1+<>cr+"LA COMUNA DE RESIDENCIA DE LOS SIGUIENTES ALUMNOS ES INCORRECTA:"+<>CR
		  //vt_text1:=vt_text1+AT_Arrays2Text (<>cr;", ";->aText1;->ATEXT2;->ATEXT3)+<>cr
		  //vt_msg:=Replace string(vt_msg;"Verificando comuna de residencia de alumnos…";"ERROR - Alumnos sin información (o con información incorrecta) en campo comuna")
		  //Else 
		  //vt_msg:=Replace string(vt_msg;"Verificando comuna de residencia de alumnos…";"OK - Verificación de comuna de residencia completada exitosamente")
		  //End if 
		  //Else 
		  //vt_msg:=Replace string(vt_msg;"Verificando comuna de residencia de alumnos…";"OK - Verificación de comuna de residencia completada exitosamente")
		  //End if 
		vl_VerifMineduc:=6
		POST KEY:C465(Character code:C91("+");256)
		
	: (vl_VerifMineduc=6)
		vt_Msg:=vt_Msg+"\r"+"Verificando Rol Unico Nacional de alumnos…"
		POST KEY:C465(Character code:C91("*");256)
		USE SET:C118("alumnos")
		SELECTION TO ARRAY:C260([Alumnos:2];$aRecNums)
		$text:=""
		For ($i;1;Size of array:C274($aRecNums))
			GOTO RECORD:C242([Alumnos:2];$aRecNums{$i})
			$rut:=CTRY_CL_VerifRUT ([Alumnos:2]RUT:5;False:C215)
			If (($rut="") & ([Alumnos:2]Nacionalidad:8="Chilen@") & ([Alumnos:2]NoPasaporte:87=""))
				$text:=$text+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20+"\r"
			End if 
		End for 
		If ($text#"")
			vt_text1:=vt_text1+"\r"+"EL RUN DE LOS SIGUIENTES ALUMNOS NO HA SIDO DEFINIDO:"+"\r"
			vt_text1:=vt_text1+$text
			vt_msg:=Replace string:C233(vt_msg;"Verificando Rol Unico Nacional de alumnos…";"ERROR - Alumnos sin información (o con información incorrecta) en campo RUN "+"o Nº de pasaporte para alumnos extranjeros sin RUN")
		Else 
			vt_msg:=Replace string:C233(vt_msg;"Verificando Rol Unico Nacional de alumnos…";"OK - Verificación de Rol Unico Nacional de alumnos completada exitosamente")
		End if 
		vl_VerifMineduc:=7
		POST KEY:C465(Character code:C91("+");256)
		
	: (vl_VerifMineduc=7)
		If (r1_Actas=1)
			vt_Msg:=vt_Msg+"\r"+"Verificando Situación Final de Alumnos…"
			POST KEY:C465(Character code:C91("*");256)
			USE SET:C118("alumnos")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33#"P";*)
			QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]Situacion_final:33#"R";*)
			QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]Situacion_final:33#"X";*)
			QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]Situacion_final:33#"Y")
			If (Records in selection:C76([Alumnos:2])#0)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]curso:20;aText2;[Alumnos:2]Situacion_final:33;aText3)
				vt_text1:=vt_text1+"\r"+"LA SITUACION FINAL DE LOS SIGUIENTES ALUMNOS ES INCORRECTA:"+"\r"
				vt_text1:=vt_text1+AT_Arrays2Text ("\r";", ";->aText1;->ATEXT2;->ATEXT3)+"\r"
				vt_msg:=Replace string:C233(vt_msg;"Verificando Situación Final de Alumnos…";"ERROR - Alumnos con situación final indefinida o incorrecta")
			Else 
				vt_msg:=Replace string:C233(vt_msg;"Verificando Situación Final de Alumnos…";"OK - Verificación de Situación final de alumnos completada exitosamente")
			End if 
		End if 
		vl_VerifMineduc:=8
		POST KEY:C465(Character code:C91("+");256)
		
		
	: (vl_VerifMineduc=8)
		If (r1_Actas=1)
			vt_Msg:=vt_Msg+"\r"+"Verificando Porcentaje de asistencia de Alumnos…"
			POST KEY:C465(Character code:C91("*");256)
			USE SET:C118("alumnos")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Porcentaje_asistencia:56=0;*)
			QUERY SELECTION:C341([Alumnos:2]; & [Alumnos:2]Situacion_final:33#"Y")
			If (Records in selection:C76([Alumnos:2])#0)
				SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]curso:20;aText2)
				vt_text1:=vt_text1+"\r"+"EL PORCENTAJE DE ASISTENCIA DE LOS SIGUIENTES ALUMNOS ES 0:"+"\r"
				vt_text1:=vt_text1+AT_Arrays2Text ("\r";", ";->aText1;->ATEXT2)+"\r"
				vt_msg:=Replace string:C233(vt_msg;"Verificando Porcentaje de asistencia de Alumnos…";"ERROR - Alumnos con porcentaje de asistencia iincorrecto")
			Else 
				vt_msg:=Replace string:C233(vt_msg;"Verificando Porcentaje de asistencia de Alumnos…";"OK - Verificación de Porcentaje de asistencia de alumnos completada exitosamente")
			End if 
		End if 
		vl_VerifMineduc:=9
		POST KEY:C465(Character code:C91("+");256)
		
	: (vl_VerifMineduc=9)
		If (r1_Actas=1)
			vt_Msg:=vt_Msg+"\r"+"Verificando Rol Unico Nacional de profesores jefes…"
			POST KEY:C465(Character code:C91("*");256)
			READ ONLY:C145([Cursos:3])
			QUERY WITH ARRAY:C644([Cursos:3]Nivel_Numero:7;<>al_NumeroNivelesOficiales)
			QUERY SELECTION:C341([Cursos:3];[Cursos:3]Nivel_Numero:7>=1)  //CAMBIOS AQUI
			SELECTION TO ARRAY:C260([Cursos:3]Numero_del_profesor_jefe:2;aLong1)
			QRY_QueryWithArray (->[Profesores:4]Numero:1;->aLong1)
			SELECTION TO ARRAY:C260([Profesores:4];$aRecNums)
			$text:=""
			For ($i;1;Size of array:C274($aRecNums))
				GOTO RECORD:C242([Profesores:4];$aRecNums{$i})
				$rut:=CTRY_CL_VerifRUT ([Profesores:4]RUT:27;False:C215)
				If ($rut="")
					$text:=$text+[Profesores:4]Apellido_paterno:3+"\r"
				End if 
			End for 
			If ($text#"")
				vt_text1:=vt_text1+"\r"+"EL RUN DE LOS SIGUIENTES PROFESORES JEFES NO HA SIDO DEFINIDO O ES INCORRECTO:"+"\r"
				vt_text1:=vt_text1+$text
				vt_msg:=Replace string:C233(vt_msg;"Verificando Rol Unico Nacional de profesores jefes…";"ERROR - Profesores jefes sin información en el campo RUN")
			Else 
				vt_msg:=Replace string:C233(vt_msg;"Verificando Rol Unico Nacional de profesores jefes…";"OK - Verificación de Rol Unico Nacional de profesores jefes completada exitosame")
			End if 
		End if 
		vl_VerifMineduc:=10
		POST KEY:C465(Character code:C91("+");256)
		
	: (vl_VerifMineduc=10)
		vb_GeneraArchivos:=True:C214
		$result:=1
		If (r1_Actas=1)
			vt_Msg:=vt_Msg+"\r"+"Verificando códigos de subsectores o asignaturas…"
			POST KEY:C465(Character code:C91("*");256)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Incluida_en_Actas:44=True:C214)
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6>=1)  //CAMBIOS AQUI
			SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;aText1)
			QRY_QueryWithArray (->[xxSTR_Materias:20]Materia:2;->aText1)
			QUERY SELECTION BY FORMULA:C207([xxSTR_Materias:20];Num:C11([xxSTR_Materias:20]Codigo:10)=0)
			If (Records in selection:C76([xxSTR_Materias:20])>0)
				SELECTION TO ARRAY:C260([xxSTR_Materias:20]Materia:2;aText1)
				vt_text1:=vt_text1+"\r"+"EL CODIGO DE LOS SIGUIENTES SUBSECTORES O ASIGNATURAS NO HA SIDO DEFINIDO:"+"\r"
				vt_text1:=vt_text1+AT_array2text (->aText1;"\r")+"\r"
				vt_msg:=Replace string:C233(vt_msg;"Verificando códigos de subsectores o asignaturas…";"ERROR - Subsectores o asignaturas sin código ")
			Else 
				vt_msg:=Replace string:C233(vt_msg;"Verificando códigos de subsectores o asignaturas…";"OK - Verificación de códigos de subsectores o asignaturas completada exitosament")
			End if 
			
			If (bEvaluar=1)
				C_BLOB:C604($blob)
				SET BLOB SIZE:C606($blob;0)
				vb_AsignaSituacionFinal:=False:C215
				ARRAY LONGINT:C221($alRecNums;0)
				QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
				ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
				LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$alRecNums;"")
				BLOB_Variables2Blob (->$blob;0;->$alRecNums)
				AL_RecalcFinalSituation ($blob)
				  //dbu_CalculaSituacionFinal ($blob;False)//MONO: Con este llamado pasa el problema de los % de asistencia que quedan todos en 100
			End if 
			
			If (bDiagnostico=1)
				$resultVerif:=dbu_VerificaPromediosActa ($blob;False:C215)
				If ($resultVerif=-1)
					vb_GeneraArchivos:=False:C215
					OBJECT SET COLOR:C271(vt_ResultadoDiagnostico;-3)
					$vt_ResultadoDiagnostico:="- Se detectaron diferencias entre las notas que figuran en actas y el promedio g"+"eral calculado por SchoolTrack."+"Estas diferencias se deben a una configuración inconsistente"
					$vt_ResultadoDiagnostico:=$vt_ResultadoDiagnostico+" de los atributos INCIDE EN PROMEDIO, EN ACTAS y OPTATIVA"
				Else 
					$vt_ResultadoDiagnostico:=""
				End if 
				
				
				$result:=DIAG_Main (False:C215)
				  //vt_ResultadoDiagnostico:=st_ClearExtraCR (vt_ResultadoDiagnostico)
				Case of 
					: ($result=-1)
						OBJECT SET COLOR:C271(vt_ResultadoDiagnostico;-3)
						OBJECT SET VISIBLE:C603(*;"printDiagnostico@";True:C214)
						vb_GeneraArchivos:=False:C215
						$ResultadoDiagnostico:="- Se detectaron SERIOS problemas de integridad o consistencia de datos que impide"+"n"+" la generación de archivos para el RECH."
					: ($result=0)
						OBJECT SET COLOR:C271(vt_ResultadoDiagnostico;-2)
						OBJECT SET VISIBLE:C603(*;"printDiagnostico@";True:C214)
						$ResultadoDiagnostico:="- Se detectaron pequeños problemas en los datos. Sin embargo, no impiden"+" la generación de archivos para el RECH."
					: ($result=1)
						OBJECT SET COLOR:C271(vt_ResultadoDiagnostico;-8)
						OBJECT SET VISIBLE:C603(*;"printDiagnostico@";False:C215)
						$ResultadoDiagnostico:="- No se detectó ningún problema durante la fase de diágnostico detallado "+"de la base de datos."
				End case 
				If (($vt_ResultadoDiagnostico#"") & ($resultVerif<0))
					vt_ResultadoDiagnostico:=$vt_ResultadoDiagnostico+"\r"+$ResultadoDiagnostico
					OBJECT SET COLOR:C271(vt_ResultadoDiagnostico;-3)
					$result:=-1
				Else 
					vt_ResultadoDiagnostico:=$ResultadoDiagnostico
				End if 
				
				If ($result>=0)
					vt_msg2:="No se detectó ningún problema que impida la generación de los archivos."
					vt_msg2:=vt_msg2+"\r\r"+"Tenga presente, sin embargo, que esto no garantiza que los datos generados sean "+"aceptados por el RECH: "
					vt_msg2:=vt_msg2+"\r"+"La aceptación depende de otras validaciones efectuadas por el sistema del"+" MINEDUC que recibe los archivos."
					vt_msg2:=vt_msg2+"\r\r"+"Haga click en el botón flecha siguiente para continuar con la generación de "+"archivos."
					OBJECT SET VISIBLE:C603(*;"printreport@";False:C215)
					OBJECT SET COLOR:C271(vt_msg2;-8)
					_O_ENABLE BUTTON:C192(bNext)
					vb_GeneraArchivos:=True:C214
				Else 
					vt_msg2:="Se detectaron errores de consistencia o integridad de la información."+"\r\r"+"Utilice las opciones de impresión para imprimir los informe de errores"
					vt_msg2:=vt_msg2+" y corríjalos para poder continuar con la generación de archivos"
					OBJECT SET VISIBLE:C603(*;"diagnostico@";True:C214)
					OBJECT SET VISIBLE:C603(*;"printdiagnostico@";True:C214)
					OBJECT SET COLOR:C271(vt_msg2;-3)
					vb_GeneraArchivos:=False:C215
				End if 
			End if 
		End if 
		
		
		If (vt_Text1#"")
			vt_msg2:="Se detectaron errores de consistencia o integridad de la información."+"\r\r"+"Utilice las opciones de impresión para imprimir los informe de errores"
			vt_msg2:=vt_msg2+" y corríjalos para poder continuar con la generación de archivos"
			OBJECT SET VISIBLE:C603(*;"printreport@";True:C214)
			OBJECT SET COLOR:C271(vt_msg2;-3)
			vb_GeneraArchivos:=False:C215
		Else 
			vt_Msg2:="Verificación exitosa\rPresione el botón página siguiente para generar los archivos"+"."
			OBJECT SET VISIBLE:C603(*;"printreport@";False:C215)
			OBJECT SET COLOR:C271(vt_msg2;-8)
		End if 
		
		
		
		vl_VerifMineduc:=-1
		POST KEY:C465(Character code:C91("/");256)
End case 

