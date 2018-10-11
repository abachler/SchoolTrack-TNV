  // [Actividades].StudSelection.seleccionAlumnos()
  // Por: Alberto Bachler K.: 08-06-14, 12:30:40
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_POINTER:C301($y_listaAlumnos)
ARRAY LONGINT:C221($al_filasSeleccionadas;0)

$y_listaAlumnos:=OBJECT Get pointer:C1124(Object named:K67:5;"seleccionAlumnos")
$y_recNumAlumnos_al:=OBJECT Get pointer:C1124(Object named:K67:5;"recNumAlumnos")
$l_filaSeleccionada:=LB_GetSelectedRows ($y_listaAlumnos;->$al_filasSeleccionadas)

If ($l_filaSeleccionada>0)
	Case of 
		: (Form event:C388=On Clicked:K2:4)
			KRL_GotoRecord (->[Alumnos:2];$y_recNumAlumnos_al->{$l_filaSeleccionada};False:C215)
			READ ONLY:C145([Alumnos_Actividades:28])
			QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
			QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Alumno_Numero:1=[Alumnos:2]numero:1)
			Case of 
				: ([Alumnos_Actividades:28]Periodos_Inscritos:44=1)
					IT_MuestraTip (__ ("Inscrito en todos los períodos"))
					
				: ([Alumnos_Actividades:28]Periodos_Inscritos:44>1)
					$t_texto:=__ ("Inscrito en: ")
					For ($i;1;viSTR_Periodos_NumeroPeriodos)
						If ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? $i)
							$t_texto:=$t_texto+"\r - "+atSTR_Periodos_Nombre{$i}
						End if 
					End for 
					IT_MuestraTip ($t_texto)
					
				Else 
					IT_MuestraTip (__ ("No está inscrito en nigún periodo"))
			End case 
			
			
		: (Form event:C388=On Selection Change:K2:29)
			
			
	End case 
End if 

OBJECT SET ENABLED:C1123(*;"botonInscribir";(Size of array:C274($al_filasSeleccionadas)>0))