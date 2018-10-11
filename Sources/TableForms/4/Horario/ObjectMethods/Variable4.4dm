If (Form event:C388=On Load:K2:1)
	  // MOD Ticket N° 211036 Patricio Aliaga 20180725
	C_LONGINT:C283($i;$j;$x;$z;$i_Horas;$index)
	C_BOOLEAN:C305($sabados;$cursiva)
	C_DATE:C307(dDate)
	C_TIME:C306(hHeure)
	ARRAY TEXT:C222($at_cursiva;0)
	READ ONLY:C145([TMT_Horario:166])
	READ ONLY:C145([Asignaturas:18])
	READ ONLY:C145([Profesores:4])
	dDate:=Current date:C33(*)
	hHeure:=Current time:C178(*)
	QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Teacher:9=[Profesores:4]Numero:1)
	QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesHasta:13>=dDate)  //ASM 20150525 Ticket 145466 
	vtSTR_Horario_NombreCiclo:=""
	If (vlSTR_Horario_NoCiclos=2)
		QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]No_Ciclo:14=vlSTR_Horario_CicloNumero)
		vtSTR_Horario_NombreCiclo:="Semana "+Char:C90(vlSTR_Horario_CicloNumero+64)
	End if 
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	QUERY SELECTION:C341([TMT_Horario:166];[Asignaturas:18]denominacion_interna:16#"")
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	CREATE SET:C116([TMT_Horario:166];"$registro_horario")
	ARRAY LONGINT:C221($aNivel;0)
	ARRAY INTEGER:C220($aDay;0)
	DISTINCT VALUES:C339([TMT_Horario:166]Nivel:10;$aNivel)
	DISTINCT VALUES:C339([TMT_Horario:166]NumeroDia:1;$aDay)
	  //If (False)
	  //ORDER BY([TMT_Horario];[TMT_Horario]NumeroDia;>;[TMT_Horario]NumeroHora;>;[TMT_Horario]Desde;>)
	  //SELECTION TO ARRAY([TMT_Horario]ID_Asignatura;$aIDAsignatura;[TMT_Horario]NumeroDia;$aDay;[TMT_Horario]NumeroHora;$aHour;[TMT_Horario]Desde;$aDesde;[TMT_Horario]Sala;$aSala;[TMT_Horario]Curso;$aCurso;[TMT_Horario]Nivel;$aNivel;[Asignaturas]Denominación_interna;$aSubject;[Asignaturas]Seleccion;$aSelection;[Asignaturas]Electiva;$aElectiva)
	  //End if 
	  //SORT ARRAY($aHour;$aDay;$aDesde;$aSala;$aSubject;$aSelection;$aElectiva;$aCurso;$aNivel;$aIDAsignatura;>)
	  //SORT ARRAY($aDay;$aHour;$aDesde;$aSala;$aSubject;$aSelection;$aElectiva;$aCurso;$aNivel;$aIDAsignatura;>)
	  //If (False)
	  //For ($i;Size of array($aDay);1;-1)
	  //If ($aSubject{$i}="")
	  //DELETE FROM ARRAY($aDay;$i)
	  //DELETE FROM ARRAY($aHour;$i)
	  //DELETE FROM ARRAY($aSala;$i)
	  //DELETE FROM ARRAY($aDesde;$i)
	  //DELETE FROM ARRAY($aSubject;$i)
	  //DELETE FROM ARRAY($aSelection;$i)
	  //DELETE FROM ARRAY($aElectiva;$i)
	  //DELETE FROM ARRAY($aCurso;$i)
	  //DELETE FROM ARRAY($aNivel;$i)
	  //DELETE FROM ARRAY($aIDAsignatura;$i)
	  //Else 
	  //PERIODOS_LoadData ($aNivel{$i})
	  //If ($aHour{$i}<=Size of array(alSTR_Horario_Desde))  // 20180627 ASM Ticket 210637
	  //$aDesde{$i}:=alSTR_Horario_Desde{$aHour{$i}}
	  //End if 
	  //End if 
	  //End for 
	  //End if 
	If (Size of array:C274($aNivel)>0)
		  //CREACION DE LA GRILLA HORARIA CONSIDERANDO LAS DIVERSAS CONFIGURACIONES DE HORARIOS
		ARRAY LONGINT:C221($processedConfigs;0)
		$nivelNumber:=$aNivel{1}
		$ref_ConfigPeriodos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelNumber;->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
		PERIODOS_LoadData (0;$ref_ConfigPeriodos)
		ARRAY INTEGER:C220($aiSTR_Horario_HoraNo;0)
		ARRAY LONGINT:C221($alSTR_Horario_Desde;0)
		ARRAY LONGINT:C221($alSTR_Horario_Hasta;0)
		ARRAY LONGINT:C221($alSTR_Horario_Duracion;0)
		  //SORT ARRAY($aiSTR_Horario_HoraNo;$atSTR_Horario_HoraNombre;$alSTR_Horario_Desde;$alSTR_Horario_Hasta;$alSTR_Horario_Duracion;>)
		$sabados:=False:C215
		For ($i;1;Size of array:C274($aNivel))
			$nivelNumber:=$aNivel{$i}
			$ref_ConfigPeriodos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelNumber;->[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44)
			$addConfig:=(Find in array:C230($processedConfigs;$ref_ConfigPeriodos)=-1)
			If ($addConfig)
				INSERT IN ARRAY:C227($processedConfigs;Size of array:C274($processedConfigs)+1;1)
				$processedConfigs{Size of array:C274($processedConfigs)}:=$ref_ConfigPeriodos
				PERIODOS_LoadData (0;$ref_ConfigPeriodos)
				If (vlSTR_Horario_SabadoLabor=1)
					If (Not:C34($sabados))
						$sabados:=True:C214
					End if 
				End if 
				  //If (False)
				  //SORT ARRAY(aiSTR_Horario_HoraNo;alSTR_Horario_Desde;alSTR_Horario_Hasta;alSTR_Horario_Duracion;>)
				  //End if 
				For ($i_Horas;1;Size of array:C274(aiSTR_Horario_HoraNo))
					If (alSTR_Horario_Desde{$i_Horas}>0)
						  //$pos:=Find in array($alSTR_Horario_Desde;alSTR_Horario_Desde{$i_Horas})
						  //$pos:=Find in array($aiSTR_Horario_HoraNo;aiSTR_Horario_HoraNo{$i_Horas})  //MONO 211036
						  //If ($pos=-1)
						$insertAt:=Size of array:C274($aiSTR_Horario_HoraNo)+1
						INSERT IN ARRAY:C227($aiSTR_Horario_HoraNo;$insertAt)
						INSERT IN ARRAY:C227($alSTR_Horario_Desde;$insertAt)
						INSERT IN ARRAY:C227($alSTR_Horario_Hasta;$insertAt)
						INSERT IN ARRAY:C227($alSTR_Horario_Duracion;$insertAt)
						$aiSTR_Horario_HoraNo{$insertAt}:=aiSTR_Horario_HoraNo{$i_Horas}
						$alSTR_Horario_Desde{$insertAt}:=alSTR_Horario_Desde{$i_Horas}
						$alSTR_Horario_Hasta{$insertAt}:=alSTR_Horario_Hasta{$i_Horas}
						$alSTR_Horario_Duracion{$insertAt}:=alSTR_Horario_Duracion{$i_Horas}
						  //End if 
					End if 
				End for 
				  //End if 
			End if 
		End for 
		COPY ARRAY:C226($aiSTR_Horario_HoraNo;aiSTR_Horario_HoraNo)
		COPY ARRAY:C226($alSTR_Horario_Desde;alSTR_Horario_Desde)
		COPY ARRAY:C226($alSTR_Horario_Hasta;alSTR_Horario_Hasta)
		COPY ARRAY:C226($alSTR_Horario_Duracion;alSTR_Horario_Duracion)
		ARRAY TEXT:C222(aSTR_Horario_Dia1;0)
		ARRAY TEXT:C222(aSTR_Horario_Dia2;0)
		ARRAY TEXT:C222(aSTR_Horario_Dia3;0)
		ARRAY TEXT:C222(aSTR_Horario_Dia4;0)
		ARRAY TEXT:C222(aSTR_Horario_Dia5;0)
		ARRAY TEXT:C222(aSTR_Horario_Dia6;0)
		ARRAY TEXT:C222(aSTR_Horario_Dia7;0)
		$s:=Size of array:C274(aiSTR_Horario_HoraNo)
		ARRAY TEXT:C222(aSTR_Horario_Dia1;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia2;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia3;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia4;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia5;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia6;$s)
		ARRAY TEXT:C222(aSTR_Horario_Dia7;$s)
		  //INSERCION DE LA INFORMACION EN LAS CELDAS DE LA GRILLA
		  //ARRAY INTEGER(a2Int;2;0)
		For ($i;1;Size of array:C274($aDay))
			USE SET:C118("$registro_horario")
			QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$aDay{$i})
			  //If ($aidAsignatura{$i}>0)
			If (Records in selection:C76([TMT_Horario:166])>0)
				$ptr:=Get pointer:C304("aSTR_Horario_Dia"+String:C10($aDay{$i}))
				CREATE SET:C116([TMT_Horario:166];"$registro_horario_dia")
				DIFFERENCE:C122("$registro_horario";"$registro_horario_dia";"$registro_horario")
				USE SET:C118("$registro_horario_dia")
				ARRAY INTEGER:C220($aHour;0)
				DISTINCT VALUES:C339([TMT_Horario:166]NumeroHora:2;$aHour)
				For ($j;1;Size of array:C274($aHour))
					USE SET:C118("$registro_horario_dia")
					QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroHora:2=$aHour{$j})
					If (Records in selection:C76([TMT_Horario:166])>0)
						CREATE SET:C116([TMT_Horario:166];"$registro_horario_hora")
						DIFFERENCE:C122("$registro_horario_dia";"$registro_horario_hora";"$registro_horario_dia")
						USE SET:C118("$registro_horario_hora")
						ARRAY LONGINT:C221($aDesde;0)
						DISTINCT VALUES:C339([TMT_Horario:166]Desde:3;$aDesde)
						For ($x;1;Size of array:C274($aDesde))
							USE SET:C118("$registro_horario_hora")
							QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]Desde:3=$aDesde{$x})
							If (Records in selection:C76([TMT_Horario:166])>0)
								CREATE SET:C116([TMT_Horario:166];"$registro_horario_desde")
								DIFFERENCE:C122("$registro_horario_hora";"$registro_horario_desde";"$registro_horario_hora")
								USE SET:C118("$registro_horario_desde")
								ARRAY TEXT:C222($aSala;0)
								ARRAY TEXT:C222($aCurso;0)
								ARRAY TEXT:C222($aSubject;0)
								ARRAY TEXT:C222($aTexto;0)
								ARRAY BOOLEAN:C223($aSelection;0)
								ARRAY BOOLEAN:C223($aElectiva;0)
								SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
								ORDER BY:C49([TMT_Horario:166];[TMT_Horario:166]Sala:8;>;[TMT_Horario:166]Curso:11;>;[Asignaturas:18]denominacion_interna:16;>)
								SELECTION TO ARRAY:C260([TMT_Horario:166]Sala:8;$aSala;[TMT_Horario:166]Curso:11;$aCurso;[Asignaturas:18]denominacion_interna:16;$aSubject;[Asignaturas:18]Seleccion:17;$aSelection;[Asignaturas:18]Electiva:11;$aElectiva)
								SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
								$cursiva:=False:C215
								For ($z;1;Size of array:C274($aSala))
									If ($aSala{$z}="")
										$aSala{$z}:="(Sin Sala)"
									End if 
									APPEND TO ARRAY:C911($aTexto;$aSubject{$z}+"\r"+$aCurso{$z}+" - "+$aSala{$z})
									If (Not:C34($cursiva))
										If ($aSelection{$z} | $aElectiva{$z})
											$cursiva:=True:C214
										End if 
									End if 
								End for 
								$index:=Find in array:C230(alSTR_Horario_Desde;$aDesde{$x})
								$ptr->{$index}:=AT_array2text (->$aTexto;"\n")
								If (Mod:C98($i;2)=0)
									APPEND TO ARRAY:C911($at_cursiva;String:C10($aDay{$i}+3)+"."+String:C10($index))
								Else 
									APPEND TO ARRAY:C911($at_cursiva;"")
								End if 
							End if 
						End for 
					End if 
				End for 
				  //If (False)
				  //  //$posicionHora:=Find in array(alSTR_Horario_Desde;$aDesde{$i})
				  //$posicionHora:=Find in array(aiSTR_Horario_HoraNo;$aHour{$i})  //MONO 211036
				  //If ($aSala{$i}#"")
				  //$sala:=" - Sala: "+$aSala{$i}
				  //Else 
				  //$sala:=""
				  //End if 
				  //If ($ptr->{$posicionHora}="")
				  //$ptr->{$posicionHora}:=$aSubject{$i}+"\r"+$aCurso{$i}+$sala
				  //Else 
				  //$ptr->{$posicionHora}:=$ptr->{$posicionHora}+"\r"+$aSubject{$i}+"\r"+$aCurso{$i}+$sala
				  //End if 
				  //If (($aSelection{$i}) | ($aElectiva{$i}))
				  //INSERT IN ARRAY(a2Int{1};1;1)
				  //INSERT IN ARRAY(a2Int{2};1;1)
				  //a2Int{1}{1}:=$aDay{$i}+3
				  //a2Int{2}{1}:=$i
				  //End if 
				  //End if 
			End if 
		End for 
		If ($sabados)
			For ($i;Size of array:C274(aiSTR_Horario_HoraNo);1;-1)
				If ((aSTR_Horario_Dia1{$i}="") & (aSTR_Horario_Dia2{$i}="") & (aSTR_Horario_Dia3{$i}="") & (aSTR_Horario_Dia4{$i}="") & (aSTR_Horario_Dia5{$i}="") & (aSTR_Horario_Dia6{$i}=""))
					AT_Delete ($i;1;->aiSTR_Horario_HoraNo;->alSTR_Horario_Desde;->alSTR_Horario_Hasta;->aSTR_Horario_Dia1;->aSTR_Horario_Dia2;->aSTR_Horario_Dia3;->aSTR_Horario_Dia4;->aSTR_Horario_Dia5;->aSTR_Horario_Dia6;->$at_cursiva)
				End if 
			End for 
			$err:=PL_SetArraysNam (Self:C308->;1;9;"aiSTR_Horario_HoraNo";"alSTR_Horario_Desde";"alSTR_Horario_Hasta";"aSTR_Horario_Dia1";"aSTR_Horario_Dia2";"aSTR_Horario_Dia3";"aSTR_Horario_Dia4";"aSTR_Horario_Dia5";"aSTR_Horario_Dia6")
			PL_SetWidths (Self:C308->;1;9;14;25;25;85;85;85;85;85;85)
			PL_SetFormat (Self:C308->;9;"";2)
			PL_SetHeaders (Self:C308->;1;9;"";"";"";"Lunes";"Martes";"Miercoles";"Jueves";"Viernes";"Sábado")
		Else 
			For ($i;Size of array:C274(aiSTR_Horario_HoraNo);1;-1)
				If ((aSTR_Horario_Dia1{$i}="") & (aSTR_Horario_Dia2{$i}="") & (aSTR_Horario_Dia3{$i}="") & (aSTR_Horario_Dia4{$i}="") & (aSTR_Horario_Dia5{$i}=""))
					AT_Delete ($i;1;->aiSTR_Horario_HoraNo;->alSTR_Horario_Desde;->alSTR_Horario_Hasta;->aSTR_Horario_Dia1;->aSTR_Horario_Dia2;->aSTR_Horario_Dia3;->aSTR_Horario_Dia4;->aSTR_Horario_Dia5;->$at_cursiva)
				End if 
			End for 
			$err:=PL_SetArraysNam (Self:C308->;1;8;"aiSTR_Horario_HoraNo";"alSTR_Horario_Desde";"alSTR_Horario_Hasta";"aSTR_Horario_Dia1";"aSTR_Horario_Dia2";"aSTR_Horario_Dia3";"aSTR_Horario_Dia4";"aSTR_Horario_Dia5")
			PL_SetWidths (Self:C308->;1;8;14;25;25;102;102;102;102;102)
			PL_SetHeaders (Self:C308->;1;8;"";"";"";"Lunes";"Martes";"Miercoles";"Jueves";"Viernes")
		End if 
		ARRAY INTEGER:C220(a2Int;2;0)
		For ($i;1;Size of array:C274($at_cursiva))
			If ($at_cursiva{$i}#"")
				INSERT IN ARRAY:C227(a2Int{1};1;1)
				INSERT IN ARRAY:C227(a2Int{2};1;1)
				a2Int{1}{1}:=Num:C11(ST_GetWord ($at_cursiva{$i};1;"."))
				a2Int{2}{1}:=Num:C11(ST_GetWord ($at_cursiva{$i};2;"."))
			End if 
		End for 
		PL_SetFormat (Self:C308->;1;"##";2)
		PL_SetFormat (Self:C308->;2;"&/2";2)
		PL_SetFormat (Self:C308->;3;"&/2";2)
		PL_SetFormat (Self:C308->;4;"";2)
		PL_SetFormat (Self:C308->;5;"";2)
		PL_SetFormat (Self:C308->;6;"";2)
		PL_SetFormat (Self:C308->;7;"";2)
		PL_SetFormat (Self:C308->;8;"";2)
		PL_SetHdrOpts (Self:C308->;2)
		PL_SetHeight (Self:C308->;1;1;0;0)
		PL_SetHdrStyle (Self:C308->;0;"Tahoma";9;1)
		PL_SetStyle (Self:C308->;0;"Tahoma";8;0)
		PL_SetDividers (Self:C308->;0.3;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetFrame (Self:C308->;0.5;"Black";"Black";0;0.5;"Black";"Black";0)
		PL_SetCellStyle (Self:C308->;0;0;0;0;a2Int;2)
		  //PL_SetSort (Self->;1;2)
		PL_SetSort (Self:C308->;2;1)
		SET_ClearSets ("$registro_horario";"$registro_horario_dia";"$registro_horario_hora";"$registro_horario_desde")
	End if 
End if 