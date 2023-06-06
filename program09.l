%{
#include<stdio.h>
%}

%s A B C F
%%
<INITIAL>\n printf("\nAccepted\n\n");BEGIN INITIAL;
<INITIAL>a BEGIN A;
<INITIAL>b BEGIN B;
<A>a BEGIN INITIAL;
<A>b BEGIN C;
<A>\n BEGIN INITIAL; printf("\nNot Accepted\n");
<B>a BEGIN C;
<B>b BEGIN INITIAL;
<B>\n BEGIN INITIAL; printf("\nNot Accepted\n");
<C>a BEGIN B;
<C>b BEGIN A;
<C>\n BEGIN INITIAL; printf("\nNot Accepted\n");
<A>[^ab\n] BEGIN F;
<B>[^ab\n] BEGIN F;
<C>[^ab\n] BEGIN F;
<INITIAL>[^ab\n] BEGIN F;
<F>[^\n] BEGIN F;
<F>[\n] BEGIN INITIAL;printf("\nInvalid Input\n");
.;
%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter the String of a and b only : \n");
    yylex();
}

___________________________________________________________________________________________________________________________________________________________________
or

%{
int a_count = 0;
int b_count = 0;
%}

%%
a { a_count++; }
b { b_count++; }
\n { 
    if (a_count % 2 == 0 && b_count % 2 == 0) {
        printf("Accepted\n");
    } else {
        printf("Rejected\n");
    }
    a_count = 0;
    b_count = 0;
}
. { /* Ignore all other characters */ }
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
