import SwiftUI

// MARK: - Color Extension
extension Color {
    init?(hex: String) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if cString.count == 6 {
            var rgb: UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgb)
            self.init(
                .sRGB,
                red: Double((rgb >> 16) & 0xFF) / 255.0,
                green: Double((rgb >> 8) & 0xFF) / 255.0,
                blue: Double(rgb & 0xFF) / 255.0,
                opacity: 1.0
            )
        } else {
            return nil
        }
    }
}

// MARK: - Main View
struct StreakPageView: View {
    @State var learningTopic: String // Learning topic
    @State private var streakedDays: Set<Int> = []
    @State private var frozenDays: Set<Int> = []
    let maxFreezes = 7
    @State private var selectedDay: Int?
    @State private var selectedDate: Date = Date()
    @State private var showingDatePicker = false
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    @State private var isLearned: Bool = false
    @State private var isFrozen: Bool = false
    @State private var isReset: Bool = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    headerView
                    calendarView
                    actionButtons.padding(.top, -45)
                }
                .navigationBarBackButtonHidden(true)
            }
        }
       
        }
    

    // MARK: - Header View
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(selectedDate, style: .date)// Current date formatted
                    .font(.subheadline)
                    .foregroundColor(Color(hex: "#48484A"))
                Text("Learning \(learningTopic)") // Learning topic
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding(.leading, 28)

            Spacer()

            NavigationLink(destination: StreakPageView3(selectedLearningTopic: $learningTopic, onUpdate: { newTopic in
                learningTopic = newTopic
            }).navigationBarBackButtonHidden(true)) { // Updated navigation to StreakPageView3
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 50, height: 50)
                    Text("🔥") // Emoji icon
                        .font(.system(size: 30))
                }
            }
            .padding(.trailing, 28)
        }
        .padding(.top, 15)
    }
    // MARK: - Calendar View
    private var calendarView: some View {
        VStack(spacing: 0) {
            titleView
            daysView
            Divider().background(Color.gray).padding(.vertical, 18)
            streakAndFreezeCounters.padding(.bottom, 1)
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(13)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(hex: "#48484A") ?? Color.gray, lineWidth: 1)
                .frame(width: 350.0, height: 220.0)
        )
        .padding([.leading, .bottom, .trailing], 40)
    }

    // MARK: - Title View
    private var titleView: some View {
        HStack {
            Button(action: {
                showingDatePicker.toggle()
            }) {
                Text(selectedDate, style: .date)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
            }
            Spacer()
            Button(action: {
                selectedDate = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate) ?? selectedDate
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.orange)
                                }
                                Button(action: {
                                    selectedDate = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: selectedDate) ?? selectedDate
                                }) {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.orange)
                                }
                            }
                        }

                        // MARK: - Days View
                        private var daysView: some View {
                            let startOfWeek = startOfWeek(for: selectedDate)
                            let daysInWeek = (0..<7).map { Calendar.current.date(byAdding: .day, value: $0, to: startOfWeek)! }

                            return VStack(spacing: 10) {
                                HStack(spacing: 6.12) {
                                    ForEach(daysOfWeek, id: \.self) { day in
                                        Text(day)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color(hex: "#48484A"))
                                            .frame(width: 40.0)
                                    }
                                }
                                HStack(spacing: 6.5) {
                                    ForEach(daysInWeek, id: \.self) { day in
                                        let dayNumber = Calendar.current.component(.day, from: day)
                                        CircleDayView(day: dayNumber,
                                                      isStreaked: streakedDays.contains(dayNumber),
                                                      isFrozen: frozenDays.contains(dayNumber),
                                                      isLearned: streakedDays.contains(dayNumber),
                                                      isSelected: selectedDay == dayNumber,
                                                      isReset: isReset,
                                                      onSelect: {
                                                          selectedDay = dayNumber
                                                          isLearned = false
                                                          isFrozen = false
                                                          isReset = true
                                                      })
                                    }
                                }
                            }
                            .padding([.top, .bottom], -12)
                        }

                        // MARK: - Streak and Freeze Counters
                        private var streakAndFreezeCounters: some View {
                            HStack {
                                VStack {
                                    Text("\(streakedDays.count)🔥")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Text("Day streak")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 20)

                                Divider().background(Color.gray).padding(.vertical, -6)

                                VStack {
                                    Text("\(frozenDays.count) 🧊")
                                        .font(.title)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Text("Days freeezed")
                                        .foregroundColor(.gray)
                                }
                                .padding(.leading, 20)
                            }
                        }

                        // MARK: - Action Buttons
                        private var actionButtons: some View {
                            VStack {
                                Spacer().frame(height: 28)
                                
                                Button(action: {
                                    if let day = selectedDay {
                                        if isLearned {
                                            streakedDays.remove(day)
                                            isLearned = false
                                            isFrozen = false
                                            selectedDay = nil
                                        } else {
                                            logTodayAsLearned(day)
                                        }
                                    }
                                }) {
                                    Text(isFrozen ? "Freezed" : (isLearned ? "Learned Today" : "Log Today as Learned"))
                                        .font(.system(size: 41, weight: .semibold))
                                        .padding()
                                        .frame(width: 320.0, height: 320.0)
                                        .foregroundColor(isFrozen ? Color(hex: "#0A84FF") : (isLearned ? Color(hex: "#FF9F0A") : Color.black))
                                        .background(isFrozen ? Color(hex: "#021F3D") : (isLearned ? Color(hex: "#422800") : Color(hex: "#FF9F0A")))
                                        .clipShape(Circle())
                                }
                                .buttonStyle(PlainButtonStyle())
                                .onTapGesture {
                                    if isLearned {
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                                Spacer().frame(height: 28)

                                            Button(action: {
                                                if let day = selectedDay {
                                                    toggleFreezeDay(day)
                                                }
                                            }) {
                                                Text(frozenDays.contains(selectedDay ?? 0) ? "Freeze Day" : "Freeze Day")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(isFrozen ? Color(hex: "#8E8E93") : (isLearned ? Color(hex: "#8E8E93") : Color.blue))
                                                    .frame(width: 200, height: 50)
                                                    .background(isFrozen ? Color(hex: "#2C2C2E") : (isLearned ? Color(hex: "#2C2C2E") : Color(hex: "#C1DDFF")))
                                                    .cornerRadius(10)
                                            }

                                            Text("\(frozenDays.count) out of \(maxFreezes) freezes used")
                                                .foregroundColor(Color(hex: "#48484A"))
                                                .padding(.top, 0.5)
                                        }
                                    }

                                  
                                    // MARK: - Helper Functions
                                    private func logTodayAsLearned(_ day: Int) {
                                        if !streakedDays.contains(day) {
                                            streakedDays.insert(day)
                                        }
                                        isLearned = true
                                        isFrozen = false
                                    }

                                    private func toggleFreezeDay(_ day: Int) {
                                        if frozenDays.contains(day) {
                                            frozenDays.remove(day)
                                            isFrozen = false
                                        } else {
                                            if frozenDays.count < maxFreezes {
                                                frozenDays.insert(day)
                                                isFrozen = true
                                            } else {
                                                print("Cannot freeze more days. Max freezes reached.")
                                            }
                                        }
                                    }

                                    private func startOfWeek(for date: Date) -> Date {
                                        let calendar = Calendar.current
                                        let weekOfYear = calendar.component(.weekOfYear, from: date)
                                        let year = calendar.component(.yearForWeekOfYear, from: date)
                                        return calendar.date(from: DateComponents(year: year, weekday: 1, weekOfYear: weekOfYear))!
                                    }
                                }

                                // MARK: - Circle Day View
                                struct CircleDayView: View {
                                    let day: Int
                                    let isStreaked: Bool
                                    let isFrozen: Bool
                                    let isLearned: Bool
                                    let isSelected: Bool
                                    let isReset: Bool
                                    let onSelect: () -> Void

                                    var body: some View {
                                        Text("\(day)")
                                            .font(.headline)
                                            .foregroundColor(
                                                isFrozen ? .blue :
                                                isStreaked ? .orange :
                                                (isSelected ? .orange : .white)
                                            )
                                            .frame(width: 40, height: 40)
                                            .background(
                                                isFrozen ? Color(hex: "#021F3D")?.opacity(isReset ? 1 : 0.3) :
                                                isLearned ? Color(hex: "#422800")?.opacity(isReset ? 1 : 0.3) :
                                                Color.clear
                                            )
                                            .clipShape(Circle())
                                            .onTapGesture {
                                                onSelect()
                                            }
                                    }
                                }

                                // MARK: - Preview
                                struct StreakPageView_Previews: PreviewProvider {
                                    static var previews: some View {
                                        StreakPageView(learningTopic: "Swift")
                                    }
                                }
