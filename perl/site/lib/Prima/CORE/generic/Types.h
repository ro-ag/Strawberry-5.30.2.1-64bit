/* This file was automatically generated.
 * Do not edit, you'll lose your changes anyway.
 * file: Types.h  */
#ifndef TYPES_H_
#define TYPES_H_
#ifndef _APRICOT_H_
#include "apricot.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif
typedef struct _Point {
	int x;
	int y;
} Point, *PPoint;

extern Point Point_buffer;

typedef struct _Rect {
	int left;
	int bottom;
	int right;
	int top;
} Rect, *PRect;

extern Rect Rect_buffer;

typedef struct _Box {
	int x;
	int y;
	int width;
	int height;
} Box, *PBox;

extern Box Box_buffer;

typedef struct _Font {
	int height;
	int width;
	int style;
	int pitch;
	double direction;
	int vector;
	char name[256];
	int size;
	char encoding[256];
	int resolution;
	char family[256];
	int ascent;
	int descent;
	int weight;
	int maximalWidth;
	int internalLeading;
	int externalLeading;
	int xDeviceRes;
	int yDeviceRes;
	int firstChar;
	int lastChar;
	int breakChar;
	int defaultChar;
	int utf8_flags;
	struct {
		unsigned height    : 1;
		unsigned width     : 1;
		unsigned style     : 1;
		unsigned pitch     : 1;
		unsigned direction : 1;
		unsigned vector    : 1;
		unsigned name      : 1;
		unsigned size      : 1;
		unsigned encoding  : 1;
	} undef;
} Font, *PFont;

extern Font * SvHV_Font( SV * hashRef, Font * strucRef, const char * errorAt);
extern SV * sv_Font2HV( Font * strucRef);
extern Font Font_buffer;

typedef struct _NPoint {
	double x;
	double y;
} NPoint, *PNPoint;

extern NPoint NPoint_buffer;

typedef struct _PrinterInfo {
	char name[256];
	char device[256];
	Bool defaultPrinter;
} PrinterInfo, *PPrinterInfo;

extern PrinterInfo * SvHV_PrinterInfo( SV * hashRef, PrinterInfo * strucRef, const char * errorAt);
extern SV * sv_PrinterInfo2HV( PrinterInfo * strucRef);
extern PrinterInfo PrinterInfo_buffer;

typedef U8 FillPattern[ 8];
extern FillPattern FillPattern_buffer;




#ifdef __cplusplus
}
#endif
#endif
