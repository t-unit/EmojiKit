//
//  ViewController.swift
//  EmojiKitExample
//
//  Created by Tobias Ottenweller on 13.03.20.
//  Copyright © 2020 Tobias Ottenweller. All rights reserved.
//

import UIKit
import EmojiKit

class ViewController: UIViewController {
    let fetcher = EmojiFetcher()

    @IBOutlet weak var label: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        label.text = EmojiKit.allEmojis
            .map { $0.character }
            .joined(separator: ", ")
    }

    @IBAction func editingChanged(_ sender: UITextField) {
        fetcher.query(sender.text ?? "") { emojis in
            self.label.text = emojis
                .map { $0.character }
                .joined(separator: ", ")
        }
    }
}

