#include <stdio.h>
#include <stdlib.h>
#include<string.h>
struct symtab
{
	char IDname[100];
	int type;
	int ivalue;
	float fvalue;
	struct symtab *next;
}*st=NULL;

typedef struct symtab symvar;

struct symtab *createnode(char *name, int t,int ival,float fval)
{
	struct symtab *p;
	p=(struct symtab*)malloc(sizeof(struct symtab));
	p->type= t;
	strcpy(p->IDname,name);
	p->ivalue=ival;
	p->fvalue=fval;
	p->next=NULL;

	return p;
}
void get_value (char *name) 
{
        struct symtab  *p=st;
        while(p!=NULL)
        {
                if(strcmp(p->IDname,name)==0)
                {
                        if(p->type==0)
                                {      
                                printf("The value is %d\n",p->ivalue);
                                break;
                                }
                        if(p->type==1)
                                {
                                printf("The value is %f\n",p->fvalue);
                                break;
                                }

                }
                p=p->next;
        }

}
void display()
{
	struct symtab *p=st;
	if(st==NULL)
	{
	printf("Empty List");
	return;
	}

	while(p!=NULL)
	{
	printf("Variable name  :%s" , p->IDname);
	printf("Datatype : %d",p-> type);
	printf("Value :%d",p->ivalue);
	printf("Value :%f",p->fvalue);
	p=p->next;
	}
	printf("\n");
}

struct symtab* getlastnode()
{
	struct symtab *p=st;
	while(p->next!=NULL)
	{
		p=p->next;
	}
	return p;

}
void insertatend(char *name,int type, int ival,float fval)
{

	struct symtab *p, *q;
	p=createnode(name,type,ival,fval);
	
	if(st==NULL)
	{
		st=p;
	
	}
	else
	{
		q=getlastnode();
		q->next=p;
	}
	//display();
}
void set_int(char *name,int ival)
{
	struct symtab *p=st;
	while(p!=NULL)
	{
		if(strcmp(p->IDname,name)==0)
		{
			p->ivalue=ival;
		}
	p=p->next;
	}
	//display();
}

void set_float(char *name, float fval)
{
	struct symtab *p=st;
	while(p!=NULL)
	{
		 if(strcmp(p->IDname,name)==0)
		{		
			p->fvalue=fval;
		}
	p=p->next;
	}
	//display();
}
int get_type(char *nm)
{
	struct symtab *p=st;
	int return_type;
	while(p!=NULL)
	{
		if(strcmp(p->IDname,nm)==0)
		{
			return_type=p->type;
			return return_type;
		}
	}
	return 5;
}
void add_int(char *name,int value)
{
	struct symtab *p=st;
	while(p!=NULL)
	{
		 if(strcmp(p->IDname,name)==0)
			{
				if(p->type==0)
				{
				p->ivalue=(p->ivalue)+value;
				set_int(name,p->ivalue);
				break;
				}
                        }
                p=p->next;
	}	
}
void mul_int(char *name,int value)  
{
        struct symtab *p=st;
        while(p!=NULL)
        {
                 if(strcmp(p->IDname,name)==0)
                        {
                                if(p->type==0)
                                {
                                p->ivalue=(p->ivalue)*value;
                                set_int(name,p->ivalue);
                                break;
                                }
                        }
                p=p->next;       
        }
} 
void mul_float(char *name,float value)  
{
        struct symtab *p=st;
        while(p!=NULL)
        {
                 if(strcmp(p->IDname,name)==0)
                        {
                                if(p->type==1)
                                {
                                p->fvalue=(p->fvalue)*(value);
                                set_float(name,p->fvalue);
                                break;
                                }
                        }
                p=p->next;       
        }
}
void add_float(char *name,float value)
{
        struct symtab *p=st;
        while(p!=NULL)
        {
                if(strcmp(p->IDname,name)==0)
                        {
                                if(p->type==1)
                                {
                                p->fvalue=(p->fvalue)+(value);
                                set_float(name,p->fvalue);
                                break;
                                }
                        }
                p=p->next;       
        }
}
void  add1(char *name,char *name1)
{
	int value;
	float value1;
	struct symtab *p=st;
	struct symtab *q=st;
	while(p!=NULL)
	{
		 if(strcmp(p->IDname,name)==0)
		{
			if(p->type==0)
			value=p->ivalue;
			if(p->type==1)
			value1=p->fvalue;
		}
	p=p->next;
	}
	while(q!=NULL)
	{
		 if(strcmp(q->IDname,name1)==0)
		{	
			if(q->type==0)
			{
			 value=q->ivalue+value;
			 set_int(name,value);
			}
			 if(q->type==1)
                        {
			 value1=q->fvalue+value1;
                         set_float(name,value1);
                        }
                  }
	q=q->next;
	}
}
void mul1(char *name,char *name1)
{
        int value;
        float value1;
        struct symtab *p=st;
        struct symtab *q=st;
        while(p!=NULL)
        {
                 if(strcmp(p->IDname,name)==0)
                {
                        if(p->type==0)
                        value=p->ivalue;
                        if(p->type==1)
                        value1=p->fvalue;
                }
        p=p->next;
        }
	while(q!=NULL)
        {
                 if(strcmp(q->IDname,name1)==0)
                { 
                        if(q->type==0)
                        {
			 value=(q->ivalue)*value;
                         set_int(name,value);
                        }
                         if(q->type==1)
                        {
			 value1=(q->fvalue)*(value1);
                         set_float(name,value1);
                        }
                  }
        q=q->next;
        }
}
int typechecking (char *name, char *name1)
{
	struct symtab *p=st;
	struct symtab *q=st;
	int typeval,typeval1;
	while(p!=NULL)
	{
		if(strcmp(p->IDname,name)==0)
		{
			typeval= p->type;
			break;
		}
		p=p->next;
	}
	while(q!=NULL)
	{
		if(strcmp(q->IDname,name1)==0)
		{
			typeval1= q->type;
			break;
		}
		q=q->next;
	}
	if(typeval==typeval1)
	{
		if(typeval==0)
		{
			p->ivalue=q->ivalue;
		}
		else
		{
			p->fvalue=q->fvalue;
		}
		return 0;
		 // return 0 is true
	}
	else
	{
	return 1; // return 1 is false
	}
}
/*
void main()
{
insertatend("abc",0,3,-1);
insertatend("xyz",0,4,-1);
get_value("xyz");
get_value("abd");
insertatend("abc1",1,-1,0.9);
insertatend("def1",1,-1,1.9);
get_value("abc1");
get_value("def1");
}
*/
