//%attributes = {}
  //CTRY_DefaultNationality

  //`xShell, Alberto Bachler
  //Metodo: CTRY_DefaultNationality
  //Por abachler
  //Creada el 03/02/2004, 18:37:07
  //Modificaciones:
If ("DESCRIPCION"="")
	  //retorna la nacionalidad por omisión en función del país de registro y del lenguaje seleccionado
	  //en esta version solo está implementado para español (otros lenguajes retornan la nacionalidad en español)
	  //esta versión solo considera los países de América (tal  vez falta alguno)
End if 

  //****DECLARACIONES****
C_TEXT:C284($0;$nationality)

  //****INICIALIZACIONES****


  //****CUERPO****


Case of 
	: ((<>gPais="Chile") | (<>gPais=""))
		$nationality:="Chilena"
		
	: (<>gPais="Argentina")
		$nationality:="Argentina"
		
	: (<>gPais="Bolivia")
		$nationality:="Boliviana"
		
	: (<>gPais="Paraguay")
		$nationality:="Paraguaya"
		
	: (<>gPais="Uruguay")
		$nationality:="Uruguaya"
		
	: (<>gPais="Brasil")
		$nationality:="Brasileña"
		
	: (<>gPais="Perú")
		$nationality:="Peruana"
		
	: (<>gPais="Ecuador")
		$nationality:="Ecuatoriana"
		
	: (<>gPais="Colombia")
		$nationality:="Colombiana"
		
	: (<>gPais="Venezuela")
		$nationality:="Venezolana"
		
	: (<>gPais="Panamá")
		$nationality:="Panameña"
		
	: (<>gPais="Haiti")
		$nationality:="Haitiana"
		
	: (<>gPais="Republica Dominicana")
		$nationality:="Dominicana"
		
	: (<>gPais="El Salvador")
		$nationality:="Salvadoreña"
		
	: (<>gPais="Guatemala")
		$nationality:="Guatemalteca"
		
	: (<>gPais="Cuba")
		$nationality:="Cubana"
		
	: (<>gPais="Mexico")
		$nationality:="Mexicana"
		
	: (<>gPais="Puerto Rico")
		$nationality:="Portoriqueña"
		
	: (<>gPais="USA")
		$nationality:="Estadounidense"
		
	: (<>gPais="Canadá")
		$nationality:="Canadiense"
End case 
  //End case 

$0:=$nationality
  //****LIMPIEZA****


