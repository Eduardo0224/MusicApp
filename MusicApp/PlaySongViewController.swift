//
//  PlaySongViewController.swift
//  MusicApp
//
//  Created by Eduardo on 23/12/15.
//  Copyright © 2015 EduardoAndrade. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlaySongViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var imgPortadaDetalle: UIImageView!
    @IBOutlet weak var imgPortadaBackground: UIImageView!
    @IBOutlet weak var lblTituloCancion: UILabel!
    @IBOutlet weak var lblCantante: UILabel!
    @IBOutlet weak var sliderVolume: UISlider!
    @IBOutlet weak var playSongButton: UIButton!
    @IBOutlet weak var lblAlbum: UILabel!
    
    var portadaString : String!
    var tituloString : String!
    var cantanteString : String!
    
    var shadow : UIView!
    
    var flagSourceImagePlayButton = false
    let dataMusic : DataMusic = DataMusic()
    
    private var reproductor : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
        // Encontrar el Path (en un solo paso se convierte a URL)
        let cancionURL = NSBundle.mainBundle().URLForResource("\(tituloString)", withExtension: "mp3")
        
        // Hacer la conexión con try catch
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: cancionURL!)
        } catch {
            print("Error al cargar el archivo de sonido \(tituloString).mp3")
        }
        
        reproductor.delegate = self
        
        // Reproducir la canción automáticamente
        PlaySong()
        
        let fixItView = UIView()
        fixItView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 20);
        fixItView.backgroundColor = UIColor(red: 60 / 255, green: 56 / 255, blue: 56 / 255, alpha: 1) // your colour
        view.addSubview( fixItView )
        
        
        imgPortadaDetalle.image = UIImage(named: "\(portadaString)-large.jpg")
        imgPortadaBackground.image = UIImage(named: "\(portadaString)-large.jpg")
        
        lblCantante.text = cantanteString
        lblTituloCancion.text = tituloString
        lblAlbum.text = portadaString
        
        // Sombra
        shadow = UIView(frame: CGRectMake(imgPortadaDetalle.frame.origin.x,
                                              imgPortadaDetalle.frame.origin.y,
                                              imgPortadaDetalle.frame.width,
                                              imgPortadaDetalle.frame.height))
        

        
        
        shadow.backgroundColor = UIColor.grayColor()
        shadow.layer.shadowOpacity = 0.1
        shadow.layer.shadowOffset = CGSizeMake(2, 10)
        shadow.layer.cornerRadius = 8
        self.view.addSubview(shadow)
        
        self.view.addSubview(imgPortadaDetalle)
        
        
        imgPortadaDetalle.layer.borderWidth = 0
        imgPortadaDetalle.layer.masksToBounds = true
        imgPortadaDetalle.layer.cornerRadius = 8
        // ----------
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        //always fill the view
        blurEffectView.frame = self.imgPortadaBackground.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.imgPortadaBackground.addSubview(blurEffectView)
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("termino la cancion")
        flagSourceImagePlayButton = false
        playSongButton.setImage(UIImage(named: "playButton"), forState: .Normal)
        reproductor.currentTime = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = .LightContent

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }

    @IBAction func ajustarVolumen(sender: AnyObject) {
        if reproductor != nil {
            reproductor?.volume = sliderVolume.value
        }
    }
    
    @IBAction func StopSong() {
        if !reproductor.playing {
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
        else {
            flagSourceImagePlayButton = false
            playSongButton.setImage(UIImage(named: "playButton"), forState: .Normal)
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
    }
    
    @IBAction func ShuffleSong(sender: AnyObject) {
        
        reproductor.stop()
        reproductor.currentTime = 0.0
        let cancionAleatoria = dataMusic.canciones.randomItem()

        // Encontrar el Path (en un solo paso se convierte a URL)
        let cancionURL = NSBundle.mainBundle().URLForResource("\(cancionAleatoria.titulo)", withExtension: "mp3")
        // Hacer la conexión con try catch
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: cancionURL!)
        } catch {
            print("Error al cargar el archivo de sonido \(cancionAleatoria.titulo).mp3")
        }
        
        imgPortadaDetalle.image = UIImage(named: "\(cancionAleatoria.portada)-large.jpg")
        imgPortadaBackground.image = UIImage(named: "\(cancionAleatoria.portada)-large.jpg")
        
        lblCantante.text = cancionAleatoria.cantante
        lblTituloCancion.text = cancionAleatoria.titulo
        lblAlbum.text = cancionAleatoria.portada
        
        flagSourceImagePlayButton = false
        PlaySong()

    }
    
    @IBAction func PlaySong() {
        flagSourceImagePlayButton = !flagSourceImagePlayButton
        
        if flagSourceImagePlayButton {
            playSongButton.setImage(UIImage(named: "pauseButton"), forState: .Normal)
            if !reproductor.playing {
                reproductor.play()
                
            }
        }
        else {
            playSongButton.setImage(UIImage(named: "playButton"), forState: .Normal)
            if reproductor.playing {
                reproductor.pause()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func dismissModalView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
