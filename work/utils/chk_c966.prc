/* Last update: 20-Set-2004 20:19 */
/* Adiciona apenas a 1ª ocorrência da cota e cria ^c com o nº de exemplares */
/* Para ignorar as alterações à cota apagar a linhas seguintes */

lw(10000)
'D9900D9901D9902D9903D9904D9905'
/* Apaga todas as ocorrencias do campo 966 */
'D966'
/* Campos virtuais para tratar os subcampos da cota */
proc('D9901A9901~'replace(s(V966^a|~|),'~','~A9901~')'~')
proc('D9902A9902~'replace(s(V966^s|~|),'~','~A9902~')'~')
proc('D9903A9903~'replace(s(V966^l|~|),'~','~A9903~')'~')
proc('D9904A9904~'replace(s(V966^m|~|),'~','~A9904~')'~')
proc('D9905A9905~'replace(s(V966^c|~|),'~','~A9905~')'~')

/* Subcampos a criar */
'A966~'
   replace(S('  ',|^a|V9901[1],|^s|V9902[1],|^l|V9903[1],|^m|V9904[1],'^c'f(nocc(V966),0,0)),'~','')
'~'