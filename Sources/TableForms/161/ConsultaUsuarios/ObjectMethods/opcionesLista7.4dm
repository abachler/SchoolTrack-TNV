  // MOD Ticket N° 192964 PA 20171115
If (Size of array:C274(SN3_AyNUsuarios)>0)
	$ref:=Create document:C266("";"TXT")
	If (ok=1)
		If (SYS_IsWindows )
			USE CHARACTER SET:C205("windows-1252";0)
		Else 
			USE CHARACTER SET:C205("MacRoman";0)
		End if 
		  //$line:=__ ("Tipo")+"\t"+__ ("Nombre")+"\t"+__ ("Nombre de Usuario")+"\t"+__ ("Contraseña")+"\r"
		$line:=__ ("Tipo")+"\t"+__ ("Apellidos y Nombres")+"\t"+__ ("Curso")+"\t"+__ ("Usuario")+"\t"+__ ("Contraseña")+"\t"+__ ("Último Acceso")+"\r"
		IO_SendPacket ($ref;$line)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Creando archivo con usuarios SchoolNet..."))
		For ($i;1;Size of array:C274(SN3_AyNUsuarios))
			  //$line:=SN3_TipoUsuario{$i}+"\t"+SN3_AyNUsuarios{$i}+"\t"+SN3_LoginUsuarios{$i}+"\t"+SN3_PasswordUsuarios{$i}+"\r"
			$line:=SN3_TipoUsuario{$i}+"\t"+SN3_AyNUsuarios{$i}+"\t"+SN3_CursosUsuarios{$i}+"\t"+SN3_LoginUsuarios{$i}+"\t"+SN3_PasswordUsuarios{$i}+"\t"+SN3_ultimo_ingreso{$i}+"\r"
			IO_SendPacket ($ref;$line)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(SN3_AyNUsuarios))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		CLOSE DOCUMENT:C267($ref)
		USE CHARACTER SET:C205(*;0)
		$r:=CD_Dlog (0;__ ("Archivo grabado con éxito.");__ ("");__ ("OK");__ ("Mostrar archivo"))
		If ($r=2)
			SHOW ON DISK:C922(document)
		End if 
	End if 
End if 