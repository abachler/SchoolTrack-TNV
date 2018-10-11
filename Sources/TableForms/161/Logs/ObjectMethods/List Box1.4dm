C_LONGINT:C283($x;$y)
Case of 
	: (Form event:C388=On Header Click:K2:40)
		If (Contextual click:C713)
			$go:=((cb_Log_VerErrores=1) | (cb_Log_VerInfo=1) | (cb_Log_VerGeneracion=1) | (cb_Log_VerEnvios=1))
			If ($go)
				COPY ARRAY:C226(SN3_Log_Fecha_Menu;$SN3_Log_Fecha)
				AT_DistinctsArrayValues (->$SN3_Log_Fecha)
				$text:="Todos;(-;"
				For ($i;1;Size of array:C274($SN3_Log_Fecha))
					$date:=$SN3_Log_Fecha{$i}
					$dateStr:=Replace string:C233(Replace string:C233(String:C10($date;Internal date short:K1:7);"/";" ");"-";" ")
					$text:=$text+$dateStr+";"
				End for 
				$choice:=Pop up menu:C542($text)
				If ($choice>0)
					If ($choice=1)
						vd_Log_SelectedFecha:=!00-00-00!
					Else 
						$date:=$SN3_Log_Fecha{$choice-2}
						vd_Log_SelectedFecha:=$date
					End if 
					If (r_ST=1)
						SN3_Log_LoadST (vd_Log_SelectedFecha;cb_Log_VerErrores;cb_Log_VerInfo;cb_Log_VerGeneracion;cb_Log_VerEnvios)
					Else 
						SN3_Log_LoadSN (vd_Log_SelectedFecha;cb_Log_VerErrores;cb_Log_VerInfo;cb_Log_VerGeneracion;cb_Log_VerEnvios)
					End if 
				End if 
			End if 
		End if 
	: (Form event:C388=On Mouse Move:K2:35)
		vLastLinea:=-1
		  //20150908 ASM comento código solo para pruebas
		  //If (r_ST=1)
		  //GET MOUSE($x;$y;$button)
		  //$height:=LISTBOX Get rows height(Self->)
		  //OBJECT GET COORDINATES(Self->;$l;$t;$r;$b)
		  //$headerHeight:=LISTBOX Get information(Self->;Listbox header height)
		  //If (($x>=$l) & ($x<=$r))
		  //If (($y>=($t+$headerHeight)) & ($y<=$b))
		  //$origin:=$t+$headerHeight
		  //$realY:=$y-$origin
		  //$realLinea:=$realY/$height
		  //$linea:=Int($realY/$height)+1
		  //If ($linea#vLastLinea)
		  //vLastLinea:=$linea
		  //If (($linea>0) & ($linea<=Size of array(SN3_Log_Fecha)))
		  //If ((SN3_Log_Tipo{$linea}=SN3_Log_Error) & (SN3_Log_DescError{$linea}#""))
		  //$l2:=$l+1
		  //$t2:=$origin+(($linea-1)*$height)
		  //$l3:=$r-1
		  //$t3:=$t2+$height
		  //$tip:=SN3_Log_DescError{$linea}+"\r"+"Máquina: "+SN3_Log_Maquina{$linea}
		  //API Create Tip ($tip;$l2;$t2;$l3;$t3)
		  //End if 
		  //End if 
		  //End if 
		  //Else 
		  //vLastLinea:=-1
		  //End if 
		  //Else 
		  //vLastLinea:=-1
		  //End if 
		  //End if 
	: (Form event:C388=On Mouse Leave:K2:34)
		vLastLinea:=-1
	: (Form event:C388=On Double Clicked:K2:5)
		If (SN3_Log_Descripcion>0)
			IT_ShowScrollableText (SN3_Log_Descripcion{SN3_Log_Descripcion};__ ("Detalle Evento"))
		End if 
End case 