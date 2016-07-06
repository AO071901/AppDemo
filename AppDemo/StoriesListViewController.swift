
import UIKit

class StoriesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblStories: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //Return to view
    
    override func viewWillAppear(animated: Bool) {
        tblStories.reloadData()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            storyMgr.story.removeAtIndex(indexPath.row)
            let myDictionary: NSMutableDictionary = NSMutableDictionary()
            for Story in storyMgr.story{
                let myStory: NSMutableArray = NSMutableArray()
                myStory.addObject(Story.name)
                myStory.addObject(Story.desc)
                myDictionary.setValue(myStory, forKey: Story.name)
            }
            storyMgr.writeToFile(myDictionary)
            tableView.reloadData()
        }
    }
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        storyMgr.story.removeAll(keepCapacity: false)
        let initData: NSDictionary = storyMgr.openPlistFile()
        for data in initData{
            let dataArr: NSArray = data.value as! NSArray
            let title: NSString = dataArr[0]as! NSString
            let desc: NSString = dataArr[1] as! NSString
            storyMgr.addStory(title, desc: desc)
        }
        return storyMgr.story.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let CellIndentifier: NSString = "StoriesCell"
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIndentifier as String)!
        cell.detailTextLabel!.text = storyMgr.story[indexPath.row].desc
        cell.detailTextLabel!.font = UIFont.systemFontOfSize(10)
        cell.textLabel!.text = storyMgr.story[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "myDetailSegue"{
            let detailStoryViewController: DetailsStoryViewController = segue.destinationViewController as! DetailsStoryViewController
            let storyIndex = tblStories.indexPathForSelectedRow!.row
            let story = storyMgr.story[storyIndex]
            detailStoryViewController.story = story
        }
    }
}

