//%attributes = {}
  //ADTcon_SaveProspectos

For ($i;1;Size of array:C274(aProsMod))
	  //If (aProsMod{$i})
	If (aProsID{$i}#-MAXLONG:K35:2)
		READ WRITE:C146([ADT_Prospectos:163])
		$rn:=Find in field:C653([ADT_Prospectos:163]ID:1;aProsID{$i})
		If ($rn#-1)
			GOTO RECORD:C242([ADT_Prospectos:163];$rn)
		End if 
	Else 
		CREATE RECORD:C68([ADT_Prospectos:163])
		[ADT_Prospectos:163]ID:1:=SQ_SeqNumber (->[ADT_Prospectos:163]ID:1)
		[ADT_Prospectos:163]ID_Contacto:2:=[ADT_Contactos:95]ID:1
	End if 
	[ADT_Prospectos:163]Apellidos_y_Nombres:6:=aProsApPaterno{$i}+" "+aProsApMaterno{$i}+" "+aProsNombres{$i}
	[ADT_Prospectos:163]Apellido_Materno:4:=aProsApMaterno{$i}
	[ADT_Prospectos:163]Apellido_Paterno:3:=aProsApPaterno{$i}
	[ADT_Prospectos:163]Fecha_de_Nacimiento:9:=aProsFechaNac{$i}
	[ADT_Prospectos:163]Nombres:5:=aProsNombres{$i}
	[ADT_Prospectos:163]Nota:8:=aProsNota{$i}
	[ADT_Prospectos:163]Postula_a:11:=aProsNivelNum{$i}
	[ADT_Prospectos:163]Relacion_con_Contacto:10:=aProsRelacion{$i}
	[ADT_Prospectos:163]Sexo:7:=aProsSexo{$i}
	SAVE RECORD:C53([ADT_Prospectos:163])
	  //End if 
End for 
KRL_UnloadReadOnly (->[ADT_Prospectos:163])
[ADT_Contactos:95]Numero_de_Prospectos:17:=Size of array:C274(aProsApPaterno)