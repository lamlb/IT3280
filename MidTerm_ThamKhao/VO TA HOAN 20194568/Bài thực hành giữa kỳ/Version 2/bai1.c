#include <stdio.h>

#include <math.h>

int main()
{
    int a, b, c;
    printf("Nhap Gia Tri canh a: ");
    scanf("%d", &a);
    if (a < 0)
        printf("ERROR: Gia tri canh tam giac >0!!");
    printf("Nhap Gia Tri canh b:");
    scanf("%d", &b);
    if (b < 0)
        printf("ERROR: Gia tri canh tam giac >0!!");
    printf("Nhap Gia Tri canh c:");
    scanf("%d", &c);
    if (c < 0)
        printf("ERROR: Gia tri canh tam giac >0!!");

    if (a + b < c)
        printf("ai, Day 0 la ba canh cua tam giac.");
    if (b + c < a)
        printf("ai, Day 0 la ba canh cua tam giac.");
    if (a + c < b)
        printf("ai, Day 0 la ba canh cua tam giac.");
    printf("Dung, day la ba canh cua tam giac");
}