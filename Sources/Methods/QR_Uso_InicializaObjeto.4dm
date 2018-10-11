//%attributes = {}
  // Método: QR_UsoInforme_InicializaObjeto
  //
  //
  // por Alberto Bachler Klein
  // creación 13/01/18, 12:00:40
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_OBJECT:C1216($o_global;$o_local)


If (Not:C34(OB Is defined:C1231([xShell_Reports:54]uso:50)))
	OB SET:C1220($o_global;"total";0)
	OB SET:C1220($o_global;"ultimaImpresion";!00-00-00!)
	OB SET:C1220($o_global;"01";0)
	OB SET:C1220($o_global;"02";0)
	OB SET:C1220($o_global;"03";0)
	OB SET:C1220($o_global;"04";0)
	OB SET:C1220($o_global;"05";0)
	OB SET:C1220($o_global;"06";0)
	OB SET:C1220($o_global;"07";0)
	OB SET:C1220($o_global;"08";0)
	OB SET:C1220($o_global;"09";0)
	OB SET:C1220($o_global;"10";0)
	OB SET:C1220($o_global;"11";0)
	OB SET:C1220($o_global;"12";0)
	$o_local:=OB Copy:C1225($o_global)
	OB SET:C1220([xShell_Reports:54]uso:50;"usoGlobal";$o_global)
	OB SET:C1220([xShell_Reports:54]uso:50;"usoLocal";$o_local)
End if 

