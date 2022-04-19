//
//  TranslationService.swift
//  Safeye
//
//  Created by Pavlo Leinonen on 19.4.2022.
//

import Foundation
import SwiftUI


final class TranslationService: ObservableObject {
    
    // Sign in
    
    let signInTitle:LocalizedStringKey = "signInTitle"
    let emailTitle:LocalizedStringKey = "emailTitle"
    let emailPlaceholder:LocalizedStringKey = "emailPlaceholder"
    let passwordTitle:LocalizedStringKey = "passwordTitle"
    let passwordPlaceholder:LocalizedStringKey = "passwordPlaceholder"
    let signInButton:LocalizedStringKey = "signInButton"
    let createNewAcc:LocalizedStringKey = "createNewAcc"

    // Create new account
    
    let createNewTitle:LocalizedStringKey = "createNewTitle"
    let createEmailTitle:LocalizedStringKey = "emailTitle"
    let createEmailPlaceholder:LocalizedStringKey = "emailPlaceholder"
    let createPasswordTitle:LocalizedStringKey = "passwordTitle"
    let createPasswordPlaceholder:LocalizedStringKey = "passwordPlaceholder"
    let signUpButton:LocalizedStringKey = "signUpButton"
    let backToSignIn:LocalizedStringKey = "backToSignIn"
    // Alert in case wrong input
    let loginAlertTitle:LocalizedStringKey = "loginAlertTitle"
    let okBtn:LocalizedStringKey = "okBtn"
    
    // Create profile
    
    let textProfile:LocalizedStringKey = "textProfile"
    let createProfileBtn:LocalizedStringKey = "createProfileBtn"
    
    let textProfileBlanc:LocalizedStringKey = "textProfileBlanc"
    let fullNameTitle:LocalizedStringKey = "fullNameTitle"
    let fullNamePlaceholder:LocalizedStringKey = "fullNamePlaceholder"
    let addressTitle:LocalizedStringKey = "addressTitle"
    let addressPlaceholder:LocalizedStringKey = "addressPlaceholder"
    let birthdayTitle:LocalizedStringKey = "birthdayTitle"
    let birthdayPlaceholder:LocalizedStringKey = "birthdayPlaceholder"
    let bloodTypeTitle:LocalizedStringKey = "bloodTypeTitle"
    let illnessTitle:LocalizedStringKey = "illnessTitle"
    let illnessPlaceholder:LocalizedStringKey = "illnessPlaceholder"
    let allergiesTitle:LocalizedStringKey = "allergiesTitle"
    let allergiesPlaceholder:LocalizedStringKey = "allergiesPlaceholder"
    let saveBtn:LocalizedStringKey = "saveBtn"
    // Alert in case wrong input
    let fieldAlertTitle:LocalizedStringKey = "fieldAlertTitle"
    let fieldAlertText:LocalizedStringKey = "fieldAlertText"
    let okFieldAlertBtn:LocalizedStringKey = "okBtn"
    
    // Settings
    
    let signOut:LocalizedStringKey = "signOut"
    let connection:LocalizedStringKey = "connection"
    let copyBtn:LocalizedStringKey = "copyBtn"
    
    // Home
    
    let eventsNumber:LocalizedStringKey = "eventsNumber"
    let createNewEventBtn:LocalizedStringKey = "createNewEventBtn"
    let yourEventsTitle:LocalizedStringKey = "yourEventsTitle"
    let yourFriendsEventsTitle:LocalizedStringKey = "yourFriendsEventsTitle"
    
    // Create event view

    let selectContactsTitle:LocalizedStringKey = "selectContactsTitle"
    let createEventInfoText:LocalizedStringKey = "createEventInfoText"
    let dateAndTime:LocalizedStringKey = "dateAndTime"
    let startTime:LocalizedStringKey = "startTime"
    let endTime:LocalizedStringKey = "endTime"
    // Event types
    let eventType:LocalizedStringKey = "eventType"
    let selectEventType:LocalizedStringKey = "selectEventType"
    let barNight:LocalizedStringKey = "barNight"
    let nightClub:LocalizedStringKey = "nightClub"
    let dinner:LocalizedStringKey = "dinner"
    let houseParty:LocalizedStringKey = "houseParty"
    let firstDate:LocalizedStringKey = "firstDate"
    let otherType:LocalizedStringKey = "otherType"
    
    
   
}
