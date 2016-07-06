
import UIKit

var storyMgr: StoryManager = StoryManager()

struct Story{
    var name = "un-named";var desc = "un-described"
}

class StoryManager: NSObject {
    var story = [Story]()
    
    func addStory(name: NSString, desc: NSString) -> NSMutableDictionary{
        let myDictionary: NSMutableDictionary = openPlistFile()
        story.append(Story(name: name as String, desc: desc as String))
        for Story in story{
            let myStory: NSMutableArray = NSMutableArray()
            myStory.addObject(Story.name)
            myStory.addObject(Story.desc)
            myDictionary.setValue(myStory, forKey: Story.name)
        }
        return myDictionary
    }
    
    func openPlistFile() -> NSMutableDictionary{
        let directories: [String]! = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let plistfile = "myPlist.plist"
        var myDictionary: NSMutableDictionary = NSMutableDictionary()
        let fileManager = NSFileManager.defaultManager()
        
        if directories != nil{
            
            let dictionary = directories![0]
            
            let plistpath = (dictionary as NSString).stringByAppendingPathComponent(plistfile)
            if fileManager.fileExistsAtPath(plistpath){
                myDictionary = NSMutableDictionary(contentsOfFile: plistpath)!
            }
        }
        return myDictionary
    }
    
    func writeToFile(myDictionary: NSMutableDictionary){
        let directories: [String]! = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let plistfile = "myPlist.plist"
        
        if directories != nil{
            let directories: [String] = directories!
            let dictionary = directories[0]
            
            let plistpath = (dictionary as NSString).stringByAppendingPathComponent(plistfile)
            myDictionary.writeToFile(plistpath, atomically: false)
        }
    }
}
