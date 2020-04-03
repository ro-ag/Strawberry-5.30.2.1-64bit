/* This file was automatically generated.
 * Do not edit, you'll lose your changes anyway.
 * file: Region.h  */
#ifndef Region_H_
#define Region_H_
#ifndef _APRICOT_H_
#include "apricot.h"
#endif
#include "Component.h"
#include "Types.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _Region_vmt {
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
	Box ( *box)( Handle self);
	Bool ( *combine)( Handle self, Handle other_region ,int rgnop );
	SV * ( *get_boxes)( Handle self);
	Bool ( *equals)( Handle self, Handle other_region );
	Bool ( *is_empty)( Handle self);
	Bool ( *offset)( Handle self, int dx ,int dy );
	Bool ( *point_inside)( Handle self, Point p );
	int ( *rect_inside)( Handle self, Rect p );
	PRegionRec ( *update_change)( Handle self, Bool disown );
	Handle ( *create_from_data)( Handle self, PRegionRec data );
} Region_vmt, *PRegion_vmt;

extern PRegion_vmt CRegion;

typedef struct _Region {
/* internal pointers */
	PRegion_vmt self;
	PComponent_vmt super;
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
	PRegionRec rects;
} Region, *PRegion;

extern void register_Region_Class( void);

/* Local methods definitions */
extern void Region_done( Handle self);
extern void Region_init( Handle self, HV * profile );
extern SV * Region_get_handle( Handle self);
extern Bool Region_combine( Handle self, Handle other_region ,int rgnop );
extern SV * Region_get_boxes( Handle self);
extern Bool Region_equals( Handle self, Handle other_region );
extern Bool Region_offset( Handle self, int dx ,int dy );
extern PRegionRec Region_update_change( Handle self, Bool disown );
extern Handle Region_create_from_data( Handle self, PRegionRec data );

#undef  get_eventFlag
#undef  set_eventFlag
#define get_eventFlag(__hs)         eventFlag((__hs),0,(Bool)0)
#define set_eventFlag(__hs,__val)   eventFlag((__hs),1,(__val))
#undef  get_owner
#undef  set_owner
#define get_owner(__hs)         owner((__hs),0,(Handle)0)
#define set_owner(__hs,__val)   owner((__hs),1,(__val))
#undef  get_name
#undef  set_name
#define get_name(__hs)         name((__hs),0,(SV *)0)
#define set_name(__hs,__val)   name((__hs),1,(__val))
#undef  get_delegations
#undef  set_delegations
#define get_delegations(__hs)         delegations((__hs),0,(SV *)0)
#define set_delegations(__hs,__val)   delegations((__hs),1,(__val))

#ifdef __cplusplus
}
#endif
#endif
