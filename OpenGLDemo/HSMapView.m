//
//  HSMapView.m
//  OpenGLDemo
//
//  Created by haoshuai on 2021/9/16.
//

#import "HSMapView.h"
#import <OpenAL/OpenAL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES3/gl.h>
#import <GLKit/GLKit.h>

@implementation HSMapView
{
    EAGLContext *_context;
    CAEAGLLayer *_eaglLayer;
    GLuint _colorBufferRender;
    GLuint _frameBuffer;
    GLuint _glProgram;
    GLuint _positionSlot;
    GLuint _textureSlot;
    GLuint _textureCoordsSlot;
    GLuint _textureID;
    CGRect _frameCAEAGLLayer;
    CADisplayLink *_displayLink;
}
+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(draw:)];
        _displayLink.preferredFramesPerSecond = 60;
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)draw:(id)sender {
    
    if (_context == nil) {
        NSLog(@"第一次创建上下文");
        _context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
        
        [EAGLContext setCurrentContext:_context];
        
        _eaglLayer = (CAEAGLLayer*)self.layer;
        _eaglLayer.frame = self.frame;
        _eaglLayer.opaque = YES;
        _eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],kEAGLDrawablePropertyRetainedBacking,
        　　　　　　　　　　　　　　　　　　　　kEAGLColorFormatRGBA8,kEAGLDrawablePropertyColorFormat, nil];
        // 渲染缓冲区
        glGenRenderbuffers(1, &_colorBufferRender);
        glBindRenderbuffer(GL_RENDERBUFFER, _colorBufferRender);
            
        // // 将可绘制对象的存储绑定到OpenGL ES renderbuffer对象。
        [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
            
        //  帧缓冲区
        {
            glGenFramebuffers(1, &_frameBuffer);
            glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
        }
        
        
        // 将 渲染缓冲区 挂载到当前 帧缓冲区上
        glFramebufferRenderbuffer(GL_FRAMEBUFFER,
                                      GL_COLOR_ATTACHMENT0,
                                      GL_RENDERBUFFER,
                                      _colorBufferRender);
    }
    

    
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    // 绑定到窗口
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}


@end
