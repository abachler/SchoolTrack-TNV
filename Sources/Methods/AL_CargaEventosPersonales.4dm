//%attributes = {}
  //AL_CargaEventosPersonales

AL_UpdateArrays (xALP_Interview;0)
QUERY:C277([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Alumno_Numero:1=[Alumnos:2]numero:1)
SELECTION TO ARRAY:C260([Alumnos_EventosPersonales:16]Fecha:3;aIWdate;[Alumnos_EventosPersonales:16]Asunto:5;aIWMotivo;[Alumnos_EventosPersonales:16]Tipo_de_evento:6;alWEvento;[Alumnos_EventosPersonales:16];aIWId;[Alumnos_EventosPersonales:16]Privada:9;$ab_Privada;[Alumnos_EventosPersonales:16]Autor:8;$autor;[Alumnos_EventosPersonales:16]ID_Autor:11;$idautor)
SORT ARRAY:C229(aIWdate;aIWMotivo;alWEvento;aIWId;$ab_Privada;$autor;$idautor;<)

  //AL_UpdateArrays (xALP_Interview;-2)
AL_UpdateArrays (xALP_Interview;0)
ALP_SetDefaultAppareance (xALP_Interview)

AL_UpdateArrays (xALP_Interview;-2)
AL_SetLine (xALP_Interview;0)


For ($i;1;Size of array:C274(aIWId))
	If (($ab_Privada{$i}) & ($idautor{$i}#<>lUSR_RelatedTableUserID))
		aIWMotivo{$i}:="Privada ("+$autor{$i}+")"
		AL_SetRowStyle (xALP_Interview;$i;2)
	End if 
End for 

AL_UpdateArrays (xALP_Interview;-2)
AL_SetSort (xALP_Interview;-1)
