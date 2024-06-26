//
//  SimpleMapApp.swift
//  SimpleMap
//
//  Created by ကင်ဇို on 25/06/2024.
//

import SwiftUI

@main
struct SimpleMapApp: App {
    @StateObject var vm : LocationViewModel = LocationViewModel()
    var body: some Scene {
        WindowGroup {
            LocationView().environmentObject(vm)
        }
    }
}
