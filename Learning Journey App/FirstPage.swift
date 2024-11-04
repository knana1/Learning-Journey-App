import SwiftUI

struct FirstPage: View {
    
    @State private var selectedLearningTopic = "Swift"
    @State private var selectedTimeFrame = "Month"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.3))  .frame(width: 118.0, height: 118.0)
                    
                    Text("🔥")
                        .font(.system(size: 60))
                }
                
                .frame(width: 118.0, height: 118.0)
                
                
                // Align the text to the left
                VStack(alignment: .leading) {
                    Text("Hello Learner!")
                        .font(.system(size: 32, weight: .bold))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                        .frame(width: 237.0, height: 38.0)
                    
                    Text("This app will help you learn everyday")
                        .font(.system(size: 18))
                        .fontWeight(.regular)
                        .foregroundColor(Color.white.opacity(0.5))
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                        .frame(width: 312.0, height: 21.0)
                }
                .frame(maxWidth: .infinity, alignment: .leading)  // This aligns the text to the left
                .padding(.horizontal, 3)
                VStack(alignment: .leading, spacing: 10) {
                    Text("I want to learn")
                        .font(.system(size: 18,weight: .semibold))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 0) { // Set spacing to 0 for tighter alignment
                        Rectangle()
                            .fill(Color.orange) // Set the vertical line color to orange
                            .frame(width: 2, height: 21) // Adjust height as needed
                        
                        TextField("", text: $selectedLearningTopic)
                            .font(.system(size: 17, weight: .regular))
                            .padding(.leading, 1) // Minimal left padding to the TextField
                            .padding(.vertical) // Maintain vertical padding
                            .foregroundColor(.gray)
                        // .background(Color.white.opacity(0.1)) // Optional background for the TextField
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 8) // Horizontal padding around the HStack
                    
                    // Horizontal line under the TextField
                    Rectangle()
                        .fill(Color.gray) // Set the line color
                        .frame(width: 352.9, height: 1) // Set width and height
                        .padding(.top, -11) // Optional spacing from the TextField
                }
                .padding(.horizontal, 30) // Horizontal padding around the VStack
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("I want to learn it in a")
                        .font(.system(size: 18 ,weight: .semibold))
                        .foregroundColor(.white)
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            selectedTimeFrame = "Week"
                        }) {
                            Text("Week")
                                .frame(width: 80, height: 40)
                                .background(selectedTimeFrame == "Week" ? Color.orange : Color("#2C2C2E"))
                                .foregroundColor(selectedTimeFrame == "Week" ? .black : .orange)
                                .cornerRadius(10)
                        };Button(action: {
                            selectedTimeFrame = "Month"
                        }) {
                            Text("Month")
                                .frame(width: 80, height: 40)
                                .background(selectedTimeFrame == "Month" ? Color.orange : Color("#2C2C2E"))
                                .foregroundColor(selectedTimeFrame == "Month" ? .black : .orange)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            selectedTimeFrame = "Year"
                        }) {
                            Text("Year")
                                .frame(width: 80, height: 40)
                                .background(selectedTimeFrame == "Year" ? Color.orange : Color("#2C2C2E"))
                                .foregroundColor(selectedTimeFrame == "Year" ? .black : .orange)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.leading, 0) // Add padding to the left of the buttons
                }
                .padding(.horizontal, 24) // Padding for the entire VStack
                .frame(maxWidth: .infinity, alignment: .leading) // Ensure the whole VStack aligns to the left
                
                Button(action: {
                    
                    
                }) {
                   
                    HStack {
                        NavigationLink(destination: StreakPageView(learningTopic: selectedLearningTopic).navigationBarBackButtonHidden(true)) {
                        Text("Start")
                                .fontWeight(.bold)
                               // .padding(.middle)
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: 151, minHeight: 52)
                    
                    .background(Color.orange)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 30)
                .padding(.top, 20)
                
               // Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
            
          
                
            .padding(.horizontal, 20)
                
                Spacer()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

            struct ContentView_Previews: PreviewProvider {
                static var previews: some View {
                    FirstPage()
                }
            }
