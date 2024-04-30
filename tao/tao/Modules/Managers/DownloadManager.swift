//
//  DownloadManager.swift
//  tao
//
//  Created by Mayank Khursija on 16/08/22.
//

import Foundation

class DownloadManager {
    static let instance = DownloadManager()
    
    //TODO: Move Inititalization to BaseViewModel
    private init() {
        //
    }
    func saveFile(url: String, fileName: String, completition: @escaping (Bool)-> Void) {
        DispatchQueue.global(qos: .background).async {
            let url = URL(string: url)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "Tao-\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                completition(true)
            } catch {
                completition(false)
            }
        }
    }
}

