%{ 
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

char *  yyerror();


%}


%option noyywrap
%option yylineno




DIGITO		        ([0-9])
LETRA			[a-zA-Z]
COMENTARIO_ABRE         "-/"
COMENTARIO_CIERRA        "/-"
CARACTERES              \?|\"|\.|\,|\+|\t|\n|\/|\_|\:|\;|¿|\*|{LETRA}|{DIGITO}|" "|=|\*|>|<|- 


COMA                    [,]
PAR_A	                [(]
PAR_C	                [)]
COR_A                   [[]
COR_C                   []]
PYC                     [;]
DP			            [:]                     


BETWEEN                 "BETWEEN"
WRITE                   "WRITE"
READ                    "READ"
IF			            "IF"
ENDIF                   "ENDIF"
WHILE	            	"WHILE"
DECVAR		            "DECVAR"
ENDDEC		            "ENDDEC"
INTEGER	            	"INTEGER"
STRING                  "STRING"
FLOAT		            "FLOAT"
ELSE		            "ELSE"
AND                     "AND"
OR                      "OR"
NOT                     "NOT"
DO                      "DO"
ENDWHILE                "ENDWHILE"
IN                      "IN"
THEN                    "THEN"
INLIST                  "INLIST"


CTE_FLOAT              {DIGITO}+"."{DIGITO}+|"."{DIGITO}|{DIGITO}+"."
CTE_STRING               \".*\" 
CTE_INTEGER	            "-"?{DIGITO}+

COMENTARIO              {COMENTARIO_ABRE}([^-/])*?{COMENTARIO_CIERRA}
ID		            	{LETRA}({LETRA}|{DIGITO})*

OP_MAY		        [>]
OP_MAYIGU	        ">="
OP_MEN		        [<]
OP_MENIGU	        "<="
OP_IGUAL	        "=="
OP_DIF		        "!="
OP_DIV                  [/]
OP_SUMA                 [+]
OP_MULT		        [*]
OP_ASIG		        ":="
OP_RESTA                [-]

%%

{DECVAR}         {printf("\nDECVAR: %s\n",yytext);return DECVAR;}
{READ}           {printf("\nREAD: %s\n",yytext);return READ;}
{ENDDEC}         {printf("\nENDDEC: %s\n",yytext);return ENDDEC;}
{WRITE}          {printf("\nWRITE: %s\n",yytext);return WRITE;}
{WHILE}          {printf("\nWHILE: %s\n",yytext);return WHILE;}
{IF}             {printf("\nIF: %s\n",yytext);return IF;}
{INTEGER}        {printf("\nINTEGER: %s\n",yytext);return INTEGER;}
{FLOAT}          {printf("\nFLOAT: %s\n",yytext);return FLOAT;}
{ELSE}           {printf("\nELSE: %s\n",yytext);return ELSE;}
{DO}             {printf("\nDO: %s\n",yytext);return DO;}
{ENDWHILE}       {printf("\nENDWHILE: %s\n",yytext);return ENDWHILE;}
{IN}             {printf("\nIN: %s\n",yytext);return IN;}
{STRING}         {printf("\nSTRING: %s\n",yytext);return STRING;}   
{THEN}           {printf("\nTHEN: %s\n",yytext);return THEN;} 
{ENDIF}          {printf("\nENDIF: %s\n",yytext);return ENDIF;} 
{BETWEEN}        {printf("\nBETWEEN: %s\n",yytext);return BETWEEN;} 
{INLIST}         {printf("\nINLIST: %s\n",yytext);return INLIST;} 

{AND}              {printf("\nAND: %s\n",yytext);return AND;}
{OR}               {printf("\nOR: %s\n",yytext);return OR;}
{NOT}              {printf("\nNOT: %s\n",yytext);return NOT;}



{CTE_INTEGER}     {printf("\nConstante Entero: %s\n",validarRangoEntero(yytext));return CTE_INTEGER;}
{CTE_STRING}     {printf("\nConstante String: %s\n",validarRangoString(yytext));return CTE_STRING;}
{CTE_FLOAT}    {printf("\nConstante Real: %s\n",validarRangoReal(yytext));return CTE_FLOAT;} 

{ID}               {yylval.strVal = strdup(yytext);printf("\nID Variable: %s\n",validarRangoID(yytext));return ID;}
{COMA}             {printf("\nComa: %s\n",yytext);return COMA;}



{COMENTARIO}  {}
 

{PAR_A}	         {printf("\nParentesis Abre: %s\n",yytext);return PAR_A;}
{PAR_C}	         {printf("\nParentesis Cerrado: %s\n",yytext);return PAR_C;}
{PYC}	         {printf("\nPunto y coma: %s\n",yytext);return PYC;}
{DP}	         {printf("\nDos puntos: %s\n",yytext);return DP;}

{COR_A}          {printf("\nCorchete Abre: %s\n",yytext);return COR_A;}
{COR_C}          {printf("\nCorchete Cierra: %s\n",yytext);return COR_C;}

{OP_ASIG}	 {printf("\nOperador Asignacion: %s\n",yytext);return OP_ASIG;}
{OP_MAY}	 {printf("\nOperador Mayor: %s\n",yytext);return OP_MAY;}
{OP_MAYIGU}      {printf("\nOperador Mayor o igual: %s\n",yytext);return OP_MAYIGU;}
{OP_MEN}         {printf("\nOperador Menor: %s\n",yytext);return OP_MEN;}
{OP_MENIGU}      {printf("\nOperador Menor o Igual: %s\n",yytext);return OP_MENIGU;}
{OP_IGUAL}       {printf("\nOperador Igual: %s\n",yytext);return OP_IGUAL;}
{OP_DIF}         {printf("\nOperador Distinto : %s\n",yytext);return OP_DIF;}
{OP_DIV}         {printf("\nOperador Division: %s\n",yytext);return OP_DIV;}
{OP_SUMA}        {printf("\nOperador Suma: %s\n",yytext);return OP_SUMA;}
{OP_MULT}        {printf("\nOperador Multiplicacion: %s\n",yytext);return OP_MULT;} 
{OP_ASIG}        {printf("\nOperador Asignacion: %s\n",yytext);return OP_ASIG;} 
{OP_RESTA}       {printf("\nOperador Resta: %s\n",yytext);return OP_RESTA;}


"\n"  
"\t"
"\r" 
"\n\t" 
"\r\n"               
" "      
            
.               {
							char msg[300];
							printf("ERROR Lexico - Caracter \'%s\' invalido", yytext);
							yyerror(msg);
						}

%%
 char* yyerror(void){
     printf("Error Lexico en linea %s %d \n",yytext ,yylineno) ;
     exit(1);
 }