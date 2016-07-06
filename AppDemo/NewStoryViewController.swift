
import UIKit

class NewStoryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDes: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func btn_AddStory_Click(sender: UIButton){
        if txtName.text != "" || txtDes.text != "" {
            let directories: [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as [String]
            let dictionary = directories![0]
            let plistfile = "myPlist.plist"
            let plistpath = (dictionary as NSString).stringByAppendingPathComponent(plistfile)
            storyMgr.addStory(txtName.text!, desc: txtDes.text!).writeToFile(plistpath, atomically: false)
            let myTask: NSMutableDictionary = NSMutableDictionary()
            taskMgr.writeTaskToFile(myTask, name: txtName.text!)
        }
        txtDes.text = ""
        txtName.text = ""
        self.tabBarController!.selectedIndex = 0
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

