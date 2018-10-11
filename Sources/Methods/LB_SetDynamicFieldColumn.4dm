//%attributes = {}
  // LB_SetDynamicFieldColumn()
  //
  //
  // creado por: Alberto Bachler Klein: 18-02-16, 09:54:25
  // -----------------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_POINTER:C301($5)
C_TEXT:C284($6)
C_LONGINT:C283($7)
C_TEXT:C284($8)
C_LONGINT:C283($9)
C_LONGINT:C283($10)
C_LONGINT:C283($11)
C_TEXT:C284($12)
C_LONGINT:C283($13)
C_LONGINT:C283($14)

C_BOOLEAN:C305($b_visible)
C_LONGINT:C283($l_alignH;$l_backColor;$l_columnFontsize;$l_columnFontStyle;$l_columnNumber;$l_textColor;$l_width)
C_POINTER:C301($y_field;$y_nil)
C_TEXT:C284($t_columnFontName;$t_columnName;$t_format;$t_header;$t_headerName;$t_listboxName;$t_styleSheet)


If (False:C215)
	C_TEXT:C284(LB_SetDynamicFieldColumn ;$0)
	C_TEXT:C284(LB_SetDynamicFieldColumn ;$1)
	C_LONGINT:C283(LB_SetDynamicFieldColumn ;$2)
	C_TEXT:C284(LB_SetDynamicFieldColumn ;$3)
	C_TEXT:C284(LB_SetDynamicFieldColumn ;$4)
	C_POINTER:C301(LB_SetDynamicFieldColumn ;$5)
	C_TEXT:C284(LB_SetDynamicFieldColumn ;$6)
	C_LONGINT:C283(LB_SetDynamicFieldColumn ;$7)
	C_TEXT:C284(LB_SetDynamicFieldColumn ;$8)
	C_LONGINT:C283(LB_SetDynamicFieldColumn ;$9)
	C_LONGINT:C283(LB_SetDynamicFieldColumn ;$10)
	C_LONGINT:C283(LB_SetDynamicFieldColumn ;$11)
	C_TEXT:C284(LB_SetDynamicFieldColumn ;$12)
	C_LONGINT:C283(LB_SetDynamicFieldColumn ;$13)
	C_LONGINT:C283(LB_SetDynamicFieldColumn ;$14)
End if 

  //OBJECT SET FORMAT

$t_listboxName:=$1
$l_columnNumber:=$2
$t_columnName:=$3
$t_headerName:=$4
$y_field:=$5
If ($t_columnName="")
	$t_columnName:=Table name:C256($y_field)+"."+Field name:C257($y_field)
End if 

$b_visible:=True:C214
$l_width:=100
$l_alignH:=Align default:K42:1
$l_backColor:=0x00FFFFFF
$l_textColor:=0

$t_styleSheet:=OBJECT Get style sheet:C1258(*;$t_listboxName)
$t_columnFontName:=OBJECT Get font:C1069(*;$t_listboxName)
$l_columnFontStyle:=OBJECT Get font style:C1071(*;$t_listboxName)
$l_columnFontsize:=OBJECT Get font size:C1070(*;$t_listboxName)

Case of 
	: (Count parameters:C259=6)
		$t_header:=$6
		
	: (Count parameters:C259=7)
		$t_header:=$6
		$l_width:=$7
		
	: (Count parameters:C259=8)
		$t_header:=$6
		$l_width:=$7
		$t_format:=$8
		
	: (Count parameters:C259=9)
		$t_header:=$6
		$l_width:=$7
		$t_format:=$8
		$l_alignH:=$9
		
	: (Count parameters:C259=10)
		$t_header:=$6
		$l_width:=$7
		$t_format:=$8
		$l_alignH:=$9
		$l_columnFontStyle:=$10
		
	: (Count parameters:C259=11)
		$t_header:=$6
		$l_width:=$7
		$t_format:=$8
		$l_alignH:=$9
		$l_columnFontStyle:=$10
		$l_columnFontSize:=$11
		
	: (Count parameters:C259=12)
		$t_header:=$6
		$l_width:=$7
		$t_format:=$8
		$l_alignH:=$9
		$l_columnFontStyle:=$10
		$l_columnFontSize:=$11
		$t_columnFontName:=$12
		
	: (Count parameters:C259=13)
		$t_header:=$6
		$l_width:=$7
		$t_format:=$8
		$l_alignH:=$9
		$l_columnFontStyle:=$10
		$l_columnFontSize:=$11
		$t_columnFontName:=$12
		$l_textColor:=$13
		
	: (Count parameters:C259=14)
		$t_header:=$6
		$l_width:=$7
		$t_format:=$8
		$l_alignH:=$9
		$l_columnFontStyle:=$10
		$l_columnFontSize:=$11
		$t_columnFontName:=$12
		$l_textColor:=$13
		$l_backColor:=$14
		
	Else 
		$t_header:=$t_columnName
End case 


$t_headerName:=Choose:C955($t_headerName="";"hdr_"+$t_columnName;$t_headerName)
$l_alignH:=Choose:C955($l_alignH=0;Align default:K42:1;$l_alignH)
$b_visible:=Choose:C955($l_width=0;False:C215;True:C214)

LISTBOX INSERT COLUMN:C829(*;$t_listboxName;$l_columnNumber;$t_columnName;$y_field->;$t_headerName;$y_nil)
OBJECT SET TITLE:C194(*;$t_headerName;$t_header)

OBJECT SET VISIBLE:C603(*;$t_columnName;$b_visible)
LISTBOX SET COLUMN WIDTH:C833(*;$t_columnName;$l_width)

OBJECT SET FORMAT:C236(*;$t_columnName;$t_format)
OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$t_columnName;$l_alignH)
If ($t_columnFontName#"")
	OBJECT SET FONT:C164(*;$t_columnName;$t_columnFontName)
End if 
If ($l_columnFontStyle>=0)
	OBJECT SET FONT STYLE:C166(*;$t_columnName;$l_columnFontStyle)
End if 
If ($l_columnFontSize>=6)
	OBJECT SET FONT SIZE:C165(*;$t_columnName;$l_columnFontSize)
End if 
OBJECT SET RGB COLORS:C628(*;$t_columnName;$l_textColor;$l_backColor)


$0:=$t_columnName