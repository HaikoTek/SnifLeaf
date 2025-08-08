//
//  LogProcessor.swift
//  Shared
//
//  Created by Hg Q. on 11/6/25.
//

import Foundation
import SnifLeafCore

public class LogProcessor: ObservableObject {

    // MARK: - Dependencies
    private var dbManager: GRDBManager!

    public init(dbManager: GRDBManager) {
        self.dbManager = dbManager
        print("LogProcessor initialized.")
    }
    
    public func processBatchNewLogs(_ logEntries: [LogEntry]) {
        Task {
            for logEntry in logEntries {
                let logToSave = logEntry
                self.processNewLog(logToSave)
            }
        }
    }

    public func processNewLog(_ logEntry: LogEntry) {
        Task {
            var logToSave = logEntry
            
            let filteredCategory: TrafficCategory
            if logEntry.url.contains("video") {
                filteredCategory = .videoStreaming
            } else if logEntry.url.contains("/order") {
                if logEntry.url.contains("agile/order") {
                    filteredCategory = .floAgileOrders
                } else {
                    filteredCategory = .sortsEndpoints
                }
            } else if logEntry.url.contains("domailsvr") {
                filteredCategory = .floWeb
            } else if logEntry.url.contains("v41-api") {
                filteredCategory = .floApp
            } else if logEntry.url.contains("chime") {
                filteredCategory = .callChat
            } else if logEntry.url.contains("socket") {
                filteredCategory = .socket
            } else if logEntry.url.contains("news") {
                filteredCategory = .newsAndInformation
            } else if logEntry.url.contains("imap") {
                filteredCategory = .email
            } else if logEntry.url.contains("flodav") {
                filteredCategory = .calendars
            } else if logEntry.url.contains("api-last-modified") {
                filteredCategory = .analytics
            } else {
                filteredCategory = .others
            }

            logToSave.trafficCategory = filteredCategory
            dbManager.insertLogEntry(log: logToSave)
        }
    }
}
