%{
#include  <stdio.h>
#include "calc.tab.h"
int line_num=1;
%}
integer "int"
float "float"
digit	[0-9]
ID 	[a-z]+[0-9]*[a-z]*
%%
"main"		 { return(TOK_MAIN);}
"{"		 { return(TOK_OPENPAR);}
"}"		 { return(TOK_CLOSEPAR);}
"("		 { return(TOK_OPENBRAC);}
")"		 { return(TOK_CLOSEBRAC);}
"printvar"       { return(TOK_PRINTVAR);}
{digit}+	{ 
		
		yylval.int_value=atoi(yytext);
		sscanf(yytext, "%d", &(yylval.int_value));
		return (TOK_NUM);
		}
{digit}+"."{digit}+ { 
		  	yylval.float_value=atof(yytext);
		  	sscanf(yytext,"%f",&(yylval.float_value));
		  	return (TOK_FNUM);
		    }
"int" {  return(TOK_INT);}
"float"   {  return(TOK_FLOAT);}
{ID}	{  sscanf(yytext,"%s",&(yylval.id));return(TOK_ID);}
"="     {   return(TOK_EQUAL);}
";"	{	return(TOK_SEMICOLON);	}

"+"	{	return(TOK_ADD);	}
"-"	{	return(TOK_SUB);	}
"*"	{	return(TOK_MUL);	}
"/"	{	return(TOK_DIV);	}
\n 	{line_num++;}
\t	{}
[ ]*    {}/* ignore whitespaces*/	
.	{
	printf("Invalid character '%c', ignored\n",yytext[0]);
	}
%%


