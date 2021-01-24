#include <stdio.h>
#include <stdlib.h>
#include <config.h>

#ifdef USE_MYMATH
  #include <MathFunctions.h>
#else
  #include <math.h>
#endif


int main(int argc, char *argv[])
{
    if (argc < 1){
        printf("Usage: %s base exponent \n", argv[0]);
        return 1;
    }
	double base = 2;
	double exponent = 10;
	
	printf("argc num is %d\n",argc);
	
	if(argc == 3)
	{
		base = atof(argv[1]);
		exponent = atoi(argv[2]);
	}
    
    
#ifdef USE_MYMATH
    printf("Now we use our own Math library. \n");
    double result = power(base, exponent);
#else
    printf("Now we use the standard library. \n");
    double result = pow(base, exponent);
#endif
    printf("%g ^ %g is %g\n", base, exponent, result);
    return 0;
}
