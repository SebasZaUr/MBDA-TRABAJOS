#include <stdio.h>

int main(void){
    int numeroEntradas;
    int i,j;
    float soluciones[numeroEntradas];
    scanf("%i",&numeroEntradas);
    for(i=0;i<numeroEntradas;i++){
        int cantidadNumeros;
        scanf("%i",&cantidadNumeros);
        float menor = 1000000;
        for(j=0;j<cantidadNumeros;j++){
            float numero;
            scanf("%f",&numero);
            if(numero < menor){
                menor = numero;
            }
        }
        soluciones[i] = menor;
    }
    int h;
    for(h=0;h<numeroEntradas;h++){
        printf("%f\n",soluciones[h]);
        
    }
    return 0;
}