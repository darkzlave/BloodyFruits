//
//  HelloWorldLayer.m
//  BloodyFruits
//
//  Created by Phillipe Casorla Sagot on 8/11/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "CCLabelTTF+Resize.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		CCLabelTTF *fuckingScore = [CCLabelTTF labelWithString:@"BITCHES: 0" fontName:@"arial" fontSize:30];
        fuckingScore.position = ccp(110,300);
        fuckingScore.color = ccRED;
        [self addChild:fuckingScore z:30 tag:666];
        
//        CCLabelTTF *tapLabel = [CCLabelTTF labelWithStringAutoSize:@"Tap Again to Skip" fontName:@"nb_strange" fontSize:20];
//        tapLabel.position = ccp(240,25);
//        [self addChild:tapLabel z:25];

        CCLayerColor *colorBackground = [CCLayerColor layerWithColor:ccc4(130, 0, 34,255)];
        colorBackground.anchorPoint = ccp(0,0);
        colorBackground.position = ccp(0,0);
        colorBackground.opacity = 0;
        [self addChild:colorBackground z:0 tag:11];
        CCSprite *fruit1 = [CCSprite spriteWithFile:@"fruit1.png"];
        [fruit1 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.2f],[CCFadeOut actionWithDuration:0.2f], nil]]];
        CCSprite *fruit2 = [CCSprite spriteWithFile:@"fruit2.png"];
        [fruit2 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.2f],[CCFadeOut actionWithDuration:0.2f], nil]]];
        CCSprite *fruit3 = [CCSprite spriteWithFile:@"fruit3.png"];
        [fruit3 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeIn actionWithDuration:0.2f],[CCFadeOut actionWithDuration:0.2f], nil]]];
        fruit1.position = ccp(170,300);
        fruit2.position = ccp(30,30);
        fruit3.position = ccp(350,300);
        [self addChild:fruit1 z:0 tag:12];
        [self addChild:fruit2 z:0 tag:13];
        [self addChild:fruit3 z:0 tag:14];
        self.isTouchEnabled = YES;
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"love.mp3" loop:YES];        
	}
	return self;
}
-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:NO];
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if([[event allTouches] count] == 2){
        total = 0;
    }
    CCLayerColor *colorBackground = (CCLayerColor*)[self getChildByTag:11];
    [colorBackground runAction:[CCFadeIn actionWithDuration:0.3f]];
    [colorBackground runAction:[CCTintBy actionWithDuration:0.3f red:100 green:10 blue:50]];
    return TRUE;
}
- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {

}
-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCSprite *fruit1 = (CCSprite*)[self getChildByTag:12];
    CCSprite *fruit2 = (CCSprite*)[self getChildByTag:13];
    CCSprite *fruit3 = (CCSprite*)[self getChildByTag:14];
    fruit1.position = ccp(arc4random() % 480,arc4random()%320);
    fruit2.position = ccp(arc4random() % 480,arc4random()%320);
    fruit3.position = ccp(arc4random() % 480,arc4random()%320);
    CCLayerColor *colorBackground = (CCLayerColor*)[self getChildByTag:11];
    [colorBackground runAction:[CCFadeOut actionWithDuration:0.3f]];
    
    CCLabelTTF *fuckingScore = (CCLabelTTF*)[self getChildByTag:666];
    total++;
    [fuckingScore setString:[@"BITCHES: " stringByAppendingFormat:@"%i",total]];
}
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
