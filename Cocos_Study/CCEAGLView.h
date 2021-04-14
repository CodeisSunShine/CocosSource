//
//  CCEAGLView.h
//  Cocos_Study
//
//  Created by 宫傲 on 2021/4/12.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <CoreFoundation/CoreFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCEAGLView : UIView

@property (nonatomic, strong) EAGLContext *context;
@property (nonatomic, assign) BOOL preserveBackbuffer;
@property (nonatomic, copy) NSString *pixelformatString;

@property (nonatomic, strong) EAGLSharegroup *sharegroup;
@property (nonatomic, assign) GLuint defaultFramebuffer;
@property (nonatomic, assign) GLuint defaultColorBuffer;
@property (nonatomic, assign) GLuint defaultDepthBuffer;

@property (nonatomic, assign) BOOL multisampling;
@property (nonatomic, assign) int requestedSamples;
@property (nonatomic, assign) GLuint msaaFramebuffer;
@property (nonatomic, assign) GLuint msaaColorBuffer;
@property (nonatomic, assign) GLuint msaaDepthBuffer;

- (void)setupGLContext;

@end

NS_ASSUME_NONNULL_END
