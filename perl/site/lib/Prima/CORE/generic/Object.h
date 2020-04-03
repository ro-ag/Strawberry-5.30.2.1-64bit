/* This file was automatically generated.
 * Do not edit, you'll lose your changes anyway.
 * file: Object.h  */
#ifndef Object_H_
#define Object_H_
#ifndef _APRICOT_H_
#include "apricot.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

typedef struct _Object_vmt {
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
} Object_vmt, *PObject_vmt;

extern PObject_vmt CObject;

typedef struct _Object {
/* internal pointers */
	PObject_vmt self;
	void *super;
	SV  *mate;
	struct _AnyObject *killPtr;
/* instance variables */
	int stage;
	int protectCount;
	int destroyRefCount;
	Handle owner;
	void * transient_class;
	ObjectOptions options;
} Object, *PObject;

extern void register_Object_Class( void);

/* Local methods definitions */
extern void Object_cleanup( Handle self);
extern void Object_done( Handle self);
extern void Object_init( Handle self, HV * profile );
extern void Object_profile_add( Handle self, SV * profile );
extern void Object_profile_check_in( Handle self, SV * profile ,SV * default_profile );
extern SV * Object_profile_default( Handle self);
extern void Object_set( Handle self, HV * profile );
extern void Object_setup( Handle self);


#ifdef __cplusplus
}
#endif
#endif
