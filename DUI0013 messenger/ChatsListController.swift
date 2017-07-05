//
//  ViewController.swift
//  DUI0013 messenger
//
//  Created by Tim on 30.06.17.
//  Copyright © 2017 Tim. All rights reserved.
//

import UIKit
import CoreData

class ChatsListController: UIViewController {
    
    var messages = [Message]()
    
    let collectionView: UICollectionView = {
        let c = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        c.translatesAutoresizingMaskIntoConstraints = false
        c.alwaysBounceVertical = true
        c.backgroundColor = .white
        return c
    }()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: cellId)
        setupViews()
        setupData()
    }
    
    func setupData() {
        clearData()
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            
            let conor = createFriend(name: "Conor Mcgregor", imageName: "conor", context: context)
            let khabib = createFriend(name: "Khabib Nurmagomedov", imageName: "khabib", context: context)
            let nate = createFriend(name: "Nate Diaz", imageName: "nate", context: context)
            let joey = createFriend(name: "Joey Diaz", imageName: "joey", context: context)
            let joe = createFriend(name: "Joe Rogan", imageName: "joe", context: context)
            let eddie = createFriend(name: "Eddie Bravo", imageName: "eddie", context: context)
            let ariel = createFriend(name: "Ariel Helwani", imageName: "ariel", context: context)
            
            createMessage(text: "I'm not surprised motherfuckers!", friend: nate, minutesAgo: 1, context: context)
    
            createMessage(text: "This is #1 bullshit", friend: khabib, minutesAgo: 6, context: context)
            createMessage(text: "Don't send me this bullshit contract", friend: khabib, minutesAgo: 4, context: context)
            createMessage(text: "No more", friend: khabib, minutesAgo: 3, context: context)
            
            createMessage(text: "What's oop?", friend: conor, minutesAgo: 13, context: context)
            createMessage(text: "Not much", friend: conor, minutesAgo: 12, context: context, isSender: true)
            createMessage(text: "Timing beats speed, precision beats power", friend: conor, minutesAgo: 5, context: context)
            createMessage(text: "They are not on me level", friend: conor, minutesAgo: 0, context: context)
            
            createMessage(text: "He supposed to fight that fucking Khalabib, you dumb fucks! Stiopic, he has that immigrant mentality. Oh Denis Siver is available... Denis Siver is availabel", friend: joey, minutesAgo: 20, context: context)
            createMessage(text: "The seed is planted", friend: joey, minutesAgo: 10, context: context)
            createMessage(text: "What about Building 7?", friend: eddie, minutesAgo: 23, context: context)
            createMessage(text: "Pull it up Jamie", friend: joe, minutesAgo: 60 * 24 * 8, context: context)
            createMessage(text: "Dana fired me :(", friend: ariel, minutesAgo: 60 * 24, context: context)
            createMessage(text: "Why?", friend: ariel, minutesAgo: 60 * 24 - 10, context: context, isSender: true)
            
            do {
                try context.save()
            } catch {
                print("\(error.localizedDescription)")
            }
            
            loadData()
        }
    }
    
    private func createFriend(name: String, imageName: String, context: NSManagedObjectContext) -> Friend {
        let friend = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        friend.name = name
        friend.profileImageName = imageName
        return friend
    }
    
    private func createMessage(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext, isSender: Bool = false) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(-minutesAgo * 60)
        message.isSender = NSNumber(value: isSender)
    }
    
    func loadData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
            if let friends = fetchFriends() {
                for friend in friends {
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    fetchRequest.fetchLimit = 1
                    do {
                        let fetchedMessages = try context.fetch(fetchRequest) as! [Message]
                        messages.append(contentsOf: fetchedMessages)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            do {
                return try context.fetch(fetchRequest) as! [Friend]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                let eNames = ["Friend", "Message"]
                for eName in eNames {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: eName)
                    let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                    for object in objects! {
                        context.delete(object)
                    }
                    
                }
            } catch {
                print("error")
            }
        }
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ChatsListController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatCell
        cell.message = messages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let controller = ChatLogController(collectionViewLayout: layout)
        controller.friend = messages[indexPath.item].friend
        navigationController?.pushViewController(controller, animated: true)
    }
}
