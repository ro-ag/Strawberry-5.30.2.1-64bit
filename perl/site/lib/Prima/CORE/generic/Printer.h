/* This file was automatically generated.
 * Do not edit, you'll lose your changes anyway.
 * file: Printer.h  */
#ifndef Printer_H_
#define Printer_H_
#ifndef _APRICOT_H_
#include "apricot.h"
#endif
#include "Drawable.h"
#include "Types.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _Printer_vmt {
/* internal runtime classifiers */
	char *className;
	void *super;
	void *base;
	int instanceSize;
	VmtPatch *patch;
	int patchLength;
	int vmtSize;
/* methods definition */
	void ( *cleanup)( Handle self);
	void ( *done)( Handle self);
	void ( *init)( Handle self, HV * profile );
	void ( *profile_add)( Handle self, SV * profile );
	void ( *profile_check_in)( Handle self, SV * profile ,SV * default_profile );
	SV * ( *profile_default)( Handle self);
	void ( *set)( Handle self, HV * profile );
	void ( *setup)( Handle self);
	Bool ( *eventFlag)( Handle self, Bool set, Bool value);
	SV * ( *delegations)( Handle self, Bool set, SV * value);
	SV * ( *name)( Handle self, Bool set, SV * value);
	Handle ( *owner)( Handle self, Bool set, Handle value);
	UV ( *add_notification)( Handle self, char * name ,SV * subroutine ,Handle referer ,int index );
	void ( *attach)( Handle self, Handle objectHandle );
	Handle ( *bring)( Handle self, char * componentName );
	Bool ( *can_event)( Handle self);
	void ( *clear_event)( Handle self);
	void ( *detach)( Handle self, Handle objectHandle ,Bool kill );
	void ( *event_error)( Handle self);
	Handle ( *first_that_component)( Handle self, void * actionProc ,void * params );
	void ( *get_components)( Handle self);
	SV * ( *get_handle)( Handle self);
	void ( *get_notification)( Handle self, char * name ,int index );
	void ( *handle_event)( Handle self, PEvent event );
	int ( *is_owner)( Handle self, Handle objectHandle );
	Bool ( *message)( Handle self, PEvent event );
	Bool ( *migrate)( Handle self, Handle attachTo );
	SV * ( *notification_types)( Handle self);
	Bool ( *notify)( Handle self, char * format ,... );
	Bool ( *pop_event)( Handle self);
	void ( *post_message)( Handle self, SV * info1 ,SV * info2 );
	void ( *push_event)( Handle self);
	void ( *recreate)( Handle self);
	void ( *remove_notification)( Handle self, UV id );
	void ( *set_notification)( Handle self, char * name ,SV * subroutine );
	void ( *unlink_notifier)( Handle self, Handle referer );
	void ( *update_sys_handle)( Handle self, HV * profile );
	Bool ( *validate_owner)( Handle self, Handle * newOwner ,HV * profile );
	Color ( *backColor)( Handle self, Bool set, Color value);
	Color ( *color)( Handle self, Bool set, Color value);
	Rect ( *clipRect)( Handle self, Bool set, Rect value);
	int ( *fillMode)( Handle self, Bool set, int value);
	SV * ( *fillPattern)( Handle self, Bool set, SV * value);
	Point ( *fillPatternOffset)( Handle self, Bool set, Point value);
	int ( *height)( Handle self, Bool set, int value);
	int ( *lineEnd)( Handle self, Bool set, int value);
	int ( *lineJoin)( Handle self, Bool set, int value);
	SV * ( *linePattern)( Handle self, Bool set, SV * value);
	int ( *lineWidth)( Handle self, Bool set, int value);
	double ( *miterLimit)( Handle self, Bool set, double value);
	SV * ( *palette)( Handle self, Bool set, SV * value);
	SV * ( *pixel)( Handle self, Bool set, int x ,int y, SV * value);
	Handle ( *region)( Handle self, Bool set, Handle value);
	Point ( *resolution)( Handle self, Bool set, Point value);
	int ( *rop)( Handle self, Bool set, int value);
	int ( *rop2)( Handle self, Bool set, int value);
	Point ( *size)( Handle self, Bool set, Point value);
	Bool ( *textOpaque)( Handle self, Bool set, Bool value);
	Bool ( *textOutBaseline)( Handle self, Bool set, Bool value);
	Point ( *translate)( Handle self, Bool set, Point value);
	int ( *width)( Handle self, Bool set, int value);
	Bool ( *begin_paint)( Handle self);
	Bool ( *begin_paint_info)( Handle self);
	void ( *end_paint)( Handle self);
	void ( *end_paint_info)( Handle self);
	Font * ( *font_match)( char * dummy ,Font * source ,Font * dest ,Bool pick );
	Bool ( *font_add)( Handle self, Font * source ,Font * dest );
	void ( *set_font)( Handle self, Font font );
	int ( *get_bpp)( Handle self);
	Font ( *get_font)( Handle self);
	SV * ( *get_font_abc)( Handle self, int first ,int last ,Bool unicode );
	SV * ( *get_font_def)( Handle self, int first ,int last ,Bool unicode );
	SV * ( *get_font_ranges)( Handle self);
	Color ( *get_nearest_color)( Handle self, Color color );
	int ( *get_paint_state)( Handle self);
	SV * ( *get_physical_palette)( Handle self);
	int ( *get_text_width)( Handle self, SV * text ,Bool addOverhang );
	SV * ( *get_text_box)( Handle self, SV * text );
	SV * ( *render_glyph)( Handle self, int index ,HV * profile );
	SV * ( *render_spline)( SV * obj ,SV * points ,HV * profile );
	Bool ( *alpha)( Handle self, int alpha ,int x1 ,int y1 ,int x2 ,int y2 );
	Bool ( *arc)( Handle self, int x ,int y ,int dX ,int dY ,double startAngle ,double endAngle );
	Bool ( *bar)( Handle self, int x1 ,int y1 ,int x2 ,int y2 );
	Bool ( *bars)( Handle self, SV * rects );
	Bool ( *chord)( Handle self, int x ,int y ,int dX ,int dY ,double startAngle ,double endAngle );
	Bool ( *clear)( Handle self, int x1 ,int y1 ,int x2 ,int y2 );
	Bool ( *ellipse)( Handle self, int x ,int y ,int dX ,int dY );
	Bool ( *fill_chord)( Handle self, int x ,int y ,int dX ,int dY ,double startAngle ,double endAngle );
	Bool ( *fill_ellipse)( Handle self, int x ,int y ,int dX ,int dY );
	Bool ( *fillpoly)( Handle self, SV * points );
	Bool ( *fill_sector)( Handle self, int x ,int y ,int dX ,int dY ,double startAngle ,double endAngle );
	Bool ( *flood_fill)( Handle self, int x ,int y ,Color color ,Bool singleBorder );
	Bool ( *line)( Handle self, int x1 ,int y1 ,int x2 ,int y2 );
	Bool ( *lines)( Handle self, SV * points );
	Bool ( *polyline)( Handle self, SV * points );
	Bool ( *put_image_indirect)( Handle self, Handle image ,int x ,int y ,int xFrom ,int yFrom ,int xDestLen ,int yDestLen ,int xLen ,int yLen ,int rop );
	Bool ( *rectangle)( Handle self, int x1 ,int y1 ,int x2 ,int y2 );
	Bool ( *sector)( Handle self, int x ,int y ,int dX ,int dY ,double startAngle ,double endAngle );
	Bool ( *text_out)( Handle self, SV * text ,int x ,int y );
	SV * ( *text_wrap)( Handle self, SV * text ,int width ,int options ,int tabIndent );
	char * ( *printer)( Handle self, Bool set, char * value);
	void ( *abort_doc)( Handle self);
	Bool ( *begin_doc)( Handle self, char * docName );
	Bool ( *end_doc)( Handle self);
	SV * ( *fonts)( Handle self, char * name ,char * encoding );
	SV * ( *font_encodings)( Handle self, char * encoding );
	Bool ( *new_page)( Handle self);
	void ( *options)( Handle self);
	SV * ( *printers)( Handle self);
	Bool ( *setup_dialog)( Handle self);
	char * ( *get_default_printer)( Handle self);
} Printer_vmt, *PPrinter_vmt;

extern PPrinter_vmt CPrinter;

typedef struct _Printer {
/* internal pointers */
	PPrinter_vmt self;
	PDrawable_vmt super;
	SV  *mate;
	struct _AnyObject *killPtr;
/* instance variables */
	int stage;
	int protectCount;
	int destroyRefCount;
	Handle owner;
	void * transient_class;
	ObjectOptions options;
	void * sysData;
	char * name;
	ApiHandle handle;
	char * evStack;
	int evPtr;
	int evLimit;
	PList postList;
	PList components;
	PList evQueue;
	PList refs;
	PList events;
	PHash eventIDs;
	int eventIDCount;
	Font font;
	int w;
	int h;
	PRGBColor palette;
	int palSize;
	PFontABC font_abc_ascii;
	PList font_abc_unicode;
} Printer, *PPrinter;

extern void register_Printer_Class( void);

/* Local methods definitions */
extern void Printer_done( Handle self);
extern void Printer_init( Handle self, HV * profile );
extern SV * Printer_get_handle( Handle self);
extern Bool Printer_validate_owner( Handle self, Handle * newOwner ,HV * profile );
extern Point Printer_resolution( Handle self, Bool set, Point value);
extern Point Printer_size( Handle self, Bool set, Point value);
extern Bool Printer_begin_paint( Handle self);
extern Bool Printer_begin_paint_info( Handle self);
extern void Printer_end_paint( Handle self);
extern void Printer_end_paint_info( Handle self);
extern char * Printer_printer( Handle self, Bool set, char * value);
extern void Printer_abort_doc( Handle self);
extern Bool Printer_begin_doc( Handle self, char * docName );
extern Bool Printer_end_doc( Handle self);
extern SV * Printer_fonts( Handle self, char * name ,char * encoding );
extern SV * Printer_font_encodings( Handle self, char * encoding );
extern Bool Printer_new_page( Handle self);
extern void Printer_options( Handle self);
extern SV * Printer_printers( Handle self);

#undef  get_eventFlag
#undef  set_eventFlag
#define get_eventFlag(__hs)         eventFlag((__hs),0,(Bool)0)
#define set_eventFlag(__hs,__val)   eventFlag((__hs),1,(__val))
#undef  get_color
#undef  set_color
#define get_color(__hs)         color((__hs),0,(Color)0)
#define set_color(__hs,__val)   color((__hs),1,(__val))
#undef  get_resolution
#undef  set_resolution
#define get_resolution(__hs)         resolution((__hs),0,Point_buffer)
#define set_resolution(__hs,__val)   resolution((__hs),1,(__val))
#undef  get_lineWidth
#undef  set_lineWidth
#define get_lineWidth(__hs)         lineWidth((__hs),0,(int)0)
#define set_lineWidth(__hs,__val)   lineWidth((__hs),1,(__val))
#undef  get_textOpaque
#undef  set_textOpaque
#define get_textOpaque(__hs)         textOpaque((__hs),0,(Bool)0)
#define set_textOpaque(__hs,__val)   textOpaque((__hs),1,(__val))
#undef  get_pixel
#undef  set_pixel
#define get_pixel(__hs)         pixel((__hs),0,(SV *)0)
#define set_pixel(__hs,__val)   pixel((__hs),1,(__val))
#undef  get_owner
#undef  set_owner
#define get_owner(__hs)         owner((__hs),0,(Handle)0)
#define set_owner(__hs,__val)   owner((__hs),1,(__val))
#undef  get_fillPattern
#undef  set_fillPattern
#define get_fillPattern(__hs)         fillPattern((__hs),0,(SV *)0)
#define set_fillPattern(__hs,__val)   fillPattern((__hs),1,(__val))
#undef  get_linePattern
#undef  set_linePattern
#define get_linePattern(__hs)         linePattern((__hs),0,(SV *)0)
#define set_linePattern(__hs,__val)   linePattern((__hs),1,(__val))
#undef  get_backColor
#undef  set_backColor
#define get_backColor(__hs)         backColor((__hs),0,(Color)0)
#define set_backColor(__hs,__val)   backColor((__hs),1,(__val))
#undef  get_printer
#undef  set_printer
#define get_printer(__hs)         printer((__hs),0,(char *)0)
#define set_printer(__hs,__val)   printer((__hs),1,(__val))
#undef  get_delegations
#undef  set_delegations
#define get_delegations(__hs)         delegations((__hs),0,(SV *)0)
#define set_delegations(__hs,__val)   delegations((__hs),1,(__val))
#undef  get_lineJoin
#undef  set_lineJoin
#define get_lineJoin(__hs)         lineJoin((__hs),0,(int)0)
#define set_lineJoin(__hs,__val)   lineJoin((__hs),1,(__val))
#undef  get_fillPatternOffset
#undef  set_fillPatternOffset
#define get_fillPatternOffset(__hs)         fillPatternOffset((__hs),0,Point_buffer)
#define set_fillPatternOffset(__hs,__val)   fillPatternOffset((__hs),1,(__val))
#undef  get_width
#undef  set_width
#define get_width(__hs)         width((__hs),0,(int)0)
#define set_width(__hs,__val)   width((__hs),1,(__val))
#undef  get_lineEnd
#undef  set_lineEnd
#define get_lineEnd(__hs)         lineEnd((__hs),0,(int)0)
#define set_lineEnd(__hs,__val)   lineEnd((__hs),1,(__val))
#undef  get_rop
#undef  set_rop
#define get_rop(__hs)         rop((__hs),0,(int)0)
#define set_rop(__hs,__val)   rop((__hs),1,(__val))
#undef  get_clipRect
#undef  set_clipRect
#define get_clipRect(__hs)         clipRect((__hs),0,Rect_buffer)
#define set_clipRect(__hs,__val)   clipRect((__hs),1,(__val))
#undef  get_rop2
#undef  set_rop2
#define get_rop2(__hs)         rop2((__hs),0,(int)0)
#define set_rop2(__hs,__val)   rop2((__hs),1,(__val))
#undef  get_region
#undef  set_region
#define get_region(__hs)         region((__hs),0,(Handle)0)
#define set_region(__hs,__val)   region((__hs),1,(__val))
#undef  get_translate
#undef  set_translate
#define get_translate(__hs)         translate((__hs),0,Point_buffer)
#define set_translate(__hs,__val)   translate((__hs),1,(__val))
#undef  get_name
#undef  set_name
#define get_name(__hs)         name((__hs),0,(SV *)0)
#define set_name(__hs,__val)   name((__hs),1,(__val))
#undef  get_textOutBaseline
#undef  set_textOutBaseline
#define get_textOutBaseline(__hs)         textOutBaseline((__hs),0,(Bool)0)
#define set_textOutBaseline(__hs,__val)   textOutBaseline((__hs),1,(__val))
#undef  get_palette
#undef  set_palette
#define get_palette(__hs)         palette((__hs),0,(SV *)0)
#define set_palette(__hs,__val)   palette((__hs),1,(__val))
#undef  get_height
#undef  set_height
#define get_height(__hs)         height((__hs),0,(int)0)
#define set_height(__hs,__val)   height((__hs),1,(__val))
#undef  get_size
#undef  set_size
#define get_size(__hs)         size((__hs),0,Point_buffer)
#define set_size(__hs,__val)   size((__hs),1,(__val))
#undef  get_miterLimit
#undef  set_miterLimit
#define get_miterLimit(__hs)         miterLimit((__hs),0,(double)0)
#define set_miterLimit(__hs,__val)   miterLimit((__hs),1,(__val))
#undef  get_fillMode
#undef  set_fillMode
#define get_fillMode(__hs)         fillMode((__hs),0,(int)0)
#define set_fillMode(__hs,__val)   fillMode((__hs),1,(__val))

#ifdef __cplusplus
}
#endif
#endif
