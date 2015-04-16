
pdf.Header=function Header()
{ 

    this.Image('/opac/imagens/logotipo.jpg',89,8,22);
    this.SetFont('Arial','B',10);
	this.title="Entidades parceiras e siglas pesquisáveis";
    w = this.GetStringWidth(this.title)+10;
	this.SetX ((210-w)/2);
    this.Cell(w,40,this.title);
	this.Line (8,33,210-8,33);
	this.Ln(10);
	this.SetY(37);
}

pdf.Footer=function Footer()
{
    this.SetY(-15);
    this.SetFont('Arial','I',8);
    
	this.Cell(0,12,'Contactos e siglas das bibliotecas',0,0,'L');
	this.Cell(0,12,'Pag. '+ this.PageNo()+ '/{nb}',0,1,'R');
	//this.Cell(0,1,'Processado por computador',0,1,'C');
}

pdf.ChapterTitle=function ChapterTitle(label,ref)
{
    //Title
	
    this.SetFont('Arial','',12);
	if (!ref)
	{
		this.SetFillColor(0,160,175);
		this.SetTextColor(255,255,255);
		this.SetX(10);
	}
	else 
    {
		this.SetFillColor(225,225,225);	  // 127, 169,255
		this.SetTextColor(0,0,0);
		this.SetX(20);
	}	
	this.Cell(0,5,label,0,0,'L',1);
	this.SetX(180);
	if (ref)
	   this.Cell(20,5,'['+ref+']',0,0,'R');
	else 
       this.Cell(20,5,'');	
    this.Ln(6);

}

pdf.ChapterBody=function ChapterBody(txt,ref)
{
    if (ref)
	    this.SetX(20);
	else
        this.SetX(10);	
	//Font
	this.SetTextColor(0,0,0);
    this.SetFont('Times','',12);
    this.MultiCell(200,5,txt);
    this.Ln();

}

pdf.PrintChapter=function PrintChapter(title,ref,txt)
{
    //Add chapter
    this.ChapterTitle(title,ref);
    this.ChapterBody(txt,ref);
}
