

import UIKit

class DetailsStoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NewTaskViewControllerDelegate {
    
    @IBOutlet weak var myTblTasks: UITableView!
    
    var story: Story = Story()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.myTblTasks.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        taskMgr.task.removeAll(keepCapacity: false)
        let filename: String = story.name
        let initData: NSDictionary = taskMgr.openTaskFile(filename)
        for data in initData{
            let dataArr: NSArray = data.value as! NSArray
            let title: NSString = dataArr[0] as! NSString
            let desc: NSString = dataArr[1] as! NSString
            taskMgr.addTask(title, content: desc, nameFile: filename)
        }
        return taskMgr.task.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let CellIndentifier: NSString = "TasksCell"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIndentifier as String)!
        
        cell.textLabel!.text = taskMgr.task[indexPath.row].taskName
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "myContentSegue"{
            let contentViewController: ContentTaskViewController = segue.destinationViewController as! ContentTaskViewController
            let task: Task = taskMgr.task[myTblTasks.indexPathForSelectedRow!.row]
            contentViewController.task = task
        }
        if segue.identifier == "myTaskSegue"{
            let addTaskController: NewTaskViewController = segue.destinationViewController as! NewTaskViewController
            addTaskController.filename = story.name
            addTaskController.delegate = self
        }
    }
    
    func addNewTask(controller: NewTaskViewController){
        controller.navigationController!.popViewControllerAnimated(true)
    }
    
}
