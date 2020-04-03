/* This file was automatically generated.
 * Do not edit, you'll lose your changes anyway.
 * file: Component.h  */
#ifndef Component_H_
#define Component_H_
#ifndef _APRICOT_H_
#include "apricot.h"
#endif
#include "Object.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _Component_vmt {
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
} Component_vmt, *PComponent_vmt;

extern PComponent_vmt CComponent;

typedef struct _Component {
/* internal pointers */
	PComponent_vmt self;
	PObject_vmt super;
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
} Component, *PComponent;

extern void register_Component_Class( void);

/* Local methods definitions */
extern void Component_cleanup( Handle self);
extern void Component_done( Handle self);
extern void Component_init( Handle self, HV * profile );
extern SV * Component_profile_default( Handle self);
extern void Component_set( Handle self, HV * profile );
extern void Component_setup( Handle self);
extern Bool Component_eventFlag( Handle self, Bool set, Bool value);
extern SV * Component_delegations( Handle self, Bool set, SV * value);
extern SV * Component_name( Handle self, Bool set, SV * value);
extern Handle Component_owner( Handle self, Bool set, Handle value);
extern UV Component_add_notification( Handle self, char * name ,SV * subroutine ,Handle referer ,int index );
extern void Component_attach( Handle self, Handle objectHandle );
extern Handle Component_bring( Handle self, char * componentName );
extern Bool Component_can_event( Handle self);
extern void Component_clear_event( Handle self);
extern void Component_detach( Handle self, Handle objectHandle ,Bool kill );
extern void Component_event_error( Handle self);
extern Handle Component_first_that_component( Handle self, void * actionProc ,void * params );
extern void Component_get_components( Handle self);
extern SV * Component_get_handle( Handle self);
extern void Component_get_notification( Handle self, char * name ,int index );
extern void Component_handle_event( Handle self, PEvent event );
extern int Component_is_owner( Handle self, Handle objectHandle );
extern Bool Component_message( Handle self, PEvent event );
extern Bool Component_migrate( Handle self, Handle attachTo );
extern SV * Component_notification_types( Handle self);
extern Bool Component_notify( Handle self, char * format ,... );
extern Bool Component_pop_event( Handle self);
extern void Component_post_message( Handle self, SV * info1 ,SV * info2 );
extern void Component_push_event( Handle self);
extern void Component_recreate( Handle self);
extern void Component_remove_notification( Handle self, UV id );
extern void Component_set_notification( Handle self, char * name ,SV * subroutine );
extern void Component_unlink_notifier( Handle self, Handle referer );
extern void Component_update_sys_handle( Handle self, HV * profile );
extern Bool Component_validate_owner( Handle self, Handle * newOwner ,HV * profile );

#undef  get_eventFlag
#undef  set_eventFlag
#define get_eventFlag(__hs)         eventFlag((__hs),0,(Bool)0)
#define set_eventFlag(__hs,__val)   eventFlag((__hs),1,(__val))
#undef  get_name
#undef  set_name
#define get_name(__hs)         name((__hs),0,(SV *)0)
#define set_name(__hs,__val)   name((__hs),1,(__val))
#undef  get_owner
#undef  set_owner
#define get_owner(__hs)         owner((__hs),0,(Handle)0)
#define set_owner(__hs,__val)   owner((__hs),1,(__val))
#undef  get_delegations
#undef  set_delegations
#define get_delegations(__hs)         delegations((__hs),0,(SV *)0)
#define set_delegations(__hs,__val)   delegations((__hs),1,(__val))

#ifdef __cplusplus
}
#endif
#endif
