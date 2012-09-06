//
//  UserChoosedData.h
//  InfoPortal
//
//  Created by Tcat on 12-9-3.
//  Copyright (c) 2012年 USTB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserChoosedData : NSObject
{
    @public
    long choosedBuildingID;
    int choosedFloorFromID,choosedFloorToID;
    int choosedClassFromID,choosedClassToID;
    long choosedDate;
}
-(void)resetChoosedData;
@end
