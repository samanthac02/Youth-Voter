//
//  DriveViewController.swift
//  Congressional App
//
//  Created by Samantha Chang on 10/2/21.
//

import UIKit
import MessageUI

class EngagementViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var donateDescriptionQuoteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        donateDescriptionQuoteLabel.text = "\"The Civics Center is dedicated to building the foundations of youth civic engagement and voter participation in high schools through education, organizing, and advocacy\"\n- theciviccenter.org"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tabBar" {
            if let vc = segue.destination as? UITabBarController {
                vc.selectedIndex = (sender as! UIButton).tag
            }
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func watchVideoButton(_ sender: Any) {
        guard let url = URL(string: "https://www.youtube.com/watch?v=Pc4X17YuNDo&feature=youtu.be") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func signUpForDriveButton(_ sender: Any) {
        guard let url = URL(string: "https://thecivicscenter.org/#workshop") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func goToRepresentativeButton(_ sender: Any) {
        (sender as! UIButton).tag = 3
            performSegue(withIdentifier: "tabBar", sender: sender)
    }
    
    @IBAction func donateButton(_ sender: Any) {
        guard let url = URL(string: "https://secure.everyaction.com/NjwUVDCl4EyjVV45TR5DXQ2") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func shareStackTapped(_ sender: Any) {
        let firstActivityItem = "Register or pre-register to vote for the 2022 Election!"
        let secondActivityItem : NSURL = NSURL(string: "https://www.youthvoter.org")!
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, img], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func creditsButton(_ sender: Any) {
        performSegue(withIdentifier: "toCredits", sender: nil)
    }
}
