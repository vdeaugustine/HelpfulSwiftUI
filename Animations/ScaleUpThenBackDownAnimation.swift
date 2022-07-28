// A way to animate scaling up a view and then scaling it back down in a given amount of time.
// note: you must know how long you want this animation to last in order for this method to work
// credit to this StackOverflow answer https://stackoverflow.com/a/61972436/7663760

import SwiftUI	

struct ContentView: View {
    // The value that determines whether the animation is triggered
    @State private var doSpin: Bool = false
    @State private var isChecked: Bool = false
    let animationDuration: Double = 0.5
    var body: some View {
        VStack {
            Button {
                // Whatever animation you want to do
                let animation = Animation.easeInOut(duration: animationDuration).repeatCount(1, autoreverses: true)
                // Start the animation
                withAnimation(animation) {
                    isChecked.toggle()
                    doSpin.toggle()
                }
                // After the animation is finished, reverse it
                DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                    withAnimation(animation) {
                        // by re-toggling the animation trigger
                        doSpin.toggle()
                    }
                }
            } label: { Text("Tap") }
            Spacer()

            Image(systemName: isChecked ? "cross.fill" : "cross")
                .rotationEffect(doSpin ? .degrees(360) : .zero)
                .foregroundColor(isChecked ? .green : .black)
                .scaleEffect(doSpin ? 2 : 1)


            Spacer()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
