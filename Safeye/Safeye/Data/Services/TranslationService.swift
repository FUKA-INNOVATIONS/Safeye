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
    let createIllnessTitle:LocalizedStringKey = "illnessTitle"
    let illnessPlaceholder:LocalizedStringKey = "illnessPlaceholder"
    let createAllergiesTitle:LocalizedStringKey = "allergiesTitle"
    let allergiesPlaceholder:LocalizedStringKey = "allergiesPlaceholder"
    let saveBtn:LocalizedStringKey = "saveBtn"
    // Alert in case wrong input
    let fieldAlertTitle:LocalizedStringKey = "fieldAlertTitle"
    let fieldAlertText:LocalizedStringKey = "fieldAlertText"
    let okFieldAlertBtn:LocalizedStringKey = "okBtn"
    
    // SETTINGS
    
    let signOut:LocalizedStringKey = "signOut"
    let connection:LocalizedStringKey = "connection"
    let copyBtn:LocalizedStringKey = "copyBtn"
    
    // HOME
    let eventsNumber:LocalizedStringKey = "eventsNumber"
    let createNewEventBtn:LocalizedStringKey = "createNewEventBtn"
    let yourEventsTitle:LocalizedStringKey = "yourEventsTitle"
    let yourFriendsEventsTitle:LocalizedStringKey = "yourFriendsEventsTitle"
    let eventInfoTitle:LocalizedStringKey = "eventInfoTitle"
    
    // Tracking mode view
    let safeStatusTitle:LocalizedStringKey = "safeStatusTitle"
    let panicStatusTitle:LocalizedStringKey = "panicStatusTitle"
    let startedStatusTitle:LocalizedStringKey = "startedStatusTitle"
    let deleteBtn:LocalizedStringKey = "deleteBtn"
    let trustedContactsTrack:LocalizedStringKey = "trustedContactsTrack"
    let eventdDetailsTrack:LocalizedStringKey = "eventdDetailsTrack"
    let startTrack:LocalizedStringKey = "startTrack"
    let endTrack:LocalizedStringKey = "endTrack"
    let eventTypeTrack:LocalizedStringKey = "eventTypeTrack"
    let otherTrack:LocalizedStringKey = "otherTrack"
    //Tracking mode copmponent
    let sosBtn:LocalizedStringKey = "sosBtn"
    let safeBtn:LocalizedStringKey = "safeBtn"


    
    // Create event view
    let selectContactsTitle:LocalizedStringKey = "selectContactsTitle"
    let createEventInfoText:LocalizedStringKey = "createEventInfoText"
    let dateAndTime:LocalizedStringKey = "dateAndTime"
    let startTime:LocalizedStringKey = "startTime"
    let endTime:LocalizedStringKey = "endTime"
    let addContactBtn:LocalizedStringKey = "addContactBtn"
    let removeContactBtn:LocalizedStringKey = "removeContactBtn"
    // Event types
    let eventType:LocalizedStringKey = "eventType"
    let selectEventType:LocalizedStringKey = "selectEventType"
    let barNight:LocalizedStringKey = "barNight"
    let nightClub:LocalizedStringKey = "nightClub"
    let dinner:LocalizedStringKey = "dinner"
    let houseParty:LocalizedStringKey = "houseParty"
    let firstDate:LocalizedStringKey = "firstDate"
    let otherType:LocalizedStringKey = "otherType"
    let otherDetailTitle:LocalizedStringKey = "otherDetailTitle"
    let detailPlaceholder:LocalizedStringKey = "detailPlaceholder"
    let saveActivateBtn:LocalizedStringKey = "saveActivateBtn"
    let savingEventInfo:LocalizedStringKey = "savingEventInfo"
    
    // PROFILE
    
    let trustedContactsTitle:LocalizedStringKey = "trustedContactsTitle"
    let bornTitle:LocalizedStringKey = "bornTitle"
    let bloodTitle:LocalizedStringKey = "bloodTitle"
    let illnessTitle:LocalizedStringKey = "illnessTitle"
    let allergiesTitle:LocalizedStringKey = "allergiesTitle"
    let safeSpaceTitle:LocalizedStringKey = "safeSpaceTitle"
    // Add TC
    let codeInput:LocalizedStringKey = "doceInput"
    let searchBtn:LocalizedStringKey = "searchBtn"
    let addBtn:LocalizedStringKey = "addBtn"
    let nothingTitle:LocalizedStringKey = "nothingTitle"
    // Add safe space
    let chooseMapBtn:LocalizedStringKey = "chooseMapBtn"
    let addSafeBtn:LocalizedStringKey = "addBtn"
    let nameSafe:LocalizedStringKey = "nameSafe"
    let streetSafe:LocalizedStringKey = "streetSafe"
    let citySafe:LocalizedStringKey = "citySafe"
    let zipSafe:LocalizedStringKey = "zipSafe"
    
    // CONNECTIONS

    let connectionsTitle:LocalizedStringKey = "connectionsTitle"
    let receivedReqTitle:LocalizedStringKey = "receivedReqTitle"
    let sentReqTitle:LocalizedStringKey = "sentReqTitle"
    let acceptBtn:LocalizedStringKey = "acceptBtn"
    let profileBtn:LocalizedStringKey = "profileBtn"
}
