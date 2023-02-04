#include <stdio.h>

int main()
{
    int numero;
    int primero;
    int segundo;
    int i,j;
    scanf("%i",&numero);
    int soluciones[numero];
    for(i=0;i<numero;i++){
        scanf("%i",&primero);
        scanf("%i",&segundo);
        soluciones[i] = primero + segundo;
    }
    for(j=0;j<numero;j++){
        printf("%i\n",soluciones[j]);
    }
    return 0;
}
