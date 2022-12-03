//
//  ViewController.swift
//  bluetooth5
//
//  Created by 이선호 on 2022/12/03.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    
    @IBOutlet weak var aaa: UILabel!
    var centralManager : CBCentralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    


}

extension ViewController: CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state{
        case .unknown:
            print("unknown")
            aaa.text = "unknown"
        case .resetting:
            print("resetting")
            
            aaa.text = "resetting"
        case .unsupported:
            print("unsupported")
            aaa.text = "unsupported"
        case .unauthorized:
            print("unauthorized")
            aaa.text = "unauthorized"
        case .poweredOff:
            print("PoweredOff")
            aaa.text = "PoweredOff"
        case .poweredOn:
            print("PoweredOn")
            aaa.text = "PoweredOn"
            centralManager.scanForPeripherals(withServices: nil)
        @unknown default:
            print("default")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData:[String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        aaa.text = peripheral as! String
    }
}
