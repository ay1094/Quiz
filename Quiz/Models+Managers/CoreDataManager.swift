//
//  CoreDataManager.swift
//  Quiz
//
//  Created by Ahmed Yacoob on 11/1/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init(){}
    
    func getScores() -> [Game]{
        let fetchRequest = NSFetchRequest<Game>(entityName: "Game")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        var games = [Game]()
        do{
            games = try context.fetch(fetchRequest)
            return games
        }
        catch{
            print(error)
            return []
        }
        
        
    }
    
    func createNewScore(accuracy: Double, category: String, score: Int16, difficulty: String){
        let date = Date()
        let game = Game(context: context)
        game.accuracy = accuracy
        game.score = score
        game.category = category
        game.date = date
        game.difficulty = difficulty
        do {
            try context.save()
        }
        catch{
            print(error)
        }
        deleteifNecessary()
    }
    
    private func deleteifNecessary(){
        let fetchRequest = NSFetchRequest<Game>(entityName: "Game")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
        var games = [Game]()
        do{
            games = try context.fetch(fetchRequest)
            if games.count == 30 {
                context.delete(games[29])
                do{
                    try context.save()
                }
                catch{
                    print(error)
                }
            }
        }
        catch{
            print(error)
        }
    }
}
