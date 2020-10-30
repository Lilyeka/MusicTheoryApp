//
//  MusicTasksPauses.swift
//  MusicTheoryApp
//
//  Created by Лилия Левина on 20.09.2020.
//  Copyright © 2020 Лилия Левина. All rights reserved.
//

import UIKit

class MusicTasksPausesDurations {
    var tasks: [MusicTask] = [
        MusicTaskPauseAndDuration(
                   questionText: "Выберите длительность, которая соответствует данной паузе",
                   notesArray: [
                       Note(name: .Do, tone: .none, duration: .whole),
                       Note(name: .Do, tone: .none, duration: .half),
                       Note(name: .Do, tone: .none, duration: .quarter),
                       Note(name: .Do, tone: .none, duration: .eighth),
                       Note(name: .Do, tone: .none, duration: .sixteen)],
                   cleff: .Treble,
                   pause: Pause(duration: .half)),
               MusicTaskPauseAndDuration(
                        questionText: "Выберите длительность, которая соответствует данной паузе",
                        notesArray: [
                            Note(name: .Do, tone: .none, duration: .whole),
                            Note(name: .Do, tone: .none, duration: .half),
                            Note(name: .Do, tone: .none, duration: .quarter),
                            Note(name: .Do, tone: .none, duration: .eighth),
                            Note(name: .Do, tone: .none, duration: .sixteen)],
                        cleff: .Treble,
                        pause: Pause(duration: .whole)),
               MusicTaskPauseAndDuration(
                            questionText: "Выберите длительность, которая соответствует данной паузе",
                            notesArray: [
                                Note(name: .Do, tone: .none, duration: .whole),
                                Note(name: .Do, tone: .none, duration: .half),
                                Note(name: .Do, tone: .none, duration: .quarter),
                                Note(name: .Do, tone: .none, duration: .eighth),
                                Note(name: .Do, tone: .none, duration: .sixteen)],
                            cleff: .Treble,
                            pause: Pause(duration: .sixteen)),
               MusicTaskPauseAndDuration(
                            questionText: "Выберите длительность, которая соответствует данной паузе",
                            notesArray: [
                                Note(name: .Do, tone: .none, duration: .whole),
                                Note(name: .Do, tone: .none, duration: .half),
                                Note(name: .Do, tone: .none, duration: .quarter),
                                Note(name: .Do, tone: .none, duration: .eighth),
                                Note(name: .Do, tone: .none, duration: .sixteen)],
                            cleff: .Treble,
                            pause: Pause(duration: .quarter)),
               MusicTaskPauseAndDuration(
                            questionText: "Выберите длительность, которая соответствует данной паузе",
                            notesArray: [
                                Note(name: .Do, tone: .none, duration: .whole),
                                Note(name: .Do, tone: .none, duration: .half),
                                Note(name: .Do, tone: .none, duration: .quarter),
                                Note(name: .Do, tone: .none, duration: .eighth),
                                Note(name: .Do, tone: .none, duration: .sixteen)],
                            cleff: .Treble,
                            pause: Pause(duration: .eighth)),
        MusicTaskAddition(
            questionText: "Решите пример с паузами",
            answer: Duration.quarter,
            variables: [(Duration.eighth,MathSign(sign:.addition)),
                        (Duration.eighth,MathSign(sign:.equation)),
                        (nil,MathSign(sign:.question))],
            variants: [Duration.whole,
                       Duration.half,
                       Duration.quarter,
                       Duration.eighth,
                       Duration.sixteen],
            variantsAreNotes: false),
        
        MusicTaskAddition(
               questionText: "Решите пример с паузами",
               answer: Duration.half,
               variables: [(Duration.quarter,MathSign(sign:.addition)),
                           (Duration.quarter,MathSign(sign:.equation)),
                           (nil,MathSign(sign:.question))],
               variants: [Duration.whole,
                          Duration.half,
                          Duration.quarter,
                          Duration.eighth,
                          Duration.sixteen],
               variantsAreNotes: false),
        MusicTaskAddition(
               questionText: "Решите пример с паузами",
               answer: Duration.quarter,
               variables: [(Duration.half,MathSign(sign:.subtraction)),
                           (Duration.quarter, MathSign(sign:.equation)),
                           (nil,MathSign(sign:.question))],
               variants: [Duration.whole,
                          Duration.half,
                          Duration.quarter,
                          Duration.eighth,
                          Duration.sixteen],
               variantsAreNotes: false),
        MusicTaskAddition(
                        questionText: "Решите пример с паузами",
                        answer: Duration.eighth,
                        variables: [(Duration.sixteen,MathSign(sign:.addition)),
                                    (Duration.sixteen,MathSign(sign: .equation)),
                                    (nil,MathSign(sign:.question))],
                        variants: [Duration.whole,
                                   Duration.half,
                                   Duration.quarter,
                                   Duration.eighth,
                                   Duration.sixteen],
                        variantsAreNotes: false),
        MusicTaskAddition(
                        questionText: "Решите пример с паузами",
                        answer: Duration.whole,
                        variables: [(Duration.quarter,MathSign(sign:.addition)),
                                    (Duration.quarter,MathSign(sign:.addition)),
                                    (Duration.quarter,MathSign(sign:.addition)),
                                    (Duration.quarter,MathSign(sign:.equation)),
                                    (nil,MathSign(sign:.question))],
                        variants: [Duration.whole,
                                   Duration.half,
                                   Duration.quarter,
                                   Duration.eighth,
                                   Duration.sixteen],
                        variantsAreNotes: false),
        MusicTaskAddition(
                           questionText: "Решите пример с паузами",
                           answer: Duration.half,
                           variables: [(Duration.quarter,MathSign(sign:.addition)),
                                       (Duration.eighth,MathSign(sign:.addition)),
                                       (Duration.eighth,MathSign(sign:.equation)),
                                       (nil,MathSign(sign:.question))],
                           variants: [Duration.whole,
                                      Duration.half,
                                      Duration.quarter,
                                      Duration.eighth,
                                      Duration.sixteen],
                           variantsAreNotes: false),
        MusicTaskAddition(
                           questionText: "Решите пример с паузами",
                           answer: Duration.half,
                           variables: [(Duration.whole,MathSign(sign:.subtraction)),
                                       (Duration.quarter,MathSign(sign:.subtraction)),
                                       (Duration.quarter,MathSign(sign:.equation)),
                                       (nil,MathSign(sign:.question))],
                           variants: [Duration.whole,
                                      Duration.half,
                                      Duration.quarter,
                                      Duration.eighth,
                                      Duration.sixteen],
                           variantsAreNotes: false),
        MusicTaskAddition(
        questionText: "Решите музыкально-математические примеры",
        answer: Duration.half,
        variables: [(Duration.quarter,MathSign(sign:.addition)),
                    (Duration.quarter,MathSign(sign:.equation)),
                    (nil,MathSign(sign:.question))],
        variants: [Duration.whole,
                   Duration.half,
                   Duration.quarter,
                   Duration.eighth,
                   Duration.sixteen],
        variantsAreNotes: true),
        MusicTaskAddition(
              questionText: "Решите музыкально-математические примеры",
              answer: Duration.whole,
              variables:[(Duration.quarter,MathSign(sign:.addition)),
                         (Duration.quarter,MathSign(sign:.addition)),
                         (Duration.half,MathSign(sign:.equation)),
                         (nil,MathSign(sign:.question))],
              variants: [Duration.whole,
                         Duration.half,
                         Duration.quarter,
                         Duration.eighth,
                         Duration.sixteen],
              variantsAreNotes: true)
    ]
}
