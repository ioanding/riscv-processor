extern void erg1Mul();
extern void erg2TestImmHazard();
extern void erg3Test();
void fibonacci()
{
    int *N = (int *)8;

    int i;
    int t1 = 0, t2 = 1;
    int nextTerm = t1 + t2;
    for (i = 3; i < *N + 1; i++)
    {
        t1 = t2;
        t2 = nextTerm;
        nextTerm = t1 + t2;
    }

    int *p = (int *)40;
    *p = nextTerm;
}

void factorial()
{
    int i, fact = 1;
    int *number = (int *)4;
    for (i = 1; i < *number + 1; i++)
    {
        fact = fact * i;
    }
    int *p = (int *)44;
    *p = fact;
}

void power()
{
    int *base= (int*)12;
    int *exponent = (int*)16;
    int result = *base;
    int i;
    for (i = 1; i < *exponent; i++)
    {
        result= result*(*base);
    }
    int *p = (int *)48;
    *p = result;
}

void multiOperand()
{
    int *a = (int*)12;      //2
    int *b = (int*)16;      //16
    int result;
    result = *b >> *a;      //4
    result = result << 1;   //8 
    result = result + *b;   //24
    result = result >> 1;   //12
    result = result - 4;    //8
    result = result * (*b); //128
    int *p = (int *)52;
    *p = result;
}

int main(int argc, char *argv[])
{
    erg1Mul();
    erg2TestImmHazard();
    fibonacci();
    factorial();
    power();
    multiOperand();
    erg3Test();
    return 0;
}
