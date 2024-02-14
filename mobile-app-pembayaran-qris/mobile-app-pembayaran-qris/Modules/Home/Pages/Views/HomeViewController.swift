//
//  HomeViewController.swift
//  mobile-app-pembayaran-qris
//
//  Created by Muhammad Fachri Nuriza on 13/02/24.
//

import UIKit
import AVFoundation

protocol HomeViewControllerProtocol where Self: UIViewController {
    var presenter: HomePresenterProtocol { get }
    var router: HomeRouterProtocol { get }
}

class HomeViewController: BaseViewController, HomeViewControllerProtocol {
    public var homePresenterProtocol: HomePresenterProtocol!
    public var barcodeTypes: [AVMetadataObject.ObjectType] = [.qr, .code128]
    public var onFinishScanning: ((_ result: String) -> Void)?
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var maskView: UIImageView!
    @IBOutlet weak var flashIcon: UIButton!
    
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    internal let presenter: HomePresenterProtocol
    internal let router: HomeRouterProtocol

    init(
        presenter: HomePresenterProtocol,
        router: HomeRouterProtocol
    ) {
        self.presenter = presenter
        self.router = router
        

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCamera()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.captureSession.stopRunning()
            }
        }
    }
    
    private func setupUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        maskView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maskView.heightAnchor.constraint(equalTo: maskView.widthAnchor)
        ])
    }

    private func setupCamera() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        // Add Input
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            showUnsupportedDeviceAlert()
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            showUnsupportedDeviceAlert()
            return
        }
        
        // Add Output
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = barcodeTypes
            
        } else {
            showUnsupportedDeviceAlert()
            return
        }
        
        // Display camera preview
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = self.cameraView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        self.cameraView.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    private func showUnsupportedDeviceAlert() {
        self.showAlert(
            title: "Scan QR Code tidak didukung!",
            message: "Silakan gunakan perangkat yang memiliki kamera."
        )
        captureSession = nil
    }
    
    @IBAction func didTapTransactionList(_ sender: Any) {
        self.router.presentTransactionHistory()
    }
    
    @IBAction func didTapFlashButton(_ sender: Any) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
      
        if device.hasTorch {
            do {
                // Turn on / off the torch
                try device.lockForConfiguration()
                
                self.presenter.isFlashOn.send(!self.presenter.isFlashOn.value)
                
                if self.presenter.isFlashOn.value {
                    device.torchMode = .on
                    self.flashIcon.setImage(UIImage(named: "ic_bolt"), for: .normal)
                } else {
                    device.torchMode = .off
                    self.flashIcon.setImage(UIImage(named: "ic_bolt_slash"), for: .normal)
                }
                
                device.unlockForConfiguration()
            } catch {
                self.showAlert(title: "Flash tidak dapat digunakan.")
            }
        } else {
            self.showAlert(title: "Flash tidak tersedia.")
        }
    }
}

extension HomeViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let result = readableObject.stringValue else { return }
            
            print("QRScanner: \(result)")
            
            let qrSplited = result.split(separator: ".")
            if qrSplited.count == 4 {
                let qrDataMapped = Transaction(
                    transactionId: "\(qrSplited[1])",
                    paymentMethod: "\(qrSplited[0])",
                    merchantName: "\(qrSplited[2])",
                    amount: Double(qrSplited[3])
                )
                
                self.router.presentTransaction(trxData: qrDataMapped)
                self.captureSession.stopRunning()
            } else {
                self.showAlert(title: Wording.error, message: Wording.qrInvalid)
            }
        }
    }
}
