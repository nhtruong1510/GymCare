//
//  ImageCompresor.h
//  GymCare
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ImageCompresor;

@interface ImageCompresor : NSObject

@property UIImage *image;
@property NSData *data;

-(void)shrinkImage : (float) maxVal;

@end
