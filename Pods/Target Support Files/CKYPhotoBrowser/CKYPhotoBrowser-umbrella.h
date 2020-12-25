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

#import "KYPhotoBrowserController.h"
#import "KYPhotoBrowserMacro.h"
#import "KYPhotoBrowserManager.h"
#import "KYPhotoGestureHandle.h"
#import "KYPhotoModel.h"
#import "KYPhotoZoomView.h"

FOUNDATION_EXPORT double CKYPhotoBrowserVersionNumber;
FOUNDATION_EXPORT const unsigned char CKYPhotoBrowserVersionString[];

