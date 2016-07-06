
import UIKit

var taskMgr: TaskManager = TaskManager()

struct Task{
    var taskName = "un-known"
    var taskContent = "un-known"
}

class TaskManager{
    
    var task = [Task]()
    
    func addTask(name: NSString, content: NSString, nameFile: String) -> NSMutableDictionary{
        let myDictionary: NSMutableDictionary = openTaskFile(nameFile)
        task.append(Task(taskName: name as String, taskContent: content as String))
        for Task in task{
            let myTask: NSMutableArray = NSMutableArray()
            myTask.addObject(Task.taskName)
            myTask.addObject(Task.taskContent)
            myDictionary.setValue(myTask, forKey: Task.taskName)
        }
        return myDictionary
    }
    
    func openTaskFile(name: String) -> NSMutableDictionary{
        let directories: [String]! = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let plistfile = name + ".plist"
        var myTaskDictionary: NSMutableDictionary = NSMutableDictionary()
        let fileManager = NSFileManager.defaultManager()
        
        if directories != nil{
            
            let dictionary = directories![0]
            let plistpath = (dictionary as NSString).stringByAppendingPathComponent(plistfile)
            if fileManager.fileExistsAtPath(plistpath){
                myTaskDictionary = NSMutableDictionary(contentsOfFile: plistpath)!
            }
        }
        return myTaskDictionary
    }
    
    func writeTaskToFile(myDictionary: NSMutableDictionary, name: String){
        let directories: [String]! = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        let plistfile = name + ".plist"
        
        if directories != nil{
            
            let dictionary = directories![0]
            let plistpath = (dictionary as NSString).stringByAppendingPathComponent(plistfile)
            myDictionary.writeToFile(plistpath, atomically: false)
        }
    }
}