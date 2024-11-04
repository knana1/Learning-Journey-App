import SwiftUI

struct StreakPageView3: View {
    @Binding var selectedLearningTopic: String // Binding to receive updates from the previous view
    @State private var selectedTimeFrame = "Month"
    var onUpdate: (String) -> Void // Closure to call when updating the topic

    @Environment(\.presentationMode) var presentationMode // Access to presentation mode

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                headerView
                learningTopicInput
                timeFrameSelection
                Spacer()
            }
            .padding(.horizontal, 20)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarBackButtonHidden(true) // Hide the default back button
        }
    }

    // MARK: - Header View
    private var headerView: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss() // Dismiss the current view
            }) {
                
            }
            .padding()

            Spacer()

            Text("Learning goal")
                .font(.headline)
                .foregroundColor(Color.white)

            Spacer()

            Button(action: {
                onUpdate(selectedLearningTopic) // Call the closure to update the topic
            }) {
                Text("Update")
                    .foregroundColor(Color.orange)
            }
            .padding()
        }
        .padding(.top, 20)
        .background(Color.black)
    }

    // MARK: - Learning Topic Input
    private var learningTopicInput: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("I want to learn")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)

            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 2, height: 21)

                TextField("Enter topic", text: $selectedLearningTopic)
                    .font(.system(size: 17, weight: .regular))
                    .padding(.leading, 1)
                    .padding(.vertical)
                    .foregroundColor(.gray)
                    .background(Color.clear)
                    .cornerRadius(8)
                    .textFieldStyle(PlainTextFieldStyle())
                    .keyboardType(.default)
                    .autocapitalization(.words)
            }
            .padding(.horizontal, 8)

            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
                .padding(.top, -11)
        }
        .padding(.horizontal, 30)
    }

    // MARK: - Time Frame Selection
    private var timeFrameSelection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("I want to learn it in a")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)

            HStack(spacing: 16) {
                ForEach(["Week", "Month", "Year"], id: \.self) { timeFrame in
                    Button(action: {
                        selectedTimeFrame = timeFrame
                    }) {
                        Text(timeFrame)
                            .frame(width: 80, height: 40)
                            .background(selectedTimeFrame == timeFrame ? Color.orange : Color("#2C2C2E"))
                            .foregroundColor(selectedTimeFrame == timeFrame ? .black : .orange)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.leading, 0)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
    }
}

// MARK: - Preview
struct StreakPageView3_Previews: PreviewProvider {
    static var previews: some View {
        StreakPageView3(selectedLearningTopic: .constant("Swift"), onUpdate: { _ in })
            }
        }
