//%attributes = {}
  //Método: CAE_PromueveAlumnos
C_LONGINT:C283(vl_UltimoAño)
NIV_LoadArrays 

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Promoción e inscripción de los alumnos en sus asignaturas en proceso…")+String:C10(vl_UltimoAño))

C_LONGINT:C283($1;$2;$l_nivelAlu)  //MONO 184433
If (Count parameters:C259=2)
	vl_UltimoAño:=$1  //MONO 184433
	$l_nivelAlu:=$2  //MONO 184433
	c1_EnCursos:=1  //MONO 184433
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$l_nivelAlu)  //MONO 184433
Else 
	QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelRegular)  //MONO 184433
End if 

QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT")
ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]no_de_lista:53;>)
ARRAY LONGINT:C221($aRecNum;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNum;"")
PERIODOS_Init 

For ($i;1;Size of array:C274($aRecNum))
	READ WRITE:C146([Alumnos:2])
	GOTO RECORD:C242([Alumnos:2];$aRecNum{$i})
	PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
	$keySintesisAnual:="0."+String:C10(vl_UltimoAño)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
	
	
	$oldNivel:=[Alumnos:2]nivel_numero:29
	$promocionAutomatica:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Promoción_auto:18)
	C_BOOLEAN:C305($bsit_manual)
	$bsit_manual:=KRL_GetBooleanFieldData (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;->[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61)
	$promovido:=False:C215
	Case of 
		: (<>vtXS_CountryCode="cl")
			If ([Alumnos:2]Situacion_final:33="P")
				$promovido:=True:C214
			Else 
				  //ABC198029 //Si es promocion automatica pero el alumno fue reprobado manual se debe considerar esta opción. en la validación.
				If (([Alumnos:2]Situacion_final:33="R") & ($bsit_manual))
					$promovido:=False:C215
					$promocionAutomatica:=False:C215
				End if 
			End if 
		: (<>vtXS_CountryCode="pe")
			If (([Alumnos:2]Situacion_final:33="A") | ([Alumnos:2]Situacion_final:33="RR") | ([Alumnos:2]Situacion_final:33="C"))
				$promovido:=True:C214
			End if 
			
		: (<>vtXS_CountryCode="co")
			  //If (([Alumnos]Situacion_final="P") | ([Alumnos]Situacion_final="RR"))
			  //$promovido:=True
			  //End if 
			If (([Alumnos:2]Situacion_final:33="P") | ([Alumnos:2]Situacion_final:33="RR") | ([Alumnos:2]Situacion_final:33#"NP"))
				$promovido:=True:C214
			Else 
				$promocionAutomatica:=False:C215
			End if 
			
		: (<>vtXS_CountryCode="ve")
			If ([Alumnos:2]Situacion_final:33="P")
				$promovido:=True:C214
			Else 
				If (([Alumnos:2]Situacion_final:33="R") & ($bsit_manual))
					$promovido:=False:C215
					$promocionAutomatica:=False:C215
				End if 
			End if 
			
		: (<>vtXS_CountryCode="ar")
			If ([Alumnos:2]Situacion_final:33="P")
				$promovido:=True:C214
			Else 
				If (([Alumnos:2]Situacion_final:33="R") & ($bsit_manual))
					$promovido:=False:C215
					$promocionAutomatica:=False:C215
				End if 
			End if 
			
		Else 
			If ([Alumnos:2]Situacion_final:33="P")
				$promovido:=True:C214
			Else 
				If (([Alumnos:2]Situacion_final:33="R") & ($bsit_manual))
					$promovido:=False:C215
					$promocionAutomatica:=False:C215
				End if 
			End if 
	End case 
	
	
	If (($promovido) | ([Alumnos:2]Situacion_final:33="PA") | ($promocionAutomatica) | ([Alumnos:2]Status:50="Retirado@") | ([Alumnos:2]Status:50="Oyente@"))
		$letter:=Substring:C12([Alumnos:2]curso:20;Position:C15("-";[Alumnos:2]curso:20)+1)
		$el:=Find in array:C230(<>al_NumeroNivelRegular;[Alumnos:2]nivel_numero:29)
		Case of 
			: ($el=Size of array:C274(<>al_NumeroNivelRegular))
				[Alumnos:2]nivel_numero:29:=Nivel_Egresados
			: (($el>0) & ($el<Size of array:C274(<>al_NumeroNivelRegular)))
				[Alumnos:2]nivel_numero:29:=<>al_NumeroNivelRegular{$el+1}
		End case 
		If ([Alumnos:2]Status:50="Promovido anticipadamente")
			[Alumnos:2]Status:50:="Activo"
		End if 
		
		Case of 
			: ([Alumnos:2]Status:50="Retirado@")
				[Alumnos:2]curso:20:="RET-"+String:C10(vl_UltimoAño)
				[Alumnos:2]nivel_numero:29:=Nivel_Retirados
				[Alumnos:2]Nivel_Nombre:34:="Retirados"
				[Alumnos:2]Sección:26:="Retirados"
				[Alumnos:2]Apoderado_académico_Número:27:=0
				
			: ([Alumnos:2]nivel_numero:29=Nivel_Egresados)
				[Alumnos:2]AgnoEgreso:91:=vl_UltimoAño
				  //[Alumnos]Curso:="EGR-"+String(vl_UltimoAño)
				[Alumnos:2]curso:20:=Substring:C12("EGR-"+vt_NombreUltimoAñoEscolar;1;20)  //20110512 RCH El campo es largo 20
				[Alumnos:2]Nivel_Nombre:34:="Egresados"
				[Alumnos:2]Sección:26:="Egresados"
				[Alumnos:2]Tutor_numero:36:=0
				[Alumnos:2]Status:50:="Egresado"
				[Alumnos:2]Apoderado_académico_Número:27:=0
				AL_EscribeSintesisAnual ($keySintesisAnual;->[Alumnos_SintesisAnual:210]Promovido:91;->$promovido)
				
			Else 
				AL_EscribeSintesisAnual ($keySintesisAnual;->[Alumnos_SintesisAnual:210]Promovido:91;->$promovido)
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
				$rolBDcurso:=[Cursos:3]cl_RolBaseDatos:20
				
				Case of 
					: (<>vtXS_CountryCode="cl")
						$letraOficial:=[Cursos:3]Letra_Oficial_del_Curso:18
						$nombreOficial:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Abreviatura_Oficial:35)+"-"+$letraOficial
						$letraCurso:=[Cursos:3]Letra_del_curso:9
						$nombreCurso:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Abreviatura:19)+"-"+$letraCurso
						
					Else 
						If (c1_EnCursos=1)  // se inscribe a los alumnos en los cursos solo si la opción ha sido seleccionada
							$letraCurso:=[Cursos:3]Letra_del_curso:9
							$nombreCurso:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Abreviatura:19)+"-"+$letraCurso
							$letraOficial:=[Cursos:3]Letra_Oficial_del_Curso:18
							$nombreOficial:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Abreviatura_Oficial:35)+"-"+$letraOficial
						Else   // en caso contrario los alumnos son todos agrupados en un curso temporal único
							$letraCurso:="TEMP"
							$nombreCurso:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Abreviatura:19)+"-"+$letraCurso
							$letraOficial:="TEMP"
							$nombreOficial:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Abreviatura_Oficial:35)+"-"+$letraOficial
						End if 
				End case 
				
				READ WRITE:C146([Cursos:3])
				QUERY:C277([Cursos:3];[Cursos:3]Nombre_Oficial_Curso:15=$nombreOficial;*)
				QUERY:C277([Cursos:3]; & ;[Cursos:3]Nivel_Numero:7=[Alumnos:2]nivel_numero:29)
				  //de la forma que se crea el nombreoficial hay colegios que tienen una letra oficial para mas de un curso y en este caso encuentran mas de un curso, promoviendo así a todos los alumnos de ese nivel al curso que queda primero en la selección
				If (Records in selection:C76([Cursos:3])>1)
					QUERY SELECTION:C341([Cursos:3];[Cursos:3]Letra_del_curso:9=$letraCurso)
				End if 
				
				If ($rolBDcurso#"")
					QUERY SELECTION:C341([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=$rolBDcurso)
				End if 
				If (Records in selection:C76([Cursos:3])=0)
					READ WRITE:C146([Cursos:3])
					QUERY:C277([Cursos:3];[Cursos:3]Nombre_Oficial_Curso:15=$nombreCurso;*)
					QUERY:C277([Cursos:3]; & ;[Cursos:3]Nivel_Numero:7=[Alumnos:2]nivel_numero:29)
					If ($rolBDcurso#"")
						QUERY SELECTION:C341([Cursos:3];[Cursos:3]cl_RolBaseDatos:20=$rolBDcurso)
					End if 
					If (Records in selection:C76([Cursos:3])=1)
						If ([Cursos:3]Nombre_Oficial_Curso:15#[Cursos:3]Curso:1)
							[Cursos:3]Curso:1:=[Cursos:3]Nombre_Oficial_Curso:15
							[Cursos:3]Letra_del_curso:9:=[Cursos:3]Letra_Oficial_del_Curso:18
							SAVE RECORD:C53([Cursos:3])
						End if 
					End if 
					$recNum:=Find in field:C653([Cursos:3]Curso:1;$nombreCurso)
					If ($recNum<0)
						CREATE RECORD:C68([Cursos:3])
						[Cursos:3]Curso:1:=$nombreCurso
						[Cursos:3]Nombre_Oficial_Curso:15:=$nombreOficial
						[Cursos:3]Letra_Oficial_del_Curso:18:=$letraOficial
						[Cursos:3]Letra_del_curso:9:=$letraCurso
						[Cursos:3]cl_RolBaseDatos:20:=$rolBDcurso
						[Cursos:3]Ciclo:5:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Sección:9)
						[Cursos:3]Nivel_Nombre:10:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Nivel:1)
						[Cursos:3]Nombre_Oficial_Nivel:14:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21)
						[Cursos:3]Nivel_Numero:7:=[Alumnos:2]nivel_numero:29
						[Cursos:3]Numero_del_curso:6:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6)
						SAVE RECORD:C53([Cursos:3])
					Else 
						GOTO RECORD:C242([Cursos:3];$recNum)
					End if 
				End if 
				[Alumnos:2]curso:20:=[Cursos:3]Curso:1
				[Alumnos:2]Nivel_Nombre:34:=[Cursos:3]Nivel_Nombre:10
				[Alumnos:2]nivel_numero:29:=[Cursos:3]Nivel_Numero:7
				[Alumnos:2]Sección:26:=[Cursos:3]Ciclo:5
		End case 
		If (([Alumnos:2]nivel_numero:29=$oldNivel) & ([Alumnos:2]Situacion_final:33="P"))
			
		End if 
		SAVE RECORD:C53([Alumnos:2])
	Else 
		
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNum);__ (""))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
$idP:=IT_UThermometer (1;0;__ ("Inscripción de postulantes aceptados y confirmados"))
  //***** REINSTALAR AQUI LA PROMOCION DE ALUMNOS DE POSTULANTES ACEPTADOS Y CONFIRMA  `DOS EN ADMISSIONTRACK - 12/01/06
CAE_PromocionAdmissionTrack 
  //*****
IT_UThermometer (-2;$idP)
FLUSH CACHE:C297






