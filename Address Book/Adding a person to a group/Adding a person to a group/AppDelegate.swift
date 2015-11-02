//
//  AppDelegate.swift
//  Adding a person to a group
//
//  Created by Domenico on 26/05/15.
//  License MIT
//

import UIKit
import AddressBook

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var addressBook: ABAddressBookRef?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        switch ABAddressBookGetAuthorizationStatus(){
        case .Authorized:
            print("Already authorized")
            createAddressBook()
            /* Now you can use the address book */
            addPersonsAndGroupsToAddressBook(addressBook!)

        case .Denied:
            print("You are denied access to address book")
            
        case .NotDetermined:
            createAddressBook()
            if let theBook: ABAddressBookRef = addressBook{
                ABAddressBookRequestAccessWithCompletion(theBook,
                    {(granted: Bool, error: CFError!) in
                        
                        if granted{
                            print("Access is granted")
                        } else {
                            print("Access is not granted")
                        }
                        
                })
            }
            
        case .Restricted:
            print("Access is restricted")
            
        default:
            print("Unhandled")
        }
        
        
        return true
        
    }
    
    func createAddressBook(){
        var error: Unmanaged<CFError>?
        
        addressBook = ABAddressBookCreateWithOptions(nil,
            &error).takeRetainedValue()
        
        /* You can use the address book here */
        func createAddressBook(){
            var error: Unmanaged<CFError>?
            
            addressBook = ABAddressBookCreateWithOptions(nil,
                &error).takeRetainedValue()
            
            /* You can use the address book here */
            addPersonsAndGroupsToAddressBook(addressBook!)
            
        }
    }
    
    //- MARK: Groups
    func newGroupWithName(name: String, inAddressBook: ABAddressBookRef) ->
        ABRecordRef?{
            
            let group: ABRecordRef = ABGroupCreate().takeRetainedValue()
            
            var error: Unmanaged<CFError>?
            let couldSetGroupName = ABRecordSetValue(group,
                kABGroupNameProperty, name, &error)
            
            if couldSetGroupName{
                
                error = nil
                let couldAddRecord = ABAddressBookAddRecord(inAddressBook,
                    group,
                    &error)
                
                if couldAddRecord{
                    
                    print("Successfully added the new group")
                    
                    if ABAddressBookHasUnsavedChanges(inAddressBook){
                        error = nil
                        let couldSaveAddressBook =
                        ABAddressBookSave(inAddressBook, &error)
                        if couldSaveAddressBook{
                            print("Successfully saved the address book")
                        } else {
                            print("Failed to save the address book")
                            return nil
                        }
                    } else {
                        print("No unsaved changes")
                        return nil
                    }
                } else {
                    print("Could not add a new group")
                    return nil
                }
            } else {
                print("Failed to set the name of the group")
                return nil
            }
            
            return group
            
    }
    
    func createNewGroupInAddressBook(addressBook: ABAddressBookRef){
        
        let personalCoachesGroup: ABRecordRef? =
        newGroupWithName("Personal Coaches",
            inAddressBook: addressBook)
        
        if let _: ABRecordRef = personalCoachesGroup{
            print("Successfully created the group")
        } else {
            print("Could not create the group")
        }
        
    }
    
    //- MARK: Person
    func newPersonWithFirstName(firstName: String,
        lastName: String,
        inAddressBook: ABAddressBookRef) -> ABRecordRef?{
            
            let person: ABRecordRef = ABPersonCreate().takeRetainedValue()
            
            let couldSetFirstName = ABRecordSetValue(person,
                kABPersonFirstNameProperty,
                firstName as CFTypeRef,
                nil)
            
            let couldSetLastName = ABRecordSetValue(person,
                kABPersonLastNameProperty,
                lastName as CFTypeRef,
                nil)
            
            var error: Unmanaged<CFErrorRef>? = nil
            
            let couldAddPerson = ABAddressBookAddRecord(inAddressBook, person, &error)
            
            if couldAddPerson{
                print("Successfully added the person.")
            } else {
                print("Failed to add the person.")
                return nil
            }
            
            if ABAddressBookHasUnsavedChanges(inAddressBook){
                
                var error: Unmanaged<CFErrorRef>? = nil
                let couldSaveAddressBook = ABAddressBookSave(inAddressBook, &error)
                
                if couldSaveAddressBook{
                    print("Successfully saved the address book.")
                } else {
                    print("Failed to save the address book.")
                }
            }
            
            if couldSetFirstName && couldSetLastName{
                print("Successfully set the first name " +
                    "and the last name of the person")
            } else {
                print("Failed to set the first name and/or " +
                    "the last name of the person")
            }
            
            return person
            
    }
    
    func addPerson(person: ABRecordRef,
        toGroup: ABRecordRef,
        saveToAddressBook: ABAddressBookRef) -> Bool{
            
            var error: Unmanaged<CFErrorRef>? = nil
            var added = false
            
            /* Now attempt to add the person entry to the group */
            added = ABGroupAddMember(toGroup,
                person,
                &error)
            
            if added == false{
                print("Could not add the person to the group")
                return false
            }
            
            /* Make sure we save any unsaved changes */
            if ABAddressBookHasUnsavedChanges(saveToAddressBook){
                error = nil
                let couldSaveAddressBook = ABAddressBookSave(saveToAddressBook,
                    &error)
                if couldSaveAddressBook{
                    print("Successfully added the person to the group")
                    added = true
                } else {
                    print("Failed to save the address book")
                }
            } else {
                print("No changes were saved")
            }
            
            return added
            
    }
    
    func addPersonsAndGroupsToAddressBook(addressBook: ABAddressBookRef){
        
        let richardBranson: ABRecordRef? = newPersonWithFirstName("Richard",
            lastName: "Branson",
            inAddressBook: addressBook)
        
        if let richard: ABRecordRef = richardBranson{
            let entrepreneursGroup: ABRecordRef? = newGroupWithName("Entrepreneurs",
                inAddressBook: addressBook)
            
            if let group: ABRecordRef = entrepreneursGroup{
                if addPerson(richard, toGroup: group, saveToAddressBook: addressBook){
                    print("Successfully added Richard Branson to the group")
                } else {
                    print("Failed to add Richard Branson to the group")
                }
                
            } else {
                print("Failed to create the group")
            }
            
        } else {
            print("Failed to create an entity for Richard Branson")
        }
        
    }



    
}

