#include <stdio.h>

int main()
{
    int numero;
    float primero;
    float segundo;
    int i,j;
    scanf("%i",&numero);
    float soluciones[numero];
    for(i=0;i<numero;i++){
        scanf("%f",&primero);
        scanf("%f",&segundo);
        if(primero > segundo){
            soluciones[i] = primero;
        }
        else{
            soluciones[i] = segundo;
        }
    }
    for(j=0;j<numero;j++){
        printf("%f\n",soluciones[j]);
    }
    return 0;
}