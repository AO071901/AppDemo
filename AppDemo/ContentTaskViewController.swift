import UIKit

class ContentTaskViewController: UIViewController {
    
    var task : Task = Task()
    @IBOutlet weak var myTextView: UITextView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTextView.text = task.taskContent
        self.myTextView.editable = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
