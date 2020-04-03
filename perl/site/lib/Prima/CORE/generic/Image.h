/* This file was automatically generated.
 * Do not edit, you'll lose your changes anyway.
 * file: Image.h  */
#ifndef Image_H_
#define Image_H_
#ifndef _APRICOT_H_
#include "apricot.h"
#endif
#include "Drawable.h"
#include "Types.h"

#ifdef __cplusplus
extern "C" {
#endif
typedef double ImageStats[ 7];
extern ImageStats ImageStats_buffer;


typedef struct _Image_vmt {
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
	int ( *conversion)( Handle self, Bool set, int value);
	SV * ( *data)( Handle self, Bool set, SV * value);
	int ( *lineSize)( Handle self, Bool set, int value);
	Bool ( *preserveType)( Handle self, Bool set, Bool value);
	int ( *scaling)( Handle self, Bool set, int value);
	double ( *stats)( Handle self, Bool set, int index, double value);
	int ( *type)( Handle self, Bool set, int value);
	Handle ( *bitmap)( Handle self);
	SV * ( *codecs)( SV * dummy ,int codecID );
	void ( *create_empty)( Handle self, int width ,int height ,int type );
	Handle ( *dup)( Handle self);
	Handle ( *extract)( Handle self, int x ,int y ,int width ,int height );
	PList ( *load)( SV * className ,char * filename ,HV * profile );
	void ( *make_empty)( Handle self);
	void ( *map)( Handle self, Color color );
	void ( *mirror)( Handle self, Bool vertically );
	void ( *premultiply_alpha)( Handle self, SV * alpha );
	Bool ( *rotate)( Handle self, double degrees );
	void ( *resample)( Handle self, double srcLo ,double srcHi ,double dstLo ,double dstHi );
	int ( *save)( SV * className ,char * filename ,HV * profile );
	void ( *reset)( Handle self, int type ,RGBColor * palette ,int palSize );
	void ( *stretch)( Handle self, int width ,int height );
	Bool ( *transform)( Handle self, double a ,double b ,double c ,double d );
	void ( *update_change)( Handle self);
} Image_vmt, *PImage_vmt;

extern PImage_vmt CImage;

typedef struct _Image {
/* internal pointers */
	PImage_vmt self;
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
	int type;
	int lineSize;
	int dataSize;
	int conversion;
	int scaling;
	unsigned char * data;
	ImageStats stats;
	int statsCache;
	Point resolution;
	int eventMask1;
	int eventMask2;
	PRegionRec regionData;
	int updateLock;
	int extraROP;
} Image, *PImage;

extern void register_Image_Class( void);

/* Local methods definitions */
extern void Image_done( Handle self);
extern void Image_init( Handle self, HV * profile );
extern SV * Image_profile_default( Handle self);
extern void Image_set( Handle self, HV * profile );
extern UV Image_add_notification( Handle self, char * name ,SV * subroutine ,Handle referer ,int index );
extern SV * Image_get_handle( Handle self);
extern void Image_handle_event( Handle self, PEvent event );
extern SV * Image_notification_types( Handle self);
extern void Image_remove_notification( Handle self, UV id );
extern Rect Image_clipRect( Handle self, Bool set, Rect value);
extern SV * Image_palette( Handle self, Bool set, SV * value);
extern SV * Image_pixel( Handle self, Bool set, int x ,int y, SV * value);
extern Handle Image_region( Handle self, Bool set, Handle value);
extern Point Image_resolution( Handle self, Bool set, Point value);
extern int Image_rop( Handle self, Bool set, int value);
extern Point Image_size( Handle self, Bool set, Point value);
extern Bool Image_begin_paint( Handle self);
extern Bool Image_begin_paint_info( Handle self);
extern void Image_end_paint( Handle self);
extern void Image_end_paint_info( Handle self);
extern int Image_get_bpp( Handle self);
extern Color Image_get_nearest_color( Handle self, Color color );
extern Bool Image_arc( Handle self, int x ,int y ,int dX ,int dY ,double startAngle ,double endAngle );
extern Bool Image_bar( Handle self, int x1 ,int y1 ,int x2 ,int y2 );
extern Bool Image_bars( Handle self, SV * rects );
extern Bool Image_chord( Handle self, int x ,int y ,int dX ,int dY ,double startAngle ,double endAngle );
extern Bool Image_clear( Handle self, int x1 ,int y1 ,int x2 ,int y2 );
extern Bool Image_ellipse( Handle self, int x ,int y ,int dX ,int dY );
extern Bool Image_fill_chord( Handle self, int x ,int y ,int dX ,int dY ,double startAngle ,double endAngle );
extern Bool Image_fill_ellipse( Handle self, int x ,int y ,int dX ,int dY );
extern Bool Image_fillpoly( Handle self, SV * points );
extern Bool Image_fill_sector( Handle self, int x ,int y ,int dX ,int dY ,double startAngle ,double endAngle );
extern Bool Image_flood_fill( Handle self, int x ,int y ,Color color ,Bool singleBorder );
extern Bool Image_line( Handle self, int x1 ,int y1 ,int x2 ,int y2 );
extern Bool Image_lines( Handle self, SV * points );
extern Bool Image_polyline( Handle self, SV * points );
extern Bool Image_put_image_indirect( Handle self, Handle image ,int x ,int y ,int xFrom ,int yFrom ,int xDestLen ,int yDestLen ,int xLen ,int yLen ,int rop );
extern Bool Image_rectangle( Handle self, int x1 ,int y1 ,int x2 ,int y2 );
extern Bool Image_sector( Handle self, int x ,int y ,int dX ,int dY ,double startAngle ,double endAngle );
extern int Image_conversion( Handle self, Bool set, int value);
extern SV * Image_data( Handle self, Bool set, SV * value);
extern int Image_lineSize( Handle self, Bool set, int value);
extern Bool Image_preserveType( Handle self, Bool set, Bool value);
extern int Image_scaling( Handle self, Bool set, int value);
extern double Image_stats( Handle self, Bool set, int index, double value);
extern int Image_type( Handle self, Bool set, int value);
extern Handle Image_bitmap( Handle self);
extern SV * Image_codecs( SV * dummy ,int codecID );
extern void Image_create_empty( Handle self, int width ,int height ,int type );
extern Handle Image_dup( Handle self);
extern Handle Image_extract( Handle self, int x ,int y ,int width ,int height );
extern PList Image_load( SV * className ,char * filename ,HV * profile );
extern void Image_make_empty( Handle self);
extern void Image_map( Handle self, Color color );
extern void Image_mirror( Handle self, Bool vertically );
extern void Image_premultiply_alpha( Handle self, SV * alpha );
extern Bool Image_rotate( Handle self, double degrees );
extern void Image_resample( Handle self, double srcLo ,double srcHi ,double dstLo ,double dstHi );
extern int Image_save( SV * className ,char * filename ,HV * profile );
extern void Image_reset( Handle self, int type ,RGBColor * palette ,int palSize );
extern void Image_stretch( Handle self, int width ,int height );
extern Bool Image_transform( Handle self, double a ,double b ,double c ,double d );
extern void Image_update_change( Handle self);

#undef  get_pixel
#undef  set_pixel
#define get_pixel(__hs)         pixel((__hs),0,(SV *)0)
#define set_pixel(__hs,__val)   pixel((__hs),1,(__val))
#undef  get_color
#undef  set_color
#define get_color(__hs)         color((__hs),0,(Color)0)
#define set_color(__hs,__val)   color((__hs),1,(__val))
#undef  get_preserveType
#undef  set_preserveType
#define get_preserveType(__hs)         preserveType((__hs),0,(Bool)0)
#define set_preserveType(__hs,__val)   preserveType((__hs),1,(__val))
#undef  get_miterLimit
#undef  set_miterLimit
#define get_miterLimit(__hs)         miterLimit((__hs),0,(double)0)
#define set_miterLimit(__hs,__val)   miterLimit((__hs),1,(__val))
#undef  get_size
#undef  set_size
#define get_size(__hs)         size((__hs),0,Point_buffer)
#define set_size(__hs,__val)   size((__hs),1,(__val))
#undef  get_lineWidth
#undef  set_lineWidth
#define get_lineWidth(__hs)         lineWidth((__hs),0,(int)0)
#define set_lineWidth(__hs,__val)   lineWidth((__hs),1,(__val))
#undef  get_stats
#undef  set_stats
#define get_stats(__hs,__var1)         stats((__hs),0,(__var1),(double)0)
#define set_stats(__hs,__var1,__val)   stats((__hs),1,(__var1),(__val))
#undef  get_fillMode
#undef  set_fillMode
#define get_fillMode(__hs)         fillMode((__hs),0,(int)0)
#define set_fillMode(__hs,__val)   fillMode((__hs),1,(__val))
#undef  get_height
#undef  set_height
#define get_height(__hs)         height((__hs),0,(int)0)
#define set_height(__hs,__val)   height((__hs),1,(__val))
#undef  get_textOutBaseline
#undef  set_textOutBaseline
#define get_textOutBaseline(__hs)         textOutBaseline((__hs),0,(Bool)0)
#define set_textOutBaseline(__hs,__val)   textOutBaseline((__hs),1,(__val))
#undef  get_fillPattern
#undef  set_fillPattern
#define get_fillPattern(__hs)         fillPattern((__hs),0,(SV *)0)
#define set_fillPattern(__hs,__val)   fillPattern((__hs),1,(__val))
#undef  get_backColor
#undef  set_backColor
#define get_backColor(__hs)         backColor((__hs),0,(Color)0)
#define set_backColor(__hs,__val)   backColor((__hs),1,(__val))
#undef  get_data
#undef  set_data
#define get_data(__hs)         data((__hs),0,(SV *)0)
#define set_data(__hs,__val)   data((__hs),1,(__val))
#undef  get_type
#undef  set_type
#define get_type(__hs)         type((__hs),0,(int)0)
#define set_type(__hs,__val)   type((__hs),1,(__val))
#undef  get_lineJoin
#undef  set_lineJoin
#define get_lineJoin(__hs)         lineJoin((__hs),0,(int)0)
#define set_lineJoin(__hs,__val)   lineJoin((__hs),1,(__val))
#undef  get_name
#undef  set_name
#define get_name(__hs)         name((__hs),0,(SV *)0)
#define set_name(__hs,__val)   name((__hs),1,(__val))
#undef  get_clipRect
#undef  set_clipRect
#define get_clipRect(__hs)         clipRect((__hs),0,Rect_buffer)
#define set_clipRect(__hs,__val)   clipRect((__hs),1,(__val))
#undef  get_translate
#undef  set_translate
#define get_translate(__hs)         translate((__hs),0,Point_buffer)
#define set_translate(__hs,__val)   translate((__hs),1,(__val))
#undef  get_scaling
#undef  set_scaling
#define get_scaling(__hs)         scaling((__hs),0,(int)0)
#define set_scaling(__hs,__val)   scaling((__hs),1,(__val))
#undef  get_region
#undef  set_region
#define get_region(__hs)         region((__hs),0,(Handle)0)
#define set_region(__hs,__val)   region((__hs),1,(__val))
#undef  get_rop2
#undef  set_rop2
#define get_rop2(__hs)         rop2((__hs),0,(int)0)
#define set_rop2(__hs,__val)   rop2((__hs),1,(__val))
#undef  get_palette
#undef  set_palette
#define get_palette(__hs)         palette((__hs),0,(SV *)0)
#define set_palette(__hs,__val)   palette((__hs),1,(__val))
#undef  get_fillPatternOffset
#undef  set_fillPatternOffset
#define get_fillPatternOffset(__hs)         fillPatternOffset((__hs),0,Point_buffer)
#define set_fillPatternOffset(__hs,__val)   fillPatternOffset((__hs),1,(__val))
#undef  get_lineEnd
#undef  set_lineEnd
#define get_lineEnd(__hs)         lineEnd((__hs),0,(int)0)
#define set_lineEnd(__hs,__val)   lineEnd((__hs),1,(__val))
#undef  get_textOpaque
#undef  set_textOpaque
#define get_textOpaque(__hs)         textOpaque((__hs),0,(Bool)0)
#define set_textOpaque(__hs,__val)   textOpaque((__hs),1,(__val))
#undef  get_owner
#undef  set_owner
#define get_owner(__hs)         owner((__hs),0,(Handle)0)
#define set_owner(__hs,__val)   owner((__hs),1,(__val))
#undef  get_conversion
#undef  set_conversion
#define get_conversion(__hs)         conversion((__hs),0,(int)0)
#define set_conversion(__hs,__val)   conversion((__hs),1,(__val))
#undef  get_lineSize
#undef  set_lineSize
#define get_lineSize(__hs)         lineSize((__hs),0,(int)0)
#define set_lineSize(__hs,__val)   lineSize((__hs),1,(__val))
#undef  get_delegations
#undef  set_delegations
#define get_delegations(__hs)         delegations((__hs),0,(SV *)0)
#define set_delegations(__hs,__val)   delegations((__hs),1,(__val))
#undef  get_width
#undef  set_width
#define get_width(__hs)         width((__hs),0,(int)0)
#define set_width(__hs,__val)   width((__hs),1,(__val))
#undef  get_resolution
#undef  set_resolution
#define get_resolution(__hs)         resolution((__hs),0,Point_buffer)
#define set_resolution(__hs,__val)   resolution((__hs),1,(__val))
#undef  get_linePattern
#undef  set_linePattern
#define get_linePattern(__hs)         linePattern((__hs),0,(SV *)0)
#define set_linePattern(__hs,__val)   linePattern((__hs),1,(__val))
#undef  get_rop
#undef  set_rop
#define get_rop(__hs)         rop((__hs),0,(int)0)
#define set_rop(__hs,__val)   rop((__hs),1,(__val))
#undef  get_eventFlag
#undef  set_eventFlag
#define get_eventFlag(__hs)         eventFlag((__hs),0,(Bool)0)
#define set_eventFlag(__hs,__val)   eventFlag((__hs),1,(__val))

#ifdef __cplusplus
}
#endif
#endif
