//
//  TranslationService.swift
//  Safeye
//
//  Created by Pavlo Leinonen on 19.4.2022.
//

import Foundation
import SwiftUI


final class TranslationService {
    static let shared = TranslationService() ; private init() { }
    
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
    // Two extra empty keys
    let extraOne:LocalizedStringKey = "extraOne"
    let extraTwo:LocalizedStringKey = "extraTwo"
    
    // Create profile
    
    let youDecidetext:LocalizedStringKey = "youDecidetext"
    let textProfile:LocalizedStringKey = "textProfile"
    let createProfileBtn:LocalizedStringKey = "createProfileBtn"
    
    let textProfileUpdate:LocalizedStringKey = "textProfileUpdate"
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
    let noCode:LocalizedStringKey = "No code"
    
    let lightMode:LocalizedStringKey = "lightMode"
    let darkMode:LocalizedStringKey = "darkMode"
    let settingsTitle:LocalizedStringKey = "settingsTitle"
    let updateCoordinatesBtn:LocalizedStringKey = "updateCoordinatesBtn"
    let updateCoordinatesInfo:LocalizedStringKey = "updateCoordinatesInfo"
    let infoSettingsTitle:LocalizedStringKey = "infoSettingsTitle"


    // Info section
    let aboutSafeye:LocalizedStringKey = "aboutSafeye"
    let faqTitle:LocalizedStringKey = "faqTitle"
    let privacyTitle:LocalizedStringKey = "privacyTitle"
    let privacyText:LocalizedStringKey = "privacyText"
    let aboutSafeyeText:LocalizedStringKey = "aboutSafeyeText"

    
    let howItWorksTitle:LocalizedStringKey = "howItWorksTitle"
    let howItWorksContact:LocalizedStringKey = "howItWorksContact"
    let howItWorksEvent:LocalizedStringKey = "howItWorksEvent"
    let howItWorksEmergency:LocalizedStringKey = "howItWorksEmergency"
    let howItWorksAlert:LocalizedStringKey = "howItWorksAlert"
    let howItWorksSafe:LocalizedStringKey = "howItWorksSafe"
    let howItWorksDelete:LocalizedStringKey = "howItWorksDelete"
    
    let faqContactQ:LocalizedStringKey = "faqContactQ"
    let faqContactA:LocalizedStringKey = "faqContactA"
    let faqSafeSpaceQ:LocalizedStringKey = "faqSafeSpaceQ"
    let faqSafeSpaceA:LocalizedStringKey = "faqSafeSpaceA"
    let faqEventQ:LocalizedStringKey = "faqEventQ"
    let faqEventA:LocalizedStringKey = "faqEventA"
    let faqEmergencyQ:LocalizedStringKey = "faqEmergencyQ"
    let faqEmergencyA:LocalizedStringKey = "faqEmergencyA"
    let faqMessageQ:LocalizedStringKey = "faqMessageQ"
    let faqMessageA:LocalizedStringKey = "faqMessageA"
    let faqHealthQ:LocalizedStringKey = "faqHealthQ"
    let faqHealthA:LocalizedStringKey = "faqHealthA"
    
    let privacyItemProfile:LocalizedStringKey = "privacyItemProfile"
    let privacyItemName:LocalizedStringKey = "privacyItemName"
    let privacyItemHealth:LocalizedStringKey = "privacyItemHealth"
    let privacyItemAddress:LocalizedStringKey = "privacyItemAddress"
    let privacyItemEvent:LocalizedStringKey = "privacyItemEvent"
    let privacyItemLocation:LocalizedStringKey = "privacyItemLocation"
    let privacyItemRecord:LocalizedStringKey = "privacyItemRecord"
    
    let privacyGroupProfile:LocalizedStringKey = "privacyGroupProfile"
    let privacyGroupName:LocalizedStringKey = "privacyGroupName"
    let privacyGroupHealth:LocalizedStringKey = "privacyGroupHealth"
    let privacyGroupAddress:LocalizedStringKey = "privacyGroupAddress"
    let privacyGroupEvent:LocalizedStringKey = "privacyGroupEvent"
    let privacyGroupLocation:LocalizedStringKey = "privacyGroupLocation"
    let privacyGroupRecord:LocalizedStringKey = "privacyGroupRecord"



    
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
    let viewOnMapBtn:LocalizedStringKey = "viewOnMapBtn"
    let showRecordedBtn:LocalizedStringKey = "showRecordedBtn"
    let recordMessageBtn:LocalizedStringKey = "recordMessageBtn"

    //Tracking mode copmponent
    let sosBtn:LocalizedStringKey = "sosBtn"
    let safeBtn:LocalizedStringKey = "safeBtn"
    // Recording view
    let recordedMessages:LocalizedStringKey = "recordedMessages"
    let recordedYourMessages:LocalizedStringKey = "recordedYourMessages"
    let SaveUpdateBtn:LocalizedStringKey = "SaveUpdateBtn"
    let cancelRecording:LocalizedStringKey = "cancelRecording"

    
    // Create event view
    let selectContactsTitle:LocalizedStringKey = "selectContactsTitle"
    let createEventInfoText:LocalizedStringKey = "createEventInfoText"
    let dateAndTime:LocalizedStringKey = "dateAndTime"
    let startTime:LocalizedStringKey = "startTime"
    let endTime:LocalizedStringKey = "endTime"
    let addContactBtn:LocalizedStringKey = "addContactBtn"
    let removeContactBtn:LocalizedStringKey = "removeContactBtn"
    let location:LocalizedStringKey = "location"

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
    let addEventInfo:LocalizedStringKey = "addEventInfo"
    let savingEventInfo:LocalizedStringKey = "savingEventInfo"
    
    // PROFILE
    
    let trustedContactsTitle:LocalizedStringKey = "trustedContactsTitle"
    let bornTitle:LocalizedStringKey = "bornTitle"
    let bloodTitle:LocalizedStringKey = "bloodTitle"
    let illnessTitle:LocalizedStringKey = "illnessTitle"
    let allergiesTitle:LocalizedStringKey = "allergiesTitle"
    let safeSpaceTitle:LocalizedStringKey = "safeSpaceTitle"
    let noPlaceYet:LocalizedStringKey = "noPlaceYet"
    let viewOnMap:LocalizedStringKey = "viewOnMap"
    let addNew:LocalizedStringKey = "addNew"
    let noName:LocalizedStringKey = "noName"
    // Edit profile
    let selectPhoto:LocalizedStringKey = "selectPhoto"
    let country:LocalizedStringKey = "country"
    // Countries
    let finland:LocalizedStringKey = "finland"
    let sweden:LocalizedStringKey = "sweden"
    let estonia:LocalizedStringKey = "estonia"
    let denmark:LocalizedStringKey = "denmark"
    let norway:LocalizedStringKey = "norway"

    
    // Add contact
    let codeInput:LocalizedStringKey = "codeInput"
    let searchBtn:LocalizedStringKey = "searchBtn"
    let addBtn:LocalizedStringKey = "addBtn"
    let nothingTitle:LocalizedStringKey = "nothingTitle"
    let errorSearch:LocalizedStringKey = "errorSearch"

    // Add safe space
    let chooseMapBtn:LocalizedStringKey = "chooseMapBtn"
    let addSafeBtn:LocalizedStringKey = "addBtn"
    let nameSafe:LocalizedStringKey = "nameSafe"
    let streetSafe:LocalizedStringKey = "streetSafe"
    let citySafe:LocalizedStringKey = "citySafe"
    let zipSafe:LocalizedStringKey = "zipSafe"
    let foundWord:LocalizedStringKey = "foundWord"
    let placesWord:LocalizedStringKey = "placesWord"
    
    // CONNECTIONS

    let connectionsTitle:LocalizedStringKey = "connectionsTitle"
    let receivedReqTitle:LocalizedStringKey = "receivedReqTitle"
    let sentReqTitle:LocalizedStringKey = "sentReqTitle"
    let acceptBtn:LocalizedStringKey = "acceptBtn"
    let profileBtn:LocalizedStringKey = "profileBtn"
    let cancelReq:LocalizedStringKey = "cancelReq"
    let connectionCode:LocalizedStringKey = "connectionCode"
    let connectiontInfo:LocalizedStringKey = "connectiontInfo"
    let addNewContact:LocalizedStringKey = "addNewContact"
    let fullNameContact:LocalizedStringKey = "fullNameContact"
    let sentContactBtn:LocalizedStringKey = "sentContactBtn"
    
    // NAVITEM
    let homeNav:LocalizedStringKey = "homeNav"
    let profileNav:LocalizedStringKey = "profileNav"
    let connectNav:LocalizedStringKey = "connectNav"
    let settingsNav:LocalizedStringKey = "settingsNav"
    
    // Components
    let friendAlert:LocalizedStringKey = "friendAlert"
    let imageAvatarError:LocalizedStringKey = "imageAvatarError"
    let focusBtn:LocalizedStringKey = "focusBtn"
    let trustedContactsMap:LocalizedStringKey = "trustedContactsMap"
    let noAddedContacts:LocalizedStringKey = "noAddedContacts"
    let headline:LocalizedStringKey = "headline"
    let settingsItemText:LocalizedStringKey = "settingsItemText"
    let firstLastName:LocalizedStringKey = "firstLastName"
    let maybeHomeAddress:LocalizedStringKey = "maybeHomeAddress"
    let healthDetail:LocalizedStringKey = "healthDetail"
    
    
    //Additional
    let eventTypesArray = [NSLocalizedString("barNight", comment: ""),
                           NSLocalizedString("nightClub", comment: ""),
                           NSLocalizedString("dinner", comment: ""),
                           NSLocalizedString("houseParty", comment: ""),
                           NSLocalizedString("firstDate", comment: ""),
                           NSLocalizedString("otherType", comment: "")
    ]
    
    let countries = [NSLocalizedString("finland", comment: ""),
                     NSLocalizedString("sweden", comment: ""),
                     NSLocalizedString("estonia", comment: ""),
                     NSLocalizedString("denmark", comment: ""),
                     NSLocalizedString("norway", comment: "")
    ]
    
    let alertFillAllfields:LocalizedStringKey = "alertFillAllfields"
    let showMessagesBtn:LocalizedStringKey = "showMessagesBtn"
    let alertHomeCoordinates:LocalizedStringKey = "alertHomeCoordinates"
    let noHomeSet:LocalizedStringKey = "noHomeSet"
    let removeAll:LocalizedStringKey = "removeAll"
    let selectAll:LocalizedStringKey = "selectAll"
    let personDetails:LocalizedStringKey = "personDetails"
    let healthDetails:LocalizedStringKey = "healthDetails"

    let connectionAlreadyExists:LocalizedStringKey = "connectionAlreadyExists"
    let requestAlreadySent:LocalizedStringKey = "requestAlreadySent"
    let requestAlreadyRecieved:LocalizedStringKey = "requestAlreadyRecieved"
    let userNotFound:LocalizedStringKey = "userNotFound"
    let cantAddYourself:LocalizedStringKey = "cantAddYourself"
    
    let connectionReqSuccesess:LocalizedStringKey = "connectionReqSuccesess"
    let errorConnectionReq:LocalizedStringKey = "errorConnectionReq"



    
}
