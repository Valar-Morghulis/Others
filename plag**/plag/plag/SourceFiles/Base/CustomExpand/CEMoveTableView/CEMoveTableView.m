//
//  CEMoveTableView.m
//  test
//
//  Created by MaYing on 13-12-19.
//  Copyright (c) 2013年 MaYing. All rights reserved.
//

#import "CEMoveTableView.h"

@implementation CESnapShotImageView

- (void)moveByOffset:(CGPoint)offset
{
    CGRect frame = [self frame];
    frame.origin.x += offset.x;
    frame.origin.y += offset.y;
    [self setFrame:frame];
}

@end


@implementation UIGestureRecognizer (CEUtilities)
- (void)cancelTouch
{
	[self setEnabled:NO];
	[self setEnabled:YES];
}
@end

@implementation UITableViewCell (CEMove)

-(void)prepareForMove
{
    [[self textLabel] setText:@""];
	[[self detailTextLabel] setText:@""];
	[[self imageView] setImage:nil];
}
-(void)prepareForStill
{
    //
}
@end

//
@interface CEMoveTableView (AutoscrollingMethods)

- (void)maybeAutoscrollForSnapShotImageView:(CESnapShotImageView *)snapShot;
- (void)autoscrollTimerFired:(NSTimer *)timer;
- (void)legalizeAutoscrollDistance;
- (float)autoscrollDistanceForProximityToEdge:(float)proximity;
- (void)stopAutoscrolling;

@end

@implementation
UITableView (CEMove)
- (BOOL)indexPathIsMovingIndexPath:(NSIndexPath *)indexPath
{
    return FALSE;
}
@end

@implementation CEMoveTableView

@synthesize movingIndexPath = _movingIndexPath;
@synthesize touchOffset = _touchOffset;
@synthesize snapShotImageView = _snapShotImageView;
@synthesize movingGestureRecognizer = _movingGestureRecognizer;

@synthesize autoscrollTimer = _autoscrollTimer;
@synthesize autoscrollDistance = _autoscrollDistance;
@synthesize autoscrollThreshold = _autoscrollThreshold;
- (void)setup
{
	UILongPressGestureRecognizer *movingGestureRecognizer = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)] autorelease];
	[self addGestureRecognizer:movingGestureRecognizer];
	[self setMovingGestureRecognizer:movingGestureRecognizer];
}


- (void)awakeFromNib
{
	[super awakeFromNib];
	[self setup];
}


- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
	if (self = [super initWithFrame:frame style:style])
    {
		[self setup];
	}
	return self;
}

-(void)dealloc
{
    self.movingIndexPath = 0;
    self.snapShotImageView = 0;
    self.movingGestureRecognizer = 0;
    self.autoscrollTimer = 0;
    
    [super dealloc];
}


//
- (BOOL)indexPathIsMovingIndexPath:(NSIndexPath *)indexPath
{
	return ([indexPath compare:[self movingIndexPath]] == NSOrderedSame);
}


- (void)moveRowToLocation:(CGPoint)location
{
	NSIndexPath *newIndexPath = [self indexPathForRowAtPoint:location];
	
	// Analyze the new moving index path
	// 1. It's a valid index path
	// 2. It's not the current index path of the cell
	// 3. The delegate allows moving to the new index path
	if ([newIndexPath section] != NSNotFound && [newIndexPath row] != NSNotFound
		&& [newIndexPath compare:[self movingIndexPath]] != NSOrderedSame
		&& newIndexPath == [[self delegate] moveTableView:self targetIndexPathForMoveFromRowAtIndexPath:[self movingIndexPath] toProposedIndexPath:newIndexPath]
		)
	{
		[self beginUpdates];
		
		// Move the row
		[self deleteRowsAtIndexPaths:[NSArray arrayWithObject:[self movingIndexPath]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		
		// Inform the delegate to update it's model
		[[self dataSource] moveTableView:self moveRowFromIndexPath:[self movingIndexPath] toIndexPath:newIndexPath];
		
		// Update the moving index path
		[self setMovingIndexPath:newIndexPath];
		[self endUpdates];
	}
}



#pragma mark -
#pragma mark Handle long press

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
	switch ([gestureRecognizer state])
	{
		case UIGestureRecognizerStateBegan:
		{
			CGPoint touchPoint = [gestureRecognizer locationInView:self];
			
			// Grap the touched index path
			NSIndexPath *touchedIndexPath = [self indexPathForRowAtPoint:touchPoint];
			
			// Check for a valid index path, otherwise cancel the touch
			if (!touchedIndexPath || [touchedIndexPath section] == NSNotFound || [touchedIndexPath row] == NSNotFound) {
				[gestureRecognizer cancelTouch];
				break;
			}
            UITableViewCell *touchedCell = (UITableViewCell *)[self cellForRowAtIndexPath:touchedIndexPath];
            if(![[self delegate] moveTableView:self canMoveRowAtIndexPath:touchedIndexPath])
            {
                [gestureRecognizer cancelTouch];
                break;
            }
            
            [[self delegate] moveTableView:self beforeMoveRowAtIndexPath:touchedIndexPath];
            
            [self setMovingIndexPath:touchedIndexPath];
			[touchedCell setSelected:NO];
			[touchedCell setHighlighted:NO];
			
			// Compute the touch offset from the cell's center
			CGPoint touchOffset = CGPointMake([touchedCell center].x - touchPoint.x, [touchedCell center].y - touchPoint.y);
			[self setTouchOffset:touchOffset];
			
			
			// Create a snap shot of the touched cell and store it
			CGRect cellFrame = [touchedCell bounds];
			
			if ([[UIScreen mainScreen] scale] == 2.0) {
				UIGraphicsBeginImageContextWithOptions(cellFrame.size, NO, 2.0);
			} else {
				UIGraphicsBeginImageContext(cellFrame.size);
			}
			
			[[touchedCell layer] renderInContext:UIGraphicsGetCurrentContext()];
			UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
			UIGraphicsEndImageContext();
			
			CESnapShotImageView *snapShotOfMovingCell = [[CESnapShotImageView alloc] initWithImage:image];
			CGRect snapShotFrame = [self rectForRowAtIndexPath:touchedIndexPath];
			snapShotFrame.size = cellFrame.size;
			[snapShotOfMovingCell setFrame:snapShotFrame];
			[snapShotOfMovingCell setAlpha:0.95];
			
			[self setSnapShotImageView:snapShotOfMovingCell];
            [snapShotOfMovingCell release];
			[self addSubview:[self snapShotImageView]];
			
			
			// Prepare the cell for moving (e.g. clear it's labels and imageView)
			[touchedCell prepareForMove];
            //
            
			
			// Set a threshold for autoscrolling and reset the autoscroll distance
			[self setAutoscrollThreshold:([[self snapShotImageView] frame].size.height * 0.6)];
			[self setAutoscrollDistance:0.0];
			
			break;
		}
			
		case UIGestureRecognizerStateChanged:
		{
			CGPoint touchPoint = [gestureRecognizer locationInView:self];
			
			// Update the snap shot's position
			CGPoint currentCenter = [[self snapShotImageView] center];
			[[self snapShotImageView] setCenter:CGPointMake(currentCenter.x, touchPoint.y + [self touchOffset].y)];
			
			// Check if the table view has to scroll
			[self maybeAutoscrollForSnapShotImageView:[self snapShotImageView]];
			
			// If the table view does not scroll, compute a new index path for the moving cell
			if ([self autoscrollDistance] == 0) {
				[self moveRowToLocation:touchPoint];
			}
			
			break;
		}
			
		case UIGestureRecognizerStateEnded:
		{
			[self stopAutoscrolling];
			
			// Get to final index path
			CGRect finalFrame = [self rectForRowAtIndexPath:[self movingIndexPath]];
			
			// Place the snap shot to it's final position and fade it out
			[UIView animateWithDuration:0.2
							 animations:^{
								 
								 [[self snapShotImageView] setFrame:finalFrame];
								 [[self snapShotImageView] setAlpha:1.0];
								 
							 }
							 completion:^(BOOL finished) {
								 
								 if (finished)
								 {
									 // Clean up snap shot
									 [[self snapShotImageView] removeFromSuperview];
									 [self setSnapShotImageView:nil];
									 
									 // Reload row at moving index path to reset it's content
									 NSIndexPath *movingIndexPath = [[self movingIndexPath] retain];
                                     [self setMovingIndexPath:nil];
									 [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:movingIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                                     [[self delegate] moveTableView:self afterMoveRowAtIndexPath:movingIndexPath];
                                     [movingIndexPath release];
								 }
								 
							 }];
			
			break;
		}
			
		default:
		{
			// Do some cleanup if necessary
			if ([self movingIndexPath])
			{
				[self stopAutoscrolling];
				
				[[self snapShotImageView] removeFromSuperview];
				[self setSnapShotImageView:nil];
				
				NSIndexPath *movingIndexPath = [[self movingIndexPath] retain];
				[self setMovingIndexPath:nil];
				[self reloadRowsAtIndexPaths:[NSArray arrayWithObject:movingIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                [[self delegate] moveTableView:self afterMoveRowAtIndexPath:movingIndexPath];
                [movingIndexPath release];
			}
			
			break;
		}
	}
}



#pragma mark -
#pragma mark Autoscrolling

- (void)maybeAutoscrollForSnapShotImageView:(CESnapShotImageView *)snapShot
{
    [self setAutoscrollDistance:0];
    
    if (CGRectIntersectsRect([snapShot frame], [self bounds]))
	{
		CGPoint touchLocation = [[self movingGestureRecognizer] locationInView:self];
		touchLocation.y += [self touchOffset].y;
		
        float distanceToTopEdge  = touchLocation.y - CGRectGetMinY([self bounds]);
        float distanceToBottomEdge = CGRectGetMaxY([self bounds]) - touchLocation.y;
		
        if (distanceToTopEdge < [self autoscrollThreshold])
		{
            [self setAutoscrollDistance:[self autoscrollDistanceForProximityToEdge:distanceToTopEdge] * -1];
        }
		else if (distanceToBottomEdge < [self autoscrollThreshold])
		{
            [self setAutoscrollDistance:[self autoscrollDistanceForProximityToEdge:distanceToBottomEdge]];
        }
    }
    
    if ([self autoscrollDistance] == 0)
	{
        [[self autoscrollTimer] invalidate];
        [self setAutoscrollTimer:nil];
    }
    else if (![self autoscrollTimer])
	{
        NSTimer *autoscrollTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 60.0) target:self selector:@selector(autoscrollTimerFired:) userInfo:snapShot repeats:YES];
		[self setAutoscrollTimer:autoscrollTimer];
    }
}


- (float)autoscrollDistanceForProximityToEdge:(float)proximity
{
    return ceilf(([self autoscrollThreshold] - proximity) / 5.0);
}


- (void)legalizeAutoscrollDistance
{
    float minimumLegalDistance = [self contentOffset].y * -1;
    float maximumLegalDistance = [self contentSize].height - ([self frame].size.height + [self contentOffset].y);
    [self setAutoscrollDistance:MAX([self autoscrollDistance], minimumLegalDistance)];
    [self setAutoscrollDistance:MIN([self autoscrollDistance], maximumLegalDistance)];
}


- (void)autoscrollTimerFired:(NSTimer *)timer
{
    [self legalizeAutoscrollDistance];
    
    CGPoint contentOffset = [self contentOffset];
    contentOffset.y += [self autoscrollDistance];
    [self setContentOffset:contentOffset];
    
	// Move the snap shot appropriately
    CESnapShotImageView *snapShot = (CESnapShotImageView *)[timer userInfo];
    [snapShot moveByOffset:CGPointMake(0, [self autoscrollDistance])];
	
	// Even if we autoscroll we need to update the moved cell's index path
	CGPoint touchLocation = [[self movingGestureRecognizer] locationInView:self];
	[self moveRowToLocation:touchLocation];
}


- (void)stopAutoscrolling
{
	[self setAutoscrollDistance:0];
	[[self autoscrollTimer] invalidate];
	[self setAutoscrollTimer:nil];
}



#pragma mark -
#pragma mark Accessor methods

- (void)setSnapShotImageView:(CESnapShotImageView *)snapShotImageView
{
    if(_snapShotImageView != snapShotImageView)
    {
        if(_snapShotImageView) [_snapShotImageView release];
        _snapShotImageView = snapShotImageView;
        if(_snapShotImageView)
        {
            [_snapShotImageView retain];
            [[_snapShotImageView layer] setShadowOpacity:0.2];
            [[_snapShotImageView layer] setShadowRadius:1];
            [[_snapShotImageView layer] setShadowOffset:CGSizeZero];
            
            CGPathRef shadowPath = [[UIBezierPath bezierPathWithRect:[[_snapShotImageView layer] bounds]] CGPath];
            [[_snapShotImageView layer] setShadowPath:shadowPath];
        }
    }
}

@end
