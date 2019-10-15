//
//  AddViewController.swift
//  CarInfo
//
//  Created by Максим Шалашников on 09.10.2019.
//  Copyright © 2019 Maxim Shalashnikov. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet private weak var brandTextField: UITextField!
    @IBOutlet private weak var modelTextField: UITextField!
    @IBOutlet private weak var bodyTextField: UITextField!
    @IBOutlet private weak var yearTextField: UITextField!
    @IBOutlet private weak var saveButtonPressed: UIBarButtonItem!
    
    //MARK: Properties
    var carInfo: ManagedCar?
    private var uuid: String?
    private var bodyPicker = UIPickerView()
    private var yearPicker = YearPickerView()

    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        cunfigure()
    }
    
    private func cunfigure() {
        
        if carInfo == nil {
            createMod()
        } else {
            updateMod()
        }
        
        bodyPicker.delegate = self
        bodyPicker.dataSource = self
        
        yearPicker.delegate = self
        yearPicker.dataSource = self
        
        bodyTextField.inputView = bodyPicker
        yearTextField.inputView = yearPicker
        
        brandTextField.delegate = self
        modelTextField.delegate = self
        
    }
    
    private func createMod(){
        self.title = "Create"
        
        uuid = UUID().uuidString
    }
    
    private func updateMod(){
        self.title = "Edit"
        
        guard let car = carInfo else { return }
        
        brandTextField.text = car.brand
        modelTextField.text = car.model
        yearTextField.text = car.yearOfIssue
        bodyTextField.text = car.body
        
        uuid = car.uuid
    }
    
    private func create(brand: String, model: String, yearOfIssue: String, body: String){
        
        let newCar = Car(year: yearOfIssue, brand: brand, model: model, body: stringToBodyType(string: body))
        
        if let vc = navigationController?.viewControllers.first as? CarDirectoryViewController {
            vc.directory.add(newCar, at: 0)
        }
        
    }
    
    private func edit(uuid: String, brand: String, model: String, yearOfIssue: String, body: String){

        let newCar = Car(uuid: uuid, year: yearOfIssue, brand: brand, model: model, body: stringToBodyType(string: body))
        
        if let vc = navigationController?.viewControllers.first as? CarDirectoryViewController {
            vc.directory.add(newCar, at: 0)
        }
    }
    
    private func showAlert(){
        let alertController = UIAlertController(title: "Error", message: "Missing model or brand! Changes not saved!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - IBActions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        guard let brand = brandTextField.text,
            !brand.isEmpty,
            let model = modelTextField.text,
            !model.isEmpty,
            var yearOfIssue = yearTextField.text,
            let body = bodyTextField.text,
            let uuid = uuid else {
                showAlert()
                return
        }
        
        if yearOfIssue == "" {
            yearOfIssue = "Not indicated"
        }
                
        if carInfo == nil {
            //Create new car
             create(brand: brand, model: model, yearOfIssue: yearOfIssue, body: body)
        }else{
            //Update existing car
            edit(uuid: uuid, brand: brand, model: model, yearOfIssue: yearOfIssue, body: body)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapInFreeSpace(_ sender: UITapGestureRecognizer) {
        brandTextField.resignFirstResponder()
        modelTextField.resignFirstResponder()
        bodyTextField.resignFirstResponder()
        yearTextField.resignFirstResponder()
    }

}

//MARK: UIPickerView extension
extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let _ = pickerView as? YearPickerView {
            return yearPicker.years.count
        } else {
            return BodyType.stringArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let _ = pickerView as? YearPickerView {
            return yearPicker.years[row]
        } else {
            return BodyType.stringArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let _ = pickerView as? YearPickerView{
            yearTextField.text = yearPicker.years[row]
        } else {
            bodyTextField.text = BodyType.stringArray[row]
        }
    
    }

}

//MARK: - UITextField extension
extension AddViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
}
