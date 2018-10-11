Case of 
		
	: (Form event:C388=On Load:K2:1)
		QR_InitGenericObjects 
		
		ARRAY TEXT:C222(aQR_text100;0)
		APPEND TO ARRAY:C911(aQR_text100;"Sexo H/M")
		APPEND TO ARRAY:C911(aQR_text100;"Situación Final (11)")
		APPEND TO ARRAY:C911(aQR_text100;"País (12)")
		APPEND TO ARRAY:C911(aQR_text100;"Padre Vive SI / NO")
		APPEND TO ARRAY:C911(aQR_text100;"Madre Vive SI / NO")
		APPEND TO ARRAY:C911(aQR_text100;"Lengua Materna (13)")
		APPEND TO ARRAY:C911(aQR_text100;"Segunda Lengua (13)")
		APPEND TO ARRAY:C911(aQR_text100;"Trabaja el Estudiante SI / NO")
		APPEND TO ARRAY:C911(aQR_text100;"Horas Semanales que labora")
		APPEND TO ARRAY:C911(aQR_text100;"Escolaridad de la Madre (14)")
		APPEND TO ARRAY:C911(aQR_text100;"Nacimineto Registrado SI / NO")
		APPEND TO ARRAY:C911(aQR_text100;"Tipo de Discapacidad (15)")
		APPEND TO ARRAY:C911(aQR_text100;"Día")
		APPEND TO ARRAY:C911(aQR_text100;"Mes")
		APPEND TO ARRAY:C911(aQR_text100;"Año")
		APPEND TO ARRAY:C911(aQR_text100;"N° de Orden")
		
		
		C_POINTER:C301($ptro)
		
		For (vQR_longint1;1;Size of array:C274(aQR_text100))
			
			$ptro:=Get pointer:C304("vQR_picture"+String:C10(vQR_longint1))
			
			vb_Modificado_4Dv11:=True:C214
			
			If (Application version:C493>="11@")
				If (vQR_longint1<13)
					$ptro->:=SVG_Text2Pict (aQR_text100{vQR_longint1};90;40;"Arial";7;Plain:K14:1;Align center:K42:3;"Black";90)
				Else 
					$ptro->:=SVG_Text2Pict (aQR_text100{vQR_longint1};60;60;"Arial";10;Plain:K14:1;Align center:K42:3;"Black";90)
				End if 
			Else 
				  //If (vQR_longint1<13)
				  //$ptro->:=IT_RotateText2Pict (aQR_text100{vQR_longint1};90;40;"Arial";7;2;2)
				  //Else 
				  //$ptro->:=IT_RotateText2Pict (aQR_text100{vQR_longint1};60;60;"Arial";10;2;2)
				  //End if 
			End if 
			
		End for 
		
		
		READ ONLY:C145([Colegio:31])
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([Alumnos:2])
		
		ALL RECORDS:C47([Colegio:31])
		
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
		ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
		
		SELECTION TO ARRAY:C260([Alumnos:2]Familia_Número:24;aQR_longint1;[Alumnos:2]apellidos_y_nombres:40;aQR_text1;[Alumnos:2]Fecha_de_nacimiento:7;aQR_date1;[Alumnos:2]Sexo:49;aQR_text5;[Alumnos:2]RUT:5;aQR_text6;[Alumnos:2]Nacionalidad:8;aQR_text7;[Alumnos:2]Situacion_final:33;aQR_text8;[Alumnos:2]Fecha_de_Ingreso:41;aQR_date2;[Alumnos:2]Colegio_de_origen:25;aQR_text12)
		
		
		vQR_text21:=AT_array2text (->aQR_text1;"\r")
		
		ARRAY TEXT:C222(aQR_text2;0)
		ARRAY TEXT:C222(aQR_text3;0)
		ARRAY TEXT:C222(aQR_text4;0)
		
		ARRAY TEXT:C222(aQR_text9;0)  //fallecido madre
		ARRAY TEXT:C222(aQR_text10;0)  //fallecido padre
		
		ARRAY TEXT:C222(aQR_text11;0)  //Escolaridad de la Madre
		ARRAY TEXT:C222(aQR_text13;0)  //Colegio de procedencia alumnos nuevos
		
		
		For (vQR_longint1;1;Size of array:C274(aQR_longint1))
			
			APPEND TO ARRAY:C911(aQR_text2;(String:C10(Day of:C23(aQR_date1{vQR_longint1});"00")))
			APPEND TO ARRAY:C911(aQR_text3;(String:C10(Month of:C24(aQR_date1{vQR_longint1});"00")))
			APPEND TO ARRAY:C911(aQR_text4;(String:C10(Year of:C25(aQR_date1{vQR_longint1}))))
			
			QUERY:C277([Familia:78];[Familia:78]Numero:1=aQR_longint1{vQR_longint1})
			
			QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Madre_Número:6)
			
			Case of 
				: ([Personas:7]Nivel_de_estudios:11="@Analfabet@")
					APPEND TO ARRAY:C911(aQR_text11;"A")
				: ([Personas:7]Nivel_de_estudios:11="@Primaria@")
					APPEND TO ARRAY:C911(aQR_text11;"P")
				: ([Personas:7]Nivel_de_estudios:11="@Secundaria@")
					APPEND TO ARRAY:C911(aQR_text11;"S")
				: ([Personas:7]Nivel_de_estudios:11="@Superior@")
					APPEND TO ARRAY:C911(aQR_text11;"SP")
				Else 
					APPEND TO ARRAY:C911(aQR_text11;"")
			End case 
			
			If ([Personas:7]Fallecido:88=True:C214)
				APPEND TO ARRAY:C911(aQR_text9;"NO")
			Else 
				APPEND TO ARRAY:C911(aQR_text9;"SI")
			End if 
			
			QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5)
			
			If ([Personas:7]Fallecido:88=True:C214)
				APPEND TO ARRAY:C911(aQR_text10;"NO")
			Else 
				APPEND TO ARRAY:C911(aQR_text10;"SI")
			End if 
			
			
			If ((Year of:C25(aQR_date2{vQR_longint1}))=(Year of:C25(Current date:C33(*))))
				APPEND TO ARRAY:C911(aQR_text13;aQR_text12{vQR_longint1})
			Else 
				APPEND TO ARRAY:C911(aQR_text13;"")
			End if 
		End for 
		
		
		vQR_text22:=AT_array2text (->aQR_text2;"\r")
		vQR_text23:=AT_array2text (->aQR_text3;"\r")
		vQR_text24:=AT_array2text (->aQR_text4;"\r")
		vQR_text25:=AT_array2text (->aQR_text5;"\r")
		vQR_text26:=AT_array2text (->aQR_text9;"\r")
		vQR_text27:=AT_array2text (->aQR_text10;"\r")
		vQR_text28:=AT_array2text (->aQR_text11;"\r")
		vQR_text29:=AT_array2text (->aQR_text13;"\r")
		
		PERIODOS_Init 
		PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
		
		vQR_date1:=adSTR_Periodos_Desde{1}
		vQR_date2:=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_hasta)}
		
		
End case 

