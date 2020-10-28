//
//  DataProvider.swift
//  SimpleNetworking
//
//  Created by cladendas on 28.10.2020.
//  Copyright © 2020 cladendas. All rights reserved.
//

import UIKit

///Класс для фоновой загрузки данных
class DataProvider: NSObject {
    
    private var downloadTask: URLSessionDownloadTask!
    
    ///Для захвата текущего пути к файлу
    var fileLocation: ((URL) -> ())?
    var onProgress: ((Double) -> ())?
    
    ///Параметры конфигурации данных для фоновой загрузки данных
    private lazy var bgSession: URLSession = {
        //Определяет поведение сессии при загрузке-выгрузке данных
        //background - параметры конфигурации с возможностью фоновой загрузки данных, ему передаётся bundl приложения
        let config = URLSessionConfiguration.background(withIdentifier: "study-swift.SimpleNetworking")
        //могут ли фоновые быть запланированы системой для обеспечения оптимальной производительности
//        config.isDiscretionary = true
        //по завершению загрузки данных приложение запустится в фоновом режиме
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    ///Создаётся задача по загрузке данных
    func startDownload() {
        if let url = URL(string: "https://speed.hetzner.de/100MB.bin") {
            //передача параметров конфигурации
            downloadTask = bgSession.downloadTask(with: url)
            //загрузка начнётся не ранее, чем через 3 сек после создания задачи
            downloadTask.earliestBeginDate = Date().addingTimeInterval(3)
            //наиболее вероятная верхняя граница числа байтов, отправляемых клиентом
            downloadTask.countOfBytesClientExpectsToSend = 512
            //наиболее вероятная верхняя граница числа байтов, ожидаемых клиентом (здесь 100mb)
            downloadTask.countOfBytesClientExpectsToReceive = 100 * 1024 * 1024
            downloadTask.resume()
        }
    }
    
    ///Отмена загрузки данных
    func stopDownload() {
        //отменяет все задачи
        downloadTask.cancel()
    }
}

extension DataProvider: URLSessionDelegate {
    //данный метод будет вызываться по завершению всех фоновых приложений, помещённых в очередь с нашим идентификатором приложения, который необходимо передать в AppDelegate (в нём должен вызваться метод, который будет перехватывать идентификатор нашей сессии
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
        DispatchQueue.main.async {
            guard
                let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let complitionHandler = appDelegate.bgSessionComplitionHandler
                else { return }
            
            appDelegate.bgSessionComplitionHandler = nil
            complitionHandler()
        }
    }
}

extension DataProvider: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Did finish downloading: \(location.absoluteString)")
        
        DispatchQueue.main.async {
            self.fileLocation?(location)
        }
    }
    
    ///Для возможности отображения хода выполнения загрузки
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
        //Если ожидаемый размер файла
        guard expectedTotalBytes != NSURLSessionTransferSizeUnknown else { return }
        
        //Результат деления кол-ва переданных байт на общее кол-во байт
        let progress = Double(fileOffset / expectedTotalBytes)
        print("Download progress: \(progress)")
        
        DispatchQueue.main.async {
            self.onProgress?(progress)
        }
    }
}
