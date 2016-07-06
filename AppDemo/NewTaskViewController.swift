
import UIKit


protocol NewTaskViewControllerDelegate{
    func addNewTask(controller: NewTaskViewController)
}

class NewTaskViewController: UIViewController {
    
    var delegate: NewTaskViewControllerDelegate! = nil
    var filename: String = ""
    @IBOutlet weak var myTitle: UITextField!
    @IBOutlet weak var myContent: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(filename)
    }
    @IBAction func addNewTask(sender: UIBarButtonItem){
        if (delegate != nil){
            if myTitle.text != "" || myContent.text != ""{
                let taskDictionary: NSMutableDictionary = taskMgr.addTask(myTitle.text!, content: myContent.text!, nameFile: filename)
                taskMgr.writeTaskToFile(taskDictionary, name: filename)
            }
            delegate!.addNewTask(self)
        }
    }
    
}
