//%attributes = {}
  // BBLci_ModosDeBusqueda()
  // Por: Alberto Bachler: 30/09/13, 17:36:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_registros)
C_POINTER:C301($y_nil)

ARRAY LONGINT:C221(al_RefModoBusqueda_BBLci;0)
ARRAY TEXT:C222(at_TipoBusqueda_BBLci;0)
ARRAY TEXT:C222(at_nombreCampo_BBLci;0)
ARRAY POINTER:C280(ay_Campo_BBLci;0)

APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;Barcode_Lector)
APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"L")
APPEND TO ARRAY:C911(at_nombreCampo_BBLci;__ ("Código de barra"))
APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Lectores:72]BarCode_SinFormato:38)

APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;NombreLector)
APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"L")
APPEND TO ARRAY:C911(at_nombreCampo_BBLci;__ ("Nombres o apellidos del lector"))
APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Lectores:72]NombreCompleto:3)

  // determino cuales identificadores nacionales son relevantes para las búsquedas
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
SET QUERY LIMIT:C395(1)

QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]RUT:7#"")
If ($l_registros>0)
	APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;IdentificadorNacional1)
	APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"L")
	APPEND TO ARRAY:C911(at_nombreCampo_BBLci;<>at_IDNacional_Names{1})
	APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Lectores:72]RUT:7)
End if 

QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]IDNacional_2:33#"")
If ($l_registros>0)
	APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;IdentificadorNacional2)
	APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"L")
	APPEND TO ARRAY:C911(at_nombreCampo_BBLci;<>at_IDNacional_Names{2})
	APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Lectores:72]IDNacional_2:33)
End if 

QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]IDNacional_3:34#"")
If ($l_registros>0)
	APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;IdentificadorNacional3)
	APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"")
	APPEND TO ARRAY:C911(at_nombreCampo_BBLci;<>at_IDNacional_Names{3})
	APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Lectores:72]IDNacional_3:34)
End if 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)

APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;IdInternoLector)
APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"L")
APPEND TO ARRAY:C911(at_nombreCampo_BBLci;__ ("ID interno del lector"))
APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Lectores:72]ID:1)

APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;Barcode_Documento)
APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"R")
APPEND TO ARRAY:C911(at_nombreCampo_BBLci;__ ("Código de barra"))
APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Registros:66]Barcode_SinFormato:26)

APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;NumeroRegistro)
APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"R")
APPEND TO ARRAY:C911(at_nombreCampo_BBLci;__ ("Número de registro"))
APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Registros:66]No_Registro:25)

APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;IdRegistro)
APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"R")
APPEND TO ARRAY:C911(at_nombreCampo_BBLci;__ ("ID interno del documento"))
APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Registros:66]ID:3)

APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;MultiCriterio_Item)
APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"I")
APPEND TO ARRAY:C911(at_nombreCampo_BBLci;__ ("Titulo, autor o materia"))
APPEND TO ARRAY:C911(ay_Campo_BBLci;->$y_nil)

APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;TituloItem)
APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"I")
APPEND TO ARRAY:C911(at_nombreCampo_BBLci;__ ("Titulo"))
APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Items:61]Titulos:5)

APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;AutorItem)
APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"I")
APPEND TO ARRAY:C911(at_nombreCampo_BBLci;__ ("Autor"))
APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Items:61]Autores:7)

APPEND TO ARRAY:C911(al_RefModoBusqueda_BBLci;Materias)
APPEND TO ARRAY:C911(at_TipoBusqueda_BBLci;"I")
APPEND TO ARRAY:C911(at_nombreCampo_BBLci;__ ("Materia"))
APPEND TO ARRAY:C911(ay_Campo_BBLci;->[BBL_Items:61]Materias_json:53)


AT_MultiLevelSort (">>";->at_TipoBusqueda_BBLci;->al_RefModoBusqueda_BBLci;->at_nombreCampo_BBLci;->ay_Campo_BBLci)
