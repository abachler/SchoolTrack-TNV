//%attributes = {}
  //ACTiecv_cEstandar
  //metodo que maneja el codigo que se utiliza para llenar los arreglos de la IEC para modelo estandar
C_TEXT:C284(vt_rutaArchivo;$1)



ACTdte_OpcionesGeneralesIE ("DeclaraArreglosIEV")
If (ACTdte_CargaArchivoIE ("IEC";vt_rutaArchivo))
	COPY ARRAY:C226(aQR_Text1;atACTie_COLUMNA1)
	COPY ARRAY:C226(aQR_Text2;atACTie_COLUMNA2)
	COPY ARRAY:C226(aQR_Text3;atACTie_COLUMNA3)
	COPY ARRAY:C226(aQR_Text4;atACTie_COLUMNA4)
	COPY ARRAY:C226(aQR_Text5;atACTie_COLUMNA5)
	COPY ARRAY:C226(aQR_Text6;atACTie_COLUMNA6)
	COPY ARRAY:C226(aQR_Text7;atACTie_COLUMNA7)
	COPY ARRAY:C226(aQR_Text8;atACTie_COLUMNA8)
	COPY ARRAY:C226(aQR_Text9;atACTie_COLUMNA9)
	COPY ARRAY:C226(aQR_Text10;atACTie_COLUMNA10)
	COPY ARRAY:C226(aQR_Text11;atACTie_COLUMNA11)
	COPY ARRAY:C226(aQR_Text12;atACTie_COLUMNA12)
	COPY ARRAY:C226(aQR_Text13;atACTie_COLUMNA13)
	COPY ARRAY:C226(aQR_Text14;atACTie_COLUMNA14)
	COPY ARRAY:C226(aQR_Text15;atACTie_COLUMNA15)
	COPY ARRAY:C226(aQR_Text16;atACTie_COLUMNA16)
	COPY ARRAY:C226(aQR_Text17;atACTie_COLUMNA17)
	COPY ARRAY:C226(aQR_Text18;atACTie_COLUMNA18)
	COPY ARRAY:C226(aQR_Text19;atACTie_COLUMNA19)
	COPY ARRAY:C226(aQR_Text20;atACTie_COLUMNA20)
	COPY ARRAY:C226(aQR_Text21;atACTie_COLUMNA21)
	COPY ARRAY:C226(aQR_Text22;atACTie_COLUMNA22)
	COPY ARRAY:C226(aQR_Text23;atACTie_COLUMNA23)
	COPY ARRAY:C226(aQR_Text24;atACTie_COLUMNA24)
	COPY ARRAY:C226(aQR_Text25;atACTie_COLUMNA25)
	COPY ARRAY:C226(aQR_Text26;atACTie_COLUMNA26)
	COPY ARRAY:C226(aQR_Text27;atACTie_COLUMNA27)
	COPY ARRAY:C226(aQR_Text28;atACTie_COLUMNA28)
	COPY ARRAY:C226(aQR_Text29;atACTie_COLUMNA29)
	COPY ARRAY:C226(aQR_Text30;atACTie_COLUMNA30)
	COPY ARRAY:C226(aQR_Text31;atACTie_COLUMNA31)
	COPY ARRAY:C226(aQR_Text32;atACTie_COLUMNA32)
	COPY ARRAY:C226(aQR_Text33;atACTie_COLUMNA33)
	COPY ARRAY:C226(aQR_Text34;atACTie_COLUMNA34)
	AT_RedimArrays (Size of array:C274(atACTie_COLUMNA1);->atACTie_COLUMNA2;->atACTie_COLUMNA3;->atACTie_COLUMNA4;->atACTie_COLUMNA5;->atACTie_COLUMNA6;->atACTie_COLUMNA7;->atACTie_COLUMNA8;->atACTie_COLUMNA9;->atACTie_COLUMNA10;->atACTie_COLUMNA11;->atACTie_COLUMNA12;->atACTie_COLUMNA13;->atACTie_COLUMNA14;->atACTie_COLUMNA15;->atACTie_COLUMNA16;->atACTie_COLUMNA17;->atACTie_COLUMNA18;->atACTie_COLUMNA19;->atACTie_COLUMNA20;->atACTie_COLUMNA21;->atACTie_COLUMNA22;->atACTie_COLUMNA23;->atACTie_COLUMNA24;->atACTie_COLUMNA25;->atACTie_COLUMNA26;->atACTie_COLUMNA27;->atACTie_COLUMNA28;->atACTie_COLUMNA29;->atACTie_COLUMNA30;->atACTie_COLUMNA31;->atACTie_COLUMNA32;->atACTie_COLUMNA33;->atACTie_COLUMNA34)
End if 