//
//  TableViewController.swift
//  MusicApp
//
//  Created by Eduardo on 22/12/15.
//  Copyright © 2015 EduardoAndrade. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let musica = DataMusic()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.separatorStyle = .SingleLine
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return musica.canciones.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SongTableViewCell
        
        let cancionActual = musica.canciones[indexPath.row]
        let imgPortada = UIImage(named: "\(cancionActual.portada).jpg")
        
        cell.imgPortada.image = imgPortada
        cell.imgPortada.layer.borderWidth = 0
        cell.imgPortada.layer.masksToBounds = false
        cell.imgPortada.layer.cornerRadius = 3
        cell.imgPortada.clipsToBounds = true
        
        cell.lblTitulo.text = cancionActual.titulo
        cell.lblCantante.text = cancionActual.cantante
        
        cell.lblCantante.textColor = UIColor(red: 169 / 255, green: 169 / 255, blue: 169 / 255, alpha: 1)
        cell.lblTitulo.textColor = UIColor(red: 100 / 255, green: 100 / 255, blue: 100 / 255, alpha: 1)
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)  {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! SongTableViewCell
        cell.lblCantante.textColor = UIColor.whiteColor()
        cell.lblTitulo.textColor = UIColor.whiteColor()
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! SongTableViewCell
        cell.lblCantante.textColor = UIColor(red: 169 / 255, green: 169 / 255, blue: 169 / 255, alpha: 1)
        cell.lblTitulo.textColor = UIColor(red: 100 / 255, green: 100 / 255, blue: 100 / 255, alpha: 1)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let cell = sender as? SongTableViewCell {
            _ = tableView.indexPathForCell(cell)!.row
            if segue.identifier == "segueSong" {
                
                let modalV = segue.destinationViewController as! PlaySongViewController
                modalV.portadaString = musica.canciones[(self.tableView.indexPathForSelectedRow?.row)!].portada
                modalV.tituloString = musica.canciones[(self.tableView.indexPathForSelectedRow?.row)!].titulo
                modalV.cantanteString = musica.canciones[(self.tableView.indexPathForSelectedRow?.row)!].cantante
            }
        }
       
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
