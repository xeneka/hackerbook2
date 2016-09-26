//
//  Books+CoreDataProperties.swift
//  hackerbookv2
//
//  Created by Antonio Benavente del Moral on 25/9/16.
//  Copyright © 2016 Antonio Benavente del Moral. All rights reserved.
//

import Foundation
import CoreData


extension Books {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Books> {
        return NSFetchRequest<Books>(entityName: "Books");
    }

    @NSManaged public var download: Bool
    @NSManaged public var favorite: Bool
    @NSManaged public var lastOpen: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var urlPdf: String?
    @NSManaged public var annotations: NSSet?
    @NSManaged public var authors: NSSet?
    @NSManaged public var booktag: NSSet?
    @NSManaged public var images: Image?
    @NSManaged public var pdfbook: PdfBook?

}

// MARK: Generated accessors for annotations
extension Books {

    @objc(addAnnotationsObject:)
    @NSManaged public func addToAnnotations(_ value: Annotations)

    @objc(removeAnnotationsObject:)
    @NSManaged public func removeFromAnnotations(_ value: Annotations)

    @objc(addAnnotations:)
    @NSManaged public func addToAnnotations(_ values: NSSet)

    @objc(removeAnnotations:)
    @NSManaged public func removeFromAnnotations(_ values: NSSet)

}

// MARK: Generated accessors for authors
extension Books {

    @objc(addAuthorsObject:)
    @NSManaged public func addToAuthors(_ value: Authors)

    @objc(removeAuthorsObject:)
    @NSManaged public func removeFromAuthors(_ value: Authors)

    @objc(addAuthors:)
    @NSManaged public func addToAuthors(_ values: NSSet)

    @objc(removeAuthors:)
    @NSManaged public func removeFromAuthors(_ values: NSSet)

}

// MARK: Generated accessors for booktag
extension Books {

    @objc(addBooktagObject:)
    @NSManaged public func addToBooktag(_ value: BookTag)

    @objc(removeBooktagObject:)
    @NSManaged public func removeFromBooktag(_ value: BookTag)

    @objc(addBooktag:)
    @NSManaged public func addToBooktag(_ values: NSSet)

    @objc(removeBooktag:)
    @NSManaged public func removeFromBooktag(_ values: NSSet)

}
