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
    var targetPeripheral: CBPeripheral!
    
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
        case .resetting:
            print("resetting")
        case .unsupported:
            print("unsupported")
        case .unauthorized:
            print("unauthorized")
        case .poweredOff:
            print("PoweredOff")
        case .poweredOn:
            print("PoweredOn")
            centralManager.scanForPeripherals(withServices: nil)
        @unknown default:
            print("default")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print(peripheral)
        aaa.text = peripheral as! String
        
        // 여기에 리스트 넣는 코드 넣어줘야함
        // 리스트에서 해당item 선택시 연결하는 코드로 ㄲ
        
        //블루투스 uuidString 이 "identifier" 이면 걔랑 연결하는 코드
        if peripheral.identifier.uuidString == "identifier" {
            self.targetPeripheral = peripheral
            targetPeripheral.delegate = self
            centralManager.stopScan() // 스캔 멈출고
            centralManager.connect(targetPeripheral) //걔랑 연결해라
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!!")
        targetPeripheral.discoverServices(nil)
    }
}

extension ViewController: CBPeripheralDelegate{
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = targetPeripheral.services else {return}
        for service in services {
            print(service)
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
}
