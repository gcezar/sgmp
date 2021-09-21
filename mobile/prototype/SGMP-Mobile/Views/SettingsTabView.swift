//
//  SettingsTabView.swift
//  SGMP-Mobile
//
//  Created by fincher on 9/19/21.
//

import Defaults
import SwiftUI

struct SettingsTabView: View {
    @EnvironmentObject var env : Env
    @Default(.loginEmailAddress) var loginEmailAddress
    
    var body: some View {
        List {
            Section {
                Text("\(loginEmailAddress)")
                
                Button {
                    loginEmailAddress = ""
                } label: {
                    Text("Logout")
                }
            } header: {
                Text("User")
            }
            
            Section {
                Toggle(isOn: .constant(false)) {
                    Text("Debug")
                }
            } header: {
                Text("Misc")
            }

        }.navigationTitle("Settings")
    }
}

struct SettingsTabView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTabView()
    }
}
