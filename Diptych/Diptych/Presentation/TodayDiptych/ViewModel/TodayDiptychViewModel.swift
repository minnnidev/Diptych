//
//  TodayDiptychViewModel.swift
//  Diptych
//
//  Created by 김민 on 2023/07/19.
//

import Foundation
import Firebase
import FirebaseFirestore

@MainActor
class TodayDiptychViewModel: ObservableObject {

    @Published var question = "상대방의 표정 중 당신이\n가장 좋아하는 표정은?"
    @Published var weeklyData = [DiptychState]()
    @Published var isLoading = false
    let db = Firestore.firestore()

    func fetchTodayQuestion() async {
        // TODO: nanoseconds 값까지 어떻게 고려하지?
        let timestamp = Timestamp(seconds: 1689692400, nanoseconds: 870000000)

        do {
            let querySnapshot = try await db.collection("contents")
                .whereField("date", isEqualTo: timestamp)
                .getDocuments()

            for document in querySnapshot.documents {
                let data = document.data()
                if let question = data["question"] as? String {
                    await MainActor.run {
                        self.question = question
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }


    func fetchWeeklyCalender() async {
        // 이번 주 월요일(17) 이후의 데이터
        // <FIRTimestamp: seconds=1689552000 nanoseconds=0>
//        firebase의 7/17 timestamp: <FIRTimestamp: seconds=1689519600 nanoseconds=863000000>
        /*
         월요일을 주고 월요일 이상의 데이터를 받아오도록 함
         seconds로만 검색할 수 없나 -> 이번주 월요일의 날짜를 구해서 넣기
         일단은 월요일(7/17)로 해서 넣음 ^_^
         */
//        await MainActor.run {
//            isLoading = true
//        }

        isLoading = true

        let timeStamp = Timestamp(seconds: 1689519600, nanoseconds: 0)

        do {
            let querySnapshot = try await db.collection("photos")            .whereField("albumId", isEqualTo: "O6ulZBskeb10JC7DMhXk")
                .whereField("date", isGreaterThanOrEqualTo: timeStamp)
                .getDocuments()

            for document in querySnapshot.documents {
                let data = document.data()
                guard let photoFirst = data["photoFirst"] as? String else { return }
                guard let photoSecond = data["photoSecond"] as? String else { return }

                if photoFirst != "" && photoSecond != "" {
                    await MainActor.run {
                        weeklyData.append(DiptychState.complete)
                    }
                } else if photoFirst != "" || photoSecond != "" {
                    await MainActor.run {
                        weeklyData.append(DiptychState.half)
                    }
                } else {
                    await MainActor.run {
                        weeklyData.append(DiptychState.incomplete)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }

        isLoading = false
    }
}
