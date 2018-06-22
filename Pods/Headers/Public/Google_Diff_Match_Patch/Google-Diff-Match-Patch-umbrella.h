#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "DiffMatchPatch.h"
#import "DiffMatchPatchCFUtilities.h"
#import "JXArcCompatibilityMacros.h"
#import "MinMaxMacros.h"
#import "NSMutableDictionary+DMPExtensions.h"
#import "NSString+JavaSubstring.h"
#import "NSString+UnicharUtilities.h"
#import "NSString+UriCompatibility.h"

FOUNDATION_EXPORT double Google_Diff_Match_PatchVersionNumber;
FOUNDATION_EXPORT const unsigned char Google_Diff_Match_PatchVersionString[];

