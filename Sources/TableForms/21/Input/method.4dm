Spell_CheckSpelling 


Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		QUERY:C277([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
		ORDER BY:C49([Profesores:4];[Profesores:4]Nombre_comun:21;>)
		SELECTION TO ARRAY:C260([Profesores:4]Nombre_comun:21;at_Profesores_Nombres;[Profesores:4]Numero:1;al_Profesores_ID)
		For ($i;Size of array:C274(at_Profesores_Nombres);1;-1)
			If (at_Profesores_Nombres{$i}="")
				DELETE FROM ARRAY:C228(at_Profesores_Nombres;$i)
				DELETE FROM ARRAY:C228(al_Profesores_ID;$i)
			End if 
		End for 
		If ([Alumnos_EventosOrientacion:21]Alumno_Numero:1=0)
			[Alumnos_EventosOrientacion:21]Registrada_por:8:=<>tUSR_CurrentUser
			[Alumnos_EventosOrientacion:21]Autor_Numero:10:=<>lUSR_RelatedTableUserID
			[Alumnos_EventosOrientacion:21]Alumno_Numero:1:=[Alumnos:2]numero:1
			[Alumnos_EventosOrientacion:21]Tipo_evento:11:="Entrevista"
			[Alumnos_EventosOrientacion:21]Fecha:2:=Current date:C33(*)
			vs_title1:="Asunto"
			_O_DISABLE BUTTON:C193(b_Guardar)
		End if 
		SET WINDOW TITLE:C213(__ ("Registro de ")+[Alumnos_EventosOrientacion:21]Tipo_evento:11+__ (" para ")+[Alumnos:2]apellidos_y_nombres:40)
		Case of 
			: ([Alumnos_EventosOrientacion:21]Tipo_evento:11="Test")
				vs_title1:=__ ("Test")
			Else 
				vs_title1:=__ ("Asunto")
		End case 
		If ([Alumnos_EventosOrientacion:21]Tipo_evento:11="Entrevista")
			OBJECT SET VISIBLE:C603(*;"Entrevista@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"Entrevista@";False:C215)
			OBJECT MOVE:C664(*;"moverh@";-244;0)
			OBJECT MOVE:C664(*;"mover@";0;-234)
		End if 
		If (Not:C34(USR_checkRights ("M";->[Alumnos_Orientacion:15])))
			OBJECT SET ENTERABLE:C238(*;"@";False:C215)
			_O_DISABLE BUTTON:C193(b_Eliminar)
			_O_DISABLE BUTTON:C193(b_OK)
			_O_DISABLE BUTTON:C193(<>popIntloc)
			_O_DISABLE BUTTON:C193(<>popIntloc2)
			_O_DISABLE BUTTON:C193(<>aPsyEvents)
			_O_DISABLE BUTTON:C193(b_RegistradoPor)
		Else 
			OBJECT SET ENTERABLE:C238(*;"@";True:C214)
			_O_ENABLE BUTTON:C192(b_Eliminar)
			_O_ENABLE BUTTON:C192(b_OK)
			_O_ENABLE BUTTON:C192(<>popIntloc)
			_O_ENABLE BUTTON:C192(<>popIntloc2)
			_O_ENABLE BUTTON:C192(<>aPsyEvents)
			_O_ENABLE BUTTON:C192(b_RegistradoPor)
		End if 
		OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevista_solicitada_por:4;False:C215)
		OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevistado:7;False:C215)
		OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevistado_2:17;False:C215)
		OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevistado_3:18;False:C215)
		OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevistado_4:19;False:C215)
		OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Entrevistado_5:20;False:C215)
		OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Asiste_Inter1:12;([Alumnos_EventosOrientacion:21]Entrevistado:7#""))
		OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Asiste_Inter2:13;([Alumnos_EventosOrientacion:21]Entrevistado_2:17#""))
		OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Asiste_Inter3:14;([Alumnos_EventosOrientacion:21]Entrevistado_3:18#""))
		OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Asiste_Inter4:15;([Alumnos_EventosOrientacion:21]Entrevistado_4:19#""))
		OBJECT SET ENTERABLE:C238([Alumnos_EventosOrientacion:21]Asiste_Inter5:16;([Alumnos_EventosOrientacion:21]Entrevistado_5:20#""))
		vtST_OldTipoEvento:=[Alumnos_EventosOrientacion:21]Tipo_evento:11
		GOTO OBJECT:C206([Alumnos_EventosOrientacion:21]Fecha:2)
		OBJECT SET ENTERABLE:C238([Alumnos:2]Fotografía:78;False:C215)
		OBJECT SET ENTERABLE:C238([Alumnos:2]apellidos_y_nombres:40;False:C215)
		OBJECT SET ENTERABLE:C238(vs_title1;False:C215)
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		Case of 
			: ([Alumnos_EventosOrientacion:21]Tipo_evento:11="Test")
				vs_title1:=__ ("Test")
			Else 
				vs_title1:=__ ("Asunto")
		End case 
		GET WINDOW RECT:C443($left;$top;$right;$bottom)
		$width:=$right-$left
		$height:=$bottom-$top
		If ([Alumnos_EventosOrientacion:21]Tipo_evento:11="Entrevista")
			OBJECT SET VISIBLE:C603(*;"Entrevista@";True:C214)
			If ([Alumnos_EventosOrientacion:21]Tipo_evento:11#vtST_OldTipoEvento)
				OBJECT MOVE:C664(*;"moverh@";244;0)
				OBJECT MOVE:C664(*;"mover@";0;234)
				$width:=789
				$height:=489
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*;"Entrevista@";False:C215)
			If (vtST_OldTipoEvento="Entrevista")
				OBJECT MOVE:C664(*;"moverh@";-244;0)
				OBJECT MOVE:C664(*;"mover@";0;-234)
				$width:=545
				$height:=255
			End if 
		End if 
		GET WINDOW RECT:C443($left;$top;$right;$bottom)
		$add2Right:=0
		$substract2Left:=0
		$substract2Top:=0
		$newLeft:=($left-$width+$right)/2
		$newTop:=$top
		$newRight:=($left+$width+$right)/2
		$newBottom:=$height+$top
		If ($newLeft<=0)
			$add2Right:=Abs:C99($newLeft)+3
			$newLeft:=3
			$newRight:=$newRight+$add2Right
		End if 
		If ($newRight>=Screen width:C187)
			$substract2Left:=$newRight-Screen width:C187+3
			$newRight:=Screen width:C187-3
			$newLeft:=$newLeft-$substract2Left
		End if 
		If ($newBottom>=Screen height:C188)
			$substract2Top:=$newBottom-Screen height:C188+3
			$newBottom:=Screen height:C188-3
			$newTop:=$newTop-$substract2Top
		End if 
		SET WINDOW RECT:C444($newLeft;$newTop;$newRight;$newBottom)
		vtST_OldTipoEvento:=[Alumnos_EventosOrientacion:21]Tipo_evento:11
		If (([Alumnos_EventosOrientacion:21]Asunto:3#"") & ([Alumnos_EventosOrientacion:21]Fecha:2#!00-00-00!))
			_O_ENABLE BUTTON:C192(b_Guardar)
		Else 
			_O_DISABLE BUTTON:C193(b_Guardar)
		End if 
	: (Form event:C388=On Close Box:K2:21)
		If (KRL_RegistroFueModificado (->[Alumnos_EventosOrientacion:21]))
			$r:=CD_Dlog (0;__ ("¿Desea guardar los cambios?");__ ("");__ ("Si");__ ("No");__ ("Cancelar"))
			If ($r=1)
				If (([Alumnos_EventosOrientacion:21]Asunto:3#"") & ([Alumnos_EventosOrientacion:21]Fecha:2#!00-00-00!))
					KRL_SaveRecord (->[Alumnos_EventosOrientacion:21])
					CANCEL:C270
				Else 
					CD_Dlog (0;__ ("Para poder guardar este registro es necesario que ingrese como mínimo una fecha y un asunto."))
				End if 
			Else 
				If ($r=2)
					CANCEL:C270
				End if 
			End if 
		Else 
			CANCEL:C270
		End if 
End case 
