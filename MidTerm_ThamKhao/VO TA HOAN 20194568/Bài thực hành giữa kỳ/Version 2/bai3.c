#include <stdio.h>
#include <string.h>

char ascii[256];
void main(){
    char str[256];
    int count = 0;
    scanf("%s", str);
    for (int i = 0; i < 256; i++)
    {
        ascii[i]=0;
    }

    for (int i = 0; i < strlen(str); i++)
    {
        ascii[str[i]]++;
    }
    for (int i = 0; i < 256; i++)
    {
        if (ascii[i]>0)
        {
            count++;
        }

    }
    printf("%d\n", count);
}
// 001100
// vovo
