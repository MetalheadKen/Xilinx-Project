//
//  cgiUtils.c
//  ZynqDemo
//
//  Created by Paul Kneeland on 1/26/12.
//  Copyright (c) 2012 Advanced Electronic Designs. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "cgiUtils.h"

static const char *cgiPostBuffer = NULL;
static const char *cgiGetBuffer = NULL;
static const char *cgiParameterBuffer = NULL;
static size_t cgiParameterBufferSize;

// Output a generic cgi response header...
void cgiOutputHeader(void)
{
    printf("Content-type: text/html\n\n");
}

// Get access to the raw post request data.
const char *cgiPostRequestData(void)
{
    if (cgiPostBuffer == NULL)
    {
        const char *postContentLength = getenv("CONTENT_LENGTH");
        if (postContentLength)
        {
            size_t postLength = atoi(postContentLength);
            if (postLength > 0)
            {
                cgiPostBuffer = malloc(postLength + 1);
                if (cgiPostBuffer)
                {
                    bzero((void *)cgiPostBuffer, postLength + 1);
                    read(0, (void *)cgiPostBuffer, postLength);                    
                }
            }
        }
    }
    return cgiPostBuffer;
}

// Get access to the raw get url parameter data
const char *cgiGetRequestData(void)
{
    if (cgiGetBuffer == NULL)
    {
        cgiGetBuffer = getenv("QUERY_STRING");
    }
    return cgiGetBuffer;
}

// Get the data for a parameter, look in get parameters first
// and if not found look in the post parameters.
const char *cgiParameter(const char *paramName)
{
    int i;
    if (cgiParameterBuffer == NULL)
    {
        const char *getData = cgiGetRequestData();
        const char *postData = cgiPostRequestData();
        char *parameterBuffer = NULL;
        size_t getDataSize = 0;
        size_t postDataSize = 0;
        size_t parameterBufferSize = 0;
        
        if (getData)
        {
            getDataSize = strlen(getData);            
        }
        if (postData)
        {
            postDataSize = strlen(postData);
        }
        parameterBufferSize = getDataSize + postDataSize + 3;  
        if (parameterBufferSize > 3)
        {
            parameterBuffer = malloc(parameterBufferSize);
            cgiParameterBuffer = parameterBuffer;
            bzero(parameterBuffer, parameterBufferSize);
            if (getData)
            {
                memcpy(parameterBuffer, getData, getDataSize);
                parameterBuffer += getDataSize + 1;
            }
            
            if (postData)
            {
                memcpy(parameterBuffer , postData, postDataSize);
            }
            parameterBuffer = (char *)cgiParameterBuffer;
            for (i = 0 ; i < parameterBufferSize ; i++)
            {
                if (parameterBuffer[i] == '&')
                {
                    parameterBuffer[i] = 0x00;
                }
            }
            cgiParameterBufferSize = parameterBufferSize - 2;
        }

    }
    
    if (cgiParameterBuffer != NULL)
    {
        for (i = 0 ; i < cgiParameterBufferSize ; i++)
        {
            if (i == 0 || cgiParameterBuffer[i - 1] == 0x00)
            {
                if (strncmp(cgiParameterBuffer + i, paramName, strlen(paramName)) == 0 && cgiParameterBuffer[i + strlen(paramName)] == '=')
                {
                    return cgiParameterBuffer + i + strlen(paramName) + 1;
                }
            }
        }
    }

    return NULL;
}
