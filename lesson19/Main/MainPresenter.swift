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
    private var textArray: [Note] = []
    
    weak var view: MainViewProtocol?

    func viewDidLoad() {
        DatabaseService.shared.entitiesFor(
            type: Note.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { notes in
                self.textArray = notes
                self.view?.reloadTableView()
            }
        )
    }
    
    func removeText(for indexPath: IndexPath) {
        DatabaseService.shared.delete(
            textArray[indexPath.row],
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { [weak self] _ in
                guard let self = self else { return }
                self.textArray.remove(at: indexPath.row)
                DatabaseService.shared.saveMain(nil)
                self.view?.removeElementFromTableView(to: indexPath)
            })
        
    }
    
    func addNewText(text: String) {
//        сохранение в базу данных Core Data
        DatabaseService.shared.insertEntityFor(
            type: Note.self,
            context: DatabaseService.shared.persistentContainer.mainContext,
            closure: { note in
                note.text = text
//                note.creationDate = CreationDate(date: Date())
                self.textArray.append(note)
                DatabaseService.shared.saveMain(nil)
                self.view?.addElementToTableView(
                    to: IndexPath(
                        row: self.numberOfElementsInTextArray() - 1,
                        section: 0
                    )
                )
            }
        )
       
    }
    
    func numberOfElementsInTextArray() -> Int {
        return textArray.count
    }
    
    func elementInTextArray(for indexPath: IndexPath) -> String {
        return textArray[indexPath.row].text!
    }
}
