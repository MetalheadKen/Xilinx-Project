//
//  multiply.c
//  ZynqDemo
//
//  Created by Paul Kneeland on 1/26/12.
//  Copyright (c) 2012 Advanced Electronic Designs. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "multiply.h"
#include "cgiUtils.h"

void multiply(void)
{
    const char *aStr = cgiParameter("a");
    const char *bStr = cgiParameter("b");
    int a = 0;
    int b = 0;
    
    printf("<H3>Multiplication results</H3>\n");

    if (aStr && bStr)
    {
        a = atoi(aStr);
        b = atoi(bStr);
        
        printf("<P>The product of %d and %d is %d.</P>\n", a, b, a * b);        
    }
    else
    {
        printf("<P>Error retrieving data parameters...</P>\n");
    }
}