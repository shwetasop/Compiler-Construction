%{
#include <stdio.h>
#include "symboltable.h"
extern int line_num;
%}

%token TOK_INT TOK_ID TOK_EQUAL TOK_NUM TOK_FNUM TOK_FLOAT TOK_SEMICOLON TOK_ADD TOK_SUB TOK_DIV TOK_MUL TOK_PRINTVAR TOK_MAIN  TOK_OPENPAR TOK_CLOSEPAR TOK_OPENBRAC TOK_CLOSEBRAC


%union{
	char id[100];
	int int_value;
	float float_value;
  }

%type <id>TOK_ID
%type <int_value>expr1 TOK_NUM
%type <float_value>fexpr TOK_FNUM
%%
prog:
	TOK_MAIN TOK_OPENBRAC TOK_CLOSEBRAC TOK_OPENPAR stmts  TOK_CLOSEPAR
;	
stmts:  |stmt TOK_SEMICOLON stmt2
;
stmt2: | stmt1 TOK_SEMICOLON stmt2
;
stmt: 	TOK_INT TOK_ID 		{	insertatend($2,0,0,-1.0);	}
	|TOK_FLOAT TOK_ID	        {	insertatend($2,1,0,-1.0);	}
	|TOK_ID TOK_EQUAL TOK_NUM 	{ 	printf("Line No %d: Statement is called before defined\n",line_num);
					 	exit(0);	
					}
	|TOK_ID TOK_EQUAL TOK_FNUM 	{	printf("Line No %d : Statement is called before defined \n",line_num);
						exit(0);
					}
;

stmt1:  TOK_INT TOK_ID                  {       insertatend($2,0,0,-1.0);       }
        |TOK_FLOAT TOK_ID               {       insertatend($2,1,0,-1.0);       }
	|TOK_ID TOK_EQUAL TOK_NUM	{   	set_int($1,$3);	if(get_type($1)==1){ printf("Line no %d: Type error\n",line_num); exit(0);}		}	
	|TOK_ID TOK_EQUAL TOK_FNUM 	{   	set_float($1,$3);if(get_type($1)==0){printf("Line no: %d  Type error\n ",line_num);exit(0);}		}				
	|TOK_ID TOK_EQUAL expr1         {	set_int($1,$3);                }
	|TOK_ID TOK_EQUAL fexpr		{ 	set_float($1,$3);		}
	|TOK_PRINTVAR TOK_ID 		{  	get_value($2);			}
	|TOK_ID TOK_EQUAL TOK_ID        {  
						if(typechecking($1,$3)==1)    
                                                    {
                                                         printf("Line : %d Type error\n",line_num);
						         exit(0);   
                                                    }	
					}
	|TOK_ID TOK_EQUAL expr
	
;

fexpr:    TOK_FNUM TOK_ADD TOK_FNUM    {  $$=$1+$3; }
	  |TOK_FNUM TOK_MUL TOK_FNUM   {  $$=$1*$3;  }  
;
expr: 	 TOK_ID TOK_ADD TOK_ID		{
					
					if(typechecking($1,$3)==1)
                                                    {
                                                         printf("Line : %d Type error\n",line_num);
                                                         exit(0);
                                                    }   					
					}
	|TOK_ID TOK_MUL TOK_ID 		{mul1($1,$3); 	
					if(typechecking($1,$3))   
						    {
                                                         printf("Line : %d Type error\n",line_num);
                                                         exit(0);
                                                    }
                                        }
 			 
	|TOK_ID TOK_ADD TOK_NUM 	{ 	add_int($1,$3); 		} 
	|TOK_ID TOK_MUL TOK_NUM 	{ 	mul_int($1,$3); 		} 
	|TOK_ID TOK_ADD TOK_FNUM 	{ 	add_float($1,$3); 		} 
	|TOK_ID TOK_MUL TOK_FNUM 	{ 	mul_float($1,$3); 		} 
	|TOK_NUM TOK_ADD TOK_FNUM 	{ 	printf(" Line %d: Type error \n",line_num);exit(0);}
	| TOK_FNUM TOK_ADD TOK_NUM 	{ 	printf("Line %d: Type error\n", line_num);exit(0);}
	|TOK_NUM TOK_MUL TOK_FNUM      {        printf(" Line %d: Type error \n",line_num);exit(0);}
        | TOK_FNUM TOK_MUL TOK_NUM      {       printf("Line %d: Type error\n", line_num);exit(0);}
	
;

expr1:	TOK_NUM TOK_ADD TOK_NUM        {    $$=$1+$3;			}
	|TOK_NUM TOK_MUL  TOK_NUM       {       $$=$1*$3;			}
;
	

%%

int yyerror(char *s)
{
	printf(" Parsing error: line %d  \n", line_num);
	return 0;
}

int main()
{
   yyparse();
   return 0;
}
