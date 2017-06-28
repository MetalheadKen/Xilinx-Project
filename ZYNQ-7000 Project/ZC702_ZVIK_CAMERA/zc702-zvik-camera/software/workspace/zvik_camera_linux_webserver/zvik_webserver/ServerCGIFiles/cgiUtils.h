//
//  cgiUtils.h
//  ZynqDemo
//
//  Created by Paul Kneeland on 1/26/12.
//  Copyright (c) 2012 Advanced Electronic Designs. All rights reserved.
//

#ifndef ZynqDemo_cgiUtils_h
#define ZynqDemo_cgiUtils_h

// Output a generic cgi response header...
void cgiOutputHeader(void);

// Get access to the raw post request data.
const char *cgiPostRequestData(void);

// Get access to the raw get url parameter data
const char *cgiGetRequestData(void);

// Get the data for a parameter, look in get parameters first
// and if not found look in the post parameters.
const char *cgiParameter(const char *paramName);


#endif
