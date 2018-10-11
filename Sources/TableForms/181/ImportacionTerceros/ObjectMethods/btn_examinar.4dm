EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")
$ref:=Open document:C264("";"TEXT")
EM_ErrorManager ("Clear")
If (ok=1)
	vt_ruta:=document
Else 
	vt_ruta:=""
	CD_Dlog (0;"El documento está abierto.")
End if 
CLOSE DOCUMENT:C267($ref)
  //vt_ruta:=xfGetFileName (__ ("Seleccione el archivo");"TEXT";True)