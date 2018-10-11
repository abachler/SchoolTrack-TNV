//%attributes = {}
  // Actas_ImpresionOficio_v14()
  // Por: Alberto Bachler K.: 03-05-14, 18:48:56
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
If (Form event:C388=On Printing Detail:K2:18)
	Case of 
		: ([Cursos:3]cl_RolBaseDatos:20#"")
			$rol:=Substring:C12([Cursos:3]cl_RolBaseDatos:20;1;Length:C16([Cursos:3]cl_RolBaseDatos:20)-1)+"-"+[Cursos:3]cl_RolBaseDatos:20[[Length:C16([Cursos:3]cl_RolBaseDatos:20)]]
		: ([Cursos:3]cl_RolBaseDatos:20="")
			$rol:=Substring:C12(<>gRolBD;1;Length:C16(<>gRolBD)-1)+"-"+<>gRolBD[[Length:C16(<>gRolBD)]]
	End case 
	vt_menciones:=Replace string:C233(vt_menciones;"<RDB>";"Rol Base de Datos "+$rol)
	vt_menciones:=Replace string:C233(vt_menciones;"<RBD>";"Rol Base de Datos "+$rol)
	
	
	If ([Cursos:3]Nivel_Numero:7>=11)
		If ([Cursos:3]cl_CodigoEspecialidadTP:29>0)
			vs_SectorEspecialidad:="Sector Eco.: "+[Cursos:3]cl_SectorEconomicoTP:27+"\rEspecialidad: "+[Cursos:3]cl_EspecialidadTP:28
		Else 
			vs_SectorEspecialidad:=""
		End if 
	End if 
	
	
	If (vb_Error)
		OBJECT SET VISIBLE:C603(*;"header";False:C215)
		OBJECT SET VISIBLE:C603(*;"error";True:C214)
		For ($i;1;Size of array:C274(aC0))
			If (Find in array:C230(aText5;aC0{$i})>0)
				PL_SetRowStyle (pl_acta;$i;2;"";vi_FontSize-1)
			End if 
		End for 
	Else 
		OBJECT SET VISIBLE:C603(*;"header";True:C214)
		OBJECT SET VISIBLE:C603(*;"error";False:C215)
	End if 
	
	If (vi_PEStart>0)
		vPTextoPC:=vs_PCtext
		vPTextoPE:=vs_PEtext
		OBJECT MOVE:C664(*;"vPTextoPC";leftmarge+4+106;78;leftmarge+4+106+PCwidth+1;92;*)
		OBJECT MOVE:C664(*;"vPTextoPE";leftmarge+4+106+PCwidth;78;leftmarge+4+106+PCwidth+1+PEwidth;92;*)
		OBJECT MOVE:C664(*;"BorderTPC";leftmarge+4+106;78;leftmarge+4+106+PCwidth+1;92;*)
		OBJECT MOVE:C664(*;"BorderTPE";leftmarge+4+106+PCwidth;78;leftmarge+4+106+PCwidth+1+PEwidth;92;*)
	End if 
	
	PICTURE PROPERTIES:C457(vPImagen1;$width;$height)
	ARRAY LONGINT:C221($widths;7)
	$widths{1}:=iNo
	$widths{2}:=iNames
	$widths{3}:=iRUT
	$widths{4}:=obswidth
	$widths{5}:=iSex
	$widths{6}:=iBirthDate
	$widths{7}:=iComuna
	
	$height:=$height+4
	OBJECT MOVE:C664(*;"vPTexto1";110;91;112;91;*)
	OBJECT MOVE:C664(*;"vPTexto1";0;0;$widths{1}-1;$height)
	OBJECT MOVE:C664(*;"BorderT1";110;91;112;91;*)
	OBJECT MOVE:C664(*;"BorderT1";0;0;$widths{1}-1;$height)
	OBJECT GET COORDINATES:C663(*;"vPTexto1";$l;$t;$r;$b)
	
	For ($i;2;7)
		If ($i#4)
			If (Application version:C493<"1400")
				OBJECT MOVE:C664(*;"vPTexto"+String:C10($i);$r-1;$t;$r+1;$t;*)
				OBJECT MOVE:C664(*;"vPTexto"+String:C10($i);0;0;$widths{$i}-1;$height)
				OBJECT MOVE:C664(*;"BorderT"+String:C10($i);$r-1;$t;$r+1;$t;*)
				OBJECT MOVE:C664(*;"BorderT"+String:C10($i);0;0;$widths{$i}-1;$height)
			Else 
				OBJECT MOVE:C664(*;"vPTexto"+String:C10($i);$r-1;$t;$r+1;$t;*)
				OBJECT MOVE:C664(*;"vPTexto"+String:C10($i);0;0;$widths{$i}-1;$height)
				OBJECT MOVE:C664(*;"BorderT"+String:C10($i);$r-1;$t;$r+1;$t;*)
				OBJECT MOVE:C664(*;"BorderT"+String:C10($i);0;0;$widths{$i}-1;$height)
			End if 
			OBJECT GET COORDINATES:C663(*;"vPTexto"+String:C10($i);$l;$t;$r;$b)
		End if 
	End for 
	For ($i;1;vi_columns)
		OBJECT MOVE:C664(*;"vPImagen"+String:C10($i);$r-1;$t;$r+1;$t;*)
		OBJECT MOVE:C664(*;"vPImagen"+String:C10($i);0;0;colwidth-1;$height)
		OBJECT MOVE:C664(*;"Border"+String:C10($i);$r-1;$t;$r+1;$t;*)
		OBJECT MOVE:C664(*;"Border"+String:C10($i);0;0;colwidth-1;$height)
		OBJECT GET COORDINATES:C663(*;"vPImagen"+String:C10($i);$l;$t;$r;$b)
	End for 
	OBJECT MOVE:C664(*;"vPTexto4";$r-1;$t;$r+1;$t;*)
	OBJECT MOVE:C664(*;"vPTexto4";0;0;$widths{4}-2;$height)
	OBJECT MOVE:C664(*;"BorderT4";$r-1;$t;$r+1;$t;*)
	OBJECT MOVE:C664(*;"BorderT4";0;0;$widths{4}-2;$height)
End if 

