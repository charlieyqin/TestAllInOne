//
//  KingfisherOptionsInfo.swift
//  Kingfisher
//
//  Created by Wei Wang on 15/4/23.
//
//  Copyright (c) 2016 Wei Wang <onevcat@gmail.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(OSX)
import AppKit
#else
import UIKit
#endif
    

/**
*	KingfisherOptionsInfo is a typealias for [KingfisherOptionsInfoItem]. You can use the enum of option item with value to control some behaviors of Kingfisher.
*/
public typealias KingfisherOptionsInfo = [KingfisherOptionsInfoItem]
let KingfisherEmptyOptionsInfo = [KingfisherOptionsInfoItem]()

/**
Items could be added into KingfisherOptionsInfo.

- TargetCache: The associated value of this member should be an ImageCache object. Kingfisher will use the specified cache object when handling related operations, including trying to retrieve the cached images and store the downloaded image to it.
- Downloader:  The associated value of this member should be an ImageDownloader object. Kingfisher will use this downloader to download the images.
- Transition:  Member for animation transition when using UIImageView. Kingfisher will use the `ImageTransition` of this enum to animate the image in if it is downloaded from web. The transition will not happen when the image is retrieved from either memory or disk cache.
- DownloadPriority: Associated `Float` value will be set as the priority of image download task. The value for it should be between 0.0~1.0. If this option not set, the default value (`NSURLSessionTaskPriorityDefault`) will be used.
- ForceRefresh: If set, `Kingfisher` will ignore the cache and try to fire a download task for the resource.
- CacheMemoryOnly: If set, `Kingfisher` will only cache the value in memory but not in disk.
- BackgroundDecode: Decode the image in background thread before using.
- CallbackDispatchQueue: The associated value of this member will be used as the target queue of dispatch callbacks when retrieving images from cache. If not set, `Kingfisher` will use main quese for callbacks.
- ScaleFactor: The associated value of this member will be used as the scale factor when converting retrieved data to an image.
*/
public enum KingfisherOptionsInfoItem {
    case targetCache(ImageCache?)
    case downloader(ImageDownloader?)
    case transition(ImageTransition)
    case downloadPriority(Float)
    case forceRefresh
    case cacheMemoryOnly
    case backgroundDecode
    case callbackDispatchQueue(DispatchQueue?)
    case scaleFactor(CGFloat)
}

infix operator <== {
    associativity none
    precedence 160
}



// This operator returns true if two `KingfisherOptionsInfoItem` enum is the same, without considering the associated values.
func <== (lhs: KingfisherOptionsInfoItem, rhs: KingfisherOptionsInfoItem) -> Bool {
    switch (lhs, rhs) {
    case (.targetCache(_), .targetCache(_)): return true
    case (.downloader(_), .downloader(_)): return true
    case (.transition(_), .transition(_)): return true
    case (.downloadPriority(_), .downloadPriority(_)): return true
    case (.forceRefresh, .forceRefresh): return true
    case (.cacheMemoryOnly, .cacheMemoryOnly): return true
    case (.backgroundDecode, .backgroundDecode): return true
    case (.callbackDispatchQueue(_), .callbackDispatchQueue(_)): return true
    case (.scaleFactor(_), .scaleFactor(_)): return true
    default: return false
    }
}

extension Collection where Iterator.Element == KingfisherOptionsInfoItem {
    func kf_firstMatchIgnoringAssociatedValue(_ target: Iterator.Element) -> Iterator.Element? {
        return index { $0 <== target }.flatMap { self[$0] }
    }
}

extension Collection where Iterator.Element == KingfisherOptionsInfoItem {
    var targetCache: ImageCache? {
        if let item = kf_firstMatchIgnoringAssociatedValue(.targetCache(nil)),
            case .targetCache(let cache) = item
        {
            return cache
        }
        return nil
    }
    
    var downloader: ImageDownloader? {
        if let item = kf_firstMatchIgnoringAssociatedValue(.downloader(nil)),
            case .downloader(let downloader) = item
        {
            return downloader
        }
        return nil
    }
    
    var transition: ImageTransition {
        if let item = kf_firstMatchIgnoringAssociatedValue(.transition(.none)),
            case .transition(let transition) = item
        {
            return transition
        }
        return ImageTransition.none
    }
    
    var downloadPriority: Float {
        if let item = kf_firstMatchIgnoringAssociatedValue(.downloadPriority(0)),
            case .downloadPriority(let priority) = item
        {
            return priority
        }
        return URLSessionTask.defaultPriority
    }
    
    var forceRefresh: Bool {
        return contains{ $0 <== .forceRefresh }
    }
    
    var cacheMemoryOnly: Bool {
        return contains{ $0 <== .cacheMemoryOnly }
    }
    
    var backgroundDecode: Bool {
        return contains{ $0 <== .backgroundDecode }
    }
    
    var callbackDispatchQueue: DispatchQueue {
        if let item = kf_firstMatchIgnoringAssociatedValue(.callbackDispatchQueue(nil)),
            case .callbackDispatchQueue(let queue) = item
        {
            return queue ?? DispatchQueue.main
        }
        return DispatchQueue.main
    }
    
    var scaleFactor: CGFloat {
        if let item = kf_firstMatchIgnoringAssociatedValue(.scaleFactor(0)),
            case .scaleFactor(let scale) = item
        {
            return scale
        }
        return 1.0
    }
}
