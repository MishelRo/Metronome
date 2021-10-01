//
//  SoundPlayer.swift
//  Metronome
//
//  Created by User on 24.09.2021.
//

import Foundation
import AVFoundation

class Metronome {
    
    var audioEngine: AVAudioEngine!
    var MetronomePlayer: AVAudioPlayerNode!
    var tickAudioFile: AVAudioFile!
    var tockClickAudioFile: AVAudioFile!
    
    init(urlSoundModel: UrlSoundModel) {
        tickAudioFile = try! AVAudioFile(forReading: urlSoundModel.lowSound)
        tockClickAudioFile = try! AVAudioFile(forReading: urlSoundModel.hightSound)
        audioEngine = AVAudioEngine()
        MetronomePlayer = AVAudioPlayerNode()
        audioEngine.attach(MetronomePlayer)
        audioEngine.connect(MetronomePlayer, to: audioEngine.mainMixerNode,
                            format: tickAudioFile.processingFormat)
        do {
            try audioEngine.start()
        } catch {
            print("Error audioEngine start with \(error)")
        }
    }
    
    
    func createBuffer(with bpm: Double, with countBeat: UInt32, with timeSignature: UInt32) -> AVAudioPCMBuffer {
        tickAudioFile.framePosition = 0
        tockClickAudioFile.framePosition = 0
        let lengthOfClick = AVAudioFrameCount(tickAudioFile.processingFormat.sampleRate * 60 / bpm)
        let bufferOftick = AVAudioPCMBuffer(pcmFormat: tickAudioFile.processingFormat,
                                                 frameCapacity: lengthOfClick)!
        do {
            try tickAudioFile.read(into: bufferOftick)
        } catch {
            print("Fuck!\(error)")
        }
        bufferOftick.frameLength = lengthOfClick / timeSignature
        let bufferOfTock = AVAudioPCMBuffer(pcmFormat: tockClickAudioFile.processingFormat,
                                                   frameCapacity: lengthOfClick)!
        do {
            try tockClickAudioFile.read(into: bufferOfTock)
        } catch {
            print("Fuck!!!\(error)")
        }
        bufferOfTock.frameLength = lengthOfClick / timeSignature
        
        if countBeat != 0 {
            let bufferBar = AVAudioPCMBuffer(pcmFormat: tickAudioFile.processingFormat,
                                             frameCapacity: countBeat * lengthOfClick)!
            bufferBar.frameLength = countBeat * lengthOfClick
            let channelCount = Int(tickAudioFile.processingFormat.channelCount)
            let accentedClickArray = Array(
                UnsafeBufferPointer(start: bufferOfTock.floatChannelData![0],
                                    count: channelCount * Int(lengthOfClick / timeSignature)))
            let mainClickArray = Array(UnsafeBufferPointer(start: bufferOftick.floatChannelData![0],
                                                           count: channelCount * Int(lengthOfClick / timeSignature)))
            var barArray = [Float]()
            barArray.append(contentsOf: accentedClickArray)
            
            for _ in 1...36 {
                barArray.append(contentsOf: mainClickArray)
            }
            bufferBar.floatChannelData!.pointee.assign(from: barArray,
                                                       count: channelCount * Int(bufferBar.frameLength))
            return bufferBar
        } else {
            return bufferOftick
        }
    }
    
    var isPlay: Bool {
        return MetronomePlayer.isPlaying
    }
    
    func playMetronome(bpm: Int32, countBeat: Int32, timeSignature: Int32) {
        
        let metranomeBuffer = createBuffer(with: Double(bpm),
                                             with: UInt32(countBeat),
                                             with: UInt32(timeSignature))
        
        
        
        if MetronomePlayer.isPlaying {
            MetronomePlayer.scheduleBuffer(metranomeBuffer,
                                           at: nil,
                                           options: .interruptsAtLoop) {
                print("hello")
            }
        } else {
            MetronomePlayer.play()
        }
        MetronomePlayer.scheduleBuffer(metranomeBuffer,
                                       at: nil,
                                       options: .loops){
            print("hello2")
        }
    }
    
    func stopMetranome() {
        MetronomePlayer.stop()
    }
    
}
