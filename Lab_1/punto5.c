#include <stdio.h>

int main(void)
{
    int numero;
    float primero;
    float segundo;
    String caracter;
    int i,j;
    scanf("%i",&numero);
    float soluciones[numero];
    for(i=0;i<numero;i++){
        scanf("%c",&caracter);
        scanf("%f",&primero);
        scanf("%f",&segundo);
        int resultado;
        if(caracter == '+'){
            resultado = primero + segundo;
        }
        else if (caracter == '-'){
            resultado = primero - segundo;
        }
        else if (caracter == '*'){
            resultado = primero * segundo;
        }
        else if (caracter == '/'){
            resultado = primero / segundo;
        }
        soluciones[i] = resultado;
    }
    for(j=0;j<numero;j++){
        printf("%f\n",soluciones[j]);
    }
    return 0;
}