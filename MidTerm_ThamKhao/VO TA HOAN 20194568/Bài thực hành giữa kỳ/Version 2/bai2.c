#include <stdio.h>

void Sapxep(int a[], int n)
{
    int tmp = 0;
    for (int i = 0; i < n; i++)
    {
        if (a[i] > 0)
        {
            for (int j = 1; j < n; j++)
            {
                if (a[j] > 0)
                {
                    if (a[i] > a[j])
                    {
                        tmp = a[i];
                        a[i] = a[j];
                        a[j] = tmp;
                    }
                }
            }
        }
    }
}

int main()
{
    int n;
    int tmp = 0;
    int a[100];
    printf("Nhap so phan tu cua mang: ");
    scanf("%d", &n);
    printf("Nhap cac phan tu cua mang: ");
    for (int i = 0; i < n; i++)
    {
        /* code */
        scanf("%d", &a[i]);
    }

    Sapxep(a, n);
    for (int i = 0; i < n; i++)
    {
        /* code */
        printf("%d ", a[i]);
    }
}
