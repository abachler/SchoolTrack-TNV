If (Self:C308->)
	ARRAY TEXT:C222($atACT_nombreT;0)
	ARRAY LONGINT:C221($alACT_idT;0)
	C_LONGINT:C283($l_idTercero)
	
	$l_idTercero:=[ACT_Terceros:138]Id:1
	
	Begin SQL
		select Nombre_Completo, id
		from ACT_Terceros
		where Es_publico_general=true AND
		id <> :$l_idTercero
		order by 1 ASC
		into :$atACT_nombreT, :$alACT_idT
	End SQL
	
	If (Size of array:C274($atACT_nombreT)>0)
		CD_Dlog (0;"El Tercero "+ST_Qte ($atACT_nombreT{1})+" (id: "+String:C10($alACT_idT{1})+")"+" ya está marcado como público general. Quite dicha condición antes de marcar a este Tercero.")
		Self:C308->:=False:C215
	Else 
		
		[ACT_Terceros:138]ReceptorDT_tipo:76:=0
		[ACT_Terceros:138]ReceptorDT_id_apoderado:78:=0
		[ACT_Terceros:138]ReceptorDT_id_tercero:77:=0
		
	End if 
	
	ACTter_fSave 
	
End if 