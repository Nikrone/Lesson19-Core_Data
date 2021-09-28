//
//  MainViewController.swift
//  lesson19
//
//  Created Vladislav on 22.09.21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

// MARK: View -
protocol MainViewProtocol: AnyObject {
    func addElementToTableView(to indexPath: IndexPath)
    func removeElementFromTableView(to indexPath: IndexPath)
}

class MainViewController: UIViewController, MainViewProtocol {
    @IBOutlet private weak var tableView: UITableView!
    
	var presenter: MainPresenterProtocol = MainPresenter()

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
        
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MainTableViewCell")
    }
    
    @IBAction private func addButtonPressed() {
        var textFieldText: String = ""
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addTextField { textFeidl in
            textFeidl.addAction(UIAction(handler: { _ in
                textFieldText = textFeidl.text ?? ""
            }), for: .editingChanged)
            
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            self.presenter.addNewText(text: textFieldText)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func addElementToTableView(to indexPath: IndexPath) {
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func removeElementFromTableView(to indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration(
            actions: [
                UIContextualAction(
                    style: .destructive,
                    title: "Delete",
                    handler: { _, _, _ in
                        self.presenter.removeText(for: indexPath)
                    }
                )
            ]
        )
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("1234")
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfElementsInTextArray()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            return UITableViewCell()
        }
        cell.update(with: presenter.elementInTextArray(for: indexPath))
        return cell
    }
}

