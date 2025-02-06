//
//  CreateEventViewModel.swift
//  Evently
//
//  Created by Theo Sementa on 05/02/2025.
//

import Foundation

@Observable
final class CreateEventViewModel {

    var currentStep: Int = 1

    var name: String = ""
    var selectedCategory: CategoryModel?
    var date: Date = .now
    var frequency: EventFrequency = .none
}

extension CreateEventViewModel {

    var isFirstStepValid: Bool {
        return !name.isBlank && selectedCategory != nil
    }

}
