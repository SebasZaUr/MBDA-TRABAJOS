#include <stdio.h>

int main(void){
    int numeroEntradas;
    int i,j,h;
    int soluciones[numeroEntradas];
    scanf("%i",&numeroEntradas);
    for(i=0;i<numeroEntradas;i++){
        int cantidadNumeros;
        scanf("%i",&cantidadNumeros);
        int contador = 0;
        for(j=0;j<cantidadNumeros;j++){
            int numero;
            scanf("%i",&numero);
            contador += numero;
        }
        soluciones[i] = contador;
    }
    for(h=0;h<numeroEntradas;h++){
        printf("%i\n",soluciones[h]);
    }
    return 0;
}