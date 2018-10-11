  // Método: Método de Objeto: SR_SectionProperties.HL_sectionProperties
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 25/12/10, 11:10:31
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

GET LIST ITEM:C378(Self:C308->;*;$page;$text)

If ($page=1)
	GET WINDOW RECT:C443($left;$top;$right;$bottom)
	SET WINDOW RECT:C444($left;$top;$left+650-1;$top+472-1)
End if 


