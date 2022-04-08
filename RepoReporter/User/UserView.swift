

import SwiftUI
import ComposableArchitecture

struct UserView: View {
  let store: Store<UserState, UserAction>
  var body: some View {
    WithViewStore(self.store) { viewStore in
      HStack {
        Spacer()
        VStack(spacing: 8) {
          Text("\(viewStore.user?.name ?? "")")
            .font(.title)
          if viewStore.user?.bio != nil {
            Text("\(viewStore.user?.bio ?? "")")
              .italic()
          } else {
            Text("No bio available")
              .italic()
          }
          Text("\(viewStore.user?.publicRepos ?? 0)")
            .bold()
            + Text(" public repos | ")
            + Text("\(viewStore.user?.followers ?? 0)")
              .bold()
            + Text(" followers")
          Spacer()
        }
        .padding()
        .onAppear {
          viewStore.send(.onAppear)
        }
        Spacer()
      }
    }
    .foregroundColor(Color("rw-light"))
    .background(Color("rw-dark").edgesIgnoringSafeArea([.top, .leading, .trailing]))
  }
}

struct UserView_Previews: PreviewProvider {
  static var previews: some View {
    return UserView(
      store: Store(
        initialState: UserState(),
        reducer: userReducer,
        environment: .dev(
          environment: UserEnvironment(
            userRequest: dummyUserEffect))))
  }
}
