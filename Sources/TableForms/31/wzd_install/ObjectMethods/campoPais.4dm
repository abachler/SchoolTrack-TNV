  // [Colegio].wzd_install.campoPais()
  // Por: Alberto Bachler K.: 09-10-14, 20:00:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



$l_paisSeleccionado:=Selected list items:C379(hl_pais)
If ($l_paisSeleccionado>0)
	GET LIST ITEM:C378(hl_pais;$l_paisSeleccionado;$l_indicePais;$t_Pais)
	[Colegio:31]Codigo_Pais:31:=Substring:C12($t_Pais;1;2)
	[Colegio:31]Pais:21:=Substring:C12($t_Pais;5)
	<>vtXS_CountryCode:=[Colegio:31]Codigo_Pais:31
	<>vtXS_langage:="es"
	
	Case of 
		: (<>vtXS_CountryCode="cl")
			OBJECT SET TITLE:C194(*;"colegio_IdColegio";"Rol Base de Datos:")
			OBJECT SET TITLE:C194(*;"colegio_IdInstitucion";"RUT:")
			OBJECT SET FORMAT:C236([Colegio:31]RUT:2;"###.###.###-#")
			OBJECT SET FILTER:C235([Colegio:31]RUT:2;"~"+Char:C90(Double quote:K15:41)+"k;K;0-9;.;-"+Char:C90(Double quote:K15:41))
		Else 
			Case of 
				: (<>vtXS_CountryCode="mx")
					OBJECT SET TITLE:C194(*;"colegio_IdInstitucion";"ID Institución:")
					OBJECT SET TITLE:C194(*;"colegio_IdColegio";"Clave Centro de Trabajo:")
				: (<>vtXS_CountryCode="ar")
					OBJECT SET TITLE:C194(*;"colegio_IdInstitucion";"ID Institución:")
					OBJECT SET TITLE:C194(*;"colegio_IdColegio";"CUE:")
				Else 
					OBJECT SET TITLE:C194(*;"colegio_IdInstitucion";"ID Institución:")
					OBJECT SET TITLE:C194(*;"colegio_IdColegio";"ID Escuela:")
			End case 
			OBJECT SET FORMAT:C236([Colegio:31]RUT:2;"")
			OBJECT SET FILTER:C235([Colegio:31]RUT:2;"")
	End case 
	
	
	If ([Colegio:31]Codigo_Pais:31="cl")
		[Colegio:31]Moneda:49:="Peso Chileno;$"
	Else 
		[Colegio:31]Moneda:49:=ACT_DivisaPais 
	End if 
	ACTutl_GetDecimalFormat 
	[Colegio:31]Numero_Decimales:53:=<>vlACT_Decimales
	
End if 


