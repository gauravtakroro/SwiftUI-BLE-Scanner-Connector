//
//  ContentView.swift
//  BleScanConnect
//
//  Created by Gaurav Tak on 16/09/25.
//

import SwiftUI

// MARK: - SwiftUI View
struct ContentView: View {
    @StateObject private var bleManager = BLEManager()
    
    var body: some View {
        NavigationView {
            VStack {
                if bleManager.isScanning {
                    Button("Stop Scanning") {
                        bleManager.stopScanning()
                    }
                    .padding()
                } else {
                    Button("Start Scanning") {
                        bleManager.startScanning()
                    }
                    .padding()
                }
                
                List(bleManager.discoveredDevices, id: \.identifier) { peripheral in
                    HStack {
                        Text(peripheral.name ?? "Unknown")
                            .font(.headline)
                        Spacer()
                        if bleManager.connectedPeripheral?.identifier == peripheral.identifier {
                            Text("Connected")
                                .foregroundColor(.green)
                        } else {
                            Button("Connect") {
                                bleManager.connect(to: peripheral)
                            }
                        }
                    }
                }
            } .navigationBarTitleDisplayMode(.inline) // Required for center alignment
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Nearby BLE Devices")
                            .font(.system(size: 32, weight: .bold))
                            
                    }
                }
           
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

