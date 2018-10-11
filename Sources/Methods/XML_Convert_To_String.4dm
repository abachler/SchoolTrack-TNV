//%attributes = {}
  //XML_Convert_To_String

  // ----------------------------------------------------
  // Nombre usuario (OS): DARTAGAN1
  // Fecha y hora: 06-07-06, 11:01:29
  // ----------------------------------------------------
  // Método: XML_DataTypeTable
  // Descripción
  // This method is a table of conversion for different kind of  var types,
  // the method converts the content to text or remains the content if a var is text, string or alpha field.
  //
  // Parámetros
  //$1 = Received Data in the function
  // ----------------------------------------------------

C_POINTER:C301($1;$vy_TypeOfVarReceived)
$vy_TypeOfVarReceived:=$1

C_LONGINT:C283($vl_TypeOfVar)
C_POINTER:C301($vy_TypeOfVarReceived)
C_TEXT:C284($vt_ItemConversion)

C_TEXT:C284($0;$vt_SchemaXML)

  //Conversion Table
$vl_TypeOfVar:=Type:C295($vy_TypeOfVarReceived->)
Case of 
	: ($vl_TypeOfVar=Is alpha field:K8:1)
		$vt_ItemConversion:=$vy_TypeOfVarReceived->
	: ($vl_TypeOfVar=Is string var:K8:2)
		$vt_ItemConversion:=$vy_TypeOfVarReceived->
	: ($vl_TypeOfVar=Is text:K8:3)
		$vt_ItemConversion:=$vy_TypeOfVarReceived->
	: ($vl_TypeOfVar=Is real:K8:4)
		$vt_ItemConversion:=String:C10($vy_TypeOfVarReceived->)
	: ($vl_TypeOfVar=Is integer:K8:5)
		$vt_ItemConversion:=String:C10($vy_TypeOfVarReceived->)
	: ($vl_TypeOfVar=Is longint:K8:6)
		$vt_ItemConversion:=String:C10($vy_TypeOfVarReceived->)
	: ($vl_TypeOfVar=Is date:K8:7)
		  // //Generar fecha en texto tippo mes dia año
		$vt_Dia:=Day of:C23($vy_TypeOfVarReceived->)  //Dia
		$vt_Mes:=Month of:C24($vy_TypeOfVarReceived->)  //Mes
		$vt_Ano:=Year of:C25($vy_TypeOfVarReceived->)  //Año
		  // //Generar fecha en texto tippo mes dia año End
		
		$vt_ItemConversion:=String:C10($vt_Dia)+"/"+String:C10($vt_Mes)+"/"+String:C10($vt_Ano)
		
	: ($vl_TypeOfVar=Is time:K8:8)
		$vt_ItemConversion:=String:C10($vy_TypeOfVarReceived->)
	: ($vl_TypeOfVar=Is boolean:K8:9)
		Case of 
			: ($vy_TypeOfVarReceived->=True:C214)
				$vt_ItemConversion:="True"
			: ($vy_TypeOfVarReceived->=False:C215)
				$vt_ItemConversion:="False"
		End case 
	: ($vl_TypeOfVar=Is picture:K8:10)
		$vt_ItemConversion:="Is a Picture"
	: ($vl_TypeOfVar=Is subtable:K8:11)
		$vt_ItemConversion:="Is a SubTable"
	: ($vl_TypeOfVar=Is BLOB:K8:12)
		$vt_ItemConversion:="Is a Blob"
	: ($vl_TypeOfVar=Is undefined:K8:13)
		$vt_ItemConversion:="Is Undefined"
	: ($vl_TypeOfVar=Is pointer:K8:14)
		$vt_ItemConversion:="Is Pointer"
	: ($vl_TypeOfVar=String array:K8:15)
		$vt_ItemConversion:="Is a String Array"
	: ($vl_TypeOfVar=Text array:K8:16)
		$vt_ItemConversion:="Is a Text Array"
	: ($vl_TypeOfVar=Real array:K8:17)
		$vt_ItemConversion:="Is a Real Array"
	: ($vl_TypeOfVar=Integer array:K8:18)
		$vt_ItemConversion:="Is a Integer Array"
	: ($vl_TypeOfVar=LongInt array:K8:19)
		$vt_ItemConversion:="Is a Longint Array"
	: ($vl_TypeOfVar=Date array:K8:20)
		$vt_ItemConversion:="Is a Date Array"
	: ($vl_TypeOfVar=Boolean array:K8:21)
		$vt_ItemConversion:="Is a Boolean Array"
	: ($vl_TypeOfVar=Picture array:K8:22)
		$vt_ItemConversion:="Is a Picture Array"
	: ($vl_TypeOfVar=Pointer array:K8:23)
		$vt_ItemConversion:="Is a Pointer Array"
	: ($vl_TypeOfVar=Array 2D:K8:24)
		$vt_ItemConversion:="Is a String Array"
		
End case 


$0:=$vt_ItemConversion



  //========================For Help=====================
  //is Alpha Field	Long Integer	  0
  //Is String Var	Long Integer	 24
  //Is Text	Long Integer	  2
  //Is Real	Long Integer	  1
  //Is Integer	Long Integer	  8
  //Is LongInt	Long Integer	  9
  //Is Date	Long Integer	  4
  //Is Time	Long Integer	 11
  //Is Boolean	Long Integer	  6
  //Is Picture	Long Integer	  3
  //Is Subtable	Long Integer	  7
  //Is BLOB	Long Integer	 30
  //Is Undefined	Long Integer	  5
  //Is Pointer	Long Integer	 23
  //String array	Long Integer	 21
  //Text array	Long Integer	 18
  //Real array	Long Integer	 14
  //Integer array	Long Integer	 15
  //LongInt array	Long Integer	 16
  //Date array	Long Integer	 17
  //Boolean array	Long Integer	 22
  //Picture array	Long Integer	 19
  //Pointer array	Long Integer	 20
  //Array 2D	Long Integer	 13


