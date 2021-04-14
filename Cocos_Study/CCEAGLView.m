//
//  CCEAGLView.m
//  Cocos_Study
//
//  Created by 宫傲 on 2021/4/12.
//

#import "CCEAGLView.h"

@implementation CCEAGLView

- (void)setupGLContext {
    CAEAGLLayer *eagLayer = (CAEAGLLayer *)self.layer;
    eagLayer.opaque = YES;
    /*
     kEAGLDrawablePropertyRetainedBacking:
     true: 保留绘制后的Buffer内容，这样会导致性能下降和占用额外内存开销的问题
     false: 每一次绘制完之后都会把渲染 buffer 清空，导致的后果就是展示 buffer 和 渲染 buffer 各自维护一组点，然后交替显示。
     
     kEAGLDrawablePropertyColorFormat:·  绘制对象内部的颜色缓存区格式
     
     */
//    eagLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
//                                   [NSNumber numberWithBool:self.preserveBackbuffer],kEAGLDrawablePropertyRetainedBacking,
//                                   self.pixelformatString,kEAGLDrawablePropertyRetainedBacking, nil];
    
    /*
     
     
     */
    if (!self.sharegroup) {
        self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
        if (!self.context) {
            self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        }
    } else {
        self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3 sharegroup:self.sharegroup];
        if (!self.context) {
            self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2 sharegroup:self.sharegroup];
        }
    }
    
    // 设置当前线程的上下文
    if (!self.context || ![EAGLContext setCurrentContext:self.context]) {
        NSLog(@"Can not crate GL context.");
        return;
    }
    
    if (![self createFrameBuffer]) {
        return;
    }
    
}

- (BOOL)createAndAttachColorBuffer {
    if (0 == self.defaultFramebuffer) {
        return NO;
    }
    
    // 绑定帧缓冲区
    glBindFramebuffer(GL_FRAMEBUFFER, self.defaultFramebuffer);
    glGenRenderbuffers(1, &_defaultColorBuffer);
    if (0 == self.defaultColorBuffer) {
        NSLog(@"Can not create default color buffer.");
        return NO;
    }
    
    glBindRenderbuffer(GL_RENDERBUFFER, self.defaultColorBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, self.defaultColorBuffer);
    [self checkGLError];
    
    if (!_multisampling || (0 == _msaaFramebuffer)) {
        return YES;
    }
    
    glBindFramebuffer(GL_FRAMEBUFFER, _msaaFramebuffer);
    glGenBuffers(1, &_msaaColorBuffer);
    if (0 == _msaaColorBuffer) {
        NSLog(@"Can not create multi sampling color buffer.");
        return YES;
    }
    
    glBindRenderbuffer(GL_RENDERBUFFER, _msaaColorBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _msaaColorBuffer);
    [self checkGLError];
    return YES;
}

- (void)checkGLError {
    GLenum __error = glGetError();
    if (__error) {
        NSLog(@"error 0x%04X in %@",__error);
    }
}

- (BOOL)createFrameBuffer {
    if (!self.context) {
        return NO;
    }
    
    // 创建帧缓冲区
    glGenBuffers(1, &_defaultFramebuffer);
    if (0 == _defaultFramebuffer) {
        NSLog(@"Can not create default frame buffer");
        return NO;
    }
    
    if (self.multisampling) {
        glGenBuffers(1, &_msaaFramebuffer);
        if (0 == _msaaFramebuffer) {
            NSLog(@"Can not create multi sampling frame buffer");
            self.multisampling = NO;
        }
    }
    
    return YES;
}

@end
