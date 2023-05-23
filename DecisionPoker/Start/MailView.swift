//
//  MailView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 21.11.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

// https://stackoverflow.com/questions/56784722/swiftui-send-email

import SwiftUI
import UIKit
import MessageUI

struct MailView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = context.coordinator
        mailViewController.setToRecipients(["mail@ipomic.de"])
        mailViewController.setSubject("Decision Poker App")
        return mailViewController
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {

    }
}
