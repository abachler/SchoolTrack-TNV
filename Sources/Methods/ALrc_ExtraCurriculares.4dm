//%attributes = {}
  //ALrc_ExtraCurriculares

C_LONGINT:C283($i;$0)
ARRAY TEXT:C222(aXCR0;0)
ARRAY TEXT:C222(aXCR1;0)
ARRAY TEXT:C222(aXCR2;0)
ARRAY TEXT:C222(aXCR3;0)
ARRAY TEXT:C222(aXCR4;0)
ARRAY TEXT:C222(aXCR5;0)
ARRAY TEXT:C222(aXCR6;0)
_O_ARRAY STRING:C218(60;aXCRCcept;0)
$0:=0
If (bXCR=1)
	COPY ARRAY:C226(<>aXCRAbrv;aXCRAbrv)  //Impresion de la evaluacion valórica
	For ($i;Size of array:C274(aXCRAbrv);1;-1)
		If (aXCRAbrv{$i}="")
			aXCRAbrv{$i}:=String:C10($i)
		End if 
	End for 
	$s:=Size of array:C274(aXCRCcept)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Alumno_Numero:1=[Alumnos:2]numero:1;*)
	QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Año:3=<>gyear)
	
	If (popInformes#3)
		  //PS 04-07-2012: se agrega filtro por periodos ya que para las actividades siempre salian en todos los periodos apresar de estar inscritas en periodos especificos
		QUERY SELECTION BY FORMULA:C207([Alumnos_Actividades:28];(([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0) | ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? vperiodo)))
		
		If (Records in selection:C76([Alumnos_Actividades:28])>0)
			Case of 
				: (vPeriodo=1)
					If (bXcrFinal=1)
						SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Actividades:29]Nombre:2;aXCR0;[Alumnos_Actividades:28]Evaluación_Final_P1:7;aXCR1;[Alumnos_Actividades:28]Comentarios_P1:6;aXcr2)
					Else 
						SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Actividades:29]Nombre:2;aXCR0;[Alumnos_Actividades:28]Periodo1_Evaluación1:15;aXCR1;[Alumnos_Actividades:28]Periodo1_Evaluación2:16;aXCR2;[Alumnos_Actividades:28]Periodo1_Evaluación3:17;aXCR3;[Alumnos_Actividades:28]Periodo1_Evaluación4:18;aXCR4;[Alumnos_Actividades:28]Periodo1_Evaluación5:19;aXCR5;[Alumnos_Actividades:28]Periodo1_Evaluación6:20;aXCR6)
					End if 
				: (vPeriodo=2)
					If (bXcrFinal=1)
						SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Actividades:29]Nombre:2;aXCR0;[Alumnos_Actividades:28]Evaluación_Final_P2:8;aXCR1;[Alumnos_Actividades:28]Comentarios_P2:13;aXcr2)
					Else 
						SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Actividades:29]Nombre:2;aXCR0;[Alumnos_Actividades:28]Periodo2_Evaluación1:21;aXCR1;[Alumnos_Actividades:28]Periodo2_Evaluación2:22;aXCR2;[Alumnos_Actividades:28]Periodo2_Evaluación3:23;aXCR3;[Alumnos_Actividades:28]Periodo2_Evaluación4:24;aXCR4;[Alumnos_Actividades:28]Periodo2_Evaluación5:25;aXCR5;[Alumnos_Actividades:28]Periodo2_Evaluación6:26;aXCR6)
					End if 
				: (vPeriodo=3)
					If (bXcrFinal=1)
						SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Actividades:29]Nombre:2;aXCR0;[Alumnos_Actividades:28]Evaluación_Final_P3:9;aXCR1;[Alumnos_Actividades:28]Comentarios_P3:14;aXcr2)
					Else 
						SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Actividades:29]Nombre:2;aXCR0;[Alumnos_Actividades:28]Periodo3_Evaluación1:27;aXCR1;[Alumnos_Actividades:28]Periodo3_Evaluación2:28;aXCR2;[Alumnos_Actividades:28]Periodo3_Evaluación3:29;aXCR3;[Alumnos_Actividades:28]Periodo3_Evaluación3:29;aXCR4;[Alumnos_Actividades:28]Periodo3_Evaluación5:31;aXCR5;[Alumnos_Actividades:28]Periodo3_Evaluación6:32;aXCR6)
					End if 
				: (vPeriodo=4)
					If (bXcrFinal=1)
						SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Actividades:29]Nombre:2;aXCR0;[Alumnos_Actividades:28]Evaluación_Final_P4:39;aXCR1;[Alumnos_Actividades:28]Comentarios_P4:41;aXcr2)
					Else 
						SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Actividades:29]Nombre:2;aXCR0;[Alumnos_Actividades:28]Periodo4_Evaluación1:33;aXCR1;[Alumnos_Actividades:28]Periodo4_Evaluación2:34;aXCR2;[Alumnos_Actividades:28]Periodo4_Evaluación3:35;aXCR3;[Alumnos_Actividades:28]Periodo4_Evaluación4:36;aXCR4;[Alumnos_Actividades:28]Periodo4_Evaluación5:37;aXCR5;[Alumnos_Actividades:28]Periodo4_Evaluación6:38;aXCR6)
					End if 
				: (vPeriodo=5)
					If (bXcrFinal=1)
						SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Actividades:29]Nombre:2;aXCR0;[Alumnos_Actividades:28]Evaluacion_Final_P5:51;aXCR1;[Alumnos_Actividades:28]Comentarios_P5:53;aXcr2)
					Else 
						SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Actividades:29]Nombre:2;aXCR0;[Alumnos_Actividades:28]Periodo5_Evaluacion1:45;aXCR1;[Alumnos_Actividades:28]Periodo5_Evaluacion2:46;aXCR2;[Alumnos_Actividades:28]Periodo5_Evaluacion3:47;aXCR3;[Alumnos_Actividades:28]Periodo5_Evaluacion4:48;aXCR4;[Alumnos_Actividades:28]Periodo4_Evaluación5:37;aXCR5;[Alumnos_Actividades:28]Periodo5_Evaluacion6:50;aXCR6)
					End if 
					
			End case 
		End if 
	Else 
		SELECTION TO ARRAY:C260([Alumnos_Actividades:28]Actividad_numero:2;$id;[Actividades:29]Nombre:2;aXCR0;[Alumnos_Actividades:28]Evaluación_Final_P1:7;aXCR1;[Alumnos_Actividades:28]Evaluación_Final_P2:8;aXCR2;[Alumnos_Actividades:28]Evaluación_Final_P3:9;aXCR3;[Alumnos_Actividades:28]Evaluación_Final_P4:39;aXCR4;[Alumnos_Actividades:28]Evaluacion_Final_P5:51;aXCR5;[Alumnos_Actividades:28]Evaluación_Final_Anual:40;aXCR6)
	End if 
	
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	$0:=Size of array:C274(aXCR0)+3
End if 