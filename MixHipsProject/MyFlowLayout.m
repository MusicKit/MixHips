//
//  MyFlowLayout.m
//  DragCollectionViewCell
//
//  Created by Sang Quý Lê on 2/26/13.
//  Copyright (c) 2013 Quy Sang Le. All rights reserved.
//

#import "MyFlowLayout.h"

@implementation MyFlowLayout


- (CGSize)collectionViewContentSize
{
    NSUInteger count = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    
    CGSize canvasSize = self.collectionView.frame.size;
    CGSize contentSize = canvasSize;
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal)
    {
        NSUInteger rowCount = (canvasSize.height - self.itemSize.height) / (self.itemSize.height + self.minimumInteritemSpacing) + 1;
        NSUInteger columnCount = (canvasSize.width - self.itemSize.width) / (self.itemSize.width + self.minimumLineSpacing) + 1;
        NSUInteger page = ceilf((CGFloat)count / (CGFloat)(rowCount * columnCount));
        contentSize.width = page * canvasSize.width;
    }
    
    return contentSize;
    /*NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger pages = ceil(itemCount / 4.0);
    
    return CGSizeMake(320 * pages, self.collectionView.frame.size.height);
     */
}

- (CGRect)frameForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize canvasSize = self.collectionView.frame.size;
    
    NSUInteger rowCount = (canvasSize.height - self.itemSize.height) / (self.itemSize.height + self.minimumInteritemSpacing) + 1;
    NSUInteger columnCount = (canvasSize.width - self.itemSize.width) / (self.itemSize.width + self.minimumLineSpacing) + 1;
    
    CGFloat pageMarginX = (canvasSize.width - columnCount * self.itemSize.width - (columnCount > 1 ? (columnCount - 1) * self.minimumLineSpacing : 0)) / 2.0f;
    CGFloat pageMarginY = (canvasSize.height - rowCount * self.itemSize.height - (rowCount > 1 ? (rowCount - 1) * self.minimumInteritemSpacing : 0)) / 2.0f;
    
    NSUInteger page = indexPath.row / (rowCount * columnCount);
    NSUInteger remainder = indexPath.row - page * (rowCount * columnCount);
    NSUInteger row = remainder / columnCount;
    NSUInteger column = remainder - row * columnCount;
    
    CGRect cellFrame = CGRectZero;
    cellFrame.origin.x = pageMarginX + column * (self.itemSize.width + self.minimumLineSpacing);
    cellFrame.origin.y = pageMarginY + row * (self.itemSize.height + self.minimumInteritemSpacing);
    cellFrame.size.width = self.itemSize.width;
    cellFrame.size.height = self.itemSize.height;
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal)
    {
        cellFrame.origin.x += page * canvasSize.width;
    }
    
    return cellFrame;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attr = [super layoutAttributesForItemAtIndexPath:indexPath];
    attr.frame = [self frameForItemAtIndexPath:indexPath];
    return attr;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSUInteger count = [self.collectionView.dataSource collectionView:self.collectionView
                                               numberOfItemsInSection:0];
    
    NSMutableArray * attrs = [NSMutableArray array];
    
    for (NSUInteger idx = 0; idx < count; ++idx)
    {
        UICollectionViewLayoutAttributes * attr = nil;
        NSIndexPath * idxPath = [NSIndexPath indexPathForRow:idx inSection:0];
        CGRect itemFrame = [self frameForItemAtIndexPath:idxPath];
        if (CGRectIntersectsRect(itemFrame, rect))
        {
            attr = [self layoutAttributesForItemAtIndexPath:idxPath];
            [attrs addObject:attr];
        }
    }
    
    return attrs;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.itemSize = CGSizeMake(90, 127);
    self.minimumLineSpacing = 8;
    self.sectionInset = UIEdgeInsetsMake(0.f, 0.f, 0.0f, 0.f);
    [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
}

@end
