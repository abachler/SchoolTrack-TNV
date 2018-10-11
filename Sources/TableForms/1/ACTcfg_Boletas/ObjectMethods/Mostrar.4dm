$t_EtiquetaBoton:=OBJECT Get title:C1068(Self:C308->)

Case of 
	: ($t_EtiquetaBoton="Mostrar")
		OBJECT SET FONT:C164(vtACT_passLLavePrivada;0)
		OBJECT SET TITLE:C194(Self:C308->;"Ocultar")
		OBJECT SET ENTERABLE:C238(vtACT_passLLavePrivada;True:C214)
		
	: ($t_EtiquetaBoton="Ocultar")
		OBJECT SET FONT:C164(vtACT_passLLavePrivada;102)
		OBJECT SET TITLE:C194(Self:C308->;"Mostrar")
		OBJECT SET ENTERABLE:C238(vtACT_passLLavePrivada;False:C215)
End case 