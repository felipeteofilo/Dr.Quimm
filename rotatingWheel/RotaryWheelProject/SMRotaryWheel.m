//
//  SMRotaryWheel.m
//  RotaryWheelProject
//
//  Created by cesarerocchi on 2/10/12.
//  Copyright (c) 2012 studiomagnolia.com. All rights reserved.


#import "SMRotaryWheel.h"
#import <QuartzCore/QuartzCore.h>
#import "SMCLove.h"

@interface SMRotaryWheel()
    - (void)drawWheel;
    - (float) calculateDistanceFromCenter:(CGPoint)point;
    - (void) buildClovesEven;
    - (void) buildClovesOdd;
    - (UIImageView *) getCloveByValue:(int)value;
    - (NSString *) getCloveName:(int)position;
@end

static float deltaAngle;
static float minAlphavalue = 0.6;
static float maxAlphavalue = 1.0;

@implementation SMRotaryWheel

@synthesize delegate, container, numberOfSections, startTransform, cloves, currentValue;

//MODIFICADO PELA JULIA
- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber eCompostos:(NSArray *)arrayDeCompostos {
    
    if ((self = [super initWithFrame:frame])) {
		
        //MODIFICADO PELA JULIA
        self.arrayDeCompostos = [[NSArray alloc]initWithArray:arrayDeCompostos];
        self.tagImagemSelecionada = 0;
        
        self.currentValue = 0;
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
		[self drawWheel];
        
	}
    return self;
}



- (void) drawWheel {

    container = [[UIView alloc] initWithFrame:self.frame];
    CGFloat angleSize = 2*M_PI/numberOfSections;
    
    //MODIFICADO PELA JULIA
    for (int i = 0; i < numberOfSections; i++) {
        AreaComposto *areaComposto = [[AreaComposto alloc]initComFrame:CGRectMake(container.bounds.size.width/2.0, container.bounds.size.height/2.0, container.bounds.size.width * 0.5, container.bounds.size.height * 0.5) eComposto:[self.arrayDeCompostos objectAtIndex:i]];
        
        areaComposto.layer.anchorPoint = CGPointMake(0.5f, 1.0f);
        areaComposto.contentMode = UIViewContentModeScaleAspectFit;
        areaComposto.layer.position = CGPointMake(container.bounds.size.width/2.0 - container.frame.origin.x, container.bounds.size.height/2.0 - container.frame.origin.y);
        areaComposto.transform = CGAffineTransformMakeRotation(angleSize * i);
        areaComposto.alpha = minAlphavalue;
        areaComposto.tag = i;

        [container addSubview:areaComposto];
    }
    
    container.userInteractionEnabled = NO;
    [self addSubview:container];
    
    cloves = [NSMutableArray arrayWithCapacity:numberOfSections];
    
    if (numberOfSections % 2 == 0) {
        [self buildClovesEven];
    } else {
        [self buildClovesOdd];
    }
    
    [self.delegate wheelDidChangeValue:[self getCloveName:currentValue]];
}


- (UIImageView *) getCloveByValue:(int)value {

    UIImageView *res;
    NSArray *views = [container subviews];
    for (UIImageView *im in views) {
        if (im.tag == value)
            res = im;
    }
    return res;
}

- (void) buildClovesEven {
    CGFloat fanWidth = M_PI*2/numberOfSections;
    CGFloat mid = 0;
    
    for (int i = 0; i < numberOfSections; i++) {
        SMClove *clove = [[SMClove alloc] init];
        clove.midValue = mid;
        clove.minValue = mid - (fanWidth/2);
        clove.maxValue = mid + (fanWidth/2);
        clove.value = i;
        
        if (clove.maxValue - fanWidth < - M_PI) {
            mid = M_PI;
            clove.midValue = mid;
            clove.midValue = fabsf(clove.maxValue);
        }
        
        mid -= fanWidth;
        [cloves addObject:clove];
    }
}


- (void) buildClovesOdd {
    CGFloat fanWidth = M_PI*2/numberOfSections;
    CGFloat mid = 0;
    for (int i = 0; i < numberOfSections; i++) {
        SMClove *clove = [[SMClove alloc] init];
        clove.midValue = mid;
        clove.minValue = mid - (fanWidth/2);
        clove.maxValue = mid + (fanWidth/2);
        clove.value = i;
        mid -= fanWidth;
        
        if (clove.minValue < - M_PI) {
            mid = -mid;
            mid -= fanWidth;
        }
        
        [cloves addObject:clove];
        NSLog(@"cl is %@", clove);
    }
}

- (float) calculateDistanceFromCenter:(CGPoint)point {
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
	float dx = point.x - center.x;
	float dy = point.y - center.y;
	return sqrt(dx*dx + dy*dy);
    
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touch locationInView:self];
    float dist = [self calculateDistanceFromCenter:touchPoint];
    
    if (dist < 40 || dist > 100) 
    {
        // forcing a tap to be on the ferrule
        NSLog(@"ignoring tap (%f,%f)", touchPoint.x, touchPoint.y);
        return NO;
    }
    
	float dx = touchPoint.x - container.center.x;
	float dy = touchPoint.y - container.center.y;
	deltaAngle = atan2(dy,dx); 
    
    startTransform = container.transform;
    
    UIImageView *im = [self getCloveByValue:currentValue];
    
    //MODIFICADO PELA JULIA
    [self alterarAlphanaImagem:im];
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event{
	CGPoint pt = [touch locationInView:self];
	
	float dx = pt.x  - container.center.x;
	float dy = pt.y  - container.center.y;
	float ang = atan2(dy,dx);
    
    float angleDifference = deltaAngle - ang;
    container.transform = CGAffineTransformRotate(startTransform, -angleDifference);
    
    UIImageView *im = [self getCloveByValue:currentValue];
    NSLog(@"%i", im.tag);
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event{
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    CGFloat newVal = 0.0;
    for (SMClove *c in cloves) {
        if (c.minValue > 0 && c.maxValue < 0) { // anomalous case
            if (c.maxValue > radians || c.minValue < radians) {
                if (radians > 0) { // we are in the positive quadrant
                    newVal = radians - M_PI;
                } else { // we are in the negative one
                    newVal = M_PI + radians;
                }
                currentValue = c.value;
            }
        }
        else if (radians > c.minValue && radians < c.maxValue) {
            newVal = radians - c.midValue;
            currentValue = c.value;
        }
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
    container.transform = t;
    
    [UIView commitAnimations];
    
    [self.delegate wheelDidChangeValue:[self getCloveName:currentValue]];
    
    UIImageView *im = [self getCloveByValue:currentValue];
    
    //MODIFICADO PELA JULIA
    [self alterarAlphanaImagem:im];
}

- (NSString *) getCloveName:(int)position {
    
    NSString *nome =[NSString stringWithFormat:@"%@", [self.arrayDeCompostos objectAtIndex:position]];
    return nome;
}

//MODIFICADO PELA JULIA
-(void)alterarAlphanaImagem:(UIImageView *)imagem{
    
    
    
}



@end
