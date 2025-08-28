//
//  CreditsViewController.swift
//  Congressional App
//
//  Created by Samantha Chang on 10/29/21.
//

import UIKit

class CreditsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func xButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func civicsCenterButton(_ sender: Any) {
        guard let url = URL(string: "https://thecivicscenter.org") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func voteRidersButton(_ sender: Any) {
        guard let url = URL(string: "https://www.voteriders.org") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func googleApiButton(_ sender: Any) {
        guard let url = URL(string: "https://developers.google.com/civic-information") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func nprButton(_ sender: Any) {
        guard let url = URL(string: "https://www.npr.org") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func voteOrgButton(_ sender: Any) {
        guard let url = URL(string: "https://www.vote.org") else { return }
        UIApplication.shared.open(url)
    }
}
