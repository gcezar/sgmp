//
//  ListDeviceView.swift
//  SGMP-Mobile
//
//  Created by fincher on 10/14/21.
//

import SwiftUI
import Defaults
import Toast

struct ListDeviceView: View {
    
    var houseId : UInt64
    
    @EnvironmentObject var env : Env
    @State private var searchText = ""
    @State var devices : [Device] = []
    @Default(.showIconInDeviceList) var showIconInDeviceList
    
    func refresh(showSuccessToast : Bool = false) -> Void {
        let callback : ( ([Device]?, Error?) -> Void) = { devices, err in
            DispatchQueue.main.async {
                if let err = err {
                    Toast.default(image: .init(systemName: "exclamationmark.arrow.circlepath")!, title: "\(err.localizedDescription)").show()
                } else if let devices = devices {
                    if showSuccessToast { Toast.default(image: .init(systemName: "clock.arrow.circlepath")!, title: "refreshed", subtitle: "\(devices.count) device(s)").show(haptic: .success) }
                    self.devices = devices
                }
            }
        }
        if houseId == env.currentDashboardHouse?.house_id {
            env.updateCurrentHouseDevices(callback: callback)
        } else {
            NetworkManager.shared.getDevices(houseId: houseId, callback: callback)
        }
    }
    
    
    var results: [Device] {
        if searchText.isEmpty {
            return devices
        } else {
            return devices.filter { $0.name.contains(searchText) || $0.description.contains(searchText) || $0.type.contains(searchText) }
        }
    }
    
    var body: some View {
        List {
            Section {
                ForEach(results) { device in
                    DeviceSelectionCell(device: device)
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search for device")
        .refreshable {
            refresh(showSuccessToast: true)
        }
        .onAppear(perform: {
            refresh()
        })
        .navigationTitle("Devices")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        showIconInDeviceList.toggle()
                    } label: {
                        Label {
                            Text("\(showIconInDeviceList ? "Hide" : "Show") icons")
                        } icon: {
                            Image(systemName: "sidebar.squares.leading")
                        }
                    }
                } label: {
                    Label {
                        Text("More")
                    } icon: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
        }
    }
}

struct ListDeviceView_Previews: PreviewProvider {
    static var previews: some View {
///       ListDeviceView()
        ZStack {}
    }
}
