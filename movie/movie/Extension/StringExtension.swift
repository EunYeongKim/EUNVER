//
//  StringExtension.swift
//  movie
//
//  Created by 60080252 on 2020/08/31.
//  Copyright © 2020 60080252. All rights reserved.
//

import Foundation
import UIKit

extension String {
    // <b> 하이라이트 효과
    func htmlEscapedWithHighlight(isTitle: Bool, colorHex: String, font: UIFont) -> NSAttributedString {
        let titleStyle = """
                        <style>
                        body {
                        font-size: 17px;
                        font-family: \(font.familyName);
                        font-weight: bolder;
                        }
                        b {
                        color: \(colorHex);
                        }
                        </style>
                        """
        
        let subtitleStyle = """
                            <style>
                            body {
                            font-family: \(font.familyName);
                            font-size: 13px;
                            }
                            b {
                            color: \(colorHex);
                            }
                            </style>
                            """
        var modified = ""
        if isTitle {
            modified = String(format:"\(titleStyle)%@", self)
        } else {
            modified = String(format:"\(subtitleStyle)%@", self)
        }
        
        do {
            guard let data = modified.data(using: .unicode) else {
                return NSAttributedString(string: self)
            }
            let attributed = try NSAttributedString(data: data,
                                                    options: [.documentType: NSAttributedString.DocumentType.html],
                                                    documentAttributes: nil)
            return attributed
        } catch {
            return NSAttributedString(string: self)
        }
    }
    
    // html 태그 제거, html entity들 디코딩.
    var htmlEscaped: String {
        guard let encodedData = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributed = try NSAttributedString(data: encodedData,
                                                    options: options,
                                                    documentAttributes: nil)
            return attributed.string
        } catch {
            return self
        }
    }
}
