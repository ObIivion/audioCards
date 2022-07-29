//
//  AudioStoriesCollectionViewFlowLayout.swift
//  SaysomeDemo
//
//  Created by Павел Виноградов on 19.07.2022.
//

import UIKit

class AudioStoriesCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    let activeDistance: CGFloat = 100
    let zoomFactor: CGFloat = 0.2
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            guard let collectionView = collectionView else { return nil }
            let rectAttributes = super.layoutAttributesForElements(in: rect)!.map { $0.copy() as! UICollectionViewLayoutAttributes }
            let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.frame.size)

            // Make the cells be zoomed when they reach the center of the screen
            for attributes in rectAttributes where attributes.frame.intersects(visibleRect) {
                let distance = visibleRect.midX - attributes.center.x
                let normalizedDistance = distance / activeDistance

                if distance.magnitude < activeDistance {
                    let zoom = 1 + zoomFactor * (1 - normalizedDistance.magnitude)
                    attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                    attributes.zIndex = Int(zoom.rounded())
                }
            }
        
            return rectAttributes
        }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        guard let collectionView = self.collectionView else { return proposedContentOffset }
        
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.size.width / 2
        var adjustementOffset = CGFloat.greatestFiniteMagnitude
        
        // какой-то шок начинается
        
        guard let attributesList = super.layoutAttributesForElements(in: targetRect) else { return proposedContentOffset }
        
        for attrbutes in attributesList {
            
            if abs(attrbutes.center.x - horizontalCenter) < abs(adjustementOffset) {
                adjustementOffset = attrbutes.center.x - horizontalCenter
            }
        }
        return CGPoint(x: proposedContentOffset.x + adjustementOffset, y: proposedContentOffset.y)
        
    }

}
