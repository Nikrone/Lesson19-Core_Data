//
//  MainPresenter.swift
//  lesson19
//
//  Created Vladislav on 22.09.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation


// MARK: Presenter -
protocol MainPresenterProtocol {
	var view: MainViewProtocol? { get set }
    func viewDidLoad()
    
    func addNewText(text: String)
    func removeText(for indexPath: IndexPath)
    
    func numberOfElementsInTextArray() -> Int
    func elementInTextArray(for indexPath: IndexPath) -> String
}

class MainPresenter: MainPresenterProtocol {
    private var textArray: [String] = []
    
    weak var view: MainViewProtocol?

    func viewDidLoad() {
        DatabaseService.shared.entitiesFor(
            type: Note.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { notes in
                self.textArray = notes.map({ note in
                    return note.text! + (note.creationDate?.date.description ?? "")
                })
                self.view?.reloadTableView()
            }
        )
    }
    
    func removeText(for indexPath: IndexPath) {
        textArray.remove(at: indexPath.row)
        view?.removeElementFromTableView(to: indexPath)
    }
    
    func addNewText(text: String) {
        textArray.append(text)
//        сохранение в базу данных Core Data
        DatabaseService.shared.insertEntityFor(
            type: Note.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { note in
                note.text = text
                note.creationDate = CreationDate(date: Date())
                DatabaseService.shared.saveMain(nil)
            }
        )
        
        view?.addElementToTableView(
            to: IndexPath(
                row: numberOfElementsInTextArray() - 1,
                section: 0
            )
        )
    }
    
    func numberOfElementsInTextArray() -> Int {
        return textArray.count
    }
    
    func elementInTextArray(for indexPath: IndexPath) -> String {
        return textArray[indexPath.row]
    }
}
