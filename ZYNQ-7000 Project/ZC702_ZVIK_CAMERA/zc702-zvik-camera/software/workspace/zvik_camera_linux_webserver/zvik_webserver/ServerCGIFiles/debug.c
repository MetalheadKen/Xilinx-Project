//
//  debug.c
//  ZynqDemo
//
//  Created by Paul Kneeland on 1/26/12.
//  Copyright (c) 2012 Advanced Electronic Designs. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

#include "debug.h"
#include "cgiUtils.h"

void debug(void)
{
    printf("<H3>Debug Information</H3>\n");
    
    printf("POST content: [%s]<br>\n", cgiPostRequestData());
    
    printf("GET content: [%s]<br>\n", cgiGetRequestData());
    
    printf("command=[%s]<br>\n", cgiParameter("command"));
}